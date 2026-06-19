#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


############ z264 ############
# https://code.videolan.org/videolan/x264.git
# https://code.videolan.org/videolan/x264/-/archive/80c1c47c/x264-80c1c47c.zip
#
function(DKINSTALL)

	dk_validate(msys2 "dk_depend(msys2)")
	dk_validate(nasm "dk_depend(nasm)")

	dk_import()

	dk_include		(${X264}/include)
	dk_include		(${X264}/${Target_Tuple})
	dk_libDebug		(${X264_Debug_Dir}/libx264.a)
	dk_libRelease	(${X264_Release_Dir}/libx264.a)

	if(Emscripten)
		dk_configure(${X264} --disable-asm --host=i686-pc-linux-gnu --enable-static --disable-cli) #--extra-cflags="-s USE_PTHREADS=1"
	else()
		dk_configure(${X264} --disable-asm)
	endif()
	dk_build        (${X264})
endfunction()
