@echo off
cls
echo %0(%*)

:::::: Load DK Function files (DK_INIT) ::::::
call ..\functions\DK.cmd

:main
	:: Get the PATH environment variable from registry
	call dk_get_registry_key HKCU\Environment PATH PATH_VALUE
	echo PATH_VALUE = %PATH_VALUE%
	echo.
	pause
	
	:: Delete the PATH environment variable from registry
	::call dk_delete_registry_key HKCU\Environment PATH
	echo.
	pause
	
	:: Set the PATH environment variable from registry
	::call dk_set_registry_key HKCU\Environment PATH REG_EXPAND_SZ %PATH_VALUE%
	echo.
	pause
goto:eof
