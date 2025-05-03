@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# DKUNINSTALL()
::#
:DKUNINSTALL
setlocal
	%dk_call% dk_debugFunc 0
	
	::######### kill cmake.exe process #########
	%dk_call% dk_killProcess cmake.exe

	::######### kill cmake-gui.exe process #########
	%dk_call% dk_killProcess cmake-gui.exe
	
	%dk_call% dk_getFileParams 			"%~dp0/dkconfig.txt"
	%dk_call% dk_validate Host_Triple 	"%dk_call% dk_Host_Triple"
	if defined WIN_ARM64_HOST			(set "CMAKE_IMPORT=%CMAKE_WIN_ARM64_IMPORT%")
	if defined LINUX_ARM64_HOST			(set "CMAKE_IMPORT=%CMAKE_LINUX_AARCH64_IMPORT%")
	if defined LINUX_X86_64_HOST		(set "CMAKE_IMPORT=%CMAKE_LINUX_X86_64_IMPORT%")
	if defined MAC_HOST					(set "CMAKE_IMPORT=%CMAKE_MAC_UNIVERSAL_IMPORT%")
	if defined WIN_X86_64_HOST			(set "CMAKE_IMPORT=%CMAKE_WIN_X86_64_IMPORT%")
	if defined WIN_X86_HOST				(set "CMAKE_IMPORT=%CMAKE_WIN_X86_IMPORT%")
    %dk_call% dk_assertVar 				CMAKE_IMPORT
	%dk_call% dk_basename 				"%CMAKE_IMPORT%" CMAKE_IMPORT_FILE
	
	%dk_call% dk_validate 				DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_importVariables		%CMAKE_DL% NAME cmake ROOT %DKTOOLS_DIR%
		
	%dk_call% dk_delete 				"%CMAKE%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKUNINSTALL
%endfunction%