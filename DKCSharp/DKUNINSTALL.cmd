rem shebang
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


rem ############ DKCSharp ############
rem #
:DKUNINSTALL
setlocal
	
	echo.
	echo ############ Uninstalling DKCSharp #############
	set "ftype=DKCSharp"
	set "assoc=cs"
	
	(ftype %ftype% 2>nul) && (ftype %ftype%=)
	%dk_call% dk_registryKeyExists "HKCR/%ftype%" && %dk_call% dk_registryDeleteKey "HKCR/%ftype%" || %clearerror%

	(assoc .%assoc% 2>nul) && (assoc .%assoc%=)
	%dk_call% dk_registryKeyExists "HKCR/.%assoc%" && %dk_call% dk_registryDeleteKey "HKCR/.%assoc%" || %clearerror%
	%dk_call% dk_registryKeyExists "HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/.%assoc%" && %dk_call% dk_registryDeleteKey "HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/.%assoc%" || %clearerror%

	::###### RESTORE DEFAULTS ######
	::ftype %assoc%file="%%1" %%*
	::assoc .%assoc%=%assoc%file
	::%dk_call% dk_registrySetKey "HKLM/SOFTWARE/Classes/.%assoc%" "" "REG_SZ" "%assoc%file"
	::%dk_call% dk_registrySetKey "HKLM/SOFTWARE/Classes/%assoc%file/shell/open/command" "" "REG_SZ" "\"%%1\" %*"
%endfunction%










rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal

	%dk_call% DKUNINSTALL
%endfunction%