@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_fileToCRLF(file)
::#
::#
:dk_fileToCRLF
	call dk_debugFunc 1
	setlocal

		%dk_call% dk_rename "%~1" "%~1_TMP"
		if not exist "%~1_TMP" %dk_call% dk_error "failed to rename %~1"
		if exist "%~1" %dk_call% dk_error "cannot rename file, destination already exists"
		
		type "%~1_TMP" | find /V "" > "%~1"
		%dk_call% dk_delete "%~1_TMP"
		if not exist "%~1" %dk_call% dk_error "failed to convert file to CRLF"
	endlocal
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_fileToCRLF dk_appendArgs.cmd
goto:eof
