::dk_include_guard()

::### BINARY DISTRIBUTIONS (PORTABLE) ###
set "NOTEPADPP_DL_WIN_ARM64=https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.arm64.zip"
set "NOTEPADPP_DL_WIN_X86=https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.zip"
set "NOTEPADPP_DL_WIN_X86_64=https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.x64.zip"

::####################################################################
::# dk_validate_notepadpp()
::#
::#
:dk_validate_notepadpp () {
    call dk_verbose "dk_validate_notepadpp(%*)"
    call dk_get_host_triple
    call dk_debug HOST_ARCH

    if "%HOST_ARCH%"=="arm64" set NOTEPADPP_DL=%NOTEPADPP_DL_WIN_ARM64%
    if "%HOST_ARCH%"=="x86" set NOTEPADPP_DL=%NOTEPADPP_DL_WIN_X86%
    if "%HOST_ARCH%"=="x86_64" set NOTEPADPP_DL=%NOTEPADPP_DL_WIN_X86_64%
    call dk_debug NOTEPADPP_DL
    
    call dk_get_filename %NOTEPADPP_DL% NOTEPADPP_DL_FILE
    call dk_debug NOTEPADPP_DL_FILE

    set NOTEPADPP_FOLDER=%NOTEPADPP_DL_FILE:~0,-4%
	::call dk_debug NOTEPADPP_FOLDER
    call dk_convert_to_c_identifier %NOTEPADPP_FOLDER% NOTEPADPP_FOLDER
	::call dk_debug NOTEPADPP_FOLDER
    call dk_convert_to_lowercase %NOTEPADPP_FOLDER% NOTEPADPP_FOLDER
    call dk_debug NOTEPADPP_FOLDER
    
    call dk_get_dkpaths
    set "NOTEPADPP_EXE=%DKTOOLS_DIR%\%NOTEPADPP_FOLDER%\notepad++.exe"
    ::call dk_debug NOTEPADPP_EXE
        
    if exist "%NOTEPADPP_EXE%" goto:eof
        
    echo.   
    echo "Installing notepad++ . . ."
    call dk_download %NOTEPADPP_DL% "%DKDOWNLOAD_DIR%\%NOTEPADPP_DL_FILE%"
    call dk_extract "%DKDOWNLOAD_DIR%\%NOTEPADPP_DL_FILE%" "%DKTOOLS_DIR%\%NOTEPADPP_FOLDER%"
	   
    if NOT exist "%NOTEPADPP_EXE%" call dk_error "cannot find notepad++.exe"
        
    call dk_check_error
goto:eof