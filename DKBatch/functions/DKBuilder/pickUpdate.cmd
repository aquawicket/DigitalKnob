@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::#####################################################################
::# pickUpdate()
::#
::#
:pickUpdate
::%setlocal%
	%dk_call% dk_debugFunc 0 1
 
    %dk_call% dk_echo
    %dk_call% dk_commandExists "git" && %dk_call% dk_gitCheckRemote

	::### Load DKBuilder.cache ###
	%dk_call% dk_validate DKCACHE_DIR "%dk_call% dk_DKCACHE_DIR"
	if exist "%DKCACHE_DIR%/DKBuilder.cache" (
		%dk_call% dk_getFileParams "%DKCACHE_DIR%/DKBuilder.cache"
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
    echo 10) Exit
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	if exist "%DKBRANCH_DIR%/build_list.txt"  echo 11) Run 'build_list.txt'
    
    %dk_call% dk_echo "Choose a selection. Press enter to skip."
    %dk_call% dk_keyboardInput
    ::%dk_call% dk_keyboardInputTimeout 13 60
		
    if "%dk_keyboardInput%" equ "0" (
		%dk_call% dk_set Target_App		%Target_App_Cache%
		%dk_call% dk_set Target_Os		%Target_Os_Cache%
		%dk_call% dk_set Target_Arch	%Target_Arch_Cache%
		%dk_call% dk_set Target_Env		%Target_Env_Cache%
		%dk_call% dk_set Target_Type	%Target_Type_Cache%
	)
    if "%dk_keyboardInput%" equ "1"  %dk_call% dk_gitUpdate https://github.com/aquawicket/DigitalKnob.git Development
    if "%dk_keyboardInput%" equ "2"  %dk_call% dk_gitCommit
    if "%dk_keyboardInput%" equ "3"  %dk_call% dk_downloadDK
    if "%dk_keyboardInput%" equ "4"  %dk_call% dk_pushAssets
    if "%dk_keyboardInput%" equ "5"  %dk_call% dk_pullAssets
    if "%dk_keyboardInput%" equ "6"  %dk_call% dk_resetAll
    if "%dk_keyboardInput%" equ "7"  %dk_call% dk_removeAll
    if "%dk_keyboardInput%" equ "8"  %dk_call% dk_clearScreen
    if "%dk_keyboardInput%" equ "9"  %dk_call% dk_reload
    if "%dk_keyboardInput%" equ "10" %dk_call% dk_exit 0
	if "%dk_keyboardInput%" equ "11" (set "BUILD_LIST_FILE=%DKBRANCH_DIR%/build_list.txt" && %return%)
      
    ::endlocal & (
		set "pickUpdate=1"
	::)
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
   
    %dk_call% pickUpdate
%endfunction%
