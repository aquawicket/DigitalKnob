@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=../../../DKBatch/functions/")
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_install()
::#
:dk_install
::setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_getFileParam "%~dp0/dkconfig.txt" CMAKE_WIN_ARM64_DL
	%dk_call% dk_getFileParam "%~dp0/dkconfig.txt" CMAKE_LINUX_AARCH64_DL
	%dk_call% dk_getFileParam "%~dp0/dkconfig.txt" CMAKE_LINUX_X86_64_DL
	%dk_call% dk_getFileParam "%~dp0/dkconfig.txt" CMAKE_MAC_UNIVERSAL_DL
	%dk_call% dk_getFileParam "%~dp0/dkconfig.txt" CMAKE_WIN_X86_64_DL
	%dk_call% dk_getFileParam "%~dp0/dkconfig.txt" CMAKE_WIN_X86_DL

	%dk_call% dk_validate host_triple "%dk_call% dk_host_triple"
	if defined WIN_ARM64_HOST		(set "CMAKE_DL=%CMAKE_WIN_ARM64_DL%")
	if defined LINUX_ARM64_HOST		(set "CMAKE_DL=%CMAKE_LINUX_AARCH64_DL%")
	if defined LINUX_X86_64_HOST	(set "CMAKE_DL=%CMAKE_LINUX_X86_64_DL%")
	if defined MAC_HOST				(set "CMAKE_DL=%CMAKE_MAC_UNIVERSAL_DL%")
	if defined WIN_X86_64_HOST		(set "CMAKE_DL=%CMAKE_WIN_X86_64_DL%")
	if defined WIN_X86_HOST			(set "CMAKE_DL=%CMAKE_WIN_X86_DL%")
	%dk_call% dk_assertVar CMAKE_DL

	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_importVariables %CMAKE_DL% NAME cmake ROOT %DKTOOLS_DIR%

	set "CMAKE_EXE=%CMAKE%/bin/cmake.exe"

	if exist "%CMAKE_EXE%" goto installed
	%dk_call% dk_notice "Installing CMake . . ."
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"

	%dk_call% dk_download "%CMAKE_DL%" "%DKDOWNLOAD_DIR%/%CMAKE_DL_FILE%"
	%dk_call% dk_smartExtract "%DKDOWNLOAD_DIR%/%CMAKE_DL_FILE%" "%CMAKE%"

	%dk_call% dk_firewallAllow "CMake" "%CMAKE%/bin/cmake.exe"
	::if NOT exist "%CMAKE_EXE%" (%dk_call% dk_error "cannot find CMAKE_EXE:%CMAKE_EXE%")
	:installed
	::### install DKCMake
	:: TODO

	:: Add cmake to git_bash (symlink)
	::%dk_call% dk_validate BASH_EXE "%dk_call% dk_installGit"
	::%BASH_EXE% -c "ln ${HOME}/digitalknob/DKTools/%CMAKE_FOLDER%/bin/cmake /usr/bin/cmake"
	::%BASH_EXE% -c "ln -s ${HOME}/digitalknob/DKTools/%CMAKE_FOLDER%/share/cmake-3.29 /usr/share/cmake-3.29"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_install
%endfunction%
