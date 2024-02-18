@echo off
::### keep window open ###
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )


:main
	set var1=3
	set var2=5

	call:if_or orResult "%var1%==4" "boy==boy" "%var2%==6" 
	if %orResult% ( 
		echo At least one expression is true
	) else echo All expressions are false
goto:eof


:if_or <resultVar> expression1 [[expr2] ... expr-n] 
	SETLOCAL
	set "if_or.result=0==1"
	set "if_or.resultVar=%~1"

	:if_or_loop 
	if "%~2"=="" goto :if_or_end
	if %~2 set "if_or.result=1==1"
	SHIFT 
	goto :if_or_loop 

	:if_or_end 
	( ENDLOCAL && set "%if_or.resultVar%=%if_or.result%" )
goto:eof


