@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::############################################################################
::# dk_deleteDigitalKnob()
::#
::#
:dk_deleteDigitalKnob
%setlocal%
 	%dk_call% dk_debugFunc 0 

	
	echo ### Deleting DIGITALKNOB_DIR ###
	%dk_call% dk_validate DIGITALKNOB_DIR "%dk_call% dk_DIGITALKNOB_DIR"
	echo Do you want to delete the DigitalKnob folder ?
	%dk_call% dk_confirm || (exit /b 0)
	
	::###### Deleting DIGITALKNOB_DIR ######
::	echo ((goto) 2^>nul ^& cd "%SystemDrive%\" ^&^& rmdir /s /q "%DIGITALKNOB_DIR:/=\%") > "%TEMP%\delete_DK.cmd"
::	echo ((goto) 2^>nul ^& del "%TEMP%\delete_DK.cmd" ^& cmd /c exit /b 0) >> "%TEMP%\delete_DK.cmd"
::	start "" /MIN "%TEMP%\delete_DK.cmd" & exit
	
	(
		cd %USERPROFILE% 
		start /b "" cmd /c rd /s /q "%DIGITALKNOB_DIR:/=\%"
		%return%
	)

%endfunction%











::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0 

	%dk_call% dk_deleteDigitalKnob
%endfunction%

