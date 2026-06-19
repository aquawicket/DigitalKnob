:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
@echo off & setlocal EnableDelayedExpansion 

    :: Porting By Francesco Poscetti aka einstein1969

	:: Use raster font 8x8, save in utf8

	:: v 0.1.0  	29/04/2023 Bigger sphere point/Point Decoration, better autotune algoritms
	::
	:: v 0.0.3 	update sin code, use vt100, , use bullet ·
	::		code optimization for faster execution, 
	:: 		auto tune number of points for dinamic resolution based on pc performance (static)
	::		better zbuffer, break near infinite loop by jeb.
	::
	:: v 0.0.2 	passed from 16.6 FPS to ~20.0 FPS

    :: Variables enigma:

    :: _R   =   Sphere radius
    :: rt   =   Rotation angle
    :: ds   =   Distance Z of sphere
    :: _dx,_dy   =   Offset x,y of projecting coordinates in 2D plane.
    :: sx,cx   =   Sine, cosine of rotation angle
    :: a,b,c   =   Rotation coordinate 3D
    :: a,b   =   X,Y coordinate of projecting 3D to 2D
    :: c   =   Z coordinate

    :: Ref:
    :: https://invisible-island.net/xterm/ctlseqs/ctlseqs.html
    :: https://learn.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
  title Sphere 3D
  set /a _cols=120, _lines=90
  mode %_cols%,%_lines%
  set /a _cols-=2, _lines-=2
  cls

  rem utf 8
  chcp 65001 >nul
  for /F %%a in ('Echo(prompt $E^| cmd') Do Set _ESC=%%a

