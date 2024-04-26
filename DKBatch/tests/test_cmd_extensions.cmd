@echo off

::####################################################################
::# test_cmd_extensions.cmd
::#
::#

if "~x0"=="%~x0" goto NOCMDEXT 
if "%%~x0"=="%~x0" goto NOCMDEXT
if CmdExtVersion 2 goto CMDEXTV2
goto CMDEXTV1

:CMDEXTV1
	echo Command extensions v1 available
	pause
goto:eof

:CMDEXTV2
	echo Command extensions v2 or later available
	pause
goto:eof

:NOCMDEXT
	echo Command extensions not available
	pause
goto:eof