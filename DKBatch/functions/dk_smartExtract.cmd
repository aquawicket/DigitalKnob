@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::##################################################################################
::# dk_smartExtract(src, dest)
::#
::#
:dk_smartExtract
 setlocal
	call dk_debugFunc 2

	set "src=%~1"
	set "dest=%~2"
	
	%dk_call% dk_realpath "%src%" src_realpath
	::%dk_call% dk_printVar src_realpath
	
	%dk_call% dk_dirname "%src_realpath%" src_dirname
	::%dk_call% dk_printVar src_dirname
	
	%dk_call% dk_basename "%src_realpath%" src_basename
	::%dk_call% dk_printVar src_basename
	
	%dk_call% dk_basename "%src_basename%" src_folder
	::%dk_call% dk_printVar src_folder
	
	%dk_call% dk_realpath "%dest%" dest_realpath
	::%dk_call% dk_printVar dest_realpath
	
	%dk_call% dk_dirname "%dest_realpath%" dest_dirname
	::%dk_call% dk_printVar dest_dirname
	
	%dk_call% dk_basename "%dest_realpath%" dest_folder
	::%dk_call% dk_printVar dest_folder

::	if not exist "%dest_realpath%" (
::		%dk_call% dk_makeDirectory "%dest_realpath%"
::	)
	
	%dk_call% dk_info "Extracting %src_basename% . . ."
	%dk_call% dk_delete "%src_dirname%\UNZIPPED"
	%dk_call% dk_extract "%src_realpath%" "%src_dirname%\UNZIPPED"
	
	%dk_call% dk_getDirectories "%src_dirname%\UNZIPPED" directories
	::%dk_call% dk_printVar directories
	%dk_call% dk_arrayLength directories dir_count
	::%dk_call% dk_printVar dir_count
	
	%dk_call% dk_getFiles "%src_dirname%\UNZIPPED" files
	%dk_call% dk_arrayLength files file_count
	::%dk_call% dk_printVar file_count
	
	if %dir_count% equ 1 if %file_count% equ 0 (
		rem rename/move UNZIPPED/root folder to dest path"
		%dk_call% dk_move "%directories[0]%" "%dest_realpath%" OVERWRITE
		goto:eof
	)

	:: rename/move UNZIPPED folder to dest path"
	%dk_call% dk_move "%src_dirname%\UNZIPPED" "%dest_realpath%" OVERWRITE
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_getDKPaths"
	%dk_call% dk_smartExtract "%DKDOWNLOAD_DIR%\test_file_0.0.1.zip" "%DKDOWNLOAD_DIR%\test_file_0.0.1"
	
	%dk_call% dk_smartExtract "%DKDOWNLOAD_DIR%\test_file_0.0.2.zip" "%DKDOWNLOAD_DIR%\test_file_0.0.2"
goto:eof