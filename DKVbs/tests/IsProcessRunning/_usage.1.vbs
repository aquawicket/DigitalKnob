Function IsProcessRunning( processNameExe )
   IsProcessRunning = GetObject("WinMgmts:\\.\root\cimv2") _
   .ExecQuery("SELECT * FROM Win32_Process WHERE Name LIKE '" & processNameExe & "'") _
      .Count > 0
End Function

'Usage
If IsProcessRunning("notepad.exe") Then
  Msgbox "notepad process is running"
Else
  Msgbox "notepad process is not running"
End If

' Using  wildcards
MsgBox IsProcessRunning("%note%")