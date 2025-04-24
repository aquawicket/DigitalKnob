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
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
    %dk_call% dk_debugFunc 0
 
    %dk_call% dk_selectFile input
    %dk_call% dk_extract "%input%"
%endfunction%
