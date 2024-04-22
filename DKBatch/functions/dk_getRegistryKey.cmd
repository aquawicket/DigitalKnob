::dk_includeGuard()

::#################################################################################
:: dk_getRegistryKey() <reg_path> <key> <result>
::
::
:dk_getRegistryKey <reg_path> <key> <result>
	FOR /F "tokens=2* skip=2" %%a in ('reg query "%1" /v "%2"') do ( set "%3=%%b" )
goto:eof