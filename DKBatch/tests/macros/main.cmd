@echo off
call :main
exit /b 

:main
setlocal disableDelayedExpansion
rem	if NOT DEFINED ESC (set "ESC=")
rem	call %~dp0dk_call2_MACRO.cmd
rem	call %~dp0printMacro.cmd @dk_call2_MACRO
	
rem	%@dk_call2_MACRO% ver

	
rem	call %~dp0strlen_init.cmd
rem	call %~dp0printMacro.cmd @strlen	
	
rem	set "string=Hello, World!"
rem	set "length="
rem	%@strlen% string length
rem	echo %length%
	
		
	rem call %~dp0simpleFunc.cmd arg1 arg2 arg3	


	call %~dp0dk_loadMACRO.cmd %~dp0simpleFunc.cmd simpleFunc
rem	call %~dp0printMacro.cmd @simpleFunc
	
	rem %@simpleFunc% arg1 arg2 arg3
	rem call %~dp0printMacro.cmd @dk_loadMACRO
	rem %@dk_loadMACRO% %~dp0dk_call2_FUNC.cmd
pause
	






pause
:main_END
exit /b