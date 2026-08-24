       IDENTIFICATION      DIVISION.
       PROGRAM-ID.         INITFILES.
       AUTHOR.             JOAO FERNANDES.

       ENVIRONMENT         DIVISION.
       INPUT-OUTPUT        SECTION.
       FILE-CONTROL.
         SELECT OFCRM ASSIGN TO "..\DATA\CRM.DAT"
         ORGANIZATION IS INDEXED
         ACCESS MODE IS RANDOM
         FILE STATUS IS FS-OFCRM
         RECORD KEY IS OFCRM-KEY.

       DATA                DIVISION.
       FILE                SECTION.
       FD OFCRM.
       COPY "#CRM.CPY".

       WORKING-STORAGE     SECTION.
       01 WS-OPTION        PIC 9     VALUE ZERO.
      * FILE STATUS
       01 FS-OFCRM         PIC 9(02) VALUE ZERO.

       01 WS-HOLD-SCREEN   PIC X     VALUE SPACE.
       SCREEN              SECTION.
       01 SC.
         05 BLANK SCREEN.
       PROCEDURE           DIVISION.
       0100-MAIN           SECTION.
           PERFORM 0200-INIT.
           PERFORM 0300-FINALIZER.
           GOBACK.
       0100-END.           EXIT.
       0200-INIT           SECTION.
           DISPLAY SC.

           DISPLAY " ___  ____  ____  __  __  ____ " LINE 01 COLUMN 01.
           DISPLAY "/ __)( ___)(_  _)(  )(  )(  _ \" LINE 02 COLUMN 01.
           DISPLAY "\__ \ )__)   )(   )(__)(  )___/" LINE 03 COLUMN 01.
           DISPLAY "(___/(____) (__) (______)(__)  " LINE 04 COLUMN 01.

           OPEN INPUT OFCRM.
           EVALUATE FS-OFCRM
             WHEN ZEROS
               DISPLAY "FILE ALREADY EXISTS" LINE 06 COLUMN 01
             WHEN 35
               OPEN OUTPUT OFCRM
               DISPLAY "FILE CREATED"        LINE 06 COLUMN 01
             WHEN OTHER
               DISPLAY "ERROR"               LINE 06 COLUMN 01
               DISPLAY FS-OFCRM              LINE 07 COLUMN 01
           END-EVALUATE.
       0200-END.           EXIT.
       0300-FINALIZER      SECTION.
           ACCEPT WS-HOLD-SCREEN LINE 20 COLUMN 01.
           CLOSE OFCRM.
       0300-END.           EXIT.
