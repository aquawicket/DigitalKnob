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


rem ####################################################################
::# RUN
::#
:RUN
%setlocal%
	
	%dk_call% dk_validate websocketd_exe %dk_call% dk_depend websocketd
	::%dk_call% dk_validate cmd.exe %dk_call% dk_depend cmd
	
	::%WEBSOCKETD_EXE% --devconsole --port=8080 count.cmd
	::%WEBSOCKETD_EXE% --devconsole --port=8080 C:\Users\Administrator\Digital Knob\Development\DKBatch\functions\DKBuilder\DKBuilder.cmd
	%dk_call% dk_validate DKBATCH_DIR %dk_call% dk_DKBRANCH_DIR
	
	%dk_call% dk_assertPath "%DKBATCH_DIR%/apps/websocketd/console.html"
	start %DKBATCH_DIR%/apps/websocketd/console.html
	
	::"%WEBSOCKETD_EXE%" --port=8080 --staticdir=%DIGITALKNOB_DIR:/=\% stdparser.cmd
	::"%WEBSOCKETD_EXE%" --port=8080 --staticdir=. stdparser.cmd
	"%WEBSOCKETD_EXE%" --port=8080 %ComSpec% /V:ON
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% RUN
%endfunction%