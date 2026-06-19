REM@usage
' Put the full or mini class/sub/function in your script to use.
Function Import(p):Import = False:Dim f,m:Set f=CreateObject("Scripting.FileSystemObject"):If(f.FileExists(f.GetAbsolutePathName(p)))Then:ExecuteGlobal(f.OpenTextFile(f.GetAbsolutePathName(p)).ReadAll):Import=-1:Exit Function:End If:Set m=CreateObject("Microsoft.XMLHTTP"):On Error Resume Next:m.Open "GET",p,0:If Not(Err.Number=-2147012890)Then:m.Send:If(m.Status=200)Then:ExecuteGlobal(m.ResponseText):Import=-1:End If:End If:End Function

' Online files work
Import "https://www.example.com/location/of/file.vbs"

' Offline files work
Import "c:\location\of\file.vbs"

' Relative paths work
Import "../file.vbs"

' Returns whether it succeeded with the import
Dim wasImported
wasImported = Import( "c:\location\of\file.vbs" )
If Not( wasImported )Then
  MsgBox "Failed to Import!", vbCritical
  WScript.Quit()
End If

' The extension doesn't have to be *.vbs, the file just has to contain valid VBScript code.
Import "c:\location\of\file.txt"