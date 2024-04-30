@echo off
call dk_includeGuard
call DK

::################################################################################
::# dk_textFormat(<OUTPUT> <column1> <column2> <column3> <column4>)
::#
::#   reference: https://stackoverflow.com/a/19588505
::#   
::#
:dk_textFormat
	call dk_debugFunc
	
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
    
	::echo %col1% %col2% %col3% %col4%
	set "output=%col1% %col2% %col3% %col4%"
    endlocal & set "%1=%output%"
goto:eof