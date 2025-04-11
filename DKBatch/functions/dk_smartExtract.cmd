@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::##################################################################################
::# dk_smartExtract(src, dest)
::#
::#
:dk_smartExtract
setlocal
	%dk_call% dk_debugFunc 2

	set "src=%~1"
	set "dest=%~2"

	%dk_call% dk_realpath "%src%" src_realpath
	%dk_call% dk_dirname "%src_realpath%" src_dirname
	%dk_call% dk_basename "%src_realpath%" src_basename
	%dk_call% dk_basename "%src_basename%" src_folder
	%dk_call% dk_set src_extractPath "%src_dirname%/%src_basename%_EXTRACTED"
	%dk_call% dk_realpath "%dest%" dest_realpath
	%dk_call% dk_dirname "%dest_realpath%" dest_dirname
	%dk_call% dk_basename "%dest_realpath%" dest_folder

::  if not exist "%dest_realpath%" %dk_call% dk_mkdir "%dest_realpath%"

    %dk_call% dk_info "Extracting %src_realpath%  to  %src_extractPath%"
	
::	if exist "%src_extractPath%"  %dk_call% dk_delete "%src_extractPath%"
	
	%dk_call% dk_extract "%src_realpath%" "%src_extractPath%"
	
	%dk_call% dk_getDirectories "%src_extractPath%"
	
    %dk_call% Array/dk_length dk_getDirectories 
	set "dir_count=%dk_length%"
	
	%dk_call% dk_getFiles "%src_extractPath%"
	
    %dk_call% Array/dk_length dk_getFiles
	set "file_count=%dk_length%"
    
    if %dir_count% equ 1 (
		if %file_count% equ 0 (
			rem rename/move EXTRACTED/root folder to dest path"
			%dk_call% dk_move "%dk_getDirectories[0]%" "%dest_realpath%" OVERWRITE
			if exist "%src_extractPath%" (%dk_call% dk_delete "%src_extractPath%")
			goto:eof
		)
    )

    :: rename/move EXTRACTED folder to dest path"
	%dk_call% dk_move "%src_extractPath%" "%dest_realpath%" OVERWRITE
	if exist "%src_extractPath%" (%dk_call% dk_delete "%src_extractPath%")
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
    %dk_call% dk_debugFunc 0

	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	%dk_call% dk_download "https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-x86_64.zip" "%DKDOWNLOAD_DIR%/cmake-3.29.5-windows-x86_64.zip"
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_smartExtract "%DKDOWNLOAD_DIR%/cmake-3.29.5-windows-x86_64.zip" "%DKTOOLS_DIR%/cmake-3.29.5-windows-x86_64"
	
	::%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	::%dk_call% dk_download "https://github.com/libsdl-org/SDL/archive/refs/tags/release-2.26.1.zip" "%DKDOWNLOAD_DIR%/sdl-release-2.26.1.zip"
	::%dk_call% dk_smartExtract "%DKDOWNLOAD_DIR%/sdl-release-2.26.1.zip" "%DKDOWNLOAD_DIR%/sdl-release-2.26.1"
	
	::%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	::%dk_call% dk_download "https://newcontinuum.dl.sourceforge.net/project/lzmautils/xz-5.4.6.tar.gz" "%DKDOWNLOAD_DIR%/xz-5.4.6.tar.gz"
    ::%dk_call% dk_smartExtract "%DKDOWNLOAD_DIR%/xz-5.4.6.tar.gz" "%DKDOWNLOAD_DIR%/xz-5.4.6"
%endfunction%