@rem shebang
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


rem #####################################################################
rem # pickUpdate()
rem #
rem #
:pickUpdate
rem %setlocal%

    %dk_call% dk_echo
    rem %dk_call% dk_commandExists "git" && %dk_call% dk_gitCheckRemote

	rem ### Load DKBuilder.cache ###
	%dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
	set "DKBuilder_cache=%DKCACHE_DIR%/DKBuilder.cache"
	if EXIST "%DKBuilder_cache%" (
		%dk_call% dk_fileVariables "%DKBuilder_cache%"
	)
	
    %dk_call% dk_echo
	if defined Target_App_Cache if defined Target_Os_Cache if defined Target_Arch_Cache if defined Target_Env_Cache if defined Target_Type_Cache (
		echo  0^) Repeat cache '%Target_App_Cache%_%Target_Os_Cache%_%Target_Arch_Cache%_%Target_Env_Cache%_%Target_Type_Cache%'
	)
    echo  1) Git Update
    echo  2) Git Commit
    echo  3) Download DigitalKnob
    echo  4) Push assets
    echo  5) Pull assets
    echo  6) Reset All
    echo  7) Remove All
    echo  8) Clear Screen
    echo  9) Reload
	echo 10) Console
    echo 11) Exit
	%dk_call% dk_validate DKBRANCH_DIR %dk_call% dk_DKBRANCH_DIR
	if EXIST "%DKBRANCH_DIR%/build_list.txt" echo 12) Run 'build_list.txt'
	if EXIST "%DKBRANCH_DIR%/build_list.txt" echo 13) Run 'build_list.txt resume'

   
    %dk_call% dk_echo "Choose a selection. Press enter to skip."
    %dk_call% dk_keyboardInput
    rem %dk_call% dk_keyboardInputTimeout 13 60
		
    if "%dk_keyboardInput%" equ "0" (
		%dk_call% dk_set Target_App		%Target_App_Cache%
		%dk_call% dk_set Target_Os		%Target_Os_Cache%
		%dk_call% dk_set Target_Arch	%Target_Arch_Cache%
		%dk_call% dk_set Target_Env		%Target_Env_Cache%
		%dk_call% dk_set Target_Type	%Target_Type_Cache%
	)
    if "%dk_keyboardInput%" equ "1"  %dk_call% dk_gitUpdate
    if "%dk_keyboardInput%" equ "2"  %dk_call% dk_gitCommit
    if "%dk_keyboardInput%" equ "3"  %dk_call% dk_downloadDK
    if "%dk_keyboardInput%" equ "4"  %dk_call% dk_pushAssets
    if "%dk_keyboardInput%" equ "5"  %dk_call% dk_pullAssets
    if "%dk_keyboardInput%" equ "6"  %dk_call% dk_resetAll
    if "%dk_keyboardInput%" equ "7"  %dk_call% dk_removeAll
    if "%dk_keyboardInput%" equ "8"  %dk_call% dk_clearScreen
    if "%dk_keyboardInput%" equ "9"  %dk_call% dk_reload
	if "%dk_keyboardInput%" equ "10" %dk_call% dk_console
    if "%dk_keyboardInput%" equ "11" %dk_call% dk_exit 0
	if "%dk_keyboardInput%" equ "12" (set "BUILD_LIST_FILE=%DKBRANCH_DIR%/build_list.txt" && %return%)
	if "%dk_keyboardInput%" equ "13" (set "BUILD_LIST_FILE=%DKBRANCH_DIR%/build_list.txt" && set "RESUME=1" && %return%)
     
    rem endlocal & (
		set "pickUpdate=1"
	rem )
%endfunction%





rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
  
    %dk_call% DKBuilder/pickUpdate
%endfunction%
