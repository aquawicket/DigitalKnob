@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_textFormat(OUTPUT. column1, column2, column3, column4)
::#
::#   reference: https://stackoverflow.com/a/19588505
::#  
::#
:dk_textFormat
%setlocal%
    %dk_call% dk_debugFunc 4 99

    set "spaces=                                        "
    set "col1=%~2%spaces%"
    set col1=%col1:~0,15%
   
    set "col2=%~3%spaces%"
    set col2=%col2:~0,30%
   
    set "col3=%~4%spaces%"
    set col3=%col3:~0,30%
   
    set "col4=%~5%spaces%"
    set col4=%col4:~0,100%
   
    ::%dk_call% dk_set output "%col1% %col2% %col3% %col4%"
    set "_textFormat_=%col1% %col2% %col3% %col4%"
    endlocal & set "%1=%_textFormat_%"
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

    %dk_call% dk_textFormat output "column1[15]" "column2[30]" "column3[20]" "column4[100]"
    %dk_call% dk_echo "%output%"
%endfunction%
