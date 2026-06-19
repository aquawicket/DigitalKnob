REM@usage
' Put the full or mini class/sub/function in your script to use.
Class FileMessageStream:Private o:Private Sub Class_Initialize:Set o=CreateObject("Scripting.FileSystemObject"):End Sub:Function ReadMessages(w):Dim f:If Not IsObject(wscript) And IsObject(window)Then:f=window.location.pathname:Else:f=wscript.scriptfullname:End If:With o.OpenTextFile(f&":FMStream",1,-1):If(.AtEndOfStream And Not w)Then:Exit Function:End If:Do While(.AtEndOfStream And w)::Loop:ReadMessages=.ReadAll():.Close():End With:WriteTo(f,0)="":End Function:Property Let WriteTo(f,a,d):Dim m:If(a)Then:m=8:Else:m=2:End If:If o.FileExists(f)Then:With o.OpenTextFile(f&":FMStream",m,-1):.Write(d):.Close():End With:Else:Err.Raise(53):End If:End Property:End Class

REM initialize the object
Set oFms = New FileMessageStream

Dim otherFile
otherFile = "c:\location\of\~usage.1b.vbs"

REM wait for usage2 to send a message (run ~usage.1b.vbs now)
Dim response
response = oFms.ReadMessages( True )
MsgBox response, vbSystemModal, WScript.ScriptName

REM send a new message to usage2.
oFms.WriteTo(otherFile, False) = "This is from usage 1a" & vbNewLine

REM append to earlier message
oFms.WriteTo(otherFile, True) = "More from usage 1a"
