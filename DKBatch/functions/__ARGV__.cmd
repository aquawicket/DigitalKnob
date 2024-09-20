@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::############################################################################
::# __ARGV__(<frame>
::#
:__ARGV__
	call dk_debugFunc 0 1
 setlocal
 
	if not defined %1 (set "_FRAME_=0") else (set "_FRAME_=%1")
	::set /A _FRAME_-=1
	
	::set "_ARGC_=%BATCH_ARGC[$_FRAME_%]%"
	::for (( i=((_ARGC_)); i>=1; i-- )); do
	::	if not defined "%_ARGV_%" (set "_ARGV_=%BATCH_ARGV[%i%]%") else (set "_ARGV_=%_ARGV_%, %BATCH_ARGV[%i%]%")
	::done
	::call dk_return "%_ARGV_%"
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
 setlocal
 
	call :DKTEST_func abc 123
%endfunction%


:DKTEST_func
	call dk_debugFunc 2
 setlocal
 
	echo __ARGV__ = %__ARGV__%
%endfunction%
