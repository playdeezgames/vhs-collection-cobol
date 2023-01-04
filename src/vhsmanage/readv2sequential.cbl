       >>SOURCE FORMAT FREE
IDENTIFICATION DIVISION.
PROGRAM-ID. READV2SEQUENTIAL.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
       SELECT V2FILE ASSIGN "v2.dat"
           ORGANIZATION IS INDEXED 
           ACCESS MODE IS DYNAMIC 
           RECORD KEY IS IMDBID OF V2FILERECORD.

DATA DIVISION.
FILE SECTION.
       FD V2FILE.
       01 V2FILERECORD.
          88 EndOfFile VALUE HIGH-VALUE.
          02 IMDBID PIC X(9) VALUE SPACES.
          02 MovieTitle PIC X(120) VALUE SPACES.
          02 HaveWatched PIC X(10) VALUE SPACES.
          02 Rating PIC X(15) VALUE SPACES.
          02 CATEGORY PIC X(30) VALUE SPACES.

WORKING-STORAGE SECTION.
       01 SCRATCHPAD.
          02 IMDBID PIC X(9).

PROCEDURE DIVISION.
       OPEN INPUT V2FILE
       START V2FILE FIRST 
       READ V2FILE NEXT RECORD 
           AT END SET ENDOFFILE TO TRUE
       END-READ
       PERFORM UNTIL ENDOFFILE
           DISPLAY IMDBID OF V2FILERECORD " - " FUNCTION TRIM(MovieTitle OF V2FILERECORD)
           READ V2FILE NEXT RECORD 
               AT END SET ENDOFFILE TO TRUE
           END-READ
       END-PERFORM
       CLOSE V2FILE
       STOP RUN.

DUMPRECORD.
       EXIT.
