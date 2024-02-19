

:main
	call:get_user_variable HKCU\Environment PATH PATH_VALUE
	echo PATH_VALUE = %PATH_VALUE%
	echo.
	
	call::delete_env_variable HKCU\Environment PATH
	
	call:set_user_variable HKCU\Environment PATH REG_EXPAND_SZ %PATH_VALUE%
	pause
goto:eof



:get_env_variable <reg_path> <key> <result>
	FOR /F "tokens=2* skip=2" %%a in ('reg query "%1" /v "%2"') do ( set "%3=%%b" )
goto:eof


:set_env_variable <reg_path> <key> <type> <value>
	"C:\Windows\System32\reg.exe" ADD %1 /v %2 /t %3 /d "%4"
goto:eof


:delete_env_variable <reg_path> <key>
	REG delete %1 /F /V %2
goto:eof