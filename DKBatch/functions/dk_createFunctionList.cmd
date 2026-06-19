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
rem # dk_createFunctionList()
rem #
rem #
:dk_createFunctionList
%setlocal%

    rem create a list of all dk_functions and store them in _functionList_
    %dk_call% dk_validate DKBRANCH_DIR %dk_call% dk_DKBRANCH_DIR
    if NOT EXIST "%DKBRANCH_DIR%\.git" (goto:eof)    &rem only create functions list when we have a local repository
   
    %dk_call% dk_delete "%DKBATCH_FUNCTIONS_DIR_%_functionList_"
    for %%a in (%DKBATCH_FUNCTIONS_DIR_%dk_*.cmd) do (
        echo %%~na
        %dk_call% dk_fileAppend "%DKBATCH_FUNCTIONS_DIR_%_functionList_" %%~na
    )
   
    if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%_functionList_" %dk_call% dk_error "_functionList_ is missing")
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_createFunctionList
%endfunction%