:ChoiceLabel
  echo(
  echo Select the maximum speed. Choose a number between 1 and 9 where:
  echo(
  echo 1 = 50.0 FPS (Frame Per Second) Very Fast, few sphere point
  echo 2 = 33.3 FPS
  echo 3 = 25.0 FPS
  echo 4 = 20.0 FPS
  echo 5 = 16.6 FPS
  echo 6 = 14.2 FPS
  echo 7 = 12.5 FPS
  echo 8 = 11.1 FPS
  echo 9 = 10.0 FPS Slow, high number of sphere point
  echo(

  choice /M "Select the maximum speed. Choose a number between 1 and 9 where 1 very fast and 9 slow. Default [4] ?" /D 4 /C 123456789 /T 8 /N
  if %errorlevel% gtr 0 (set /a _dT=%errorlevel%+1, _FPS=100/_dT) else goto :ChoiceLabel

(  
  for /F "Tokens=1 delims==" %%v in ('set') do set "%%v="
  set /a "_cols=%_cols%, _lines=%_lines%"
  set "_ESC=%_ESC%"
  set "_dT=%_dT%"
  set "_FPS=%_FPS%"
)

  set "_loop=FOR /L %%# in (1,1,2) do "
  %_loop%%_loop% set "_loop=!_loop!!_loop!!_loop!"

  :: check pc performance. Return var "ms"
  call :perf

  rem https://www.dostips.com/forum/viewtopic.php?f=3&t=4896
  set "_SIN(x)=(a=((x)%%62832)+(((x)%%62832)>>31&62832), b=(a-15708^a-47124)>>31,a=(-a&b)+(a&~b)+(31416&b)+(-62832&(47123-a>>31)),a-a*a/1875*a/320000+a*a/1875*a/15625*a/16000*a/2560000-a*a/1875*a/15360*a/15625*a/15625*a/16000*a/44800000)"

:: Main loop

  :: Hide the cursor
  <nul set /p "=%_ESC%[?25l"

  set /a "_R=160, _dx=_cols/2, _dy=_lines/2, _dz=4000, _ndx=6, ds=0, rt=0, i=1"

  for /L %%L in () do (

	%= Prepare for faster dinamic execution =%

	set /a "_ndy=_ndx/2, _stepx=62832/_ndx, _stepy=31416/_ndy"

	%= rainbow colors =%
	set /a H=0, dH=359/_ndx, V=10000

	for /L %%C in (1,1,!_ndx!) do (

	  set /a "mm = (H*10000/60 %% 20000) - 10000, mm=(mm>>31|1)*mm, C = V, X = C *(10000 - mm)/10000, C=C*255/10000, X=X*255/10000"
	  if !H! lss 60 (set /a R=C, G=X, B=0) else (
   		if !H! lss 120 (set /a R=X, G=C, B=0) else (
			if !H! lss 180 (set /a R=0, G=C, B=X) else (
				if !H! lss 240 (set /a R=0, G=X, B=C) else (
					if !H! lss 300 (set /a R=X, G=0, B=C) else (
						if !H! lss 360 (set /a R=C, G=0, B=X) else (echo ERROR!)
	  )))))
	  %= compute for 216 color map =%
          set /A "C_%%C=((R-35)/40+((R-48)>>8)-((R-75)>>8))*36 + ((G-35)/40+((G-48)>>8)-((G-75)>>8))*6 + ((B-35)/40+((B-48)>>8)-((B-75)>>8)) + 16"
	  set /A H+=dH
	)
	%= Empty vars =%
	rem cambiare nome per auto clean con for
	set "X=" & set "V=" & set "G=" & set "R=" & set "C=" & set "B=" & set "mm=" & set "dH=" & set "H="

	%= meridians =%	
	set /a "angle=0"	
	set "_X="
	for /L %%X in (1,1,!_ndx!) do (
		set /A "sx=%_SIN(x):x=angle%, cx=%_SIN(x):x=(15708-angle)%, angle+=_stepx"
		set "_X=!_X!"!sx! !cx!" "
	)

	%= parallels =%
	set /a "angle=_stepy"
	set "_Y="
	for /L %%X in (2,1,!_ndy!) do (	
		set /A "sx=%_SIN(x):x=angle%, cx=%_SIN(x):x=(15708-angle)%, angle+=_stepy"
		set "_Y=!_Y!"!sx! !cx!" "	
	)
	set "angle="

	%= Poles 0-pi =%
	set /A "sx=%_SIN(x):x=0%, cx=%_SIN(x):x=(15708)%"
	set "_PX="!sx! !cx!""
	set "_PY="!sx! !cx!" "
	set /A "sx=%_SIN(x):x=31416%, cx=%_SIN(x):x=(15708-31416)%"
	set "_PY=!_PY!"!sx! !cx!""

	call :rotate
	
	set /a _ndx+=2
  )

goto :eof

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:rotate

  %= *Φ•○♥øo█ =%

  set "_DEC=♥"

  rem remove this rem for bigger spere point
  rem set "_DEC=█%_ESC%[A█\%_ESC%[D%_ESC%[B█%_ESC%[B%_ESC%[2D█/%_ESC%[3D\%_ESC%[2A%_ESC%[D/%_ESC%[B○"

(setlocal

  for /F "Tokens=1 delims==" %%v in ('set _') do set "%%v="

  %= clear screen and go cursor in 1,1-Home =%
  set/p "=%_ESC%[2J%_ESC%[H"<nul

  %_loop% (

    for /f "tokens=1-4 delims=:.," %%a in ("!time: =0!") do set /a "t2=(((1%%a*60)+1%%b)*60+1%%c)*100+1%%d-36610100, tD=t2-t1, tD+=(tD>>31) & 8640000, el+=1"
  
    %= 2=50 FPS max, 3=33 FPS max, 4=25 FPS max, 5=20 FPS max and so on... =%
    if !tD! geq %_dT% (

	%= Full loop rt=(120)*31416/60 or multiple of 120 =%
	set /a "t1=t2, rt+=31416/60, il+=1, fc+=1"

	rem every sec_elaps (sec_elaps:100=elt/1000000:x) x=elt/1000000*100/sec_elaps -> x=elt/10000/sec_elaps
	set /a "sec_elaps=1, step=%_FPS%*sec_elaps"
	if !fc! geq !step! (
		set /a "elaps=(t2-oldt), FPS=1000*fc/elaps, oldt=t2, fc=0, elt=micros*el/10, percCPUfree=elt/10000/sec_elaps"
		title Sphere 3D - FPS:!FPS:~0,-1!.!FPS:~-1! - splits:%_ndx% - CPU free=!percCPUfree!%% [on single core]

		%= on 7 percent cpu free or more, increase numbor of point =%
		if !percCPUfree! gtr 6 goto :exit_rotate
		set /a "il=el=0"
		set "elaps="
		set "FPS="
	)
	set "Step="
	set "sec_elaps=1"

	if !ds! lss 1000 (set /a ds+=10)

	%= Cos(x)=Sin(PI/2-x) =%
	set /A "sx=%_SIN(x):x=rt%, cx=%_SIN(x):x=(15708-rt)%"

	For /f "tokens=1,2" %%a in ("!sx! !cx!") do (
	set "cx=" & set "sx="

	set "s=!s!%_ESC%[92m"
	for /L %%G in (1,1,%_ndx%) do set "e[%%G]=!e[%%G]!%_ESC%[30m"

	%= Bright Foreground Red =%
	set "t[1]=!t[1]!%_ESC%[91m"

	%= Poles =%
        for %%f in (%_PX%) do for /f "tokens=1,2" %%g in (%%f) do (
		for %%t in (%_PY%) do for /f "tokens=1,2" %%u in (%%t) do (
			set /a "a=%_R%*%%h/10000*%%u/10000, c=%_R%*%%g/10000*%%u/10000, b=%_R%*%%v/10000, a=(a*%%b/10000-(b*%%a+c*%%b)/10000*%%a/10000)*%%b/10000-(b*%%b-c*%%a)/10000*%%a/10000, b=(%_R%*%%h/10000*%%u/10000*%%b/10000-(b*%%a+c*%%b)/10000*%%a/10000)*%%a/10000+(b*%%b-c*%%a)/10000*%%b/10000, c=%_R%*%%h/10000*%%u/10000*%%a/10000+(%_R%*%%v/10000*%%a+c*%%b)/10000*%%b/10000, a=ds*a/(c-%_dz%)+%_dx%, b=ds*b/(c-%_dz%)+%_dy%"
			if !c! lss 0 (
				set "s=!s!%_ESC%[!b!;!a!H·"
			) else (
				set "d=!d!%_ESC%[!b!;!a!H%_DEC%"
	)))

	set /A "z=1"

	%= meridians =%
	for %%f in (%_X%) do for /f "tokens=1,2" %%g in (%%f) do (

	  For %%C in (!z!) do set "t[%%C]=!t[%%C]!%_ESC%[38;5;!C_%%C!m"

	  %= parallels =%
          for %%t in (%_Y%) do for /f "tokens=1,2" %%u in (%%t) do (

            set /a "a=%_R%*%%h/10000*%%u/10000, c=%_R%*%%g/10000*%%u/10000, b=%_R%*%%v/10000, a=(a*%%b/10000-(b*%%a+c*%%b)/10000*%%a/10000)*%%b/10000-(b*%%b-c*%%a)/10000*%%a/10000, b=(%_R%*%%h/10000*%%u/10000*%%b/10000-(b*%%a+c*%%b)/10000*%%a/10000)*%%a/10000+(b*%%b-c*%%a)/10000*%%b/10000, c=%_R%*%%h/10000*%%u/10000*%%a/10000+(%_R%*%%v/10000*%%a+c*%%b)/10000*%%b/10000, a=ds*a/(c-%_dz%)+%_dx%, b=ds*b/(c-%_dz%)+%_dy%"

	    if !c! lss 0 (
			set "s=!s!%_ESC%[!b!;!a!H·"
	    ) else (
			set "d=!d!%_ESC%[!b!;!a!H%_DEC%"
	    )

          ) %= parallels =%

	  for %%G in (!z!) do (
		set "t[%%G]=!t[%%G]!!d!"
	  	set "e[%%G]=!e[%%G]!!d!"
	  )
	  set "d="

	  set /A z+=1
  		
	) %= meridians =%
	)

	%= intrinsic cls =%
	%= echo zbuffer like, keep separate to overcome 8k limit =%
	echo(!s!
	for /L %%G in (1,1,%_ndx%) do echo(%_ESC%M!t[%%G]!

	set "s=!s! "
	for /L %%G in (1,1,%_ndx%) do (
		set "t[%%G]=!e[%%G]! "
		%= keep space for empty "t" =%
		set "e[%%G]= "
	)

	%= Foreground Black =%
	set s=!s:92m=30m!

	set /a i+=1
	if !i! geq 3 (
		set "s=!s:* =!"
		for /L %%G in (1,1,%_ndx%) do set "t[%%G]=!t[%%G]:* =!"
	)

    ) %= if !tD! geq _dT =%
  ) %= end_loop =%
)
:exit_rotate

(endlocal & set /a rt=%rt%, ds=%ds%)

goto :eof
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:perf return microsec*10

setlocal

  echo(
  echo Testing your cpu Speed. Wait for Turbo Boost ... 

  set "a=0"

:loop_a

  set /a "i=1"

  set "csSec=!time:~-2!"
  set cs=%time:~-1%
:sync
  if %time:~-1% equ %cs% goto :sync

:: while loop
%_loop% (
	if !time:~-2! neq %csSec% (
		set /a "i+=1"
	) else goto :exit_while1
)
:exit_while1

set /a "a+=1"
:: two second is enough for Turbo Boost?
if !a! lss 2 goto loop_a

:: Calculate timing of external loop (el)

for /f "tokens=1-4 delims=:.," %%a in ("!time: =0!") do set /a "t1=(((1%%a*60)+1%%b)*60+1%%c)*100+1%%d-36610100"

set "_dT=1000"
for /L %%L in (1,1,!i!) do (
	
	for /f "tokens=1-4 delims=:.," %%a in ("!time: =0!") do set /a "t2=(((1%%a*60)+1%%b)*60+1%%c)*100+1%%d-36610100, tD=t2-t1, tD+=(tD>>31) & 8640000, el+=1"
	if !tD! geq %_dT% rem
)
rem calculate microsecond time * 10 (rounded)
set /A micros=(td*1000000/i+5)/10

(endlocal & set micros=%micros%)

goto :eof
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
