       IDENTIFICATION          DIVISION.
       PROGRAM-ID.             ACTINACT.
       AUTHOR.                 JOAO FERNANDES.
       DATE-WRITTEN.           27/08/2026.
       DATE-COMPILED.          27/08/2026.

       ENVIRONMENT             DIVISION.
       INPUT-OUTPUT            SECTION.
       FILE-CONTROL.
         SELECT FIOCRM ASSIGN TO "..\DATA\CRM.DAT"
         ORGANIZATION IS INDEXED
         ACCESS MODE IS RANDOM
         FILE STATUS IS FS-FIOCRM
         RECORD KEY IS OFCRM-KEY.

       DATA                    DIVISION.
       FILE                    SECTION.
       FD FIOCRM.
       COPY "#CRM.CPY".

       WORKING-STORAGE         SECTION.

       01 FS-FIOCRM            PIC 9(02) VALUE ZEROS.
       01 WS-HOLD-SCREEN       PIC X(01) VALUE SPACE.

       01 WS-ACTION-OPT        PIC X(01).
         88 OPT-EDIT           VALUE 'Y'.
         88 OPT-DO-NOT-EDIT    VALUE 'N'.

       01 WS-FOLLOW-UP           PIC X(01).
         88 OPT-EDIT-MORE        VALUE 'Y'.
         88 OPT-DO-NOT-EDIT-MORE VALUE 'N'.

       01 WS-ACTION            PIC A(10).
         88 OPT-ACTION-ACT     VALUE "ACTIVATE".
         88 OPT-ACTION-INACT   VALUE "INACTIVATE".
       
       SCREEN                  SECTION.
       01 SC.
         05 BLANK SCREEN.
         05 LINE 01 COLUMN 01 VALUE " ____      __".
         05 LINE 02 COLUMN 01 VALUE "(_  _)    /__\".
         05 LINE 03 COLUMN 01 VALUE " _)(_    /(  )\".
         05 LINE 04 COLUMN 01 VALUE "(____)()(__)(__)".

       PROCEDURE DIVISION.
       0100-MAIN               SECTION.
           PERFORM 0200-INIT.
           PERFORM 0300-PROCCESS UNTIL OPT-DO-NOT-EDIT-MORE.
           PERFORM 0400-FINALIZER.
           GOBACK.
       0100-END.               EXIT.
       0200-INIT               SECTION.
           DISPLAY SC.
           MOVE SPACE TO WS-ACTION-OPT.
           MOVE SPACE TO WS-FOLLOW-UP.

           OPEN I-O FIOCRM.
           IF FS-FIOCRM NOT EQUAL ZEROS
             DISPLAY "FAILED TO OPEN CRM FILE" LINE 06 COLUMN 01
             DISPLAY FS-FIOCRM                 LINE 07 COLUMN 01
             ACCEPT WS-HOLD-SCREEN             LINE 20 COLUMN 01
             PERFORM 0400-FINALIZER
             GOBACK
           END-IF.
       0200-END.               EXIT.
       0300-PROCCESS           SECTION.
           DISPLAY SC.
           MOVE SPACE TO WS-ACTION-OPT.
           MOVE SPACE TO WS-FOLLOW-UP.

           DISPLAY "ENTER CLIENT ID:" LINE 06 COLUMN 01.
             ACCEPT OFCRM-ID          LINE 06 COLUMN 18.

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

               IF OFCRM-STATUS EQUAL 0
                 MOVE "ACTIVATE"   TO WS-ACTION
               ELSE
                 MOVE "INACTIVATE" TO WS-ACTION
               END-IF
               
               PERFORM UNTIL OPT-EDIT OR OPT-DO-NOT-EDIT
                 DISPLAY 
                   WS-ACTION 
                     LINE 15 COLUMN 01
                   "REGISTER? (Y/N)"  
                     LINE 15 COLUMN 12
                 ACCEPT WS-ACTION-OPT
                   LINE 15 COLUMN 29
               END-PERFORM
             WHEN 23
               DISPLAY "REGISTER NOT FOUND."   LINE 10 COLUMN 01

             WHEN OTHER
               DISPLAY "ERROR READING FILE:"   LINE 10 COLUMN 01
               DISPLAY FS-FIOCRM               LINE 10 COLUMN 23
               ACCEPT WS-HOLD-SCREEN           LINE 20 COLUMN 01
           END-EVALUATE.

           IF OPT-EDIT
             COMPUTE OFCRM-STATUS = 1 - OFCRM-STATUS
             REWRITE OFCRM-REGISTER
             DISPLAY "FILE SAVED."     LINE 16 COLUMN 01
           END-IF.

           PERFORM UNTIL OPT-EDIT-MORE OR OPT-DO-NOT-EDIT-MORE
             DISPLAY "SEARCH ANOTHER? (Y/N)" LINE 17 COLUMN 01
               ACCEPT WS-FOLLOW-UP           LINE 17 COLUMN 24
           END-PERFORM.
       0300-END.               EXIT.
       0400-FINALIZER          SECTION.
           CLOSE FIOCRM.
       0400-END.               EXIT.
