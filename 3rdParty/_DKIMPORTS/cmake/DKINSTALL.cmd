@echo off&::###### DK.cmd #########################################################################################################################
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
	
	%dk_call% dk_getFileParams			"%~dp0/dkconfig.txt"
	%dk_call% dk_validate Host_Tuple	"%dk_call% dk_Host_Tuple"
	set "cmake_Import=!cmake_%Host_Tuple%_Import!"
	%dk_call% dk_assertVar				cmake_Import
	
	%dk_call% dk_validate				DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_importVariables		%cmake_Import% ROOT %DKTOOLS_DIR%
	%dk_call% dk_assertVar 				CMAKE

	set "CMAKE_EXE=%CMAKE%/bin/cmake.exe"
	if exist "%CMAKE_EXE%" 				(%return%)
	
	%dk_call% dk_echo
	%dk_call% dk_info 					"Installing CMake . . ."
	%dk_call% dk_download 				"%cmake_Import%"
	%dk_call% dk_smartExtract 			"%dk_download%" "%CMAKE%"

	%dk_call% dk_assertPath 			"%CMAKE_EXE%"
	%dk_call% dk_firewallAllow 			"CMake" "%CMAKE_EXE%"
	
	:: Add cmake to git_bash (symlink)
	::%dk_call% dk_validate BASH_EXE "%dk_call% dk_installGit"
	::%BASH_EXE% -c "ln ${HOME}/DigitalKnob/DKTools/%CMAKE_FOLDER%/bin/cmake /usr/bin/cmake"
	::%BASH_EXE% -c "ln -s ${HOME}/DigitalKnob/DKTools/%CMAKE_FOLDER%/share/cmake-3.29 /usr/share/cmake-3.29"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% DKINSTALL
%endfunction%
