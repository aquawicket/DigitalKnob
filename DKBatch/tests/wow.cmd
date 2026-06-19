@echo off & setlocal EnableDelayedExpansion 

rem save how utf8

call :GetInfo

set /a X=ccx/2, Y=ccy/2

mode con cols=!X! lines=!Y!

call :init_transparent

for %%L in (50 100) do %transparent% %%L

call  :init_setfont

%setfont% 8 Terminal

mode con cols=82 lines=50

call :GetInfo
call :AndCenter

chcp 65001

for /f "delims=" %%E in (
    'forfiles /p "%~dp0." /m "%~nx0" /c "cmd /c echo.0x1B"'
  ) do (
    cls
    echo.
    <nul set /p "=%%E7"
    set "cls=<nul set /p "=%%E8""
    set "col=%%E[38;2;"
rem Hide the cursor
   <nul set /p "=%%E[?25l"
)

for /F "delims==" %%f in ('set') do if /i not "%%f"=="cls" if /i not "%%f"=="col" if /i not "%%f"=="Path" if not %%f==SystemRoot if not %%f==TMP set "%%f="

call :init_transparent

for /L %%L in (100,-25,0) do %transparent% %%L

rem ALT+219
set "P=¦ "
set /a n=0

set "c1=((( ( ((((15625*(4054-%%Y*128-%%X)) %% 2000000)/10000*(2048000000/(4054-%%Y*128-%%X)*2)/100)/100)-((2048000000/(4054-%%Y*128-%%X)*2)/100) + (%%N*10000/64) )/3000 ^ (2048000000/(4054-%%Y*128-%%X)*2)/100000) ) & 1)*10000000"
set "c2=((( ( ((((15625*(4053-%%Y*128-%%X)) %% 2000000)/10000*(2048000000/(4053-%%Y*128-%%X)*2)/100)/100)-((2048000000/(4053-%%Y*128-%%X)*2)/100) + (%%N*10000/64) )/3000 ^ (2048000000/(4053-%%Y*128-%%X)*2)/100000) ) & 1)*1000000" 
set "c3=((( ( ((((15625*(4052-%%Y*128-%%X)) %% 2000000)/10000*(2048000000/(4052-%%Y*128-%%X)*2)/100)/100)-((2048000000/(4052-%%Y*128-%%X)*2)/100) + (%%N*10000/64) )/3000 ^ (2048000000/(4052-%%Y*128-%%X)*2)/100000) ) & 1)*100000"
set "c4=((( ( ((((15625*(4051-%%Y*128-%%X)) %% 2000000)/10000*(2048000000/(4051-%%Y*128-%%X)*2)/100)/100)-((2048000000/(4051-%%Y*128-%%X)*2)/100) + (%%N*10000/64) )/3000 ^ (2048000000/(4051-%%Y*128-%%X)*2)/100000) ) & 1)*10000"
set "c5=((( ( ((((15625*(4050-%%Y*128-%%X)) %% 2000000)/10000*(2048000000/(4050-%%Y*128-%%X)*2)/100)/100)-((2048000000/(4050-%%Y*128-%%X)*2)/100) + (%%N*10000/64) )/3000 ^ (2048000000/(4050-%%Y*128-%%X)*2)/100000) ) & 1)*1000"
set "c6=((( ( ((((15625*(4049-%%Y*128-%%X)) %% 2000000)/10000*(2048000000/(4049-%%Y*128-%%X)*2)/100)/100)-((2048000000/(4049-%%Y*128-%%X)*2)/100) + (%%N*10000/64) )/3000 ^ (2048000000/(4049-%%Y*128-%%X)*2)/100000) ) & 1)*100"
set "c7=((( ( ((((15625*(4048-%%Y*128-%%X)) %% 2000000)/10000*(2048000000/(4048-%%Y*128-%%X)*2)/100)/100)-((2048000000/(4048-%%Y*128-%%X)*2)/100) + (%%N*10000/64) )/3000 ^ (2048000000/(4048-%%Y*128-%%X)*2)/100000) ) & 1)*10"
set "c8=((( ( ((((15625*(4047-%%Y*128-%%X)) %% 2000000)/10000*(2048000000/(4047-%%Y*128-%%X)*2)/100)/100)-((2048000000/(4047-%%Y*128-%%X)*2)/100) + (%%N*10000/64) )/3000 ^ (2048000000/(4047-%%Y*128-%%X)*2)/100000) ) & 1)"

