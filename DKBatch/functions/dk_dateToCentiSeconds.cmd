@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::##################################################################################################
::# dk_dateToCentiSeconds(centiseconds %centiseconds% %second% %minute% %hour% %day% %month% %year%)
::#
::#
:dk_dateToCentiSeconds
	call dk_debugFunc
	if %__ARGC__% LSS 1 call dk_error "%__FUNCTION__%(): not enough arguments"
	
	setlocal
	if "%~2" equ "" (set "cs=0")    else (set /a "cs=100%~2%%100")
	if "%~3" equ "" (set "ss=0")    else (set /a "ss=100%~3%%100")
	if "%~4" equ "" (set "nn=0")    else (set /a "nn=100%~4%%100")
	if "%~5" equ "" (set "hh=0")    else (set /a "hh=100%~5%%100")
	if "%~6" equ "" (set "dd=1")    else (set /a "dd=100%~6%%100")
	if "%~7" equ "" (set "mm=1")    else (set /a "mm=100%~7%%100")
	if "%~8" equ "" (set "yy=1970") else (set /a "yy=10000%~8%%10000")

	set /a "dd=dd-1"
	set /a "mm=mm-1"
	set /a "yy=yy-1970"
	
	set /a "CentiSeconds_cs=%cs%"
	set /a "Seconds_cs=%ss%*100+%CentiSeconds_cs%"
	set /a "Minutes_cs=%nn%*60*100+%Seconds_cs%"
	set /a "Hours_cs=%hh%*60*60*100+%Minutes_cs%"
	set /a "Days_cs=%dd%*24*60*60*100+%Hours_cs%
	set /a "Months_cs=(%mm%*304/10)*24*60*60*100+%Days_cs%"
	::set /a "Years_cs=(%yy%*12*304/10)*24*60*60*100+%Months_cs%"
	::if %Years_cs% gtr 9999999999 set /a "Years_cs=Years_cs+216000000"
	endlocal & set %1=%Months_cs%
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_getDate Day Month Year
	call dk_getTime CentiSecond Second Minute Hour
	echo TIMESTAMP = %Year%-%Month%-%Day%T%Hour%:%Minute%:%Second%.%CentiSecond%
	
	echo:
	echo ###### dk_dateToCentiSeconds ######
	::call dk_dateToCentiSeconds centiseconds %CentiSecond% %Second% %Minute% %Hour% %Day% %Month% %Year% 
	::echo %Year%/%Month%/%Day% %Hour%:%Minute%:%Second%.%CentiSecond% = %centiseconds% centiseconds
	call dk_dateToCentiSeconds centiseconds %CentiSecond% %Second% %Minute% %Hour% %Day% %Month%
	echo %Month%/%Day% %Hour%:%Minute%:%Second%.%CentiSecond% = %centiseconds% centiseconds
	call dk_dateToCentiSeconds centiseconds %CentiSecond% %Second% %Minute% %Hour% %Day%
	echo %Day% %Hour%:%Minute%:%Second%.%CentiSecond% = %centiseconds% centiseconds
	call dk_dateToCentiSeconds centiseconds %CentiSecond% %Second% %Minute% %Hour%
	echo %Hour%:%Minute%:%Second%.%CentiSecond% = %centiseconds% centiseconds
	call dk_dateToCentiSeconds centiseconds %CentiSecond% %Second% %Minute%
	echo %Minute%:%Second%.%CentiSecond% = %centiseconds% centiseconds
	call dk_dateToCentiSeconds centiseconds %CentiSecond% %Second%
	echo :%Second%.%CentiSecond% = %centiseconds% centiseconds
	call dk_dateToCentiSeconds centiseconds %CentiSecond%
	echo .%CentiSecond% = %centiseconds% centiseconds
goto:eof
