rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
    setlocal enableDelayedExpansion
    if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
    if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
    if NOT EXIST "!DK.cmd!" (
        start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
    call "!DK.cmd:/=\!" "%%~0" %%*
    exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ##########################################
:DKINSTALL

%setlocal%
	if "%~1" neq ":DKINSTALL" (
        echo :DKINSTALL %*
		%dk_call% dk_fatal "DKCmake/DKINSTALL.cmd does NOT take arguments"
		exit /b -1
	)

    ::###### Install DKCmake ######
	echo Installing DKCmake . . .
	
	rem ###### Install DKCmake ######
	%dk_call% dk_validate cmake.exe     	%dk_call% dk_depend cmake.exe
REM	%dk_call% dk_validate cmake-gui.exe		%dk_call% dk_findFile cmake-gui.exe "%cmake%"
rem	if NOT DEFINED cmake-gui.exe            (set "cmake-gui.exe=%cmake%/bin/cmake-gui.exe")
	%dk_call% dk_validate cygpath_exe		%dk_call% dk_depend cygpath_exe
	
	rem %dk_call% dk_validate DKCMAKE_FUNCTIONS_DIR_ 	%dk_call% dk_DKBRANCH_DIR

    rem ### cmake.exe from cmd 
    	rem ########## Method 2: Evaluate all variables in regestry code ##########
	rem ## This method does not call back to this file. It will call cmake with the chosen file directly. This means that any variables that
	rem ## need to be passed to cmake will have to be present within the regisry code. 
rem ftype DKCmake="%ComSpec:/=\%" /V:ON /K ^
rem     set "DKCMAKE_FUNCTIONS_DIR_=%DKCMAKE_FUNCTIONS_DIR_%" ^&^
rem     set "DKSCRIPT_PATH=%%1" ^& call %cmake.exe% -P "%%1" ^
rem     ^&^& echo CMAKE_CMDLINE successful ^
rem     ^|^| echo CMAKE_CMDLINE failed
	ftype DKCmake="%ComSpec:/=\%" /V:ON /k FOR /F "usebackq delims=" %%%%a IN (`"%cygpath_exe:/=\%" -m '%%1'`^) DO "%cmake.exe:/=\%" -P  "%%%%a" ^&^& echo RETURN:true:^^!errorlevel^^! ^|^| echo RETURN:false:^^!errorlevel^^!
	%dk_call% dk_registrySetKey "HKCR/DKCmake/DefaultIcon" "" "REG_SZ" "%cmake-gui.exe:/=\%"
	
	
	rem ### cmake.exe from wsl 
	rem %dk_call% dk_validate wsl.exe     			%dk_call% dk_depend wsl.exe
	rem set "DKSCRIPT_PATH_WSL=%DKSCRIPT_PATH:C:=/mnt/c%"
rem	ftype DKCmake="%ComSpec:/=\%" /V:ON /k FOR /F "usebackq delims=" %%%%a IN (`"%wslpath:/=\%" '%%1'`^) DO start "" !wsl.exe! /bin/bash -c "%%%%a" ^&^& echo RETURN:true:^^!errorlevel^^! ^|^| echo RETURN:false:^^!errorlevel^^!
rem	%dk_call% dk_registrySetKey "HKCR/DKCmake/DefaultIcon" "" "REG_SZ" "%cmake-gui.exe:/=\%"
	
	assoc .cmake=DKCmake
	
	%dk_call% dk_success "DKCmake install complete"
%endfunction%
