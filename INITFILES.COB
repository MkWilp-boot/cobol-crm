       IDENTIFICATION      DIVISION.
       PROGRAM-ID.         SETUP.

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

       PROCEDURE           DIVISION.
       0100-MAIN           SECTION.
           PERFORM 0200-INIT.
           PERFORM 0300-FINALIZER.
           GOBACK.
       0100-END.           EXIT.
       0200-INIT           SECTION.
           OPEN INPUT OFCRM.
           EVALUATE FS-OFCRM
             WHEN ZEROS
               DISPLAY "FILE ALREADY EXISTS" 
             WHEN 35
               OPEN OUTPUT OFCRM
               DISPLAY FS-OFCRM
               DISPLAY "FILE CREATED"        
             WHEN OTHER
               DISPLAY "ERROR"               
               DISPLAY FS-OFCRM              
               GOBACK
           END-EVALUATE.
       0200-END.           EXIT.
       0300-FINALIZER      SECTION.
           CLOSE OFCRM.
       0300-END.           EXIT.
           STOP RUN.
