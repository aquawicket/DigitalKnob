Function BrowseForFile()
  REM@description
  ' HTML based browse for file dialog that doesn't require a temporary file. 
  REM@returns
  ' BrowseForFile <string> - The file path of the selected file.
  REM@author
  ' Jeremy England, http://codeartery.com/
  REM@mini
  ' Function BrowseForFile():BrowseForFile=CreateObject("WScript.Shell").Exec("mshta.exe ""about:<input type=file id=f><script>resizeTo(0,0);f.click();new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(f.value);close();</script>""").StdOut.ReadLine():End Function
    
  BrowseForFile = CreateObject("WScript.Shell").Exec( _
    "mshta.exe ""about:<input type=file id=f>" & _
    "<script>resizeTo(0,0);f.click();new ActiveXObject('Scripting.FileSystemObject')" & _
    ".GetStandardStream(1).WriteLine(f.value);close();</script>""" _
  ).StdOut.ReadLine()
End Function
