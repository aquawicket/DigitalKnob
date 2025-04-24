<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_hexToAscii(<hex_string> rtn_var)
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_hexToAscii(<hex>, <output>:optional)
>>>>>>> Development
::#
::#    reference: https://www.ascii-code.com
::#
:dk_hexToAscii
<<<<<<< HEAD
    call dk_debugFunc 2
 setlocal
 
    set "hex=%~1"
=======
setlocal
	%dk_call% dk_debugFunc 1 2

    set "hex=%~1"
	%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
>>>>>>> Development
    %dk_call% dk_fileWrite %DKCACHE_DIR%\hex.tmp %hex:~-2%
    
    ::for /f %%b in ('forfiles /c "%ComSpec% /c echo 0x1b"') do set "ESC=%%b"
    
<<<<<<< HEAD
    %dk_call% certutil -decodehex %DKCACHE_DIR%\hex.tmp %DKCACHE_DIR%\ascii.tmp >nul
    set "ascii="
    set /p ascii=<%DKCACHE_DIR%\ascii.tmp
    ( del %DKCACHE_DIR%\hex.tmp & del %DKCACHE_DIR%\ascii.tmp )>nul
    
    endlocal & set "%2=%ascii%"
=======
	set "CERTUTIL_EXE=%WINDIR%\System32\certutil.exe"
	::%dk_call% dk_validate CERTUTIL_EXE "%dk_call% d_CERTUTIL_EXE"
    %dk_call% %CERTUTIL_EXE% -decodehex %DKCACHE_DIR%\hex.tmp %DKCACHE_DIR%\ascii.tmp >nul
    set "dk_hexToAscii="
    set /p dk_hexToAscii=<%DKCACHE_DIR%\ascii.tmp
    ( del %DKCACHE_DIR%\hex.tmp & del %DKCACHE_DIR%\ascii.tmp )>nul
    
    endlocal & (
		set "dk_hexToAscii=%dk_hexToAscii%"
		if "%~2" neq "" (set "%~2=%dk_hexToAscii%")
	)
>>>>>>> Development
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_hexToAscii 0x41 ascii
    %dk_call% dk_echo "ascii = %ascii%"
=======
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_hexToAscii 0x41
    %dk_call% dk_echo "dk_hexToAscii = %dk_hexToAscii%"
>>>>>>> Development
%endfunction%
