@echo off&rem  ########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG"
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
rem  #################################################################################################################################################

%dk_call% dk_echo "############################################################################"
%dk_call% dk_echo "#################### Mac_Arm32_Clang_Toolchain.cmake #######################"
%dk_call% dk_echo "############################################################################"

if not defined Mac_Host (
	%dk_call% dk_exit
)

%dk_call% dk_depend xcode
%dk_call% dk_depend make
	
rem  %dk_call% dk_append CMAKE_C_FLAGS				-DMAC -DMAC_ARM -std=c17 -x objective-c
rem  %dk_call% dk_append CMAKE_CXX_FLAGS			-DMAC -DMAC_ARM -std=c++17 -x objective-c++
rem  %dk_call% dk_append DKCONFIGURE_CFLAGS		-DMAC -DMAC_ARM -std=c17 #-x objective-c rem # https://stackoverflow.com/questions/28756343/clang-link-failure-error-source-file-is-not-valid-utf-8
rem  %dk_call% dk_append DKCONFIGURE_CXXFLAGS		-DMAC -DMAC_ARM -std=c++17) #-x objective-c++ #https://stackoverflow.com/questions/28756343/clang-link-failure-error-source-file-is-not-valid-utf-8
rem  %dk_call% dk_append DKCMAKE_FLAGS				-DCMAKE_OSX_ARCHITECTURES=ARM)
rem  %dk_call% dk_append CMAKE_EXE_LINKER_FLAGS	-static  &rem  -s)
