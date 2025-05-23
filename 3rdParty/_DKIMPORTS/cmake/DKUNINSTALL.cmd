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
	
	%dk_call% dk_validate host_triple   "%dk_call% dk_host_triple.cmd"
  ::if defined win_arm32    	 (set "CMAKE_DL=")
    if defined win_arm64_host    (set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-arm64.zip")
    if defined win_x86_host      (set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-i386.zip")
    if defined win_x86_64_host   (set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-x86_64.zip")
    if defined mac_host          (set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-macos-universal.tar.gz")
  ::if defined mac_host          (set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-macos10.10-universal.tar.gz")
    if defined linux_x86_64_host (set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-linux-x86_64.tar.gz")
    if defined linux_arm64_host  (set "CMAKE_DL=https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-linux-aarch64.tar.gz")
    %dk_call% dk_assertVar CMAKE_DL
	
	::%dk_call% dk_basename %CMAKE_DL% CMAKE_DL_FILE
	::%dk_call% dk_removeExtension %CMAKE_DL_FILE% CMAKE_FOLDER
    ::%dk_call% dk_toLower %CMAKE_FOLDER% CMAKE_FOLDER
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_importVariables %CMAKE_DL% NAME cmake ROOT %DKTOOLS_DIR%

	::FIXME: kill pwsh.exe process
	%dk_call% dk_delete "%CMAKE%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% DKUNINSTALL
%endfunction%