REM:<RunAsAdminNoUAC>
' Place this code at the top of your VBScript file you'd like to run with admin permissions.
' When you first run it it will ask for UAC permissions and run and add a task to your Windows 'Task Scheduler' with the name of the script.
' From here on out the VBScript file name and location should not be changed.
' Next time you run it, it will be called from the Task Scheduler with admin permissions and thus not prompt for UAC anymore.
' This script runs with WScript.exe, and does not support command line arguments.
' To delete the task, use the Windows Task Scheduler.
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

' Your code here...
