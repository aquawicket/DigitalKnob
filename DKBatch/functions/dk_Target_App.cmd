@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::#####################################################################
::# dk_Target_App(RTN:Target_App)
::#
::#
:dk_Target_App
::%setlocal%
	%dk_call% dk_debugFunc 0 1 
	
    ::### read DKBuilder.cache file ###
	if exist "%DKCACHE_DIR%/DKBuilder.cache" (
		%dk_call% dk_getFileParams "%DKCACHE_DIR%/DKBuilder.cache"
	)
	
    ::### get a list of the directories in DKCpp/apps ###
	%dk_call% dk_validate DKCPP_APPS_DIR "%dk_call% dk_DKBRANCH_DIR"
	
	%dk_call% dk_deleteArray dk_getDirectories
    %dk_call% dk_getDirectories "%DKCPP_APPS_DIR%" 
	set "dk_getDirectories=%dk_getDirectories%"
	%dk_call% dk_deleteArray commands
	
    ::### rename the list elements to the folder basename and add a matching command ###
    set /a "n=0"
    :loop1
        if not defined dk_getDirectories[%n%] goto endloop1
        for %%Z in ("!dk_getDirectories[%n%]!") do set "dk_getDirectories[%n%]=%%~nxZ"
        set "commands[%n%]=%dk_call% dk_set Target_App !dk_getDirectories[%n%]!"
        set /a n+=1
        goto loop1 
    :endloop1

    ::### prepend cache selection if available ###
    if defined Target_App_Cache if defined Target_Os_Cache if defined Target_Arch_Cache if defined Target_Env_Cache if defined Target_Type_Cache (
        %dk_call% Array/dk_unshift dk_getDirectories "re-run '%Target_App_Cache%_%Target_Os_Cache%_%Target_Arch_Cache%_%Target_Env_Cache%_%Target_Type_Cache%'"
        %dk_call% Array/dk_unshift commands "call:runCache"
    )
    goto end_runCache
    :runCache
        %dk_call% dk_info "re-running cached dk_getDirectories..."
        %dk_call% dk_set Target_App		%Target_App_Cache% 
		%dk_call% dk_set Target_Os		%Target_Os_Cache%
		%dk_call% dk_set Target_Arch	%Target_Arch_Cache%
		%dk_call% dk_set Target_Env		%Target_Env_Cache%
		%dk_call% dk_set Target_Type	%Target_Type_Cache% 
		%return%
    :end_runCache
    
    ::### Append remaining dk_getDirectories with commands ###
    %dk_call% Array/dk_push dk_getDirectories "Enter Manually"
    %dk_call% Array/dk_push commands "%dk_call% dk_enterManually"
    
    %dk_call% Array/dk_push dk_getDirectories "Clear Screen"
    %dk_call% Array/dk_push commands "%dk_call% dk_clearScreen"
    
    %dk_call% Array/dk_push dk_getDirectories "Reload"
    %dk_call% Array/dk_push commands "%dk_call% dk_reload"
    
    %dk_call% Array/dk_push dk_getDirectories "Go Back"
    %dk_call% Array/dk_push commands "%dk_call% dk_unset dk_pickUpdate"
    
    %dk_call% Array/dk_push dk_getDirectories "Exit"
    %dk_call% Array/dk_push commands "%dk_call% dk_exit"

    ::### Print the dk_getDirectories list ###
    set /a "n=0"
    :loop2
        if not defined dk_getDirectories[%n%] goto endloop2
        echo %n%: !dk_getDirectories[%n%]!
        set /a n+=1
        goto loop2 
    :endloop2
    
    %dk_call% dk_echo 
    %dk_call% dk_echo "Please select a Target_App to build"
    
    %dk_call% dk_keyboardInput
    :: %dk_call% dk_keyboardInputTimeout 23 60
    
    %dk_call% dk_echo "!dk_getDirectories[%dk_keyboardInput%]!"
    
    if not defined commands[%dk_keyboardInput%] (
        %dk_call% dk_echo "%dk_keyboardInput%: invalid selection, please try again"
        %dk_call% dk_unset Target_App
        %return%
    )
    
	endlocal & (
		!commands[%dk_keyboardInput%]!
	)
	endlocal & (
		set "Target_App=%Target_App%"
	)
	
    %dk_call% dk_deleteArray dk_getDirectories
    %dk_call% dk_deleteArray commands
    %return%
    
	:: TODO
	:: %dk_call% dk_echo "%dk_keyboardInput%: invalid selection, please try again"
	:: %dk_call% dk_unset Target_App
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
::%setlocal%
    %dk_call% dk_debugFunc 0

    %dk_call% dk_Target_App
	%dk_call% dk_printVar Target_App
%endfunction%
