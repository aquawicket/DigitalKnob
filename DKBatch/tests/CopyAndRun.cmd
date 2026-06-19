@echo off &setlocal EnableDelayedExpansion
 
powershell -Command get-clipboard | out-file code.txt
::%===% [DllImport(\"user32.dll\")] static extern int GetSystemMetrics(int nIndex);^
::%===% [DllImport(\"kernel32.dll\")] static extern IntPtr GetConsoleWindow();^
::%===% [DllImport(\"user32.dll\")] static extern int GetWindowPlacement(IntPtr hWnd, int[] lpwndpl);^
::%===% [DllImport(\"user32.dll\")] static extern int SetWindowPlacement(IntPtr hWnd, int[] lpwndpl);^
::%===% public static void center() {^
::%=====% int screen_width=GetSystemMetrics(16), screen_height=GetSystemMetrics(17);^
::%=====% var wpl=new int[11];^
::%=====% wpl[0]=44;^
::%=====% GetWindowPlacement(GetConsoleWindow(), wpl);^
::%=====% int top=screen_height / 2 - (wpl[10] - wpl[8]) / 2,^
::%=========% left=screen_width / 2 - (wpl[9] - wpl[7]) / 2,^
::%=========% bottom=top + (wpl[10] - wpl[8]),^
::%=========% right=left + (wpl[9] - wpl[7]);^
::%=====% SetWindowPlacement(GetConsoleWindow(),^
::%=======% new []{wpl[0], 0, 1, wpl[3], wpl[4], wpl[5], wpl[6], left, top, right, bottom});^
::%===% }^
::%=% ';^


pause











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% CopyAndRun
%endfunction%

