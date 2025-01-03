@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*


::##################################################################################
::# dk_move(from, to)
::#
::# Move/Rename a file or directory to another location/name
::#
::# @from       - The source path to move or rename
::# @to         - The destination path to move or rename to
::# OVERWRITE   - if any of the parameters equals OVERWRITE, overwritting existing file or folder is enabled
::#
:dk_move
 setlocal
    %dk_call% dk_debugFunc 2 3
    
    %dk_call% dk_replaceAll "%~1" "/" "\" _from_
    %dk_call% dk_replaceAll "%~2" "/" "\" _to_
    if "%~3" equ "OVERWRITE" ( set "OVERWRITE=1" ) else ( set "OVERWRITE=0" )
    
    %dk_call% dk_info "Moving %_from_% to %_to_%"
    
    if not exist "%_from_%" ( %dk_call% dk_error "dk_move: %_from_% not found" )
    
    if exist "%_to_%" (
        if "%OVERWRITE%" neq "1" (
            %dk_call% dk_error "dk_rename Cannot move file. Destiantion exists and OVERWRITE is not set"
        ) 
        %dk_call% dk_delete %_to_%
    )
    
    :: the base directory of the %to% path must exist.    
    %dk_call% dk_dirname "%_to_%" _parent_dir_
    %dk_call% dk_printVar _parent_dir_
    %dk_call% dk_makeDirectory "%_parent_dir_%"
    
    move /Y "%_from_%" "%_to_%"
    
    ::TODO
    ::[ ? = "success" ]
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
   
    %dk_call% dk_validate DIGITALKNOB_DIR "%dk_call% dk_DIGITALKNOB_DIR"    
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
    %dk_call% dk_fileWrite %DKDOWNLOAD_DIR%/moveMe.file "dk_move test"
    %dk_call% dk_move %DKDOWNLOAD_DIR%/moveMe.file %DIGITALKNOB_DIR%/iWasMoved.txt OVERWRITE
    
    %dk_call% dk_fileWrite moveMe.file "dk_move test"
    %dk_call% dk_move moveMe.file iWasMoved.txt OVERWRITE
    
    %dk_call% dk_makeDirectory %DKDOWNLOAD_DIR%/moveMe
%endfunction%

    %dk_call% dk_move %DKDOWNLOAD_DIR%/moveMe %DIGITALKNOB_DIR%/iWasMoved OVERWRITE
    
    %dk_call% dk_makeDirectory moveMe
    %dk_call% dk_move moveMe iWasMoved OVERWRITE
%endfunction%
