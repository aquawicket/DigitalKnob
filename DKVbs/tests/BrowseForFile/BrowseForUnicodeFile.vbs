Function BrowseForUnicodeFile()
  REM@description
  ' HTML based browse for file dialog that doesn't require a temporary file. 
  REM@returns
  ' BrowseForUnicodeFile <string> - The file path of the selected file with support for unicode characters in the path.
  REM@author
  ' Jeremy England, http://codeartery.com/
  
  Dim unicodePathW, unicodePath, i
	unicodePathW = CreateObject("WScript.Shell").Exec( _
		"mshta.exe ""about:<input type=file id=f>" & _
		"<script>resizeTo(0,0);f.click();new ActiveXObject('Scripting.FileSystemObject')" & _
		".GetStandardStream(1,true).WriteLine(f.value);close();</script>""" _
	).StdOut.ReadLine()
	For i = 1 To Len(unicodePathW) Step 2
		unicodePath = unicodePath & ChrW(CLng(AscW(Mid(unicodePathW,i,1))) + CLng(AscW(Mid(unicodePathW,i+1,1))*(2^8)))
	Next
	BrowseForUnicodeFile = unicodePath
  
End Function