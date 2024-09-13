@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::####################################################################
::# dk_extract(file, dest)
::#
::#
:dk_extract
    call dk_debugFunc 1 2
 setlocal
    set "dk_extract_argc=%__ARGC__%"
    
    if %dk_extract_argc% equ 1 (%dk_call% dk_info "Extracting %~1 . . .")
    if %dk_extract_argc% equ 2 (%dk_call% dk_info "Extracting %~1 to %~2. . .")
    
    :: if the dest isn't provided, we should extract to a folder named the same as the file
    :: in the same diretory the archive file is in.    
    if not exist "%~1" %dk_call% dk_error "%~1 does not exist"
    
    if "%dk_extract_argc%" equ "2" goto:twoParams
    ::### handle 1 parameter
    %dk_call% dk_basename "%~1" basename
    %dk_call% dk_removeExtension "%basename%" basename
    %dk_call% dk_dirname "%~1" dest      &:: extract contents to same directoy
    set "dest=%dest%\%basename%"  &:: extract contents to folder within same directory
	
    %dk_call% dk_powershell Expand-Archive '"%1"' -DestinationPath '"%dest%"'
	::%dk_call% dk_callPowershell dk_extract %*
    %return%
    
    :twoParams
    ::### handle 2 parameters
    
    :: try dk_powershell
    if not exist "%~2" %dk_call% dk_powershell Expand-Archive '"%1"' -DestinationPath '"%2"'
	::if not exist "%~2" %dk_call% dk_callPowershell dk_extract %*
    
    :: try tar
    if not exist "%~2" %dk_call% dk_makeDirectory "%2" && tar --help && tar -xf "%~1" -C "%~2"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal   
    ::%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_getDKPaths"
    ::%dk_call% dk_extract "%DKDOWNLOAD_DIR%/ReactOS-0.4.14-release-119-gce0b4ff-iso.zip"
    ::%dk_call% dk_extract "%DKDOWNLOAD_DIR%/ReactOS-0.4.14-release-119-gce0b4ff-iso.zip" "%DKDOWNLOAD_DIR%\REACTOS_DL"
    
    %dk_call% dk_selectFile input
    %dk_call% dk_extract "%input%"
%endfunction%
