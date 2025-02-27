@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::################################################################################
::# dk_logo()
::#
:dk_logo
setlocal
	%dk_call% dk_debugFunc 0

	echo %black%"%lblue% ______  _____ _______ ______ ______ ______        _     __ _   _   _____  ______ 
	echo %black%"%lblue% |     \   |   |  ____   |      |    |_____| |      |____/  | \  | |     | |_____]
	 echo %black%"%blue% |_____/ __|__ |_____| __|__    |    |     | |_____ |    \_ |  \_| |_____| |_____]
	echo %black%"%lcyan%                                                             __     __            
	echo %black%"%lcyan%                                                            |  \|_/|__) _ |_ _|_  
	 echo %black%"%cyan%                                                            |__/| \|__)(_||_(_| ) 
	echo %clr%
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_logo
%endfunction%
