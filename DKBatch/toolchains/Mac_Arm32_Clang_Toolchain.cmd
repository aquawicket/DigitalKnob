if not defined Mac_Host (
	set "CMAKE_GENERATOR="
	exit /b 0
)
%dk_call% dk_echo "############################################################################"
%dk_call% dk_echo "#################### Mac_Arm32_Clang_Toolchain.cmd #######################"
%dk_call% dk_echo "############################################################################"

%dk_call% dk_set  MULTI_CONFIG					1
%dk_call% dk_set  CMAKE_GENERATOR				"Xcode"




::%dk_call% dk_depend xcode
::%dk_call% dk_depend make	
rem  %dk_call% dk_append CMAKE_C_FLAGS				-DMAC -DMAC_ARM -std=c17 -x objective-c
rem  %dk_call% dk_append CMAKE_CXX_FLAGS			-DMAC -DMAC_ARM -std=c++17 -x objective-c++
rem  %dk_call% dk_append DKCONFIGURE_CFLAGS		-DMAC -DMAC_ARM -std=c17 #-x objective-c rem # https://stackoverflow.com/questions/28756343/clang-link-failure-error-source-file-is-not-valid-utf-8
rem  %dk_call% dk_append DKCONFIGURE_CXXFLAGS		-DMAC -DMAC_ARM -std=c++17) #-x objective-c++ #https://stackoverflow.com/questions/28756343/clang-link-failure-error-source-file-is-not-valid-utf-8
rem  %dk_call% dk_append DKCMAKE_FLAGS				-DCMAKE_OSX_ARCHITECTURES=ARM)
rem  %dk_call% dk_append CMAKE_EXE_LINKER_FLAGS	-static  &rem  -s)
