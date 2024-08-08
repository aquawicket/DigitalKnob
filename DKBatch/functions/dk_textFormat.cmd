@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::# dk_textFormat(OUTPUT. column1, column2, column3, column4)
::#
::#   reference: https://stackoverflow.com/a/19588505
::#   
::#
:dk_textFormat
	call dk_debugFunc 4 5
	
    setlocal
    set "spaces=                                        "
	set "col1=%~2%spaces%"
    set col1=%col1:~0,10%
    
	set "col2=%~3%spaces%"
    set col2=%col2:~0,30%
    
	set "col3=%~4%spaces%"
    set col3=%col3:~0,30%
    
	set "col4=%~5%spaces%"
    set col4=%col4:~0,100%
    
	::call dk_set output "%col1% %col2% %col3% %col4%"
	set "_textFormat_=%col1% %col2% %col3% %col4%"
    endlocal & set "%1=%_textFormat_%"
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_textFormat output "column1" "column2" "column3" "column4"
	call dk_echo "%output%"
goto:eof
