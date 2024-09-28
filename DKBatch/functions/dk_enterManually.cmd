@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_enterManually()
::#
::#
:dk_enterManually
    call dk_debugFunc 0
 ::setlocal
 
    %dk_call% dk_info "Please type the name of the library, tool or app to build. Then press enter."
    %dk_call% dk_keyboardInput input

    set "APP=%input%"
  
    ::Search digitalknob for the matching entry containing a DKMAKE.cmake file  
    ::cd %DIGITALKNOB_DIR%
    ::for /f "delims=" %%a in ('dir /b /s /a-d DKMAKE.cmake ^| findstr /E /R "%input%\\DKMAKE.cmake" ') do set "path=%%a"
    ::set "TARGET_PATH=%path:~0,-13%"
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_validate DKPLUGINS_DIR "%dk_call% dk_DKBRANCH_DIR"
    %dk_call% dk_validate DKAPPS_DIR    "%dk_call% dk_DKBRANCH_DIR"
    if exist "%DKIMPORTS_DIR%\%input%\DKMAKE.cmake" set "TARGET_PATH=%DKIMPORTS_DIR%\%input%"
    if exist "%DKPLUGINS_DIR%\%input%\DKMAKE.cmake" set "TARGET_PATH=%DKPLUGINS_DIR%\%input%"
    if exist "%DKAPPS_DIR%\%input%\DKMAKE.cmake"    set "TARGET_PATH=%DKAPPS_DIR%\%input%"
    %dk_call% dk_printVar TARGET_PATH
    
    
	%dk_call% dk_getParentFolder "%TARGET_PATH%" parent
    %dk_call% dk_printVar parent
    
    if "%parent%"=="DKApps" %return%
    %dk_call% dk_makeDirectory "%DKAPPS_DIR%\%APP%"
    
    :: create DKApps/<APP>/DKMAKE.cmake
	echo dk_depend(%input%) > "%DKAPPS_DIR%\%APP%\DKMAKE.cmake"
    ::%dk_call% dk_fileWrite "%DKAPPS_DIR%\%APP%\DKMAKE.cmake" dk_depend(%input%)
    
    :: create DKApps/<APP>/main.cpp
    echo int main(int argc, char** argv) { return 0; } > "%DKAPPS_DIR%\%APP%\main.cpp"
	::%dk_call% dk_fileWrite "%DKAPPS_DIR%\%APP%\main.cpp" "int main(int argc, char** argv) { return 0; }"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_enterManually
%endfunction%
