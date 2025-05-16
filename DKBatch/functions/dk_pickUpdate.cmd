@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::#####################################################################
::# dk_pickUpdate(rtn_var:UPDATE)
::#
::#
:dk_pickUpdate UPDATE
::%setlocal%
	%dk_call% dk_debugFunc 0 1
 
    %dk_call% dk_echo
    %dk_call% dk_commandExists "git" && %dk_call% dk_gitCheckRemote

	:: read DKBuilder.cache file
	if exist "%DKCACHE_DIR%/DKBuilder.cache" (%dk_call% dk_fileToGrid "%DKCACHE_DIR%/DKBuilder.cache" words)
	set "Target_App_Cache=%words[0][0]%"
	set "Target_Tuple_Cache=%words[0][1]%"
	set "Target_Type_Cache=%words[0][2]%"
    
    %dk_call% dk_echo
    if exist "%DKCACHE_DIR%/DKBuilder.cache" if "%Target_App_Cache%" neq "" if "%Target_Tuple_Cache%" neq "" if "%Target_Type_Cache%" neq "" echo  0) Repeat cache [%Target_App_Cache% - %Target_Tuple_Cache% - %Target_Type_Cache%]
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
    %dk_call% dk_keyboardInput choice
    ::%dk_call% dk_keyboardInputTimeout 13 60 choice
		
    if "%choice%" equ "0" (
		%dk_call% dk_set Target_App		%Target_App_Cache%
		%dk_call% dk_set Target_Tuple	%Target_Tuple_Cache%
		%dk_call% dk_set Target_Type	%Target_Type_Cache%
	)
    if "%choice%" equ "1"  %dk_call% dk_gitUpdate https://github.com/aquawicket/DigitalKnob.git Development
    if "%choice%" equ "2"  %dk_call% dk_gitCommit
    if "%choice%" equ "3"  %dk_call% dk_downloadDK
    if "%choice%" equ "4"  %dk_call% dk_pushAssets
    if "%choice%" equ "5"  %dk_call% dk_pullAssets
    if "%choice%" equ "6"  %dk_call% dk_resetAll
    if "%choice%" equ "7"  %dk_call% dk_removeAll
    if "%choice%" equ "8"  %dk_call% dk_clearScreen
    if "%choice%" equ "9"  %dk_call% dk_reload
    if "%choice%" equ "10" %dk_call% dk_exit 0
	if "%choice%" equ "11" (set "BUILD_LIST_FILE=%DKBRANCH_DIR%/build_list.txt" && %return%)
      
    ::endlocal & 
	set "UPDATE=1"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
   
    %dk_call% dk_pickUpdate
%endfunction%
