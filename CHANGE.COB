       IDENTIFICATION      DIVISION.
       PROGRAM-ID.         CHANGE.
       AUTHOR.             JOAO FERNANDES.
       DATE-WRITTEN.       25/08/2026.

       ENVIRONMENT         DIVISION.
       INPUT-OUTPUT        SECTION.
       FILE-CONTROL.
         SELECT FIOCRM ASSIGN TO "..\DATA\CRM.DAT"
         ORGANIZATION IS INDEXED
         ACCESS MODE IS RANDOM
         FILE STATUS IS FS-FIOCRM
         RECORD KEY IS OFCRM-KEY.

       DATA                DIVISION.
       FILE                SECTION.
       FD FIOCRM.
       COPY "#CRM.CPY".

       WORKING-STORAGE     SECTION.
       COPY "#CRM-WS.CPY".
       01 FS-FIOCRM             PIC 9(02) VALUE ZEROS.
       01 WS-FOLLOW-OPT         PIC X(01).
         88 OPT-EDIT-REG        VALUE 'Y'.
         88 OPT-DO-NOT-EDIT-REG VALUE 'N'.
       
       01 WS-HOLD-SCREEN        PIC X(01) VALUE SPACE.

       SCREEN              SECTION.
       01 SC.
         05 BLANK SCREEN.
         05 LINE 01 COLUMN 01 VALUE " ____  ____   ____  ____ ".
         05 LINE 02 COLUMN 01 VALUE "( ___)(  _ \ (_  _)(_  _)".
         05 LINE 03 COLUMN 01 VALUE " )__)  )(_) ) _)(_   )(  ".
         05 LINE 04 COLUMN 01 VALUE "(____)(____/ (____) (__) ".

       PROCEDURE           DIVISION.
       0100-MAIN           SECTION.
           PERFORM 0200-INIT.
           PERFORM 0300-PROCCESS.
           PERFORM 0400-FINALIZER.
           GOBACK.
       0100-END.           EXIT.
       0200-INIT           SECTION.
           MOVE SPACE TO WS-FOLLOW-OPT.
           DISPLAY SC.

           OPEN I-O FIOCRM.
           IF FS-FIOCRM NOT EQUAL ZEROS
             DISPLAY "FAILED TO OPEN CRM FILE" LINE 06 COLUMN 01
             DISPLAY FS-FIOCRM                 LINE 07 COLUMN 01
             ACCEPT WS-HOLD-SCREEN             LINE 20 COLUMN 01
             PERFORM 0400-FINALIZER
             GOBACK
           END-IF.
       0200-END.           EXIT.
       0300-PROCCESS       SECTION.
           DISPLAY "ENTER CLIENT ID:" LINE 06 COLUMN 01.
             ACCEPT WS-CRM-ID         LINE 06 COLUMN 18.
           MOVE WS-CRM-ID TO OFCRM-ID.

           READ FIOCRM.
           EVALUATE FS-FIOCRM
             WHEN 00
               DISPLAY "ID:"           LINE 08 COLUMN 01
                 DISPLAY OFCRM-ID      LINE 08 COLUMN 08
               DISPLAY "NAME:"         LINE 09 COLUMN 01
                 DISPLAY OFCRM-NAME    LINE 09 COLUMN 08
               DISPLAY "EMAIL:"        LINE 10 COLUMN 01
                 DISPLAY OFCRM-EMAIL   LINE 10 COLUMN 08
               DISPLAY "PHONE:"        LINE 11 COLUMN 01
                 DISPLAY OFCRM-PHONE   LINE 11 COLUMN 08
               DISPLAY "STATUS:"       LINE 12 COLUMN 01
                 DISPLAY OFCRM-STATUS  LINE 12 COLUMN 08

               PERFORM UNTIL OPT-EDIT-REG OR OPT-DO-NOT-EDIT-REG
               DISPLAY "EDIT REGISTER? (Y/N)"  LINE 15 COLUMN 01
                 ACCEPT WS-FOLLOW-OPT          LINE 15 COLUMN 25
               END-PERFORM
               IF OPT-EDIT-REG
                 MOVE SPACE TO WS-FOLLOW-OPT

                 DISPLAY "NAME:"           LINE 17 COLUMN 01
                   ACCEPT WS-CRM-NAME      LINE 17 COLUMN 08
                 DISPLAY "EMAIL:"          LINE 18 COLUMN 01
                   ACCEPT WS-CRM-EMAIL     LINE 18 COLUMN 08
                 DISPLAY "PHONE:"          LINE 19 COLUMN 01
                   ACCEPT WS-CRM-PHONE     LINE 19 COLUMN 08

                 PERFORM UNTIL OPT-EDIT-REG OR OPT-DO-NOT-EDIT-REG
                 DISPLAY "CONFIRM? (Y/N)"        LINE 20 COLUMN 01
                   ACCEPT WS-FOLLOW-OPT          LINE 20 COLUMN 16
                 END-PERFORM
                 IF OPT-EDIT-REG
                   MOVE WS-CRM-REGISTER TO OFCRM-REGISTER
                   REWRITE OFCRM-REGISTER
                 END-IF
               END-IF
             WHEN 23
               DISPLAY "REGISTER NOT FOUND."   LINE 10 COLUMN 01
             WHEN OTHER
               DISPLAY "ERROR READING FILE:"   LINE 10 COLUMN 01
               DISPLAY FS-FIOCRM               LINE 10 COLUMN 23
               ACCEPT WS-HOLD-SCREEN           LINE 20 COLUMN 01
           END-EVALUATE.
       0300-END.           EXIT.
       0400-FINALIZER      SECTION.
           CLOSE FIOCRM.
       0400-END.           EXIT.
