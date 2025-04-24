'From Winhelponline.com
'Forces a refresh of the shell icons by resetting .txt file association
If WScript.Arguments.length = 0 Then
   Set objShell = CreateObject("Shell.Application")
   objShell.ShellExecute "wscript.exe", Chr(34) & _
   WScript.ScriptFullName & Chr(34) & " uac", "", "runas", 1
Else   
   Dim WshShell
   Set WshShell = WScript.CreateObject("Wscript.Shell")
   sCmd = "cmd.exe /c assoc .txt=textfile"
   WshShell.Run sCmd,0,True
   sCmd = "cmd.exe /c assoc .txt=txtfile"   
End If