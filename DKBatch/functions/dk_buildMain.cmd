@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_buildMain()
::#
::#
:dk_buildMain
    call dk_debugFunc 0
 setlocal

	%dk_call% dk_assertPath DKDESKTOP_DIR
	%dk_call% dk_assertPath DIGITALKNOB_DIR
	%dk_call% dk_createShortcut "%DKDESKTOP_DIR%\digitalknob.lnk" "%DIGITALKNOB_DIR%" OVERWRITE
	%dk_call% dk_pinToQuickAccess "%DIGITALKNOB_DIR%"

	%dk_call% dk_assertPath DKSCRIPT_DIR
	%dk_call% dk_assertPath DKBRANCH_DIR
	if "%DKSCRIPT_DIR%" neq "%DKBRANCH_DIR%" (
        %dk_call% dk_warning "Not running from the DKBRANCH_DIR directory. Any changes will not be saved by git!"
        %dk_call% dk_warning "DKSCRIPT_DIR = %DKSCRIPT_DIR%"
        %dk_call% dk_warning "DKBRANCH_DIR = %DKBRANCH_DIR%"
    )
    
    %dk_call% dk_unset UPDATE
    %dk_call% dk_unset APP
    %dk_call% dk_unset triple
    %dk_call% dk_unset TYPE
        
    :while_loop   
        ::%dk_call% dk_echo "33 UPDATE-%UPDATE% - APP-%APP% - triple-%triple% - TYPE-%TYPE%"
        
        if not defined UPDATE     %dk_call% dk_pickUpdate UPDATE    && goto:while_loop
        if not defined APP        %dk_call% dk_pickApp APP          && goto:while_loop
        if not defined triple     %dk_call% dk_pickOs triple        && goto:while_loop
        if not defined TYPE       %dk_call% dk_pickType TYPE        && goto:while_loop
		
        %dk_call% dk_createCache
        %dk_call% dk_generate
        %dk_call% dk_buildApp

        %dk_call% dk_unset UPDATE
        %dk_call% dk_unset APP
        %dk_call% dk_unset triple
        %dk_call% dk_unset TYPE
    goto while_loop
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_buildMain
%endfunction%
