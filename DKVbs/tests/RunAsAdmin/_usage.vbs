REM:<RunAsAdmin>
If Not WScript.Arguments.Named.Exists("AsAdmin") Then
	CreateObject("Shell.Application").ShellExecute "WScript.exe", """" & WScript.ScriptFullName & """ /AsAdmin", "", "runas", 1
	WScript.Quit    
End If
REM:</RunAsAdmin>

' Example code that needs admin permissions to run.
Dim oWss: Set oWss = CreateObject("WScript.Shell")
Call oWss.Run("cmd /k net user administrator /active:yes")
' Call oWss.Run("cmd /k net user administrator /active:no")
