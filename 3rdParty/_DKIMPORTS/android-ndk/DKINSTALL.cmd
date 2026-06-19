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


rem ####################################################################
rem # DKINSTALL()
rem #
:DKINSTALL
%setlocal%

	%dk_call% dk_validate android-sdk %dk_call% dk_depend android-sdk
	
	set "Import.Path=%CD%"
	%dk_call% dk_assertPath "%Import.Path%/dkconfig.txt"
	%dk_call% dk_fileVariables "%Import.Path%/dkconfig.txt"
	%dk_call% dk_validate Host_Tuple %dk_call% dk_Host_Tuple
	%dk_call% dk_basename %Import.Path% Import.Name
	
	%dk_call% dk_assertVar %Import.Name%_%Host_Tuple%_Import
	%dk_call% dk_importVariables !%Import.Name%_%Host_Tuple%_Import! INSTALL_ROOT "%ANDROID_SDK%/ndk" INSTALL_NAME %android-ndk_Build%
	
	if EXIST "%PLUGIN_Install_Path%" (%return%)
	
	%dk_call% dk_echo "Installing %PLUGIN_Url_Basename% . . ."
	%dk_call% dk_download %PLUGIN_Url%
	%dk_call% dk_smartExtract "%dk_download%" "%PLUGIN_Install_Path%" 
%endfunction%	
