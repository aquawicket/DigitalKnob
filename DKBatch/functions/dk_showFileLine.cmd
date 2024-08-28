@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::################################################################################
::# dk_showFileLine(filepath, match_string)
::# dk_showFileLine(filepath, line_number)
::#
::#
:dk_showFileLine
 setlocal enableDelayedExpansion
	call dk_debugFunc 2
	
	if "!DE!" neq "" %dk_call% dk_error "%__FUNCTION__% requires delayed expansion"
	
	set /a "line=%~2" || for /f "delims=:" %%a in ('findstr /n /c:"%~2" "%~f1"') do set "line=%%a"
	
	echo [91m  File: %~f1: !line! [0m
	set /A n=1
	set /A min=!line!-15
	set /A max=!line!+15
	for /f "delims=" %%a in ('findstr /n /r /c:"^" "%~f1"') do (
		if !n! LSS !max! (
			if !n! GTR !min! (
				set str=%%a
				set str=!str::=:	! 
				if !n! equ !line! (
					echo [30;41m^>  !str![0m
				) else (
					echo    !str!
				)
			)
		)		
		set /a n+=1
	)
	%dk_call% dk_echo
	endlocal
goto :eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_showFileLine "../../README.md" 302
	%dk_call% dk_showFileLine "../../README.md" "How to build"
goto:eof
