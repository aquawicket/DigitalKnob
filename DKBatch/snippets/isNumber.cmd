@echo off

call :isNumber 0     	&:: OK	positive
call :isNumber -0		&:: OK	positive
call :isNumber 0-		&:: OK	Not numeric
call :isNumber .0		&:: OK	positive
call :isNumber 0.		&:: OK	positive
call :isNumber -.0		&:: OK	positive
call :isNumber -0.		&:: OK	positive
call :isNumber 0-.		&:: OK	Not numeric
call :isNumber .-0		&:: BAD	positive
call :isNumber .0-		&:: OK	Not numeric
call :isNumber 0.-		&:: OK	Not numeric
call :isNumber --0		&:: OK	Not numeric
call :isNumber -0-		&:: OK	Not numeric
call :isNumber 0--		&:: OK	Not numeric
call :isNumber ..0		&:: BAD	positive
call :isNumber .0.		&:: BAD	positive
call :isNumber 0..		&:: BAD	positive

call :isNumber 1     	&:: OK	positive
call :isNumber -1		&:: OK	negative
call :isNumber 1-		&:: OK	Not numeric
call :isNumber .1		&:: OK	positive
call :isNumber 1.		&:: OK	positive
call :isNumber -.1		&:: OK	negative
call :isNumber -1.		&:: OK	negative
call :isNumber 1-.		&:: OK	Not numeric
call :isNumber .-1		&:: BAD	negative
call :isNumber .1-		&:: OK	Not numeric
call :isNumber 1.-		&:: OK	Not numeric
call :isNumber --1		&:: OK	Not numeric
call :isNumber -1-		&:: OK	Not numeric
call :isNumber 1--		&:: OK	Not numeric
call :isNumber ..1		&:: BAD	positive
call :isNumber .1.		&:: BAD	positive
call :isNumber 1..		&:: BAD	positive





call :isNumber 1		&:: OK
call :isNumber -1		&:: OK
call :isNumber 2-		&:: OK
call :isNumber 00		&:: OK
call :isNumber -00		&:: OK
call :isNumber 0-0		&:: OK
call :isNumber 00-		&:: OK
call :isNumber 11		&:: OK
call :isNumber -11		&:: OK
call :isNumber 1-1		&:: OK
call :isNumber 11-		&:: OK
call :isNumber 2-		&:: OK
call :isNumber bob		&:: OK
call :isNumber 1bob1	&:: OK
call :isNumber			&:: OK
call :isNumber 0.0		&:: OK
call :isNumber 1.1		&:: OK
call :isNumber -1.1		&:: OK
call :isNumber 2-.		&:: OK
call :isNumber 00.00	&:: OK
call :isNumber 11.11	&:: OK
call :isNumber -11.11	&:: OK
call :isNumber -2.2		&:: OK
call :isNumber 2-.2		&:: OK
call :isNumber 2.-2		&:: OK
call :isNumber 2.2-		&:: OK
call :isNumber -03.30	&:: OK
call :isNumber 0-3.30	&:: OK
call :isNumber 03-.30	&:: OK
call :isNumber 03.-30	&:: OK
call :isNumber 03.3-0	&:: OK
call :isNumber 03.30-	&:: OK
call :isNumber --4		&:: OK
call :isNumber -.4		&:: OK
call :isNumber -0.4		&:: OK
call :isNumber .-4		&:: BAD
pause

:isNumber
setlocal enableDelayedExpansion
	
	if "%~1" equ "" (
		echo %~1 is undefined
	) else (
		for /f "delims=-.0123456789" %%i in ("%~1") do set var=%%i
		if defined var (echo %~1 is NOT numeric) else (
			set decimal=%~1
			set nodecimalA=!decimal:.=!
			set /a nodecimal=!decimal:.=! 2>nul && (
				if !nodecimalA! equ !nodecimal! (
					if !nodecimal! equ +!nodecimal! (
						echo %~1 is a positive number
					) else (
						echo %~1 is a negative number
					)
				) else (echo %~1 is NOT numeric)
			) || echo %~1 is NOT numeric
		)
	)

exit /b 0
