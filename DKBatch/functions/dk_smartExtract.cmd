@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::##################################################################################
::# dk_smartExtract(src, dest)
::#
::#
:dk_smartExtract
setlocal
	%dk_call% dk_debugFunc 2

    set "src=%~1"
	::set "src=%src:/=\%"
    set "dest=%~2"
	::set "dest=%dest:/=\%"
    
    %dk_call% dk_realpath "%src%" src_realpath
	::%dk_call% dk_printVar src_realpath
    
    %dk_call% dk_dirname "%src_realpath%" src_dirname
	::%dk_call% dk_printVar src_dirname
    
    %dk_call% dk_basename "%src_realpath%" src_basename
	::%dk_call% dk_printVar src_basename
    
    %dk_call% dk_basename "%src_basename%" src_folder
	::%dk_call% dk_printVar src_folder
	
	%dk_call% dk_set src_extractPath "%src_dirname%\%src_basename%_EXTRACT"
	%dk_call% dk_printVar src_extractPath
    
    %dk_call% dk_realpath "%dest%" dest_realpath
	::%dk_call% dk_printVar dest_realpath
    
    %dk_call% dk_dirname "%dest_realpath%" dest_dirname
	::%dk_call% dk_printVar dest_dirname
    
    %dk_call% dk_basename "%dest_realpath%" dest_folder
	::%dk_call% dk_printVar dest_folder

::  if not exist "%dest_realpath%" %dk_call% dk_makeDirectory "%dest_realpath%"

    ::%dk_call% dk_info "Extracting %src_realpath%  to  %src_extractPath%"
	
	if exist "%src_extractPath%"  %dk_call% dk_delete "%src_extractPath%"
	
	%dk_call% dk_extract "%src_realpath%" "%src_extractPath%"
	
	echo %dk_call% dk_getDirectories "%src_extractPath%" directories
	%dk_call% dk_getDirectories "%src_extractPath%" directories
    %dk_call% dk_printVar directories

	echo %dk_call% Array::dk_length directories dir_count
    %dk_call% Array::dk_length directories dir_count
    %dk_call% dk_printVar dir_count
   
	echo %dk_call% dk_getFiles "%src_extractPath%" files
	%dk_call% dk_getFiles "%src_extractPath%" files
	%dk_call% dk_printVar files

	echo %dk_call% Array::dk_length files file_count
    %dk_call% Array::dk_length files file_count
    %dk_call% dk_printVar file_count
    
    if %dir_count% equ 1 if %file_count% equ 0 (
        rem rename/move EXTRACTED/root folder to dest path"
        %dk_call% dk_move "%directories[0]%" "%dest_realpath%" OVERWRITE
		if exist "%src_extractPath%"  %dk_call% dk_delete "%src_extractPath%"
        %endfunction%
    )

    :: rename/move EXTRACTED folder to dest path"
	%dk_call% dk_move "%src_extractPath%" "%dest_realpath%" OVERWRITE
	if exist "%src_extractPath%"  %dk_call% dk_delete "%src_extractPath%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
	::%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	::%dk_call% dk_download "https://github.com/libsdl-org/SDL/archive/refs/tags/release-2.26.1.zip" "%DKDOWNLOAD_DIR%\sdl-release-2.26.1.zip"
	::%dk_call% dk_smartExtract "%DKDOWNLOAD_DIR%\sdl-release-2.26.1.zip" "%DKDOWNLOAD_DIR%\sdl-release-2.26.1"

%endfunction%