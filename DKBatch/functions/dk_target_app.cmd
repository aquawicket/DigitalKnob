::@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::#####################################################################
::# dk_target_app(RTN:target_app)
::#
::#
:dk_target_app
::setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 0 1 
	
    :: read cache file
	if exist "%DKCACHE_DIR%\cache" (%dk_call% dk_fileToGrid "%DKCACHE_DIR%\cache" words)
	set "_target_app_=%words[0][0]%"
	set "_target_triple_=%words[0][1]%"
	set "_target_type_=%words[0][2]%"
	
	:: echo _target_app_ = %_target_app_%
	:: echo _target_triple_ = %_target_triple_%
	:: echo _target_type_ = %_target_type_%
	
    :: get a list of the directories in DKApps
	%dk_call% dk_validate DKAPPS_DIR "%dk_call% dk_DKAPPS_DIR"
	
	%dk_call% dk_deleteArray dk_getDirectories
    %dk_call% dk_getDirectories "%DKAPPS_DIR%" 
	set "dk_getDirectories=%dk_getDirectories%"
	%dk_call% dk_deleteArray commands
	
    :: rename the list elements to the folder basename and add a matching command
    set /a "n=0"
    :loop1
        if not defined dk_getDirectories[%n%] goto endloop1
        for %%Z in ("!dk_getDirectories[%n%]!") do set "dk_getDirectories[%n%]=%%~nxZ"
        set "commands[%n%]=%dk_call% dk_set target_app !dk_getDirectories[%n%]!"
        set /a n+=1
        goto loop1 
    :endloop1
	:: %dk_call% dk_printVar dk_getDirectories
    :: %dk_call% dk_printVar commands

    :: prepend cache selection if available
    if exist "%DKCACHE_DIR%\cache" if "%_target_app_%" neq "" if "%_target_triple_%" neq "" if "%_target_type_%" neq "" (
        %dk_call% Array::dk_unshift dk_getDirectories "re-run [%_target_app_% - %_target_triple_% - %_target_type_%]"
        %dk_call% Array::dk_unshift commands "call:runCache"
    )
    goto end_runCache
    :runCache
        %dk_call% dk_info "re-running cached dk_getDirectories..."
        %dk_call% dk_set target_app %_target_app_% && %dl_call% dk_set target_triple %_target_triple_% && call dk_set target_type %_target_type_% && %return%
    :end_runCache
    
    ::### Append remaining dk_getDirectories with commands ###
    %dk_call% Array::dk_push dk_getDirectories "Enter Manually"
    %dk_call% Array::dk_push commands "%dk_call% dk_enterManually"
    
    %dk_call% Array::dk_push dk_getDirectories "Clear Screen"
    %dk_call% Array::dk_push commands "%dk_call% dk_clearScreen"
    
    %dk_call% Array::dk_push dk_getDirectories "Reload"
    %dk_call% Array::dk_push commands "%dk_call% dk_reload"
    
    %dk_call% Array::dk_push dk_getDirectories "Go Back"
    %dk_call% Array::dk_push commands "%dk_call% dk_unset UPDATE"
    
    %dk_call% Array::dk_push dk_getDirectories "Exit"
    %dk_call% Array::dk_push commands "%dk_call% dk_exit"

	:: %dk_call% dk_printVar dk_getDirectories
	:: %dk_call% dk_printVar commands
	
    ::### Print the dk_getDirectories list ###
    set /a "n=0"
    :loop2
        if not defined dk_getDirectories[%n%] goto endloop2
        echo %n%: !dk_getDirectories[%n%]!
        set /a n+=1
        goto loop2 
    :endloop2
    
    %dk_call% dk_echo 
    %dk_call% dk_echo "Please select an app to build"
    
    %dk_call% dk_keyboardInput choice
    :: %dk_call% dk_keyboardInputTimeout choice 23 60 
    
    %dk_call% dk_echo "!dk_getDirectories[%choice%]!"
    
    if not defined commands[%choice%] (
        %dk_call% dk_echo "%choice%: invalid selection, please try again"
        %dk_call% dk_unset target_app
        %return%
    )
    
    endlocal & !commands[%choice%]!
    if "%~1" neq "" endlocal & set "%1=%target_app%"
	
    %dk_call% dk_deleteArray dk_getDirectories
    %dk_call% dk_deleteArray commands
    %return%
    
	:: TODO
	:: %dk_call% dk_echo "%choice%: invalid selection, please try again"
	:: %dk_call% dk_unset target_app
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
::setlocal
    %dk_call% dk_debugFunc 0

    %dk_call% dk_target_app target_app
	%dk_call% dk_echo "target_app = %target_app%"
%endfunction%
