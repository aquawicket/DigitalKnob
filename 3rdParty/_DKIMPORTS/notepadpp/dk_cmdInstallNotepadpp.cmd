@echo off
call ../../../DKBatch/functions/DK.cmd
call dk_includeGuard

::### BINARY DISTRIBUTIONS (PORTABLE) ###
set "NOTEPADPP_DL_WIN_ARM64=https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.arm64.zip"
set "NOTEPADPP_DL_WIN_X86=https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.zip"
set "NOTEPADPP_DL_WIN_X86_64=https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.5/npp.8.6.5.portable.x64.zip"

::####################################################################
::# dk_validateNotepadpp()
::#
::#
:dk_validateNotepadpp () {
    call dk_debugFunc
    
	if "%HOST_ARCH%"==""       call dk_getHostTriple
    if "%HOST_ARCH%"=="arm64"  set NOTEPADPP_DL=%NOTEPADPP_DL_WIN_ARM64%
    if "%HOST_ARCH%"=="x86"    set NOTEPADPP_DL=%NOTEPADPP_DL_WIN_X86%
    if "%HOST_ARCH%"=="x86_64" set NOTEPADPP_DL=%NOTEPADPP_DL_WIN_X86_64%
    call dk_debug NOTEPADPP_DL
    
    call dk_getFilename %NOTEPADPP_DL% NOTEPADPP_DL_FILE
    call dk_debug NOTEPADPP_DL_FILE

    set NOTEPADPP_FOLDER=%NOTEPADPP_DL_FILE:~0,-4%
	::call dk_debug NOTEPADPP_FOLDER
	
    call dk_convertToCIdentifier %NOTEPADPP_FOLDER% NOTEPADPP_FOLDER
	::call dk_debug NOTEPADPP_FOLDER
	
    call dk_convertToLowercase %NOTEPADPP_FOLDER% NOTEPADPP_FOLDER
    call dk_debug NOTEPADPP_FOLDER
    
    if "%DKTOOLS_DIR%"==""   call dk_getDKPaths
    set "NOTEPADPP_EXE=%DKTOOLS_DIR%\%NOTEPADPP_FOLDER%\notepad++.exe"
    call dk_debug NOTEPADPP_EXE
        
    if exist "%NOTEPADPP_EXE%" goto:eof
        
    echo.   
    echo "Installing notepad++ . . ."
    call dk_download %NOTEPADPP_DL% "%DKDOWNLOAD_DIR%\%NOTEPADPP_DL_FILE%"
    call dk_extract "%DKDOWNLOAD_DIR%\%NOTEPADPP_DL_FILE%" "%DKTOOLS_DIR%\%NOTEPADPP_FOLDER%"
	   
    if NOT exist "%NOTEPADPP_EXE%" call dk_error "cannot find notepad++.exe"
        
    call dk_checkError
goto:eof