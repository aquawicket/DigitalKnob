 '--converts hex-encoded URLs to normal. 
 '-- i.e.: "http%3A%2F%2Fwww%2E" becomes "http:\\www."
 '-- paste URL into input box. Converted URL will appear in
 '--2nd input box.
 
Dim sIn, sOut, Pt1, Pt2, sPerc, s2, sChar
    On Error Resume Next
    sPerc = "%"
  sIn = InputBox("Paste encoded URL in text box.", "URL Converter")
    If sIn = "" Then WScript.Quit
    
    Pt1 = 1
  Do
    Pt2 = InStr(Pt1, sIn, sPerc)
        If Pt2 = 0 Then Exit Do
      s2 = mid(sIn, (Pt2 + 1), 2)
      s3 = sPerc & s2
      sChar = Chr(clng("&H" & s2))
      sIn = Replace(sIn, s3, sChar)
  Loop    
  
   s2 = InputBox("This is the converted URL:", "URL Converter", sIn)
   
  WScript.Quit
  