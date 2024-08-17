@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_extract(file, destination)
::#
::#
:dk_extract
	call dk_debugFunc 1 2

	set "dk_extract_argc=%__ARGC__%"
	
	if %dk_extract_argc% equ 1 (%dk_call% dk_info "Extracting %~1 . . .")
	if %dk_extract_argc% equ 2 (%dk_call% dk_info "Extracting %~1 to %~2. . .")
	
	:: if the destination isn't provided, we should extract to a folder named the same as the file
	:: in the same diretory the archive file is in.    
	if not exist "%~1" %dk_call% dk_error "%~1 does not exist"
	
	if "%dk_extract_argc%" equ "2" goto:twoParams
	::### handle 1 parameter
	%dk_call% dk_basename "%~1" basename
	%dk_call% dk_removeExtension "%basename%" basename
	%dk_call% dk_getParentDir "%~1" destination      &:: extract contents to same directoy
	set "destination=%destination%\%basename%"  &:: extract contents to folder within same directory
	%dk_call% dk_echo "destination = %destination%"
	%dk_call% dk_powershell Expand-Archive '"%1"' -DestinationPath '"%destination%"'
	::powershell Expand-Archive '"%1"' -DestinationPath '"%destination%"'
	goto:eof
	
:twoParams
	::### handle 2 parameters
	%dk_call% dk_powershell Expand-Archive '"%1"' -DestinationPath '"%2"'
	::owershell Expand-Archive '"%1"' -DestinationPath '"%2"'
	goto:eof
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	::%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_getDKPaths"
	::%dk_call% dk_extract "%DKDOWNLOAD_DIR%/ReactOS-0.4.14-release-119-gce0b4ff-iso.zip"
	::%dk_call% dk_extract "%DKDOWNLOAD_DIR%/ReactOS-0.4.14-release-119-gce0b4ff-iso.zip" "%DKDOWNLOAD_DIR%\REACTOS_DL"
	
	%dk_call% dk_selectFile input
	%dk_call% dk_extract "%input%"
goto:eof
