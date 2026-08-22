       IDENTIFICATION      DIVISION.
       PROGRAM-ID.         CRM.

       ENVIRONMENT         DIVISION.

       DATA                DIVISION.
       
       WORKING-STORAGE     SECTION.
       01 WS-OPTION        PIC 9 VALUE ZERO.
       SCREEN              SECTION.
       01 SC.
         05 BLANK SCREEN.

       PROCEDURE           DIVISION.
           PERFORM UNTIL WS-OPTION EQUALS 9
             DISPLAY SC
      
             DISPLAY "  ___  ____  __  __ " LINE 01 COLUMN 01
             DISPLAY " / __)(  _ \(  \/  )" LINE 02 COLUMN 01
             DISPLAY "( (__  )   / )    ( " LINE 03 COLUMN 01
             DISPLAY " \___)(_)\_)(_/\/\_)" LINE 04 COLUMN 01
      
                
             DISPLAY "1-CADASTRO"        LINE 06 COLUMN 01
             DISPLAY "2-CONSULTA"        LINE 07 COLUMN 01
             DISPLAY "3-ALTERACAO"       LINE 08 COLUMN 01
             DISPLAY "4-EXCLUSAO"        LINE 09 COLUMN 01
             DISPLAY "5-ATIVAR/INATIVAR" LINE 10 COLUMN 01
             DISPLAY "6-REL ATIVOS"      LINE 11 COLUMN 01
             DISPLAY "7-REL INATIVOS"    LINE 12 COLUMN 01
             DISPLAY "8-SETUP SISTEMA"   LINE 13 COLUMN 01
             DISPLAY "9-ENCERRAR"        LINE 14 COLUMN 01
             DISPLAY "  QUAL OPCAO:"     LINE 20 COLUMN 01
               ACCEPT WS-OPTION          LINE 20 COLUMN 20
             
             EVALUATE WS-OPTION
               WHEN 1
                 CALL "REGISTER"
               WHEN 2
                 CALL "QUERY"
               WHEN 3
                 CALL "CHANGE"
               WHEN 4
                 CALL "DELETE"
               WHEN 5
                 CALL "ACTINACT"
               WHEN 6
                 CALL "REPACT"
               WHEN 7
                 CALL "REPINACT"
               WHEN 8
                 CALL "SETUP"
             END-EVALUATE
           END-PERFORM.
           STOP RUN.
