<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_compileCpp(filepath)
::#
::#
:dk_compileCpp
    call dk_debugFunc 1 2
 setlocal
 
    set "filepath=%~1"
    set "appname=%~2"
    if not defined appname set "appname=temp"
    
    %dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKBRANCH_DIR"
    %dk_call% dk_validate GXX_EXE "call %DKIMPORTS_DIR%\gcc\dk_installGcc.cmd"
    
    ::gcc -o [executable_name] [source_file].c
    %GXX_EXE% -o %appname% -static "%filepath%"
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# dk_compileCpp(<filepath>, optional:<appname>)
::#
::#
:dk_compileCpp
setlocal
	%dk_call% dk_debugFunc 1 2
 
    set "filepath=%~1"
	
    set "appname=%~2"
    if not defined appname (set "appname=temp")
    
    %dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
    %dk_call% dk_validate GXX_EXE "%dk_call% %DKIMPORTS_DIR%\gcc\DKINSTALL.cmd"
    
    ::gcc -o [executable_name] [source_file].c
    %GXX_EXE% -o %appname% -static "%filepath:/=\%"
>>>>>>> Development
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
    set "MSYSTEM=CLANG64"
    %dk_call% dk_validate DKAPPS_DIR "%dk_call% dk_DKBRANCH_DIR"
    %dk_call% dk_compile "%DKAPPS_DIR%\HelloWorld\main.cpp"
=======
setlocal
	%dk_call% dk_debugFunc 0

    set "MSYSTEM=CLANG64"
    %dk_call% dk_validate DKCPP_APPS_DIR "%dk_call% dk_DKBRANCH_DIR"
    %dk_call% dk_compileCpp "%DKCPP_APPS_DIR%/HelloWorld/main.cpp"
>>>>>>> Development
%endfunction%
