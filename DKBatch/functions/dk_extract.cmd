@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_extract(<filepath>, <target>:OPTIONAL)
::#
::#
:dk_extract
%setlocal%
    %dk_call% dk_debugFunc 1 2
	
	for /F %%G IN ("%~1") do set dk_extract_file=%%~G
	for /F %%G IN ("%~2") do set dk_extract_dest=%%~G
	
	%dk_call% dk_assertPath "%dk_extract_file%"
	
	::###### validate destination ######
    ::## if the destination isn't provided, we should extract to a folder named the same as the file
    ::## in the same diretory the archive file is in.
	if "%dk_extract_dest%" equ "" (
		%dk_call% dk_basename "%dk_extract_file%"
		%dk_call% dk_removeExtension "!dk_basename!"
		%dk_call% dk_dirname "%dk_extract_file%"					&rem extract contents to same directoy
		set "dk_extract_dest=!dk_dirname!/!dk_removeExtension!"	&rem extract contents to folder within same directory
	)

	if EXIST "%dk_extract_dest%" (%dk_call% dk_error "%dk_extract_dest% already exists")
	
	%dk_call% dk_info "Extracting '%dk_extract_file%' to '%dk_extract_dest%' . . ."

	::###### Try tar ######
    if NOT EXIST "%dk_extract_dest%" (
		%dk_call% dk_mkdir "%dk_extract_dest%" 
		tar --help %NO_OUTPUT% && tar -xf "%dk_extract_file%" -C "%dk_extract_dest%"
		%dk_call% dk_isNonEmptyDirectory "%dk_extract_dest%" || %dk_call% dk_delete "%dk_extract_dest%"
	)
	
	::###### Try dk_callDKPowershell ######
	if NOT EXIST "%dk_extract_dest%" (
		%dk_call% dk_callDKPowershell dk_extract "%dk_extract_file%" "%dk_extract_dest%"
		%dk_call% dk_isNonEmptyDirectory "%dk_extract_dest%" || %dk_call% dk_delete "%dk_extract_dest%"
	)

	::###### Try powershell.exe [System.IO.Compression.ZipFile]::ExtractToDirectory ######
	if NOT EXIST "%dk_extract_dest%" (
		%dk_call% dk_validate powershell_exe "%dk_call% dk_depend powershell"
		%powershell_exe% Add-Type -Assembly 'System.IO.Compression.Filesystem'; [System.IO.Compression.ZipFile]::ExtractToDirectory^('%dk_extract_file%', '%dk_extract_dest%'^)
		%dk_call% dk_isNonEmptyDirectory "%dk_extract_dest%" || %dk_call% dk_delete "%dk_extract_dest%"
	)

	::###### Try dk_evalPowershell Expand-Archive *** VERY SLOW *** ######
	if NOT EXIST "%dk_extract_dest%" (
		%dk_call% dk_evalPowershell Expand-Archive '"%dk_extract_file%"' -DestinationPath '"%dk_extract_dest%"'
		%dk_call% dk_isNonEmptyDirectory "%dk_extract_dest%" || %dk_call% dk_delete "%dk_extract_dest%"
	)
	
	%dk_call% dk_isNonEmptyDirectory "%dk_extract_dest%" || %dk_call% dk_delete "%dk_extract_dest%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
    %dk_call% dk_debugFunc 0

	%dk_call% dk_extract "C:/Users/Administrator/DigitalKnob/download/msys2-base-x86_64-20241208.tar.xz" "C:/Users/Administrator/DigitalKnob/download/msys2-base-x86_64-20241208.tar.xz_EXTRACTED"
	%endfunction%
	
    %dk_call% dk_selectFile
    %dk_call% dk_extract "%dk_selectFile%"
%endfunction%
