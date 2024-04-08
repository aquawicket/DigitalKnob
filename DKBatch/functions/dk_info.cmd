::include_guard()

::####################################################################
:: dk_info()
::
::
:dk_info() {
	::call dk_verbose "%0(%*)"
	
	call:dk_require dk_info %1
	echo "%white% INFO: %1 %white%"
goto:eof