@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::############################################################################
::# dk_fileCompair(fileA fileB)
::#
::#
:dk_fileCompair
setlocal
	%dk_call% dk_debugFunc 0

	set "fileA=%~1"
	set "fileA=%fileA:/=\%"
	
	set "fileB=%~2"
	set "fileB=%fileB:/=\%"
	
    fc %fileA% %fileB% > nul && (exit /b 0) || (exit /b 1)
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_set file1 "C:/Windows/notepad.exe"
	%dk_call% dk_set file2 "C:/Windows/notepad.exe"
	%dk_call% dk_fileCompair "%file1%" "%file2%" && (echo %file1% %file2% files are the same) || (echo %file1% %file2% files are different)
	
	%dk_call% dk_set file1 "C:/Windows/notepad.exe"
	%dk_call% dk_set file2 "C:/Windows/regedit.exe"
    %dk_call% dk_fileCompair "%file1%" "%file2%" && (echo %file1% %file2% files are the same) || (echo %file1% %file2% files are different)
	(call )
%endfunction%
