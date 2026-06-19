set move_window=for %%i in (1 2) do if %%i==2 (%\n%
%=% for /f "tokens=1*" %%j in ("^!arg^!") do (%\n%
%=====% powershell.exe -NoProfile -ExecutionPolicy Bypass -Command ^"try{$c=Add-Type -Name WinAPI -PassThru -MemberDefinition '^
%=====% [DllImport(\"user32.dll\"^)] public static extern void SetProcessDPIAware(^);^
%=====% [DllImport(\"user32.dll\"^)] public static extern int SetWindowPos(IntPtr hWnd^, IntPtr hWndInsertAfter^, int X^, int Y^, int cx^, int cy^, uint uFlags^);^
%=====% [DllImport(\"kernel32.dll\"^)] public static extern IntPtr GetConsoleWindow(^);';^
%=====% $c::SetProcessDPIAware(^);^
%=====% $x=0; $y=0;^
%=====% if (([Int32]::TryParse(\"%%~j\"^, [ref]$x^) -eq $false^) -or ([Int32]::TryParse(\"%%~k\"^, [ref]$y^) -eq $false^)^){^
%=========% [Console]::Error.WriteLine(\"Syntax Error`r`n Usage:`r`n%%move_window%% X Y`r`n   X  left side of the window`r`n   Y  top of the window\"^);^
%=========% exit 1;^
%=====% }^
%=====% exit [int]($c::SetWindowPos($c::GetConsoleWindow(^)^, [IntPtr]::Zero^, $x^, $y^, 0^, 0^, 5^) -eq 0^);}catch{exit 1;}^"%\n%
%=% )%\n%
%=% endlocal%\n%
) else setlocal EnableDelayedExpansion ^&set arg=