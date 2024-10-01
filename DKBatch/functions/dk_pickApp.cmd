::@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::#####################################################################
::# dk_pickApp(rtn_var:APP)
::#
::#
:dk_pickApp APP
    call dk_debugFunc 0 1
 ::setlocal 
    
    %dk_call% dk_setTitle DigitalKnob - %APP% %triple% %TYPE%
    
    %dk_call% dk_readCache _APP_ _triple_ _TYPE_
	
    :: get a list of the directories in DKApps
	%dk_call% dk_validate DKAPPS_DIR "%dk_call% dk_DKBRANCH_DIR"
    %dk_call% dk_getDirectories "%DKAPPS_DIR%" options
  
    :: rename the list elements to the folder basename and add a matching command
    set /a "n=0"
    :loop1
        if not defined options[%n%] goto:endloop1
        ::if "!DE!" neq "" for %%Z in ("%%%options%[%n%]%%") do set "options[%n%]=%%~nxZ"
        if "!DE!" equ "" for %%Z in ("!options[%n%]!") do set "options[%n%]=%%~nxZ"
        set "commands[%n%]=%dk_call% dk_set APP !options[%n%]!"
        set /a n+=1
        goto:loop1 
    :endloop1
    ::%dk_call% dk_printVar commands

    :: prepend cache selection if available
    if exist "%DKBRANCH_DIR%\cache" if "%_APP_%" neq "" if "%_triple_%" neq "" if "%_TYPE_%" neq "" (
        %dk_call% dk_arrayUnshift options "re-run [%_APP_% - %_triple_% - %_TYPE_%]"
        %dk_call% dk_arrayUnshift commands "call:runCache"
    )
    goto:end_runCache
    :runCache
        %dk_call% dk_info "re-running cached options..."
        %dk_call% dk_set APP %_APP_% & call dk_set triple %_triple_% & call dk_set TYPE %_TYPE_% & %return%
    :end_runCache
    
    :: append remaining options with commands
    %dk_call% dk_arrayPush options "Enter Manually"
    %dk_call% dk_arrayPush commands "%dk_call% dk_enterManually"
    
    %dk_call% dk_arrayPush options "Clear Screen"
    %dk_call% dk_arrayPush commands "%dk_call% dk_clearScreen"
    
    %dk_call% dk_arrayPush options "Reload"
    %dk_call% dk_arrayPush commands "%dk_call% dk_reload"
    
    %dk_call% dk_arrayPush options "Go Back"
    %dk_call% dk_arrayPush commands "%dk_call% dk_unset UPDATE"
    
    %dk_call% dk_arrayPush options "Exit"
    %dk_call% dk_arrayPush commands "%dk_call% dk_exit"

	::%dk_call% dk_printVar options
	::%dk_call% dk_printVar commands
	
    :: Print the options list
    set /a "n=0"
    :loop2
        if not defined options[%n%] goto:endloop2
        echo %n%: !options[%n%]!
        set /a n+=1
        goto:loop2 
    :endloop2
    
    %dk_call% dk_echo 
    %dk_call% dk_echo "Please select an app to build"
    
    %dk_call% dk_keyboardInput choice
    ::%dk_call% dk_keyboardInputTimeout choice 23 60 
    
    %dk_call% dk_echo "!options[%choice%]!"
    
    if not defined commands[%choice%] (
        %dk_call% dk_echo "%choice%: invalid selection, please try again"
        %dk_call% dk_unset APP
        %return%
    )
    
    if "!DE!" neq "" %dk_call% dk_error "delayed expansion is required"
    
    endlocal & !commands[%choice%]!
    if "%~1" neq "" endlocal & set "%1=%APP%"
    %dk_call% dk_deleteArray options
    %dk_call% dk_deleteArray commands
    %return%
    
	:: TODO
	:: %dk_call% dk_echo "%choice%: invalid selection, please try again"
	:: %dk_call% dk_unset APP
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
:: setlocal
    call dk_debugFunc 0

    %dk_call% dk_pickApp APP
	%dk_call% dk_echo "APP = %APP%"
%endfunction%
