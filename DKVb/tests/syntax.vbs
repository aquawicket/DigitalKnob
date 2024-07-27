Option Explicit

Dim objFSO

Set objFSO = CreateObject("Scripting.FileSystemObject")

' Create a new folder

objFSO.CreateFolder("C:\NewFolder")

' Check if a file exists

If objFSO.FileExists("C:\Example.txt") Then

' Delete the file

objFSO.DeleteFile("C:\Example.txt")

End If