@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_depend android-sdk
	
	set "Import.Path=%CD:\=/%"
	%dk_call% dk_assertPath "%Import.Path%/dkconfig.txt"
	%dk_call% dk_getFileParams "%Import.Path%/dkconfig.txt"
	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
	%dk_call% dk_basename %Import.Path% Import.Name
	
	%dk_call% dk_assertVar %Import.Name%_%Host_Tuple%_Import
	%dk_call% dk_importVariables !%Import.Name%_%Host_Tuple%_Import! INSTALL_ROOT "%ANDROID_SDK%/ndk" INSTALL_NAME %android-ndk_Build%
	
	if EXIST "%PLUGIN.Install.Path%" (%return%)
	
	%dk_call% dk_echo "Installing %Plugin.Url.Basename% . . ."
	%dk_call% dk_download %PLUGIN.Url%
	%dk_call% dk_smartExtract "%dk_download%" "%PLUGIN.Install.Path%" 

%endfunction%	
	

::	%dk_call% dk_validatePath DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
::    %dk_call% dk_cmakeEval "dk_load(%DKIMPORTS_DIR%/android-ndk/DKINSTALL.cmake)" "ANDROID_GENERATOR;ANDROID_API;ANDROID_NDK;ANDROID_TOOLCHAIN_FILE"
::    %dk_call% dk_assertVar ANDROID_GENERATOR
::    %dk_call% dk_assertVar ANDROID_API
::    %dk_call% dk_assertVar ANDROID_NDK
::    %dk_call% dk_assertVar ANDROID_TOOLCHAIN_FILE
::	endlocal & (
::		set "ANDROID_GENERATOR=%ANDROID_GENERATOR%"
::		set "ANDROID_API=%ANDROID_API%"
::		set "ANDROID_NDK=%ANDROID_NDK%"
::		set "ANDROID_TOOLCHAIN_FILE=%ANDROID_TOOLCHAIN_FILE%"
::	)
