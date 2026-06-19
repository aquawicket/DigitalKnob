@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ############################################################################
rem # dk_callFileLabel(batch_file, :label, ...args)
rem #
rem #
:dk_callFileLabel
%setlocal%

	set "_file_=%~1"
	set "_name_=%~n1"
	set "_label_=%~2"
	set "_label_=:%_label_::=%"
	%dk_call% dk_allButFirst2Args %*
	set _args_=%dk_allButFirst2Args%
	
	
	%dk_call% dk_fileContains "%_file_%" "%_label_%" || (
		%dk_call% dk_error "_file_:'%_file_%' does NOT contain _label_:'%_label_%'"
		%return%
	)
	
	%dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
	set "dk_callFileLabel_TEMP=%DKCACHE_DIR%/dk_callFileLabel_TEMP.cmd"
	
	(
		echo.@echo off
		echo.
		echo.call %_label_%
		echo.exit /b %%errorlevel%%
		echo.
		echo.%_label_%
		echo.	"%_file_:/=\%" %_args_%
		echo.%%endfunction%%
		echo.
	) > "%dk_callFileLabel_TEMP%"
	
	call "%dk_callFileLabel_TEMP:/=\%"
	rem del "%dk_callFileLabel_TEMP:/=\%"
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	echo calling dk_debug.cmd :DKTEST. . .
	%dk_call% dk_callFileLabel "C:\Users\Administrator\Digital Knob\Development\DKBatch\functions\dk_debug.cmd" ":DKTEST"
	
	echo calling dk_debug.cmd :dk_debug. . .
	%dk_call% dk_callFileLabel "C:\Users\Administrator\Digital Knob\Development\DKBatch\functions\dk_debug.cmd" ":dk_debug" "test dk_debug string"
%endfunction%

