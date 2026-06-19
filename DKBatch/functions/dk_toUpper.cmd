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
rem # dk_toUpper(string rtn_var)
rem #
rem #
:dk_toUpper
%setlocal%
	
	set "dk_toUpper=%~1"
	for %%# in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
		set "dk_toUpper=!dk_toUpper:%%#=%%#!"
	)
   
	:return
	endlocal & (
		set "dk_toUpper=%dk_toUpper%"
		if "%~2" neq "" (set "%~2=%dk_toUpper%")
	)
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    rem Can't handle these characters yet->    [ ] \ ' . / ~ " ? < >
    set "myVar=a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0 ` - = ; , ! @ # $ % ^ & * ( ) _ + { } | :"
	%dk_call% dk_debug
	%dk_call% dk_debug "myVar = %myVar%"
	
	rem default variable output
    %dk_call% dk_toUpper "%myVar%"
	%dk_call% dk_debug
	%dk_call% dk_debug "dk_toUpper = %dk_toUpper%"
	
	rem user variable output
	%dk_call% dk_toUpper "%myVar%" myVar_UPPER
	%dk_call% dk_debug
	%dk_call% dk_debug "myVar_UPPER = %myVar_UPPER%"
%endfunction%
