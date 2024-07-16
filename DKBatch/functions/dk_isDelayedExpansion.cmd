@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd


set "if_DE=if "!!" equ """
set "if_NDE=if "!!" neq """
set "_DE_=%if_DE% (echo delayed expansion ON) else (echo delayed expansion OFF)" 

::####################################################################
::# dk_isDelayedExpansion(rtn_var)
::#
::#
:dk_isDelayedExpansion
	call dk_debugFunc
	if %__ARGC__% neq 1 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	if "!!" == "" (
	  set "%1=ON"
	)  else (
	  set "%1=OFF"
	)
goto:eof




::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_isDelayedExpansion deylayedExpansion
	echo deylayedExpansion = %deylayedExpansion%
goto:eof