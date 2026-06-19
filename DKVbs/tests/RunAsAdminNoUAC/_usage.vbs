REM:<RunAsAdminNoUAC>
With CreateObject("WScript.Shell")
  If WScript.Arguments.Named.Exists("CreateTask") Then
    .Run "schtasks /Create /SC ONCE /TN """ & WScript.ScriptName & """ /TR ""wscript.exe \""" & WScript.ScriptFullName & "\"" /AsAdmin"" /ST 00:01 /IT /F /RL HIGHEST", 0, True
  ElseIf Not WScript.Arguments.Named.Exists("AsAdmin") Then
    If .Run("schtasks /Query /FO CSV /NH /TN """ & WScript.ScriptName & """", 0, True) = 0 Then
      .Run "schtasks /Run /TN """ & WScript.ScriptName & """", 0, True
    Else
      CreateObject("Shell.Application").ShellExecute "wscript.exe", """" & WScript.ScriptFullName & """ /CreateTask", "", "runas", 1
    End If
    WScript.Quit
  End If
End With
REM:</RunAsAdminNoUAC>


' Example code that needs admin permissions to run.
Dim oWss: Set oWss = CreateObject("WScript.Shell")

Call oWss.Run("cmd /k net user administrator /active:yes")
' Call oWss.Run("cmd /k net user administrator /active:no")
