@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::##################################################################################
::# dk_copy(from, to)
::#
::# copy a file or directory to another location
::#
::# @from       - The source path to copy
::# @to         - The destination path to copy to
::# OVERWRITE   - if any of the parameters equals OVERWRITE, overwritting existing file or folder is enabled
::#
:dk_copy
    call dk_debugFunc 2 3
 setlocal
 
    %dk_call% dk_replaceAll "%~1" "/" "\" _from_
    %dk_call% dk_replaceAll "%~2" "/" "\" _to_
    if "%~3" equ "OVERWRITE" ( set "OVERWRITE=1" ) else ( set "OVERWRITE=0" )
    
    %dk_call% dk_info "Copying %_from_% to %_to_%"
    
    if not exist "%_from_%" ( %dk_call% dk_error "dk_copy: %_from_% not found" )
    
    if exist "%_to_%" (
        if "%OVERWRITE%" neq "1" (
            %dk_call% dk_error "dk_copy Cannot copy file. Destiantion exists and OVERWRITE is not set"
        ) 
        %dk_call% dk_delete %_to_%
    )
    
    :: the base directory of the %to% path must exist.    
    %dk_call% dk_dirname "%_to_%" _parent_dir_
    %dk_call% dk_makeDirectory "%_parent_dir_%"
    
    ::copy "%_from_%" "%_to_%"
    if exist "%_from_%\*" (
        echo D|xcopy "%_from_%" "%_to_%" /S /E /H /Y
    ) else (
        echo F|xcopy "%_from_%" "%_to_%" /H /Y
    )
    ::TODO
    ::[ ? = "success" ]
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_validate DKTEMP_DIR "%dk_call% dk_DKTEMP_DIR"
    
    %dk_call% dk_fileWrite %DKTEMP_DIR%\copyMe.file "dk_copy test"
    %dk_call% dk_copy %DKTEMP_DIR%\copyMe.file %DKTEMP_DIR%\iWasCopied.txt OVERWRITE
    
    
    %dk_call% dk_makeDirectory %DKTEMP_DIR%\copyMe
    %dk_call% dk_copy %DKTEMP_DIR%\copyMe %DKTEMP_DIR%\iWasCopied OVERWRITE
%endfunction%
