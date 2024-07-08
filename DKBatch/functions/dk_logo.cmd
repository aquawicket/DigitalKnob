@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_logo()
::#
:dk_logo
	call dk_debugFunc
	
	echo %black%"%lblue%   ______  _____ _______ ______ ______ ______        _     __ _   _   _____  ______  
	echo %black%"%lblue%   |     \   |   |  ____   |      |    |_____| |      |____/  | \  | |     | |_____] 
	echo %black%"%blue%   |_____/ __|__ |_____| __|__    |    |     | |_____ |    \_ |  \_| |_____| |_____]    %clr%
	echo %black%"%blue%                                                                     __     __            
    echo %black%"%cyan%                                                                    |  \|_/|__) _ |_ _|_  
    echo %black%"%cyan%                                                                    |__/| \|__)(_||_(_| ) 
    echo %clr%
goto:eof







::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
:DKTEST
	call dk_debugFunc
	
	call dk_logo
goto:eof
