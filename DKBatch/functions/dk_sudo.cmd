@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::####################################################################
::# dk_sudo(command args...)
::#
::#
:dk_sudo
	call dk_debugFunc
	
	@echo Set objShell = CreateObject("Shell.Application") > %temp%\sudo.tmp.vbs
	@echo args = Right("%*", (Len("%*") - Len("%1"))) >> %temp%\sudo.tmp.vbs
	@echo objShell.ShellExecute "%1", args, "", "runas" >> %temp%\sudo.tmp.vbs
	@cscript %temp%\sudo.tmp.vbs
goto:eof




::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_sudo cmd
goto:eof