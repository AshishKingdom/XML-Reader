'show how to use XML files to make a simple transalator
'available words -
'apple,animal,amazing,boy,brick,bomb,brain,book and cat.
SCREEN _NEWIMAGE(700, 400, 32)

showText "Choose Output Language <E>nglish, <G>erman, <H>indi, <I>talian and <P>ortuguese"

PRINT

INPUT "", k$

SELECT CASE LCASE$(k$)
    CASE "e"
        output_language$ = "english"
    CASE "g"
        output_language$ = "german"
    CASE "h"
        output_language$ = "hindi"
    CASE "i"
        output_language$ = "italian"
    CASE "p"
        output_language$ = "portuguese"
    CASE ELSE
        output_language$ = "english"
END SELECT

CLS

DO
    INPUT ">", word$

    result$ = readXML("translator.xml", "word", output_language$, "#w-" + LCASE$(word$))

    IF result$ = "" THEN
        COLOR _RGB(255, 0, 0)
        PRINT "Word " + CHR$(34) + word$ + CHR$(34) + " not found in the xml file"
        COLOR _RGB(0, 255, 255)
    ELSE
        COLOR _RGB(0, 255, 0)
        PRINT word$;
        COLOR _RGB(255, 255, 0)
        PRINT "   <<-->>   ";
        COLOR _RGB(255, 0, 255)
        PRINT result$
        COLOR _RGB(0, 255, 255)
    END IF

LOOP

SUB showText (strs$)
    COLOR _RGB(0, 255, 255)
    FOR i = 1 TO LEN(strs$)
        ca$ = MID$(strs$, i, 1)
        IF ca$ = "<" OR ca$ = ">" THEN COLOR _RGB(255, 255, 255)
        IF pca$ = "<" AND ca$ <> ">" THEN COLOR _RGB(255, 255, 0)
        IF pca$ = ">" THEN COLOR _RGB(0, 255, 255)
        PRINT ca$;
        pca$ = ca$
    NEXT
END SUB

'$include:'xml reader.bm'
