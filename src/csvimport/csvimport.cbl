       >>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. CSVIMPORT.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
       SELECT InputCsvFile ASSIGN "input.csv"
           ORGANIZATION LINE SEQUENTIAL.
       
DATA DIVISION.
FILE SECTION.
       FD InputCsvFile.
       01 InputCsvLine PIC X(120).

WORKING-STORAGE SECTION.
       01 InputEOF PIC X VALUE "N".
       01 BufferLine PIC X(120).
       01 VhsInputRecord.
          02 IMDBID PIC X(9) VALUE SPACES.
          02 MovieTitle PIC X(120) VALUE SPACES.
          02 HaveWatched PIC X(10) VALUE SPACES.
          02 Rating PIC X(15) VALUE SPACES.
          02 Category PIC X(30) VALUE SPACES.

PROCEDURE DIVISION.
       OPEN INPUT InputCsvFile
       PERFORM UNTIL InputEOF IS EQUAL TO "Y"
           READ InputCsvFile
               AT END MOVE "Y" TO InputEOF
               NOT AT END PERFORM ParseLine
           END-READ
       END-PERFORM
       CLOSE InputCsvFile
STOP RUN.
ParseLine.
       MOVE InputCsvLine TO BufferLine
       UNSTRING BufferLine 
           DELIMITED BY ","
           INTO 
               IMDBID
               MovieTitle
               HaveWatched
               Rating
               Category
       END-UNSTRING
       DISPLAY "*******************************"
       DISPLAY "IMDBID: " IMDBID
       DISPLAY "Title: " MovieTitle
       DISPLAY "Have Watched? " HaveWatched
       DISPLAY "Rating: " Rating
       DISPLAY "Category: " Category
       EXIT.
