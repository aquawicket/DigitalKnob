@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::#################################################################################
::# dk_registryGetKey() <reg_path> <key> rtn_var
::#
::#
:dk_registryGetKey <reg_path> <key> rtn_var
 setlocal
	call dk_debugFunc 3

	FOR /F "tokens=2* skip=2" %%a in ('reg query "%1" /v "%2"') do ( 
		endlocal & set "%3=%%b"
	)
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_todo
	%dk_call% dk_registryGetKey
goto:eof
