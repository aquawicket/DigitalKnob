@echo off
call DK.cmd

::################################################################################
::# dk_logo()
::#
:dk_logo (){
	call dk_debugFunc
	
	
	echo %black%"%lblue%   ______  _____ _______ ______ ______ ______        _     __ _   _   _____  ______  
	echo %black%"%lblue%   |     \   |   |  ____   |      |    |_____| |      |____/  | \  | |     | |_____] 
	echo %black%"%blue%   |_____/ __|__ |_____| __|__    |    |     | |_____ |    \_ |  \_| |_____| |_____]    %clr%
	echo.
goto:eof




:DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	call dk_debugFunc
	
	call dk_logo
goto:eof
