@echo off
call DK


::##################################################################################
::# dk_smartExtract(<src> <dest>)
::#
::#
:dk_smartExtract () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (dk_error "%__FUNCTION__%(): incorrect number of arguments")

	set "src=%~1"
	set "dest=%~2"
	
	::src_fullpath="$(realpath "${src}")"
	call dk_getFullPath "%src%" src_fullpath
	call dk_printVar src_fullpath
	
	call dk_getDirectory "%src_fullpath%" src_directory
	call dk_printVar src_directory
	
	::src_filename="$(basename "${src_fullpath}")"
	call dk_getFilename "%src_fullpath%" src_filename
	call dk_printVar src_filename
	
	::src_folder="${src_filename%.*}"
	call dk_getName "%src_filename%" src_folder
	call dk_printVar src_folder
	
	::dest_fullpath="$(realpath "${dest}")"
	call dk_getFullPath "%dest%" dest_fullpath
	call dk_printVar dest_fullpath
	
	::dest_directory="$(dirname "${dest_fullpath}")"
	call dk_getDirectory "%dest_fullpath%" dest_directory
	call dk_printVar dest_directory
	
	::dest_folder="$(basename "${dest_fullpath}")"
	call dk_getFilename "%dest_fullpath%" dest_folder
	call dk_printVar dest_folder
	
::	if not exist "%dest_fullpath%" (
::		call dk_makeDirectory "%dest_fullpath%"
::	)
	
	call dk_info "Extracting %src_filename% . . ."
	call dk_remove "%src_directory%/UNZIPPED"
	call dk_extract "%src_fullpath%" "%src_directory%/UNZIPPED"
	
	
	call dk_getDirectories "%src_directory%/UNZIPPED" directories
	call dk_printVar directories
	call dk_arrayLength directories dir_count
	call dk_printVar dir_count
	
	call dk_getFiles "%src_directory%/UNZIPPED" files
	call dk_arrayLength files file_count
	call dk_printVar file_count
	
	if %dir_count% equ 1 if %file_count% equ 0 (
		rem echo "rename/move directories[0] to dest path"
		rem echo directories[0] = %directories[0]%
		call dk_rename "%directories[0]%" "%dest_folder%"
		call dk_remove %dest_fullpath%
		rem move /Y %src_directory%/UNZIPPED/%dest_folder% %dest_directory%
		call dk_move "%src_directory%/UNZIPPED/%dest_folder%" "%dest_directory%"
		rem if exist "%dest_fullpath%" ( call dk_remove "%src_directory%/UNZIPPED" )
	) else (
		echo "rename/move UNZIPPED folder to dest path"
	)
	
	
	
	:: if UNZIPPED contains less than 2 items and 1 folder, rename/move folder to dest path
	:: else rename/move UNZIPPED folder to dest path
	
goto:eof



:DKTEST ########################################################################

	call dk_validate DKDOWNLOAD_DIR dk_getDKPaths
	call dk_smartExtract "%DKDOWNLOAD_DIR%/test_file_0.0.1.zip" "%DKDOWNLOAD_DIR%/mySmartExtractFolder"
	