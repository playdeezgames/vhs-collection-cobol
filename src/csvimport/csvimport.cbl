       >>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. CSVIMPORT.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
       SELECT InputCsvFile ASSIGN "input.csv"
           ORGANIZATION LINE SEQUENTIAL.
       SELECT OutputFile ASSIGN "output.dat"
           ORGANIZATION INDEXED
           ACCESS MODE RANDOM
           RECORD KEY IS IMDBID.

       
DATA DIVISION.
FILE SECTION.
       FD InputCsvFile.
       01 InputCsvLine PIC X(120).
       FD OutputFile.
       01 OutputFileRecord.
          02 IMDBID PIC X(9) VALUE SPACES.
          02 MovieTitle PIC X(120) VALUE SPACES.
          02 HaveWatched PIC X(10) VALUE SPACES.
          02 Rating PIC X(15) VALUE SPACES.
          02 Category PIC X(30) VALUE SPACES.
           

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
       OPEN I-O OutputFile
       OPEN INPUT InputCsvFile
       PERFORM CopyToOutput UNTIL InputEOF IS EQUAL TO "Y"
       CLOSE InputCsvFile
       CLOSE OutputFile
       STOP RUN.

CopyToOutput.
       READ InputCsvFile
           AT END MOVE "Y" TO InputEOF
           NOT AT END PERFORM ProcessLine
       END-READ
       EXIT.

ProcessLine.
       PERFORM ParseLine
       MOVE VhsInputRecord TO OutputFileRecord
       DISPLAY OutputFileRecord
       WRITE OutputFileRecord
       EXIT.

ParseLine.
       MOVE InputCsvLine TO BufferLine
       UNSTRING BufferLine 
           DELIMITED BY ","
           INTO 
               IMDBID OF VhsInputRecord
               MovieTitle OF VhsInputRecord
               HaveWatched OF VhsInputRecord
               Rating OF VhsInputRecord
               Category OF VhsInputRecord
       END-UNSTRING
       DISPLAY "*******************************"
       DISPLAY "IMDBID: " IMDBID OF VhsInputRecord
       DISPLAY "Title: " MovieTitle OF VhsInputRecord
       DISPLAY "Have Watched? " HaveWatched OF VhsInputRecord
       DISPLAY "Rating: " Rating OF VhsInputRecord
       DISPLAY "Category: " Category OF VhsInputRecord
       EXIT.
