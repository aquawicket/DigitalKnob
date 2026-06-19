REM@usage
' Put the full or mini class/sub/function in your script to use.
Function BrowseForFile():BrowseForFile=CreateObject("WScript.Shell").Exec("mshta.exe ""about:<input type=file id=f><script>resizeTo(0,0);f.click();new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(f.value);close();</script>""").StdOut.ReadLine():End Function
Function BrowseForFileWithFilter(f):BrowseForFileWithFilter=CreateObject("WScript.Shell").Exec("mshta.exe ""about:<meta http-equiv=""X-UA-Compatible"" content=""IE=10""><input type=file id=f accept="""&f&"""><script>resizeTo(0,0);f.click();new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1).WriteLine(f.value);close();</script>""").StdOut.ReadLine():End Function

Dim filePath1
filePath1 = BrowseForFile()

Dim filePath2
filePath2 = BrowseForFileWithFilter(".zip")

Dim filePath3
filePath3 = BrowseForFileWithFilter(".jpg,.jpeg,.png")