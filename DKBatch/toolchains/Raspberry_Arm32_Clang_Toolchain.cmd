if not defined Raspberry_Host (
	exit /b 1
)
%dk_call% dk_echo "############################################################################"
%dk_call% dk_echo "################### Raspberry_Arm32_Clang_Toolchain.cmd ####################"
%dk_call% dk_echo "############################################################################"

set CMAKE_GENERATOR="Unix Makefiles"





rem %dk_call% dk_depend build-essential
::%dk_call% dk_depend 	clang
::%dk_call% dk_depend 	make	
rem %dk_call% dk_append CMAKE_C_FLAGS				-DLINUX -DRASPBERRY -DRASPBERRY_ARM32 -std=gnu11 				&rem -march=armv7l
rem %dk_call% dk_append CMAKE_CXX_FLAGS				-DLINUX -DRASPBERRY -DRASPBERRY_ARM32 -std=gnu++17 -lstdc++fs 	&rem -march=armv7l 
rem %dk_call% dk_append DKCONFIGURE_CFLAGS			-DLINUX -DRASPBERRY -DRASPBERRY_ARM32 -std=gnu11 				&rem -march=armv7l 
rem %dk_call% dk_append DKCONFIGURE_CXXFLAGS		-DLINUX -DRASPBERRY -DRASPBERRY_ARM32 -std=gnu++17 -lstdc++fs 	&rem -march=armv7l
rem %dk_call% dk_append CMAKE_EXE_LINKER_FLAGS		"-static"  &rem  -s
