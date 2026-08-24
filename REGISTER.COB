       IDENTIFICATION      DIVISION.
       PROGRAM-ID.         REGISTER.
       AUTHOR.             JOAO FERNANDES.
       DATE-WRITTEN.       24/08/2026.

       ENVIRONMENT         DIVISION.
       INPUT-OUTPUT        SECTION.
       FILE-CONTROL.
         SELECT FCRM ASSIGN TO "..\DATA\CRM.DAT"
         ORGANIZATION IS INDEXED
         ACCESS MODE IS RANDOM
         FILE STATUS IS FS-FCRM
         RECORD KEY IS OFCRM-KEY.

       DATA                DIVISION.
       FILE                SECTION.
       FD FCRM.
       COPY "#CRM.CPY".

       WORKING-STORAGE     SECTION.
       COPY "#CRM-WS.CPY".
       01 FS-FCRM         PIC X(02) VALUE ZERO.
       01 WS-HOLD-SCREEN   PIC X VALUE SPACE.

       PROCEDURE           DIVISION.
       0100-MAIN           SECTION.
           PERFORM 0200-INIT.
           PERFORM 0300-PROCCESS.
           PERFORM 0400-FINALIZER.

           ACCEPT WS-HOLD-SCREEN LINE 20 COLUMN 01.
           GOBACK.
       0100-END.           EXIT.
       0200-INIT           SECTION.
           OPEN I-O FCRM.
           IF FS-FCRM NOT EQUAL ZERO
             DISPLAY "FAILED TO OPEN CRM FILE" LINE 01 COLUMN 01
             ACCEPT WS-HOLD-SCREEN             LINE 20 COLUMN 01
             GOBACK
           END-IF.
           DISPLAY " ____  ____   ___  ____  ___  ____  ____  ____ "
             LINE 01 COLUMN 01.
           DISPLAY "(  _ \( ___) / __)(_  _)/ __)(_  _)( ___)(  _ \"
             LINE 02 COLUMN 01.
           DISPLAY " )   / )__) ( (_-. _)(_ \__ \  )(   )__)  )   /"
             LINE 03 COLUMN 01.
           DISPLAY "(_)\_)(____) \___/(____)(___/ (__) (____)(_)\_)"
             LINE 04 COLUMN 01.
       0200-END.           EXIT.
       0300-PROCCESS       SECTION.
           DISPLAY "ID:"           LINE 06 COLUMN 01.
             ACCEPT WS-CRM-ID      LINE 06 COLUMN 08.
           DISPLAY "NAME:"         LINE 07 COLUMN 01.
             ACCEPT WS-CRM-NAME    LINE 07 COLUMN 08.
           DISPLAY "EMAIL:"        LINE 08 COLUMN 01.
             ACCEPT WS-CRM-EMAIL   LINE 08 COLUMN 08.
           DISPLAY "PHONE:"        LINE 09 COLUMN 01.
             ACCEPT WS-CRM-PHONE   LINE 09 COLUMN 08.

           MOVE 01 TO WS-CRM-STATUS.
           MOVE WS-CRM-REGISTER TO OFCRM-REGISTER.
           WRITE OFCRM-REGISTER.

           EVALUATE FS-FCRM
             WHEN 00
               DISPLAY "OPERATION COMPLETED!"      LINE 15 COLUMN 01
             WHEN 22
               DISPLAY "REGISTER ALREADY EXISTS"   LINE 15 COLUMN 01
             WHEN OTHER
               DISPLAY "UNEXPECTED ERROR:"         LINE 15 COLUMN 01
               DISPLAY FS-FCRM                     LINE 16 COLUMN 01
           END-EVALUATE.
       0300-END.           EXIT.
       0400-FINALIZER      SECTION.
           CLOSE FCRM.
       0400-END.           EXIT.
