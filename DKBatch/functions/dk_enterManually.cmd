@echo off
call DK

::####################################################################
::# dk_enterManually()
::#
::#
:dk_enterManually () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
    call dk_info "Please type the name of the library, tool or app to build. Then press enter."
    set /p input= 

    set "APP=_%input%_"
  
    ::Search digitalknob for the matching entry containing a DKMAKE.cmake file  
    ::cd %DIGITALKNOB_DIR%
    ::for /f "delims=" %%a in ('dir /b /s /a-d DKMAKE.cmake ^| findstr /E /R "%input%\\DKMAKE.cmake" ') do set "path=%%a"
    ::set "TARGET_PATH=%path:~0,-13%"
    
    if exist "%DKIMPORTS_DIR%\%input%\DKMAKE.cmake" set "TARGET_PATH=%DKIMPORTS_DIR%\%input%"
    if exist "%DKPLUGINS_DIR%\%input%\DKMAKE.cmake" set "TARGET_PATH=%DKPLUGINS_DIR%\%input%"
    if exist "%DKAPPS_DIR%\%input%\DKMAKE.cmake"    set "TARGET_PATH=%DKAPPS_DIR%\%input%"
    ::call dk_printVar TARGET_PATH
    
    call dk_getParentFolder "%TARGET_PATH%" parent
    ::call dk_printVar parent
    
    if "%parent%"=="DKApps" goto:eof
    call dk_makeDirectory "%DKAPPS_DIR%\%APP%"
    
    :: create DKApps/<APP>/DKMAKE.cmake 
    echo dk_depend(%input%)> "%DKAPPS_DIR%\%APP%\DKMAKE.cmake"
    
    :: create DKApps/<APP>/main.cpp
    echo int main(int argc, char** argv) { return 0; } > "%DKAPPS_DIR%\%APP%\main.cpp"
goto:eof




:DKTEST ########################################################################
