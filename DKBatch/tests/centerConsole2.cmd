@echo off &setlocal EnableDelayedExpansion
mode con lines=20 cols=50
 
set center=powershell -NoProfile -ExecutionPolicy Bypass -Command ^"^
%=% $w=Add-Type -Name WAPI -PassThru -MemberDefinition '^
%===% [DllImport(\"kernel32.dll\")] static extern IntPtr GetConsoleWindow();^
%===% [DllImport(\"user32.dll\")] static extern void GetWindowRect(IntPtr hwnd,int[] rect);^
%===% [DllImport(\"user32.dll\")] static extern void GetMonitorInfoW(IntPtr hMonitor,int[] lpmi);^
%===% [DllImport(\"user32.dll\")] static extern IntPtr MonitorFromWindow(IntPtr hwnd,int dwFlags);^
%===% [DllImport(\"user32.dll\")] static extern void MoveWindow(IntPtr hwnd,int x,int y,int w,int h,int repaint);^
%===% public static void center() {^
%=====% var hwnd=GetConsoleWindow();^
%=====% var rect=new int[4];^
%=====% GetWindowRect(hwnd,rect);^
%=====% var moninf=new int[10];^
%=====% moninf[0]=40;^
%=====% GetMonitorInfoW(MonitorFromWindow(hwnd,2),moninf);^
%=====% MoveWindow(hwnd,^
%=======% moninf[5]+(moninf[7]-moninf[5])/2-(rect[2]-rect[0])/2,^
%=======% moninf[6]+(moninf[8]-moninf[6])/2-(rect[3]-rect[1])/2,^
%=======% rect[2]-rect[0],^
%=======% rect[3]-rect[1],^
%=======% 0);^
%===% }';^
%=% $w::center();^"

%center%
pause