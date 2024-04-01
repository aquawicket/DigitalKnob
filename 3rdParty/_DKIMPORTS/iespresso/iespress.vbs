Option Explicit

Dim objShell, objWMI, objCmd, objMyParent
Dim strMyParentPath
Dim intMyPid, intMyParentPid, intParents

intParents = 1
If WScript.Arguments.Count > 0 Then
  If Abs(WScript.Arguments(0)) > 0 Then
    intParents = Abs(WScript.Arguments(0))
  End If
End If

Set objShell = CreateObject("WScript.Shell")
Set objWMI = GetObject("winmgmts:\\.\root\CIMV2")

Set objCmd = objShell.Exec("cmd.exe")
intMyPid = objWMI.Get("Win32_Process.Handle='" & objCmd.ProcessID & "'").ParentProcessId
objCmd.Terminate

Do While intParents > 0
  intMyParentPid = objWMI.Get("Win32_Process.Handle='" & intMyPid & "'").ParentProcessId
  Set objMyParent = objWMI.Get("Win32_Process.Handle='" & intMyParentPid & "'")
  strMyParentPath = objMyParent.ExecutablePath
  intMyPid = intMyParentPid
  intParents = intParents - 1
Loop

WScript.Echo """" & strMyParentPath & """"
