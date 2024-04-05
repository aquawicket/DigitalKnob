::dk_include_guard()

::#################################################################################
:: dk_set_registry_key() <reg_path> <key> <type> <value>
::
::
:dk_set_registry_key <reg_path> <key> <type> <value>
	"C:\Windows\System32\reg.exe" ADD %1 /v %2 /t %3 /d "%4"
goto:eof