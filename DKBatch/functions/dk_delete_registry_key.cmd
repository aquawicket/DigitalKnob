::dk_include_guard()

::#################################################################################
:: dk_delete_registry_key() <reg_path> <key>
::
::
:dk_delete_registry_key <reg_path> <key>
	REG delete %1 /F /V %2
goto:eof