@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_hexToAscii(<hex_string> rtn_var)
::#
::#    reference: https://www.ascii-code.com
::#
:dk_hexToAscii
    %dk_call% dk_debugFunc 2
 setlocal
 
    set "hex=%~1"
    %dk_call% dk_fileWrite %DKCACHE_DIR%\hex.tmp %hex:~-2%
    
    ::for /f %%b in ('forfiles /c "%ComSpec% /c echo 0x1b"') do set "ESC=%%b"
    
    %dk_call% certutil -decodehex %DKCACHE_DIR%\hex.tmp %DKCACHE_DIR%\ascii.tmp >nul
    set "ascii="
    set /p ascii=<%DKCACHE_DIR%\ascii.tmp
    ( del %DKCACHE_DIR%\hex.tmp & del %DKCACHE_DIR%\ascii.tmp )>nul
    
    endlocal & set "%2=%ascii%"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    %dk_call% dk_debugFunc 0
 setlocal
 
    %dk_call% dk_hexToAscii 0x41 ascii
    %dk_call% dk_echo "ascii = %ascii%"
%endfunction%
