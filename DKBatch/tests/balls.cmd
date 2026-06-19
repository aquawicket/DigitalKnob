@echo off & setlocal enableDelayedExpansion & if NOT "%1"=="" goto :dispatch

rem save this script in UTF-8

rem restart maximized

Start "Sphere" /MAX "%~f0" max

goto :eof
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:dispatch

if "%1"=="max" (

	call :GetInfo

	rem setting request console size and remove buffers size on max
	mode CON: COLS=!MaxConsoleSize.X! LINES=!MaxConsoleSize.Y!

	rem multithread 9 thread

	set /A deltaX=MaxConsoleSize.X/3, deltaY=MaxConsoleSize.Y/3, Radius=DeltaY/2

	start "" /B "%~f0" sphere Red     1 1 !deltaX! !deltaY! !Radius!
	start "" /B "%~f0" sphere Green   !deltaX! 1 !deltaX!*2 !deltaY! !Radius!
	start "" /B "%~f0" sphere Blue    !deltaX!*2 1 !deltaX!*3 !deltaY! !Radius!

	start "" /B "%~f0" sphere Yellow  1 !deltaY!+1 !deltaX! !deltaY!*2 !Radius!
	start "" /B "%~f0" sphere Cyan    !deltaX! !deltaY!+1 !deltaX!*2 !deltaY!*2 !Radius!
	start "" /B "%~f0" sphere Magenta !deltaX!*2 !deltaY!+1 !deltaX!*3 !deltaY!*2 !Radius!

	start "" /B "%~f0" sphere White   1 !deltaY!*2+1 !deltaX! !deltaY!*3 !Radius!
	start "" /B "%~f0" sphere Orange  !deltaX! !deltaY!*2+1 !deltaX!*2 !deltaY!*3 !Radius!
	start "" /B "%~f0" sphere Pink    !deltaX!*2 !deltaY!*2+1 !deltaX!*3 !deltaY!*3 !Radius!

	pause>nul
)

if "%1"=="sphere" call :sphere %2 %3 %4 %5 %6 %7

goto :eof
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:sphere color Begin.X Begin.Y End.X End.Y Radius

rem title %1 %2 %3 %4 %5 %6
rem pause 

call :init

set /A Bimg.x=%2, Bimg.y=%3
set /A Eimg.x=%4, Eimg.y=%5
set /A Radius=%6

rem font size in pixels
set /A xc=FontSize.X, yc=FontSize.Y

rem draw a circle (x-x0)^2+(y-y0)^2=r^2 . Implicit equation for simpler math.

rem set radius and center in cmd windows, assume screen ratio greater than one ie 1280/720=1.777

set /A "R=Radius*yc, X0=((Eimg.x-Bimg.x)/2+Bimg.x)*xc, Y0=Bimg.y*yc+R"

rem setting step for better smoothing colors
set /A "mS=-(R*R), step=255*100000/-mS, stepL=128*100000/-mS"

For /L %%y in (!Bimg.y!,1,!Eimg.y!) do (

  For /L %%x in (!Bimg.x!,1,!Eimg.x!) do (

	rem calculate circle equation and color for smooting.
	rem This code generate multiple circlesof different color and simulate a 3D sphere.
        set /A px=%%x*xc, py=%%y*yc, x=px-x0, y=py-y0, S=y*y+x*x-R*R, C=-S*step/100000, CL=-S*stepL/100000"

	if !S! leq 0 (
		if "%1"=="Red" %plot% %%x %%y !C! 0 0
		if "%1"=="Green" %plot% %%x %%y 0 !C! 0
		if "%1"=="Blue" %plot% %%x %%y 0 0 !C!
		if "%1"=="Yellow" %plot% %%x %%y !C! !C! 0
		if "%1"=="Cyan" %plot% %%x %%y 0 !C! !C!
		if "%1"=="Magenta" %plot% %%x %%y !C! 0 !C!
		if "%1"=="White" %plot% %%x %%y !C! !C! !C!
		if "%1"=="Orange" %plot% %%x %%y !C! !CL! 0
		if "%1"=="Pink" %plot% %%x %%y !C! 0 !CL!
		if "%1"=="Salmon" %plot% %%x %%y !C! !CL! !CL!
		if "%1"=="Navy" %plot% %%x %%y 0 0 !CL!
		if "%1"=="Gray" %plot% %%x %%y !CL! !CL! !CL!
	)
  )
) 
%flush%

pause>nul
goto :eof
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:GetInfo

