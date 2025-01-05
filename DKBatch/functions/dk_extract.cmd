@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_extract(file, dest)
::#
::#
:dk_extract
setlocal
	%dk_call% dk_debugFunc 1 2
 
	set "_file_=%~1"
	::set "_file_=%_file_:/=\%"
	
	if not exist "%_file_%" %dk_call% dk_error "%_file_% does not exist"
	 
    :: if the _dest_ isn't provided, we should extract to a folder named the same as the file
    :: in the same diretory the archive file is in.    
    if "%__ARGC__%" equ "2" goto twoParams

    ::### handle 1 parameter
    %dk_call% dk_basename "%_file_%" basename
    %dk_call% dk_removeExtension "%basename%" basename
    %dk_call% dk_dirname "%_file_%" _dest_      &:: extract contents to same directoy
    set "_dest_=%_dest_%\%basename%"              &:: extract contents to folder within same directory
	
	%dk_call% dk_info "Extracting %_file_% to %dest%. . ."
	if exist "%_dest_%" %dk_call% dk_error "%_dest_% already exists"
    %dk_call% dk_powershell Expand-Archive '"%_file_%"' -DestinationPath '"%_dest_%"'
	::%dk_call% dk_callDKPowershell dk_extract %*
    %return%
    
	::### handle 2 parameters
    :twoParams
    
	set "_dest_=%~2"
	:set "_dest_=%_dest_:/=\%"
    
	:: try dk_powershell
	%dk_call% dk_info "Extracting %_file_% to %_dest_%. . ."
	if exist "%_dest_%" %dk_call% dk_error "%_dest_% already exists"
    if not exist "%_dest_%" %dk_call% dk_powershell Expand-Archive '"%_file_%"' -DestinationPath '"%_dest_%"'
	::if not exist "%~2" %dk_call% dk_callDKPowershell dk_extract %*
    
    :: try tar
    if not exist "%_dest_%" %dk_call% dk_makeDirectory "%_dest_%" && tar --help && tar -xf "%_file_%" -C "%_dest_%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	::%dk_call% dk_validate DKDOWNLOAD_DIR "call dk_DKDOWNLOAD_DIR"
    ::%dk_call% dk_extract "%DKDOWNLOAD_DIR%/ReactOS-0.4.14-release-119-gce0b4ff-iso.zip"
    ::%dk_call% dk_extract "%DKDOWNLOAD_DIR%/ReactOS-0.4.14-release-119-gce0b4ff-iso.zip" "%DKDOWNLOAD_DIR%\REACTOS_DL"
    
    %dk_call% dk_selectFile input
    %dk_call% dk_extract "%input%"
%endfunction%
