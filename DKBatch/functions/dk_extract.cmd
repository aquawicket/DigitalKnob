@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

call dk_source dk_powershellEval
::####################################################################
::# dk_extract(file, destination)
::#
::#
:dk_extract
	call dk_debugFunc 1 2

	set "dk_extract_argc=%__ARGC__%"
	
	if %dk_extract_argc% equ 1 (call dk_info "Extracting %~1 . . .")
	if %dk_extract_argc% equ 2 (call dk_info "Extracting %~1 to %~2. . .")
	
	:: if the destination isn't provided, we should extract to a folder named the same as the file
	:: in the same diretory the archive file is in.    
	if not exist "%~1" call dk_error "%~1 does not exist"
	
	if "%dk_extract_argc%" equ "2" goto:twoParams
	::### handle 1 parameter
	call dk_basename "%~1" basename
	call dk_removeExtension "%basename%" basename
	call dk_getParentDir "%~1" destination      &:: extract contents to same directoy
	set "destination=%destination%\%basename%"  &:: extract contents to folder within same directory
	call dk_echo "destination = %destination%"
	::call dk_powershellEval Expand-Archive '"%1"' -DestinationPath '"%destination%"'
	powershell Expand-Archive '"%1"' -DestinationPath '"%destination%"'
	goto:eof
	
:twoParams
	::### handle 2 parameters
	::call dk_powershellEval Expand-Archive '"%1"' -DestinationPath '"%2"'
	powershell Expand-Archive '"%1"' -DestinationPath '"%2"'
	goto:eof
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	::call dk_validate DKDOWNLOAD_DIR "call dk_getDKPaths"
	::call dk_extract "%DKDOWNLOAD_DIR%/ReactOS-0.4.14-release-119-gce0b4ff-iso.zip"
	::call dk_extract "%DKDOWNLOAD_DIR%/ReactOS-0.4.14-release-119-gce0b4ff-iso.zip" "%DKDOWNLOAD_DIR%\REACTOS_DL"
	
	call dk_selectFile input
	call dk_extract "%input%"
goto:eof
