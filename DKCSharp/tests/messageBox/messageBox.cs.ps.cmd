@echo off 
setlocal EnableDelayedExpansion
 
set pscommand=powershell -NoProfile -ExecutionPolicy Bypass -Command ^"^
$dk=Add-Type -ReferencedAssemblies System.Drawing -Name WAPI -PassThru -MemberDefinition '^
[System.Runtime.InteropServices.DllImport(\"user32.dll\", CharSet = System.Runtime.InteropServices.CharSet.Auto)]^
public static extern int MessageBox(System.IntPtr hWnd, System.String text, System.String caption, int options);';^
$dk::MessageBox([IntPtr]::Zero, \"text\", \"caption\", 0);"


%pscommand%
pause