rem 6.90fps, 8.55fps, 9.30fps, 9.74fps, 10,25fps

(
set cls=
set col=
set c1=
set c2=
set c3=
set c4=
set c5=
set c6=
set c7=
set c8=

for /L %%N in (-65,-1,-10000) do (


  %cls% 
  For /L %%Y in (6,-1,-28) do (
	set St=
	For /L %%X in (-20,8,52) do (

		set /a "a=100000000 + %c1% + %c2% + %c3% + %c4% + %c5% + %c6% + %c7% + %c8%"

		for /f "tokens=1-8" %%i in ("!a:~1,1! !a:~2,1! !a:~3,1! !a:~4,1! !a:~5,1! !a:~6,1! !a:~7,1! !a:~8,1!") do set St=!St!!P:~%%~i,1!!P:~%%~j,1!!P:~%%~k,1!!P:~%%~l,1!!P:~%%~m,1!!P:~%%~n,1!!P:~%%~o,1!!P:~%%~p,1!
	)
	
	set /a "H=H=(%%Y+28)*(2560/26)/10, V=(n+10)*40"

	if !V! gtr 10000 set V=10000

	set /a "mm = (h*10000/60 %% 20000) - 10000, mm=(mm>>31|1)*mm, C = V, X = C *(10000 - mm)/10000, C=C*255/10000, X=X*255/10000"

	if !H! lss 60 (set /a R=C, G=X, B=0) else (
   		if !H! lss 120 (set /a R=X, G=C, B=0) else (
      			if !H! lss 180 (set /a R=0, G=C, B=X) else (
         			if !H! lss 240 (set /a R=0, G=X, B=C) else (
            				if !H! lss 300 (set /a R=X, G=0, B=C) else (
               					if !H! lss 360 (set /a R=C, G=0, B=X) else (echo ERROR!)
            				)
         			)
      			)
   		)
	)

	echo. %col%!R!;!G!;!B!m!St!
  )

  set /a n+=1
 
  for /F "tokens=1-8 delims=:.," %%a in ("%time: =0%:!time: =0!") do set /a "a=(((1%%e-1%%a)*60)+1%%f-1%%b)*6000+1%%g%%h-1%%c%%d, a+=(a>>31) & 8640000, FPS=10000*n/a"
  title FPS=!FPS:~0,-2!.!FPS:~-2! &set "a="& set "FPS="
  
)
)

