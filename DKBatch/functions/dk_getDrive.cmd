@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_getDrive(path rtn_var)
::#
::#
:dk_getDrive
	call dk_debugFunc 2
	
	setlocal
		set "_input=%1"
		set "_input=%_input:"=%"
		if [%_input:~-1,1%] == [\] set "_input=%_input:~0,-1%"
		if [%_input:~-1,1%] == [/] set "_input=%_input:~0,-1%"
		for %%Z in ("%_input_%") do set "_drive_=%%~dZ"
	endlocal & set "%2=%_drive_%"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_set myPath "C:\Windows"
	call dk_getDrive "%myPath%" drive
	call dk_printVar drive
goto:eof
