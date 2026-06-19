REM:<RunAsAdmin>
' Place this code at the top of your VBScript file to run the script as an admin.
' It will quit the current script and re-run the script as an administrator.
' Note that depending on your UAC permissions you may be prompted.
' Does not support command line arguments.
If Not WScript.Arguments.Named.Exists("AsAdmin") Then
	CreateObject("Shell.Application").ShellExecute "WScript.exe", """" & WScript.ScriptFullName & """ /AsAdmin", "", "runas", 1
	WScript.Quit    
End If
REM:</RunAsAdmin>

' Your code here...