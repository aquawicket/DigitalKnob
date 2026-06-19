Function IsProcessRunning( processNameExe )
   IsProcessRunning = GetObject("WinMgmts:\\.\root\cimv2") _
   .ExecQuery("SELECT * FROM Win32_Process WHERE Name LIKE '" & processNameExe & "'") _
      .Count > 0
End Function