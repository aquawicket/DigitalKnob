@echo off&rem ###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../DKBatch/functions/") 
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DKINIT_cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %* && exit /b %errorlevel%)
rem #################################################################################################################################################


:dk_uninstall_bat
	ftype DKBat=
	%dk_call% dk_registryDeleteKey "HKCR/DKBat"
	
	assoc .=bat
	%dk_call% dk_registryDeleteKey "HKCR/.bat"
	%dk_call% dk_registryDeleteKey "HKCU/SOFTWARE/Microsoft/Windows/CurrentVersion/Explorer/FileExts/.bat"

	::###### RESTORE DEFAULTS (restore.reg) ######
	:: .bat
	ftype batfile="%%1" %%*
	assoc .bat=batfile
	::%dk_call% dk_registrySetKey "HKLM/SOFTWARE/Classes/.bat" "" "REG_SZ" "cmdfile"
	::%dk_call% dk_registrySetKey "HKLM/SOFTWARE/Classes/batfile/shell/open/command" "" "REG_SZ" "\"%%1\" %*"
%endfunction%
