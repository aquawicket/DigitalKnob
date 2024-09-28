@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*


::### DEPEND ###
::dk_depend(vc_redist) #for VCRUNTIME140.dll


::####################################################################
::# dk_installPhp
::#
:dk_installPhp
    call dk_debugFunc 0
	
	%dk_call% dk_validate host_triple "%dk_call% dk_host_triple"
	if defined win_x86_host           set "PHP_DL=https://windows.php.net/downloads/releases/php-8.0.30-Win32-vs16-x86.zip"
	if defined win_x86_64_host        set "PHP_DL=https://windows.php.net/downloads/releases/php-8.0.30-Win32-vs16-x64.zip"
	if not defined PHP_DL             %dk_call% dk_error "PHP_DL is invalid"
	
	
	%dk_call% dk_basename %PHP_DL% PHP_DL_FILE
    %dk_call% dk_removeExtension %PHP_DL_FILE% PHP_FOLDER
    ::%dk_call% dk_convertToCIdentifier %PHP_FOLDER% PHP_FOLDER
    %dk_call% dk_toLower %PHP_FOLDER% PHP_FOLDER
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DIGITALKNOB_DIR"
	%dk_call% dk_set PHP "%DKTOOLS_DIR%\%PHP_FOLDER%"
	%dk_call% dk_set PHP_EXE "%PHP%\php.exe"

	if exist "%PHP_EXE%" %return%
	
	%dk_call% dk_download "%PHP_DL%"
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DIGITALKNOB_DIR"
	%dk_call% dk_smartExtract "%DKDOWNLOAD_DIR%\%PHP_DL_FILE%" "%PHP%"
	
	if NOT exist "%PHP_EXE%"  %dk_call% dk_error "cannot find PHP_EXE:%PHP_EXE%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	%dk_call% dk_installPhp
%endfunction%