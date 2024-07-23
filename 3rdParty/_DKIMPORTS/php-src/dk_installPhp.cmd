@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd


::####################################################################
::# dk_installPhp
::#
:dk_installPhp
    call dk_debugFunc
    if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	call dk_validate HOST_OS "call dk_getHostTriple"
	
	::if "%HOST_OS%_%HOST_ARCH%"=="win_x86" call dk_import https://windows.php.net/downloads/releases/php-8.0.30-Win32-vs16-x86.zip
	
	if "%HOST_OS%_%HOST_ARCH%"=="win_x86"    call dk_set PHP_DL "https://windows.php.net/downloads/releases/php-8.0.30-Win32-vs16-x86.zip"
	if "%HOST_OS%_%HOST_ARCH%"=="win_x86_64" call dk_set PHP_DL "https://windows.php.net/downloads/releases/php-8.0.30-Win32-vs16-x64.zip"
	if not defined PHP_DL call dk_error "PHP_DL is invalid"
	
	
	call dk_basename %PHP_DL% PHP_DL_FILE
    call dk_removeExtension %PHP_DL_FILE% PHP_NAME
    call dk_convertToCIdentifier %PHP_NAME% PHP_FOLDER
    call dk_toLower %PHP_FOLDER% PHP_FOLDER
	
	if not defined DKTOOLS_DIR call dk_setDKTOOLS_DIR
	call dk_set PHP "%DKTOOLS_DIR%\%PHP_FOLDER%"
	call dk_set PHP_EXE "%PHP%\php.exe"

	if exist "%PHP_EXE%" goto:eof
	
	call dk_download "%PHP_DL%"
	call dk_smartExtract "%DKDOWNLOAD_DIR%\%PHP_DL_FILE%" "%PHP%"
	
	if NOT exist "%PHP_EXE%"  call dk_error "cannot find PHP_EXE:%PHP_EXE%"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_installPhp
goto:eof