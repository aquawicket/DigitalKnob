@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0

	::######### kill cmake.exe process #########
	::%dk_call% dk_killProcess cmake.exe

	::######### kill cmake-gui.exe process #########
	::%dk_call% dk_killProcess cmake-gui.exe
	
	%dk_call% dk_getFileParams 		"%~dp0/dkconfig.txt"
	%dk_call% dk_validate 			Host_Tuple "%dk_call% dk_Host_Tuple"
	if defined LINUX_ARM64_HOST		(set "CMAKE_IMPORT=%CMAKE_LINUX_AARCH64_IMPORT%")
	if defined LINUX_X86_64_HOST	(set "CMAKE_IMPORT=%CMAKE_LINUX_X86_64_IMPORT%")
	if defined Mac_Host				(set "CMAKE_IMPORT=%CMAKE_MAC_UNIVERSAL_IMPORT%")
	if defined WIN_ARM64_HOST		(set "CMAKE_IMPORT=%CMAKE_WIN_ARM64_IMPORT%")
	if defined WIN_X86_64_HOST		(set "CMAKE_IMPORT=%CMAKE_WIN_X86_64_IMPORT%")
	if defined WIN_X86_HOST			(set "CMAKE_IMPORT=%CMAKE_WIN_X86_IMPORT%")
	%dk_call% dk_assertVar 			CMAKE_IMPORT
	
	%dk_call% dk_basename 			"%CMAKE_IMPORT%" CMAKE_IMPORT_FILE

	%dk_call% dk_validate 			DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_importVariables 	%CMAKE_IMPORT% NAME cmake ROOT %DKTOOLS_DIR%

	set "CMAKE_EXE=%CMAKE%/bin/cmake.exe"

	if exist "%CMAKE_EXE%" 			(%return%)
	%dk_call% dk_notice 			"Installing CMake . . ."
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"

	%dk_call% dk_download 			"%CMAKE_IMPORT%" "%DKDOWNLOAD_DIR%/%CMAKE_IMPORT_FILE%"
	%dk_call% dk_smartExtract 		"%DKDOWNLOAD_DIR%/%CMAKE_IMPORT_FILE%" "%CMAKE%"

	%dk_call% dk_firewallAllow 		"CMake" "%CMAKE%/bin/cmake.exe"
	%dk_call% dk_assertPath 		"%CMAKE_EXE%"

	:: Add cmake to git_bash (symlink)
	::%dk_call% dk_validate BASH_EXE "%dk_call% dk_installGit"
	::%BASH_EXE% -c "ln ${HOME}/digitalknob/DKTools/%CMAKE_FOLDER%/bin/cmake /usr/bin/cmake"
	::%BASH_EXE% -c "ln -s ${HOME}/digitalknob/DKTools/%CMAKE_FOLDER%/share/cmake-3.29 /usr/share/cmake-3.29"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% DKINSTALL
%endfunction%
