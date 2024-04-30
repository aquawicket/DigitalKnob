@echo off
call dk_includeGuard
call DK

::################################################################################
::# dk_showFileLine(<filepath> <match_string>)
::#
::#
::#
:dk_showFileLine
	call dk_debugFunc
	
	setlocal enableDelayedExpansion
		::echo ~0 = %~0
		::echo ~1 = %~1
		::echo ~3 = %~2
		::echo ~3 = %~3
		for /f "delims=:" %%a in ('findstr /n /c:"%~2" "%~f1"') do set "line=%%a"
		echo [91m  File: %~f1: !line! [0m
		set /A n=1
		set /A min=!line!-15
		set /A max=!line!+15
		for /f "delims=" %%a in ('findstr /n /r /c:"^" "%~f1"') do (
			if !n! LSS !max! (
				if !n! GTR !min! (
					set str=%%a
					set str=!str::=:	! 
					if !n! EQU !line! (
						echo [30;41m^>  !str![0m
					) else (
						echo    !str!
					)
				)
			)		
			set /a n+=1
		)
		echo.
	endlocal
goto :eof





:DKTEST ::########################################################################
call dk_showFileLine "../../README.md" "How to build"
call dk_exit