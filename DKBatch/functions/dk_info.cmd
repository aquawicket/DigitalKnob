::include_guard()

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: dk_info()
::
::
:dk_info() {
	::echo "dk_info(%*)"
	call:dk_require dk_info %1
	echo "%white% INFO: %1 %white%"
goto:eof