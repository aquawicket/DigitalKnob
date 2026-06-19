Function BrowseForFileWithFilter( filter )
  REM@description
  ' HTML based browse for file dialog that doesn't require a temporary file. 
  REM@params
  ' filter <string> - Comma separated list of extensions or types to filter by.
  REM@returns
  ' BrowseForFileWithFilter <string> - The file path of the selected file.
  REM@author
  ' Jeremy England, http://codeartery.com/
  REM@mini
  ' Function BrowseForFileWithFilter(f):BrowseForFileWithFilter=CreateObject("WScript.Shell").Exec("mshta.exe ""about:<meta http-equiv=""X-UA-Compatible"" content=""IE=10""><input type=file id=f accept="""&f&"""><script>resizeTo(0,0);f.click();new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(f.value);close();</script>""").StdOut.ReadLine():End Function
    
  BrowseForFileWithFilter = CreateObject("WScript.Shell").Exec( _
    "mshta.exe ""about:<meta http-equiv=""X-UA-Compatible"" content=""IE=10""><input type=file id=f accept="""& filter &""">" & _
    "<script>resizeTo(0,0);f.click();new ActiveXObject('Scripting.FileSystemObject')" & _
    ".GetStandardStream(1).WriteLine(f.value);close();</script>""" _
  ).StdOut.ReadLine()
End Function
