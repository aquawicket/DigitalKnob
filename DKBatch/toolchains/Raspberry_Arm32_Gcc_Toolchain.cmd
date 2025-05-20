::@echo off&rem  ########################################## DigitalKnob DKBatch ########################################################################
::if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG"
::if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::######################################################################################################################################################

if nor defined Raspberry_Host (
	%return%
)

%dk_call% dk_echo "############################################################################"
%dk_call% dk_echo "################# Raspberry_Arm32_Gcc_Toolchain.cmd ######################"
%dk_call% dk_echo "############################################################################"

rem %dk_call% dk_depend build-essential
%dk_call% dk_depend 	gcc
%dk_call% dk_depend 	make
	
rem  %dk_call% dk_append CMAKE_C_FLAGS				-DLINUX -DRASPBERRY -DRASPBERRY_ARM32 -std=gnu11 				&rem -march=armv7l
rem  %dk_call% dk_append CMAKE_CXX_FLAGS			-DLINUX -DRASPBERRY -DRASPBERRY_ARM32 -std=gnu++17 -lstdc++fs 	&rem -march=armv7l 
rem  %dk_call% dk_append DKCONFIGURE_CFLAGS			-DLINUX -DRASPBERRY -DRASPBERRY_ARM32 -std=gnu11 				&rem -march=armv7l 
rem  %dk_call% dk_append DKCONFIGURE_CXXFLAGS		-DLINUX -DRASPBERRY -DRASPBERRY_ARM32 -std=gnu++17 -lstdc++fs 	&rem -march=armv7l
rem  %dk_call% dk_append CMAKE_EXE_LINKER_FLAGS		"-static"  &rem  -s
