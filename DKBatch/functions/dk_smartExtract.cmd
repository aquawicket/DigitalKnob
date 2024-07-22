@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd


::##################################################################################
::# dk_smartExtract(src, dest)
::#
::#
:dk_smartExtract
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"

	setlocal
	set "src=%~1"
	set "dest=%~2"
	
	call dk_realpath "%src%" src_realpath
	::call dk_printVar src_realpath
	
	call dk_dirname "%src_realpath%" src_dirname
	::call dk_printVar src_dirname
	
	call dk_basename "%src_realpath%" src_basename
	::call dk_printVar src_basename
	
	call dk_basename "%src_basename%" src_folder
	::call dk_printVar src_folder
	
	call dk_realpath "%dest%" dest_realpath
	::call dk_printVar dest_realpath
	
	call dk_dirname "%dest_realpath%" dest_dirname
	::call dk_printVar dest_dirname
	
	call dk_basename "%dest_realpath%" dest_folder
	::call dk_printVar dest_folder

::	if not exist "%dest_realpath%" (
::		call dk_makeDirectory "%dest_realpath%"
::	)
	
	call dk_info "Extracting %src_basename% . . ."
	call dk_remove "%src_dirname%\UNZIPPED"
	call dk_extract "%src_realpath%" "%src_dirname%\UNZIPPED"
	
	
	call dk_getDirectories "%src_dirname%\UNZIPPED" directories
	::call dk_printVar directories
	call dk_arrayLength directories dir_count
	::call dk_printVar dir_count
	
	call dk_getFiles "%src_dirname%\UNZIPPED" files
	call dk_arrayLength files file_count
	::call dk_printVar file_count
	
	if %dir_count% equ 1 if %file_count% equ 0 (
		rem rename/move UNZIPPED/root folder to dest path"
		call dk_move "%directories[0]%" "%dest_realpath%" OVERWRITE
		goto:eof
	)

	:: rename/move UNZIPPED folder to dest path"
	call dk_move "%src_dirname%\UNZIPPED" "%dest_realpath%" OVERWRITE
	
	endlocal
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_validate DKDOWNLOAD_DIR "call dk_getDKPaths"
	call dk_smartExtract "%DKDOWNLOAD_DIR%\test_file_0.0.1.zip" "%DKDOWNLOAD_DIR%\test_file_0.0.1"
	
	call dk_smartExtract "%DKDOWNLOAD_DIR%\test_file_0.0.2.zip" "%DKDOWNLOAD_DIR%\test_file_0.0.2"
goto:eof