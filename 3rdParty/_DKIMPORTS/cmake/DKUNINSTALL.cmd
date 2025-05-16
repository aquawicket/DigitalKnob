@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# DKUNINSTALL()
::#
:DKUNINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0
	
	::######### kill cmake.exe process #########
	%dk_call% dk_killProcess cmake.exe

	::######### kill cmake-gui.exe process #########
	%dk_call% dk_killProcess cmake-gui.exe
	
	%dk_call% dk_getFileParams 			"%~dp0/dkconfig.txt"
	%dk_call% dk_validate Host_Tuple	"%dk_call% dk_Host_Tuple"
	if defined Linux_Arm64_Host			(set "CMAKE_IMPORT=%CMAKE_LINUX_AARCH64_IMPORT%")
	if defined Linux_X86_64_Host		(set "CMAKE_IMPORT=%CMAKE_LINUX_X86_64_IMPORT%")
	if defined Mac_Host					(set "CMAKE_IMPORT=%CMAKE_MAC_UNIVERSAL_IMPORT%")
	if defined Windows_Arm64_Host		(set "CMAKE_IMPORT=%CMAKE_WIN_ARM64_IMPORT%")
	if defined Windows_X86_64_Host		(set "CMAKE_IMPORT=%CMAKE_WIN_X86_64_IMPORT%")
	if defined Windows_X86_Host			(set "CMAKE_IMPORT=%CMAKE_WIN_X86_IMPORT%")
	%dk_call% dk_assertVar 				CMAKE_IMPORT
	
	%dk_call% dk_basename "%CMAKE_IMPORT%" CMAKE_IMPORT_FILE
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_importVariables %CMAKE_IMPORT% NAME cmake ROOT %DKTOOLS_DIR%
	
	%dk_call% dk_assertVar CMAKE
	%dk_call% dk_delete 				"%CMAKE%"
	
pause	
	set "CMAKE_EXE=%CMAKE%/bin/cmake.exe"
	
::	if exist "%CMAKE_EXE%" 			(%return%)
	%dk_call% dk_notice 			"UnInstalling CMake . . ."
::	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"

::	%dk_call% dk_download 			"%CMAKE_IMPORT%" "%DKDOWNLOAD_DIR%/%CMAKE_IMPORT_FILE%"
::	%dk_call% dk_smartExtract 		"%DKDOWNLOAD_DIR%/%CMAKE_IMPORT_FILE%" "%CMAKE%"

::	%dk_call% dk_firewallAllow 		"CMake" "%CMAKE%/bin/cmake.exe"
::	%dk_call% dk_assertPath 		"%CMAKE_EXE%"
	
	%dk_call% dk_echo 				"%CMAKE%"
	%dk_call% dk_delete 			"%CMAKE%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	call :DKUNINSTALL
%endfunction%