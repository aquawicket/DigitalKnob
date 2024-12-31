@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_compileCpp(filepath)
::#
::#
:dk_compileCpp
    %dk_call% dk_debugFunc 1 2
 setlocal
 
    set "filepath=%~1"
    set "appname=%~2"
    if not defined appname set "appname=temp"
    
    %dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
    %dk_call% dk_validate GXX_EXE "%dk_call% %DKIMPORTS_DIR%\gcc\dk_install.cmd"
    
    ::gcc -o [executable_name] [source_file].c
    %GXX_EXE% -o %appname% -static "%filepath%"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    %dk_call% dk_debugFunc 0
 setlocal
 
    set "MSYSTEM=CLANG64"
    %dk_call% dk_validate DKAPPS_DIR "%dk_call% dk_DKAPPS_DIR"
    %dk_call% dk_compile "%DKAPPS_DIR%\HelloWorld\main.cpp"
%endfunction%
