
WScript.Echo "WScript.Echo"
WScript.stdout.WriteLine ("WScript.stdout.WriteLine")  
WScript.stdout.Write ("WScript.stdout.Write")  

Set fso = CreateObject ("Scripting.FileSystemObject")
Set stdout = fso.GetStandardStream (1)
Set stderr = fso.GetStandardStream (2)
stdout.WriteLine "stdout.WriteLine "
stderr.WriteLine "stderr.WriteLine"
MsgBox("MsgBox")

Public Function echo(message)
	On Error Resume Next
	WScript.stdout.WriteLine (s)  
	If  err= &h80070006& Then WScript.Echo " Please run this script with CScript": WScript.quit
End Function


echo "hello"