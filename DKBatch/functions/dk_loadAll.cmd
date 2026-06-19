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
rem # dk_loadAll()
rem #
rem #
:dk_loadAll()
%setlocal%
   
    rem if we are working from a local repository, all function files should be there. No need to loadAll
    if EXIST "%DKBATCH_FUNCTIONS_DIR_%../../.git" %return%
   
    rem download _functionList_ and load each function in the list"
    if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%_functionList_" %dk_call% dk_download "%DKHTTP_DKBATCH_FUNCTIONS_DIR%/_functionList_" "%DKBATCH_FUNCTIONS_DIR_%_functionList_"

    if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%_functionList_" %dk_call% dk_error "failed to download %DKBATCH_FUNCTIONS_DIR_%_functionList_"
   
    for /F "usebackq delims=" %%a in ("%DKBATCH_FUNCTIONS_DIR_%_functionList_") do (
        %dk_call% dk_load %%a
    )
%endfunction%







rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
  
    %dk_call% dk_loadAll
%endfunction%
