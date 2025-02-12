@echo off
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::############################################################################
::# __ARGV__(<frame>)
::#
:::__ARGV__
::	%dk_call% dk_debugFunc 0 1
::setlocal
:: 
::	if not defined %1 (set "_FRAME_=0") else (set "_FRAME_=%1")
::	::set /a _FRAME_-=1
::	
::	::set "_ARGC_=%BATCH_ARGC[$_FRAME_%]%"
::	::for (( i=((_ARGC_)); i>=1; i-- )); do
::	::	if not defined "%_ARGV_%" (set "_ARGV_=%BATCH_ARGV[%i%]%") else (set "_ARGV_=%_ARGV_%, %BATCH_ARGV[%i%]%")
::	::done
::	::%dk_call% dk_return "%_ARGV_%"
::%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
 
	call :DKTEST_func abc 123 def 456 ghi 789
%endfunction%


:DKTEST_func
setlocal
	%dk_call% dk_debugFunc 6

 
	echo __ARGV__ = %__ARGV__%
	echo ARGV[1] = %ARGV[1]%
	echo ARGV[2] = %ARGV[2]%
	echo ARGV[3] = %ARGV[3]%
	echo ARGV[4] = %ARGV[4]%
	echo ARGV[5] = %ARGV[5]%
	echo ARGV[6] = %ARGV[6]%
	%dk_call% dk_printVar ARGV
%endfunction%
