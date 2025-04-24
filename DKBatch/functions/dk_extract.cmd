<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_extract(file, dest)
::#
::#
:dk_extract
    call dk_debugFunc 1 2
 setlocal
 
	if not exist "%~1" %dk_call% dk_error "%~1 does not exist"
	 
    :: if the dest isn't provided, we should extract to a folder named the same as the file
    :: in the same diretory the archive file is in.    
    if "%__ARGC__%" equ "2" goto twoParams

    ::### handle 1 parameter
    %dk_call% dk_basename "%~1" basename
    %dk_call% dk_removeExtension "%basename%" basename
    %dk_call% dk_dirname "%~1" dest      &:: extract contents to same directoy
    set "dest=%dest%\%basename%"         &:: extract contents to folder within same directory
	
	%dk_call% dk_info "Extracting %~1 to %dest%. . ."
	if exist "%dest%" %dk_call% dk_error "%~2 already exists"
    %dk_call% dk_powershell Expand-Archive '"%1"' -DestinationPath '"%dest%"'
	::%dk_call% dk_callDKPowershell dk_extract %*
    %return%
    
	::### handle 2 parameters
    :twoParams
    
    :: try dk_powershell
	%dk_call% dk_info "Extracting %~1 to %~2. . ."
	if exist "%~2" %dk_call% dk_error "%~2 already exists"
    if not exist "%~2" %dk_call% dk_powershell Expand-Archive '"%1"' -DestinationPath '"%2"'
	::if not exist "%~2" %dk_call% dk_callDKPowershell dk_extract %*
    
    :: try tar
    if not exist "%~2" %dk_call% dk_makeDirectory "%2" && tar --help && tar -xf "%~1" -C "%~2"
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_extract(<filepath>, <target>:OPTIONAL)
::#
::#
:dk_extract
setlocal enableDelayedExpansion
    %dk_call% dk_debugFunc 1 2

	set "_file_=%~1"
	set "_dest_=%~2"
	
	if not exist "%_file_%" (%dk_call% dk_error "%_file_% does not exist")
	 
	::###### validate destination ######
    ::## if the destination isn't provided, we should extract to a folder named the same as the file
    ::## in the same diretory the archive file is in.
	if "%_dest_%" equ "" (
		%dk_call% dk_basename "%_file_%"
		%dk_call% dk_removeExtension "!dk_basename!"
		%dk_call% dk_dirname "%_file_%"					&rem extract contents to same directoy
		set "_dest_=!dk_dirname!/!dk_removeExtension!"	&rem extract contents to folder within same directory
	)
	if exist "%_dest_%" (%dk_call% dk_error "%_dest_% already exists")
	

	%dk_call% dk_info "Extracting %_file_% to %_dest_% . . ."
	
	::###### Try dk_callDKPowershell ######
	if not exist "%_dest_%" (%dk_call% dk_callDKPowershell dk_extract "%_file_%" "%_dest_%")
	
	::###### Try powershell.exe [System.IO.Compression.ZipFile]::ExtractToDirectory ######
	if not exist "%_dest_%" (
		%dk_call% dk_validate POWERSHELL_EXE "%dk_call% dk_POWERSHELL_EXE"
		%POWERSHELL_EXE% Add-Type -Assembly '"System.IO.Compression.Filesystem"'; [System.IO.Compression.ZipFile]::ExtractToDirectory^('"%_file_%"', '"%_dest_%"'^)
	)
	
	::###### Try tar ######
    if not exist "%_dest_%" (%dk_call% dk_mkdir "%_dest_%" && tar --help && tar -xf "%_file_%" -C "%_dest_%")
	
	::###### Try dk_powershell Expand-Archive *** VERY SLOW *** ######
	if not exist "%_dest_%" (%dk_call% dk_powershell Expand-Archive '"%_file_%"' -DestinationPath '"%_dest_%"')
>>>>>>> Development
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
	::%dk_call% dk_validate DKDOWNLOAD_DIR "call dk_DIGITALKNOB_DIR"
    ::%dk_call% dk_extract "%DKDOWNLOAD_DIR%/ReactOS-0.4.14-release-119-gce0b4ff-iso.zip"
    ::%dk_call% dk_extract "%DKDOWNLOAD_DIR%/ReactOS-0.4.14-release-119-gce0b4ff-iso.zip" "%DKDOWNLOAD_DIR%\REACTOS_DL"
    
=======
setlocal
    %dk_call% dk_debugFunc 0
 
>>>>>>> Development
    %dk_call% dk_selectFile input
    %dk_call% dk_extract "%input%"
%endfunction%