rem many thanks aGerman and Aacini
set ConsoleInfo=^
powershell ^
 ^"$w=Add-Type -Name WAPI -PassThru -MemberDefinition ' ^
      [DllImport(\"kernel32.dll\"^)] public static extern ^
         IntPtr CreateFile(string name,int acc,int share,IntPtr sec,int how,int flags,IntPtr tmplt^); ^
      [DllImport(\"kernel32.dll\"^)] public static extern void GetCurrentConsoleFont(IntPtr hOut,int isMax,int[] info^); ^
      [DllImport(\"kernel32.dll\"^)] public static extern void CloseHandle(IntPtr h^); ^
   '; ^
   [int[]]$info=0,0; ^
   $h=$w::CreateFile('CONOUT$',0xC0000000,2,[IntPtr]::Zero,3,0,[IntPtr]::Zero^); ^
   $w::GetCurrentConsoleFont($h,0,$info^); ^
   $w::CloseHandle($h^); ^
   \"cfx^=$($info[1] -band 0xFFFF^)^,cfy^=$($info[1] -shr 16^)\"; ^
   $r=$host.UI.RawUI; ^
   $c=$r.WindowSize; ^
   \"ccx^=$($c.Width^)^,ccy^=$($c.Height^)\"; ^
   $l=$r.MaxPhysicalWindowSize; ^
   \",clx^=$($l.Width^)^,cly^=$($l.Height^)\"; ^
 ^"

for /f %%i in ('%ConsoleInfo%') do set /a "%%i"

rem font size in pixels
set /a "FontSize.X=%cfx%, FontSize.Y=%cfy%"

rem max/largest Size of cmd window/console window
set /a "MaxConsoleSize.X=%clx%, MaxConsoleSize.Y=%cly%"

rem Current Size of cmd window/console window
set /a "ConsoleSize.X=%ccx%, ConsoleSize.Y=%ccy%"

rem get resolution of screen
for /f "usebackq tokens=1,2 delims= " %%x in (
`mshta "javascript:new ActiveXObject('Scripting.FileSystemObject').GetStandardStream(1).Write(screen.width+' '+screen.height);close();noflash"`
) do set /A Screen.Width=%%x, Screen.Height=%%y

goto :eof
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:init

rem for ansi sequence
for /F %%a in ('echo prompt $E^| %ComSpec%') do set "ESC=%%a"

rem Hide the cursor
<nul set /p "=!ESC![?25l"

rem this code must execute after GetConsoleFontSize macro, if not this change font family to TERMINAL/RASTER, in window 10
chcp 65001 >nul

rem clear environment for faster execution of SET command
(
set "Path=%SystemRoot%\system32"
for /F "Tokens=1 delims==" %%v in ('set') do if not %%v==ESC if not %%v==TMP if not %%v==Path set "%%v="
set /a "FontSize.X=%FontSize.X%, FontSize.Y=%FontSize.Y%"
set /a "ConsoleSize.X=%ConsoleSize.X%, ConsoleSize.Y=%ConsoleSize.Y%"
set /a "MaxConsoleSize.X=%MaxConsoleSize.X%, MaxConsoleSize.Y=%MaxConsoleSize.Y%"
set /A Screen.Width=%Screen.Width%, Screen.Height=%Screen.Height%
)

rem ALT+219
set "Char=¦"
rem set "Char=*"

rem for macro definition/readability
(set \n=^^^
%= This creates an escaped Line Feed - DO NOT ALTER =%
)

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem macro Plot=Screen.Setpixel X Y R G B

set "Buffer="

set Plot=for %%# in (1 2) do if %%#==2 (%\n%
	for /f "tokens=1-5 delims=, " %%1 in ("^!args^!") do ( %\n%
		if not defined Buffer (%\n%
			set "Buffer=^!ESC^![%%2;%%1H^!ESC^![38;2;%%3;%%4;%%5m^!Char^!" %\n%
		) else ( %\n%
			if "^!Buffer:~100,1^!"=="" ( %\n%
				set "Buffer=^!Buffer^!^!ESC^![%%2;%%1H^!ESC^![38;2;%%3;%%4;%%5m^!Char^!" %\n%
			) else ( %\n%
				^<nul set /p "=^!Buffer^!^!ESC^![%%2;%%1H^!ESC^![38;2;%%3;%%4;%%5m^!Char^!^!ESC^![0m" %\n%
				set "Buffer=" %\n%
			) %\n%
		) %\n%
)) else set args=

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
rem Flush flush the variable buffer.

set Flush=^<nul set /p "=^!Buffer^!^!ESC^![0m" ^& set "Buffer="

goto :eof
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::