pause
goto :eof

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:init_transparent
setlocal DisableDelayedExpansion
rem Define the transparency of the console window.
rem Usage:
rem %transparent% percentage
rem   percentage  0 (opaque) to 100 (limpid)
set transparent=for %%- in (1 2) do if %%-==2 (for /f %%. in ("^^!arg^^! x") do ^
%=% powershell -nop -ep Bypass -c ^"^
%===% $w=Add-Type -Name WAPI -PassThru -MemberDefinition '^
%=====% [DllImport(\"user32.dll\")]^
%=======% public static extern void SetWindowLong(IntPtr wnd, int idx, int newLong);^
%=====% [DllImport(\"user32.dll\")]^
%=======% public static extern void SetWindowLongPtr(IntPtr wnd, int idx, Int64 newLong);^
%=====% [DllImport(\"user32.dll\")]^
%=======% public static extern int GetWindowLong(IntPtr wnd, int idx);^
%=====% [DllImport(\"user32.dll\")]^
%=======% public static extern Int64 GetWindowLongPtr(IntPtr wnd, int idx);^
%=====% [DllImport(\"user32.dll\")]^
%=======% public static extern int SetLayeredWindowAttributes(IntPtr wnd, int color, byte alpha, int flags);^
%=====% [DllImport(\"kernel32.dll\")]^
%=======% public static extern IntPtr GetConsoleWindow();^
%===% ';^
%===% $val=0;^
%===% if (-not [Int32]::TryParse(\"%%~.\", [ref]$val) -or $val -lt 0 -or $val -gt 100) {exit 1;}^
%===% $GWL_EXSTYLE=-20;^
%===% $WS_EX_LAYERED=0x80000;^
%===% $wnd=$w::GetConsoleWindow();^
%===% if ([IntPtr]::Size -eq 4) { %= Win x86 =%^
%=====% $w::SetWindowLong($wnd, $GWL_EXSTYLE, $w::GetWindowLong($wnd, $GWL_EXSTYLE) -bOr $WS_EX_LAYERED);^
%===% } else { %= Win x64 =%^
%=====% $w::SetWindowLongPtr($wnd, $GWL_EXSTYLE, $w::GetWindowLongPtr($wnd, $GWL_EXSTYLE) -bOr [Int64]$WS_EX_LAYERED);^
%===% }^
%===% $LWA_ALPHA=2;^
%===% exit ($w::SetLayeredWindowAttributes($wnd, 0, [byte](2.55 * (100 - $val) + 0.5), $LWA_ALPHA) -eq 0);^
%=% ^" ^&endlocal) else setlocal EnableDelayedExpansion ^&set arg=

endlocal &set "transparent=%transparent%"
if !!# neq # set "transparent=%transparent:^^=%"
exit /b
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:init_setfont
rem - BRIEF -
rem  Get or set the console font size and font name.
rem - SYNTAX -
rem  %setfont% [fontSize [fontName]]
rem    fontSize   Size of the font. (Can be 0 to preserve the size.)
rem    fontName   Name of the font. (Can be omitted to preserve the name.)
rem - EXAMPLES -
rem  Output the current console font size and font name:
rem    %setfont%
rem  Set the console font size to 14 and the font name to Lucida Console:
rem    %setfont% 14 Lucida Console
setlocal DisableDelayedExpansion
set setfont=for /l %%# in (1 1 2) do if %%#==2 (^
%=% for /f "tokens=1,2*" %%- in ("? ^^!arg^^!") do endlocal^&powershell.exe -nop -ep Bypass -c ^"Add-Type '^
%===% using System;^
%===% using System.Runtime.InteropServices;^
%===% [StructLayout(LayoutKind.Sequential,CharSet=CharSet.Unicode)] public struct FontInfo{^
%=====% public int objSize;^
%=====% public int nFont;^
%=====% public short fontSizeX;^
%=====% public short fontSizeY;^
%=====% public int fontFamily;^
%=====% public int fontWeight;^
%=====% [MarshalAs(UnmanagedType.ByValTStr,SizeConst=32)] public string faceName;}^
%===% public class WApi{^
%=====% [DllImport(\"kernel32.dll\")] public static extern IntPtr CreateFile(string name,int acc,int share,IntPtr sec,int how,int flags,IntPtr tmplt);^
%=====% [DllImport(\"kernel32.dll\")] public static extern void GetCurrentConsoleFontEx(IntPtr hOut,int maxWnd,ref FontInfo info);^
%=====% [DllImport(\"kernel32.dll\")] public static extern void SetCurrentConsoleFontEx(IntPtr hOut,int maxWnd,ref FontInfo info);^
%=====% [DllImport(\"kernel32.dll\")] public static extern void CloseHandle(IntPtr handle);}';^
%=% $hOut=[WApi]::CreateFile('CONOUT$',-1073741824,2,[IntPtr]::Zero,3,0,[IntPtr]::Zero);^
%=% $fInf=New-Object FontInfo;^
%=% $fInf.objSize=84;^
%=% [WApi]::GetCurrentConsoleFontEx($hOut,0,[ref]$fInf);^
%=% If('%%~.'){^
%===% $fInf.nFont=0; $fInf.fontSizeX=0; $fInf.fontFamily=0; $fInf.fontWeight=0;^
%===% If([Int16]'%%~.' -gt 0){$fInf.fontSizeX=[Int16]'%%~.';$fInf.fontSizeY=[Int16]'%%~.'}^
%===% If('%%~/'){$fInf.faceName='%%~/'}^
%===% [WApi]::SetCurrentConsoleFontEx($hOut,0,[ref]$fInf);}^
%=% Else{(''+$fInf.fontSizeY+' '+$fInf.faceName)}^
%=% [WApi]::CloseHandle($hOut);^") else setlocal EnableDelayedExpansion^&set arg=
endlocal &set "setfont=%setfont%"
if !!# neq # set "setfont=%setfont:^^!=!%"
goto :eof
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:GetInfo

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem The %ConsoleInfo% macro collects properties of the console window and its environment.
rem It prints a string in the following format to StdOut:
rem   cml=N,cmt=N,cmr=N,cmb=N,cwx=N,cwy=N,cvx=N,cvy=N,cfx=N,cfy=N,chx=N,chy=N,ccx=N,ccy=N,clx=N,cly=N
rem With:
rem   N    different integral values of the below properties
rem   cml  left dots boundary of the monitor's workspace
rem   cmt  top dots boundary of the monitor's workspace
rem   cmr  right dots boundary of the monitor's workspace
rem   cmb  bottom dots boundary of the monitor's workspace
rem   cwx  current width of the console window as number of dots
rem   cwy  current height of the console window as number of dots
rem   cvx  current width of the console viewport as number of dots
rem   cvy  current height of the console viewport as number of dots
rem   cfx  console font width as number of pixels
rem   cfy  console font height as number of pixels
rem   chx  approximated console charcell width as number of dots
rem   chy  approximated console charcell height as number of dots
rem   ccx  current width of the console client window as number of character cells
rem   ccy  current height of the console client window as number of character cells
rem   clx  largest width of the console client window as number of character cells
rem   cly  largest height of the console client window as number of character cells
rem To define variables %cfx% .. %cly%, execute the macro in a FOR /F loop like that:
rem   FOR /F %%I IN ('%ConsoleInfo%') DO SET /A "%%I"
set ConsoleInfo=^
powershell -nop -ep Bypass -c ^"^
%=% $w=Add-Type -Name WAPI -PassThru -MemberDefinition '^
%===% [DllImport(\"user32.dll\"^)]^
%=====% public static extern void SetProcessDPIAware(^);^
%===% [DllImport(\"shcore.dll\"^)]^
%=====% public static extern void SetProcessDpiAwareness(int value^);^
%===% [DllImport(\"kernel32.dll\"^)]^
%=====% public static extern IntPtr GetConsoleWindow(^);^
%===% [DllImport(\"user32.dll\"^)]^
%=====% public static extern void GetWindowRect(IntPtr hwnd, int[] rect^);^
%===% [DllImport(\"user32.dll\"^)]^
%=====% public static extern void GetClientRect(IntPtr hwnd, int[] rect^);^
%===% [DllImport(\"user32.dll\"^)]^
%=====% public static extern void GetMonitorInfoW(IntPtr hMonitor, int[] lpmi^);^
%===% [DllImport(\"user32.dll\"^)]^
%=====% public static extern IntPtr MonitorFromWindow(IntPtr hwnd, int dwFlags^);^
%===% [DllImport(\"kernel32.dll\"^)]^
%=====% public static extern IntPtr CreateFile(string name, int acc, int share, IntPtr sec, int how, int flags, IntPtr tmplt^);^
%===% [DllImport(\"kernel32.dll\"^)]^
%=====% public static extern void GetCurrentConsoleFont(IntPtr hOut, int isMax, int[] info^);^
%===% [DllImport(\"kernel32.dll\"^)]^
%=====% public static extern void CloseHandle(IntPtr h^);^
%=% ';^
 ^
%=% $PROCESS_PER_MONITOR_DPI_AWARE=2;^
%=% try {$w::SetProcessDpiAwareness($PROCESS_PER_MONITOR_DPI_AWARE^)} catch {$w::SetProcessDPIAware(^)}^
 ^
%=% $hwnd=$w::GetConsoleWindow(^);^
%=   The $moninf array is a replacement for the MONITORINFO structure. The elements at index         =% ^
%=   5, 6, 7, and 8 represent left, top, right, and bottom boundaries of the monitor's work space.   =% ^
%=% $moninf=[int[]]::new(10^);^
%=% $moninf[0]=40;^
%=% $MONITOR_DEFAULTTONEAREST=2;^
%=% $w::GetMonitorInfoW($w::MonitorFromWindow($hwnd, $MONITOR_DEFAULTTONEAREST^), $moninf^);^
 ^
%=   The $wrect array is a replacement for the RECT structure. The elements at index    =% ^
%=   0, 1, 2, and 3 represent left, top, right, and bottom boundaries of the window.   =% ^
%=% $wrect=[int[]]::new(4^);^
%=% $w::GetWindowRect($hwnd, $wrect^);^
 ^
%=   The $crect array is a replacement for the RECT structure. The elements at index          =% ^
%=   0, 1, 2, and 3 represent left, top, right, and bottom boundaries of the client window.   =% ^
%=% $crect=[int[]]::new(4^);^
%=% $w::GetClientRect($hwnd, $crect^);^
 ^
%=% $NIL=[IntPtr]::Zero;^
%=% $GENERIC_READ=0x80000000;^
%=% $GENERIC_WRITE=0x40000000;^
%=% $FILE_SHARE_WRITE=0x00000002;^
%=% $OPEN_EXISTING=3;^
%=   Because the StdOut stream is redirected to a pipe behind the scenes of a FOR /F loop,   =% ^
%=   we need to explicitly open a handle to the console output device (alias 'CONOUT$').     =% ^
%=% $out=$w::CreateFile('CONOUT$', $GENERIC_READ -bor $GENERIC_WRITE, $FILE_SHARE_WRITE, $NIL, $OPEN_EXISTING, 0, $NIL^);^
%=   The $fntinf array is a replacement for the CONSOLE_FONT_INFO structure. The 16 low order bits of the   =% ^
%=   second element represent the font width, while its 16 high order bits represent the font height.       =% ^
%=% $fntinf=[int[]]::new(2^);^
%=% $w::GetCurrentConsoleFont($out, 0, $fntinf^);^
%=% $w::CloseHandle($out^);^
 ^
%=% $raw=$host.UI.RawUI;^
%=% $cur=$raw.WindowSize;^
%=% $lrg=$raw.MaxPhysicalWindowSize;^
 ^
%=% 'cml={0},cmt={1},cmr={2},cmb={3},cwx={4},cwy={5},cvx={6},cvy={7},cfx={8},cfy={9},chx={10},chy={11},ccx={12},ccy={13},clx={14},cly={15}' -f^
%===% $moninf[5], $moninf[6], $moninf[7], $moninf[8],^
%===% ($wrect[2]-$wrect[0]^), ($wrect[3]-$wrect[1]^),^
%===% ($crect[2]-$crect[0]^), ($crect[3]-$crect[1]^),^
%===% ($fntinf[1] -band 0xFFFF^), ($fntinf[1] -shr 16^),^
%===% [math]::Round(($crect[2]-$crect[0]^)/$cur.Width^), [math]::Round(($crect[3]-$crect[1]^)/$cur.Height^),^
%===% $cur.Width, $cur.Height,^
%===% $lrg.Width, $lrg.Height;^
 ^"
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem %MoveWindow% X Y
rem   X  left side of the window
rem   Y  top of the window
set MoveWindow=for %%i in (1 2) do if %%i==2 (^
%=% for /f "tokens=1*" %%j in ("^!arg^!") do (powershell.exe -nop -ep Bypass -Command ^"^
%===% try {$w=Add-Type -Name WAPI -PassThru -MemberDefinition '^
%=====% [DllImport(\"user32.dll\"^)]^
%=======% public static extern void SetProcessDPIAware(^);^
%=====% [DllImport(\"shcore.dll\"^)]^
%=======% public static extern void SetProcessDpiAwareness(int value^);^
%=====% [DllImport(\"user32.dll\"^)]^
%=======% public static extern int SetWindowPos(IntPtr hWnd^, IntPtr hWndInsertAfter^, int X^, int Y^, int cx^, int cy^, uint uFlags^);^
%=====% [DllImport(\"kernel32.dll\"^)]^
%=======% public static extern IntPtr GetConsoleWindow(^);^
%===% ';^
%===% $PROCESS_PER_MONITOR_DPI_AWARE=2;^
%===% try {$w::SetProcessDpiAwareness($PROCESS_PER_MONITOR_DPI_AWARE^)} catch {$w::SetProcessDPIAware(^)}^
%===% $x=0; $y=0;^
%===% if (([Int32]::TryParse(\"%%~j\"^, [ref]$x^) -eq $false^) -or ([Int32]::TryParse(\"%%~k\"^, [ref]$y^) -eq $false^)^){^
%=====% [Console]::Error.WriteLine(\"Syntax Error`r`n Usage:`r`n%%MoveWindow%% X Y`r`n   X  left side of the window`r`n   Y  top of the window\"^);^
%=====% exit 1;^
%===% }^
%===% exit [int]($w::SetWindowPos($w::GetConsoleWindow(^)^, [IntPtr]::Zero^, $x^, $y^, 0^, 0^, 5^) -eq 0^)} catch {exit 1}^"^
%=% )^
%=% ^&endlocal^
) else setlocal EnableDelayedExpansion ^&set arg=
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
::
for /f %%i in ('%ConsoleInfo%') do set /a "%%i"
goto :eof
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:AndCenter

rem center the window
set /a "newX=cml+(cmr-cml)/2-cwx/2, newY=cmt+(cmb-cmt)/2-cwy/2"
%MoveWindow% %newX% %newY%

rem title Move to %newX%,%newY%

goto :eof

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::