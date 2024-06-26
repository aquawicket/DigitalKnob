@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::##################################################################################
::# __ARGV__(<frame>
::#
:__ARGV__() {
	if not defined %1 (set "_FRAME_=0") else (set "_FRAME_=%1")
	::set /A _FRAME_-=1
	
::	set "_ARGC_=%BATCH_ARGC[$_FRAME_%]%"
::	for (( i=((_ARGC_)); i>=1; i-- )); do
::		if not defined "%_ARGV_%" (set "_ARGV_=%BATCH_ARGV[%i%]%") else (set "_ARGV_=%_ARGV_%, %BATCH_ARGV[%i%]%")
::	done
::	call dk_return "%_ARGV_%"
goto:eof



:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	
	echo "$(__ARGV__)"
