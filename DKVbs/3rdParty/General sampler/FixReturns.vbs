''------ FixReturns.vbs can be used to correct text files that lack carriage returns, such
'--  as text from a Unix-created file.
'------ These files will have normal text but show boxes where there should be a return.


Dim fso, ts, s, arg, fil, fpath, s1
Set fso = CreateObject("Scripting.FileSystemObject")
     If WScript.arguments.count = 0 Then
           arg = InputBox("This script will correct web server text that lacks carriage returns. Enter path of file.", "Fix File", "C:\Windows\Desktop\")
     Else
           arg = WScript.arguments.item(0)
     End If
     If fso.FileExists(arg) = False Then
        MsgBox "Wrong path", 64, "No such file"
        WScript.Quit
    End If
 '-- ------got the file. read it into s.---------------------------
  
 Set ts = fso.OpenTextFile(arg, 1, False)
     s = ts.ReadAll
     ts.Close
  Set ts = Nothing

 '-------- replace linefeed characters with vbcrlf ------------------------

's1 = Replace(s, "&gt;", ">", 1, -1, 1)
s1 = Replace(s, vbCrLf, vbCr, 1, -1, 0)  '-- reoplace all vbcrlf with vbCr.
s1 = Replace(s1, vbLf, vbCr, 1, -1, 0)  '-- now any vbLf are alone, so also replace those.
 s1 = Replace(s1, vbCr, vbCrLf, 1, -1, 0)  '-- now any vbCr should represent a single lie return, whether Unix, MS Word, etc.
 
'---- -get new file name and path. -----------------------------------------

'''fil = fso.GetBaseName(arg)
'''fpath = fso.GetAbsolutePathName(fso.GetParentFolderName(arg))
'''fpath = fpath & "\" & fil & "2.txt"

'-- -----write file. -----------------
If fso.fileexists(arg) = True Then
  fso.deletefile arg, True
End If
  Set ts = fso.CreateTextFile(arg, True)
     ts.Write s1
     ts.Close
  Set ts = Nothing
  Set fso = Nothing
MsgBox "All done", 64, "File fixed"


