@echo off
call DK.cmd

::####################################################################
::# dk_isNumber(<in> rtn_var)
::#
::#	 https://stackoverflow.com/a/17584764
::#
:dk_isNumber () {
	call dk_debugFunc

	SET "var="&for /f "delims=0123456789" %%i in ("%1") do set var=%%i
	if defined var (echo %1 NOT numeric) else (echo %1 numeric)
	
	::TODO
goto:eof



:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###