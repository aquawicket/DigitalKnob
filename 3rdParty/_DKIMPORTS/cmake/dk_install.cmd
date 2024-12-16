@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_install()
::#
:dk_install
	call dk_debugFunc 0

	%dk_call% dk_validate host_triple "%dk_call% dk_host_triple"
    if defined win_arm32_host         set "CMAKE_DL="
    if defined win_arm64_host         set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-arm64.zip"
    if defined win_x86_host           set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-i386.zip"
    if defined win_x86_64_host        set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-x86_64.zip"
    if defined mac_host               set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-macos-universal.tar.gz"
::	if defined mac_host               set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-macos10.10-universal.tar.gz"
    if defined linux_x86_64_host      set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-linux-x86_64.tar.gz"
    if defined linux_arm64_host       set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-linux-aarch64.tar.gz"
    if not defined CMAKE_DL           %dk_call% dk_error "CMAKE_DL is invalid"

    ::%dk_call% dk_basename %CMAKE_DL% CMAKE_DL_FILE
	::%dk_call% dk_removeExtension %CMAKE_DL_FILE% CMAKE_FOLDER
    ::%dk_call% dk_toLower %CMAKE_FOLDER% CMAKE_FOLDER
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_importVariables %CMAKE_DL% NAME cmake ROOT %DKTOOLS_DIR%
 	
	::set "CMAKE_DIR=%DKTOOLS_DIR%\%CMAKE_FOLDER%"
    set "CMAKE_EXE=%CMAKE_DIR%\bin\cmake.exe"

    if exist "%CMAKE_EXE%" goto installed
    %dk_call% dk_echo
    %dk_call% dk_info "Installing CMake . . ."
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"

    %dk_call% dk_download "%CMAKE_DL%" "%DKDOWNLOAD_DIR%\%CMAKE_DL_FILE%"
	%dk_call% dk_smartExtract "%DKDOWNLOAD_DIR%\%CMAKE_DL_FILE%" "%CMAKE_DIR%"
    if NOT exist "%CMAKE_EXE%" %dk_call% dk_error "cannot find CMAKE_EXE:%CMAKE_EXE%"
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
	call dk_debugFunc 0
	
	%dk_call% dk_install
%endfunction%
