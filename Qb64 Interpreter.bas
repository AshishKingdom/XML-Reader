'ON ERROR GOTO checkError
_TITLE "Qb64 Interpreter"
REDIM SHARED Coding(1) AS STRING
TYPE variables
    n AS STRING * 256
    typ AS STRING * 32
    global AS _BYTE
    variable_float AS _FLOAT
    variable_double AS DOUBLE
    variable_single AS SINGLE
    variable_integer AS INTEGER
    id AS LONG
END TYPE
REDIM SHARED variables(1) AS variables
REDIM SHARED StringsVar(1) AS STRING
'IF COMMAND$ <> "" THEN
'    codeFile$ = COMMAND$(0)
'    n = _COMMANDCOUNT
'    IF n > 0 THEN
'        spec$ = COMMAND$(1)
'    END IF
'    GOTO runcode
'END IF
_ICON
COLOR 15
getInfo:
INPUT "File name --> ", codeFile$
INPUT "Spec (-d or -nd) --> ", spec$

runcode:
IF _FILEEXISTS(codeFile$) THEN
    IF spec$ <> "" THEN spec$ = "-d" 'debug -nd=no debug
    getCode codeFile$
    execute codeFile$, spec$
ELSE
    COLOR 4
    PRINT "Fatal Error"
    PRINT "Could not locate " + CHR$(34) + codeFile$ + CHR$(34)
    COLOR 15
    GOTO getInfo
END IF
END
checkError:
PRINT "An error occured"
PRINT "Error code - "; ERR
ERROR ERR
SUB execute (code$, spc$)
    SHARED Coding() AS STRING
    DO
        IF UCASE$(LEFT$(Coding(currentline), 5)) = "PRINT" THEN
            n = 5
            DO WHILE n < LEN(Coding(currentline))
                gaq% = INSTR(gaq%, Coding(currentline), CHR$(34))
                gaq2% = INSTR(gaq% + 1, Coding(currentline), CHR$(34))

                wtp$ = MID$(Coding(currentline), gaq% + 1, (gaq2% - gaq%) - 1)
                PRINT wtp$
                n = gaq2%
            LOOP
        ELSEIF UCASE$(LEFT$(Coding(currentline), 3)) = "CLS" THEN
            CLS
        END IF
        currentline = currentline + 1
    LOOP UNTIL currentline > UBOUND(coding) - 1
END SUB

SUB getCode (file$)
    SHARED Coding() AS STRING
    f = FREEFILE
    OPEN file$ FOR INPUT AS #f
    WHILE NOT EOF(f)
        INPUT #f, tmp$
        n = n + 1
    WEND
    CLOSE #f
    REDIM Coding(n + 1) AS STRING
    n = 0
    f = FREEFILE
    OPEN file$ FOR INPUT AS #f
    WHILE NOT EOF(f)
        INPUT #f, tmp$
        Coding(n) = tmp$
        n = n + 1
    WEND
    CLOSE #f
END SUB
