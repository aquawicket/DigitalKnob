<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::################################################################################
::# dk_logo()
::#
:dk_logo
<<<<<<< HEAD
 setlocal
    call dk_debugFunc 0
    
    echo %black%"%lblue%   ______  _____ _______ ______ ______ ______        _     __ _   _   _____  ______  
    echo %black%"%lblue%   |     \   |   |  ____   |      |    |_____| |      |____/  | \  | |     | |_____] 
    echo %black%"%blue%   |_____/ __|__ |_____| __|__    |    |     | |_____ |    \_ |  \_| |_____| |_____]    %clr%
    echo %black%"%blue%                                                                     __     __            
    echo %black%"%cyan%                                                                    |  \|_/|__) _ |_ _|_  
    echo %black%"%cyan%                                                                    |__/| \|__)(_||_(_| ) 
    echo %clr%
=======
setlocal
	%dk_call% dk_debugFunc 0

	echo %black%"%lblue% ______  _____ _______ ______ ______ ______        _     __ _   _   _____  ______ 
	echo %black%"%lblue% |     \   |   |  ____   |      |    |_____| |      |____/  | \  | |     | |_____]
	 echo %black%"%blue% |_____/ __|__ |_____| __|__    |    |     | |_____ |    \_ |  \_| |_____| |_____]
	echo %black%"%lcyan%                                                             __     __            
	echo %black%"%lcyan%                                                            |  \|_/|__) _ |_ _|_  
	 echo %black%"%cyan%                                                            |__/| \|__)(_||_(_| ) 
	echo %clr%
>>>>>>> Development
%endfunction%







::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
    
    %dk_call% dk_logo
=======
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_logo
>>>>>>> Development
%endfunction%
