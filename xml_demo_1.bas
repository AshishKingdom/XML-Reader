q$ = CHR$(34)
'<email to="Ashish@Cb.com" from="sender_name" subject="Ahh! I don't know why I sent this mail!"/>
xml$ = "<email to=" + q$ + "Ashish@Cb.com" + q$ + " from=" + q$ + "sender_name" + q$ + " subject=" + q$ + "Ahh! I don't knows why I sent this mail!" + q$ + "/>"

PRINT "To --> "; getXMLAttributeValue("to", xml$)
PRINT "From --> "; getXMLAttributeValue("from", xml$)
PRINT "Subject --> "; getXMLAttributeValue("subject", xml$)

'$include:'xml reader.bm'
