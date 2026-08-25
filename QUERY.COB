       IDENTIFICATION      DIVISION.
       PROGRAM-ID.         QUERY.
       AUTHOR.             JOAO FERNANDES.
       DATE-WRITTEN.       24/08/2026.

       ENVIRONMENT         DIVISION.
       INPUT-OUTPUT        SECTION.
       FILE-CONTROL.
         SELECT FICRM ASSIGN TO "..\DATA\CRM.DAT"
         ORGANIZATION IS INDEXED
         ACCESS MODE IS RANDOM
         FILE STATUS IS FS-FICRM
         RECORD KEY IS OFCRM-KEY.

       DATA                DIVISION.
       FILE                SECTION.
       FD FICRM.
       COPY "#CRM.CPY".

       WORKING-STORAGE     SECTION.
       01 FS-FICRM         PIC 9(02) VALUE ZEROS.
       01 WS-HOLD-SCREEN   PIC X     VALUE SPACE.

       PROCEDURE           DIVISION.
       0100-MAIN           SECTION.
           PERFORM 0200-INIT.
           PERFORM 0300-PROCCESS.
           PERFORM 0400-FINALIZER.
           ACCEPT WS-HOLD-SCREEN LINE 20 COLUMN 01.
           GOBACK.
       0100-END.           EXIT.
       0200-INIT           SECTION.
           DISPLAY " _____  __  __  ____  ____  _  _ " 
             LINE 01 COLUMN 01.
           DISPLAY "(  _  )(  )(  )( ___)(  _ \( \/ )" 
             LINE 02 COLUMN 01.
           DISPLAY " )(_)(  )(__)(  )__)  )   / \  / "
             LINE 03 COLUMN 01.
           DISPLAY "(___/\\(______)(____)(_)\_) (__) " 
             LINE 04 COLUMN 01.

           OPEN INPUT FICRM.
           IF FS-FICRM NOT EQUAL ZEROS
             DISPLAY "FAILED TO OPEN CRM FILE" LINE 06 COLUMN 01
             DISPLAY FS-FICRM                  LINE 07 COLUMN 01
             ACCEPT WS-HOLD-SCREEN             LINE 20 COLUMN 01
             PERFORM 0400-FINALIZER
             GOBACK
           END-IF.
       0200-END.           EXIT.
       0300-PROCCESS       SECTION.
           
           DISPLAY "ENTER CLIENT ID:" LINE 06 COLUMN 01.
             ACCEPT OFCRM-ID          LINE 06 COLUMN 18.

           READ FICRM.
           EVALUATE FS-FICRM
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
             WHEN 23
               DISPLAY "REGISTER NOT FOUND." LINE 10 COLUMN 01
             WHEN OTHER
               DISPLAY "ERROR READING FILE:"  LINE 10 COLUMN 01
               DISPLAY FS-FICRM               LINE 10 COLUMN 23
           END-EVALUATE.
       0300-END.           EXIT.
       0400-FINALIZER      SECTION.
           CLOSE FICRM.
       0400-END.           EXIT.
