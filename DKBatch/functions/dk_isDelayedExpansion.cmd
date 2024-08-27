@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"


set "_DE_=%if_DE% (echo delayed expansion ON) else (echo delayed expansion OFF)" 

::####################################################################
::# dk_isDelayedExpansion(rtn_var)
::#
::#
:dk_isDelayedExpansion
 setlocal
	call dk_debugFunc 1
	
	if "!DE!" == "" (
	  set "%1=ON"
	)  else (
	  set "%1=OFF"
	)
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_isDelayedExpansion deylayedExpansion
	echo deylayedExpansion = %deylayedExpansion%
goto:eof