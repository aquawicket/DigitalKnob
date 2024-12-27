@echo off
setlocal enableDelayedExpansion

::set "global=call:getGlobal $"
::echo %global:$=myVar%

call :setGlobal myVar 123
call :getGlobal myVar
echo myvar = %myVar%

::call set_test:main args
::call:main && exit /b 0


:main
setlocal enableDelayedExpansion
	call debugFunc

	call :funcA A
	
	echo cmdlvl = %cmdlvl%
	echo _0 = %_0%
	echo f0 = %f0%
	echo n0 = %n0%
	echo p0 = %p0%
	echo ALL = %ALL%
	::call :getGlobal myVar
	echo myvar = %myVar%

	pause
exit /b 0




:funcA
setlocal enableDelayedExpansion
	call debugFunc

	call :funcB B
	
	
	
	echo cmdlvl = %cmdlvl%
	echo _0 = %_0%
	echo f0 = %f0%
	echo n0 = %n0%
	echo p0 = %p0%
	echo ALL = %ALL%
	::call :getGlobal myVar
	echo myvar = %myVar%
exit /b 0


:funcB
setlocal enableDelayedExpansion
    call debugFunc
	
	call :setGlobal myVar CCCCCCCCCC
	call :funcC C
	
	echo cmdlvl = %cmdlvl%
	echo _0 = %_0%
	echo f0 = %f0%
	echo n0 = %n0%
	echo p0 = %p0%
	echo ALL = %ALL%
	::call :getGlobal myVar
	echo myvar = %myVar%
exit /b 0

:funcC
setlocal enableDelayedExpansion
    call debugFunc

	call :funcD D
	
	echo cmdlvl = %cmdlvl%
	echo _0 = %_0%
	echo f0 = %f0%
	echo n0 = %n0%
	echo p0 = %p0%
	echo ALL = %ALL%
	::call :getGlobal myVar
	echo myvar = %myVar%
exit /b 0

:funcD
setlocal enableDelayedExpansion
    call debugFunc

	call :funcE E
	
	echo cmdlvl = %cmdlvl%
	echo _0 = %_0%
	echo f0 = %f0%
	echo n0 = %n0%
	echo p0 = %p0%
	echo ALL = %ALL%
	::call :getGlobal myVar
	echo myvar = %myVar%
exit /b 0

:funcE
setlocal enableDelayedExpansion
    call debugFunc

	call :funcF F
	
	echo cmdlvl = %cmdlvl%
	echo _0 = %_0%
	echo f0 = %f0%
	echo n0 = %n0%
	echo p0 = %p0%
	echo ALL = %ALL%
	::call :getGlobal myVar
	echo myvar = %myVar%
exit /b 0

:funcF
setlocal enableDelayedExpansion
    call debugFunc

	call :funcG G
	
	echo cmdlvl = %cmdlvl%
	echo _0 = %_0%
	echo f0 = %f0%
	echo n0 = %n0%
	echo p0 = %p0%
	echo ALL = %ALL%
	::call :getGlobal myVar
	echo myvar = %myVar%
exit /b 0

:funcG
setlocal enableDelayedExpansion
    call debugFunc
	
	echo ##########################################
	
	

exit /b 0


:setGlobal name value
setlocal enableDelayedExpansion
	echo %~2 > %~1.var
	::endlocal & set "%~1=%~2"
exit /b 0

:getGlobal name
setlocal enableDelayedExpansion
	set /p value=< %~1.var
	endlocal & set "%~1=%value%"
exit /b 0