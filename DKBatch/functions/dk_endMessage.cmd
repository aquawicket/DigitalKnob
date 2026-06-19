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


rem #################################################################################
rem # dk_endMessage()
rem #
:dk_endMessage
%setlocal%

    %dk_call% dk_echo
    %dk_call% dk_info "####################################################################"
    %dk_call% dk_info "****** Done Building %Target_App% - %Target_Tuple% - %Target_Type% - %Target_Level% ******"
    %dk_call% dk_info "####################################################################"
    %dk_call% dk_echo
       
    set "dk_BUILDER_pickUpdate="
    set "Target_App="
    set "Target_Tuple="
    set "Target_Type="
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_endMessage
%endfunction%
