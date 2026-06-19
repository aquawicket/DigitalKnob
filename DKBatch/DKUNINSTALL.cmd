@echo off&rem ###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../DKBatch/functions/") 
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DKINIT_cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %* && exit /b %errorlevel%)
rem #################################################################################################################################################


:DKUNINSTALL
setlocal
	
	echo.
	echo ############ Uninstalling DKcmd #############
	set "ftype=DKcmd"
	set "assoc=cmd"
	
	(ftype %ftype% 2>nul) && (ftype %ftype%=)
	%dk_call% dk_registryKeyExists "HKCR/%ftype%" && %dk_call% dk_registryDeleteKey "HKCR/%ftype%"

	(assoc .%assoc% 2>nul) && (assoc .%assoc%=)
	%dk_call% dk_registryKeyExists "HKCR/.%assoc%" && %dk_call% dk_registryDeleteKey "HKCR/.%assoc%"
	%dk_call% dk_registryKeyExists "HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/.%assoc%" && %dk_call% dk_registryDeleteKey "HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/.%assoc%"

	::###### RESTORE DEFAULTS ######
	ftype %assoc%file="%%1" %%*
	assoc .%assoc%=%assoc%file
	::%dk_call% dk_registrySetKey "HKLM/SOFTWARE/Classes/.%assoc%" "" "REG_SZ" "%assoc%file"
	::%dk_call% dk_registrySetKey "HKLM/SOFTWARE/Classes/%assoc%file/shell/open/command" "" "REG_SZ" "\"%%1\" %*"
%endfunction%










rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal

	%dk_call% DKUNINSTALL
%endfunction%
