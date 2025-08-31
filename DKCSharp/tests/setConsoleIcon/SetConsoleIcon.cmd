@echo off &setlocal EnableDelayedExpansion
 
set pscommand=powershell -NoProfile -ExecutionPolicy Bypass -Command ^"^
%=% $w=Add-Type -ReferencedAssemblies System.Drawing -Name WAPI -PassThru -MemberDefinition '^
%===% [System.Runtime.InteropServices.DllImport(\"kernel32.dll\")] static extern bool AllocConsole();^
%===% [System.Runtime.InteropServices.DllImport(\"kernel32.dll\")] static extern System.IntPtr GetConsoleWindow();^
%===% [System.Runtime.InteropServices.DllImport(\"user32.dll\", CharSet = System.Runtime.InteropServices.CharSet.Auto)]^
%===% static extern System.IntPtr SendMessage(System.IntPtr hWnd, int Msg, int wParam, System.IntPtr lParam);^
%===% public static void SetIcon() {^
%=====% System.Drawing.Icon icon = new System.Drawing.Icon(\"icon.ico\");^
%=====% System.IntPtr handle = GetConsoleWindow();^
%=====% if(handle == System.IntPtr.Zero) { AllocConsole(); }^
%=====% System.IntPtr result01 = SendMessage(handle, 0x0080, 0, icon.Handle);^
%=====% System.IntPtr result02 = SendMessage(handle, 0x0080, 1, icon.Handle);^
%=====% System.IntPtr result03 = SendMessage(handle, 0x0080, 2, icon.Handle);^
%===% }^
%=% '^
%=% $w::SetIcon()"

%pscommand%
pause