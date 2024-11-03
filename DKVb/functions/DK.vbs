Function ForceConsole()	
    If InStr(LCase(WScript.FullName), "cscript.exe") = 0 Then
		Set oWSH = CreateObject("WScript.Shell")
        oWSH.Run "cmd.exe /k cscript.exe" & " //NoLogo " & Chr(34) & WScript.ScriptFullName & Chr(34)
        WScript.Quit
    End If
End Function
Call ForceConsole()
WScript.StdOut.Write Chr(27) & "[34A" 'move cursor to beggining of cmd screen
WScript.StdOut.Write Chr(27) & "[2J"  'clear screen
