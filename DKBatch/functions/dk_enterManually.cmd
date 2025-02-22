@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::####################################################################
::# dk_enterManually()
::#
::#
:dk_enterManually
 ::setlocal
    %dk_call% dk_debugFunc 0

    %dk_call% dk_info "Please type the name of the library, tool or app to build. Then press enter."
    %dk_call% dk_keyboardInput input

    set "target_app=_%input%_"
  
    ::Search digitalknob for the matching entry containing a DKMAKE.cmake file  
    ::%dk_call% dk_cd %DIGITALKNOB_DIR%
    ::for /f "delims=" %%a in ('dir /b /s /a-d DKMAKE.cmake ^| findstr /E /R "%input%\\DKMAKE.cmake" ') do set "path=%%a"
    ::set "TARGET_PATH=%path:~0,-13%"
	%dk_call% dk_validate DKIMPORTS_DIR		"%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate DKCPP_PLUGINS_DIR "%dk_call% dk_DKBRANCH_DIR"
    %dk_call% dk_validate DKCPP_APPS_DIR    "%dk_call% dk_DKBRANCH_DIR"
    if exist "%DKIMPORTS_DIR%\%input%\DKMAKE.cmake" 	(set "TARGET_PATH=%DKIMPORTS_DIR%\%input%")
    if exist "%DKCPP_PLUGINS_DIR%\%input%\DKMAKE.cmake" (set "TARGET_PATH=%DKCPP_PLUGINS_DIR%\%input%")
    if exist "%DKCPP_APPS_DIR%\%input%\DKMAKE.cmake"    (set "TARGET_PATH=%DKCPP_APPS_DIR%\%input%")
    %dk_call% dk_printVar TARGET_PATH
    
	%dk_call% dk_getParentFolder "%TARGET_PATH%" parent
    %dk_call% dk_printVar parent
    
    if "%parent%"=="apps" %return%
    %dk_call% dk_makeDirectory "%DKCPP_APPS_DIR%\%target_app%"
    
    :: create apps/<target_app>/DKMAKE.cmake
	echo dk_depend(%input%) > "%DKCPP_APPS_DIR%\%target_app%\DKMAKE.cmake"
    ::%dk_call% dk_fileWrite "%DKCPP_APPS_DIR%\%target_app%\DKMAKE.cmake" dk_depend(%input%)
    
    :: create apps/<target_app>/main.cpp
    echo int main(int argc, char** argv) { return 0; } > "%DKCPP_APPS_DIR%\%target_app%\main.cpp"
	::%dk_call% dk_fileWrite "%DKCPP_APPS_DIR%\%target_app%\main.cpp" "int main(int argc, char** argv) { return 0; }"
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_enterManually
%endfunction%
