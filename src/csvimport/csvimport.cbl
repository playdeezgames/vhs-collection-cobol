       >>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. CSVIMPORT.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
       SELECT InputCsvFile ASSIGN "input.csv"
           ORGANIZATION LINE SEQUENTIAL.
       SELECT V1FILE ASSIGN "v1.dat"
           ORGANIZATION LINE SEQUENTIAL.

       
DATA DIVISION.
FILE SECTION.
       FD InputCsvFile.
       01 InputCsvLine PIC X(120).
       FD V1FILE.
       01 V1FILERECORD.
          02 IMDBID PIC X(9) VALUE SPACES.
          02 MovieTitle PIC X(120) VALUE SPACES.
          02 HaveWatched PIC X(10) VALUE SPACES.
          02 Rating PIC X(15) VALUE SPACES.
          02 Category PIC X(30) VALUE SPACES.
           

WORKING-STORAGE SECTION.
       01 InputEOF PIC X VALUE "N".
       01 BUFFERLINE PIC X(120).
       01 VhsInputRecord.
          02 IMDBID PIC X(9) VALUE SPACES.
          02 MovieTitle PIC X(120) VALUE SPACES.
          02 HaveWatched PIC X(10) VALUE SPACES.
          02 Rating PIC X(15) VALUE SPACES.
          02 CATEGORY PIC X(30) VALUE SPACES.
       01 SCRATCHPAD.
          02 COMMAND PIC X.

PROCEDURE DIVISION.
       OPEN OUTPUT V1FILE
       OPEN INPUT InputCsvFile
       PERFORM CopyToOutput UNTIL InputEOF IS EQUAL TO "Y"
       CLOSE InputCsvFile
       CLOSE V1FILE
       STOP RUN.

CopyToOutput.
       READ InputCsvFile
           AT END MOVE "Y" TO InputEOF
           NOT AT END PERFORM ProcessLine
       END-READ
       EXIT.

ProcessLine.
       PERFORM PARSELINE
       PERFORM WRITELINE
       EXIT.

WRITELINE.
       MOVE IMDBID OF VHSINPUTRECORD TO IMDBID OF V1FILERECORD
       MOVE MOVIETITLE OF VHSINPUTRECORD TO MOVIETITLE OF V1FILERECORD
       MOVE HAVEWATCHED OF VHSINPUTRECORD TO HAVEWATCHED OF V1FILERECORD
       MOVE RATING OF VHSINPUTRECORD TO RATING OF V1FILERECORD
       MOVE CATEGORY OF VHSINPUTRECORD TO CATEGORY OF V1FILERECORD
       WRITE V1FILERECORD
       END-WRITE
       EXIT.

PARSELINE.
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
       DISPLAY "CATEGORY: " Category OF VHSINPUTRECORD
       EXIT.
