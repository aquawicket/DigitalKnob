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


rem ################################################################################
rem # dk_textFormat(OUTPUT. column1, column2, column3, column4)
rem #
rem #   reference: https://stackoverflow.com/a/19588505
rem #  
rem #
:dk_textFormat
%setlocal%

    set "spaces=                                        "
    set "col1=%~2%spaces%"
    set col1=%col1:~0,15%
   
    set "col2=%~3%spaces%"
    set col2=%col2:~0,30%
   
    set "col3=%~4%spaces%"
    set col3=%col3:~0,30%
   
    set "col4=%~5%spaces%"
    set col4=%col4:~0,100%
   
    rem %dk_call% dk_set output "%col1% %col2% %col3% %col4%"
    set "_textFormat_=%col1% %col2% %col3% %col4%"
    endlocal & set "%1=%_textFormat_%"
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_textFormat output "column1[15]" "column2[30]" "column3[20]" "column4[100]"
    %dk_call% dk_echo "%output%"
%endfunction%
