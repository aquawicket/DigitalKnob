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


rem https://ss64.com/nt/syntax-error.html
rem https://reactos.org/archives/public/ros-diffs/2020-September/074204.html
rem https://stackoverflow.com/a/34987886/688352
rem https://stackoverflow.com/a/34987886

set "ErrCode[9009]=File Not Found"
set "ErrCode[1073750988]=Unbalanced parentheses"
set "ErrCode[1073750989]=Missing operand"
set "ErrCode[1073750990]=Syntax error"
set "ErrCode[1073750991]=Invalid number"
set "ErrCode[1073750992]=Number larger than 32-bits"
set "ErrCode[1073750993]=Division by zero"

rem SomeCommand && (
rem  Echo success
rem ) || (
rem  Echo failed/error
rem )

rem set "dk_onError=&& (echo success) || (echo error)



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
  
    set "dk_onError=&& (%dk_call% dk_echo "success") || (%dk_call% dk_error "error")"
    set "dk_onError=&& (echo success) || (echo error)"
   
    (call ) %dk_onError%
    (call) %dk_onError%
%endfunction%
