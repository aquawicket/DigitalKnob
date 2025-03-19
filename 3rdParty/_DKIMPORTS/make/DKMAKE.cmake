#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")



############ make #############
# https://packages.msys2.org/base/make
if((NOT DKUPDATE) AND (EXISTS ${CMAKE_MAKE_PROGRAM}))
	dk_notice("CMAKE_MAKE_PROGRAM is already set, returning")
	dk_return()
endif()


#if(WIN_HOST)
#	if(DEFINED ENV{MSYSTEM})
#		dk_set(MSYSTEM "$ENV{MSYSTEM}")
#		dk_set($ENV{MSYSTEM} 1)
#		dk_validate(MSYS2 "dk_depend(msys2)")
#	endif()
#endif()


#dk_validate(target_triple "dk_target_triple()")
#dk_validate(host_triple "dk_host_triple()")

dk_installPackage("make")


#if(cosmopolitan)
#	if(WIN_HOST)
#		dk_validate(MSYS2 "dk_depend(msys2)")
#		dk_installPackage(make)
#		dk_exportVars(PATH "${MSYS2_DIR}/usr/bin;$ENV{PATH}")
#		dk_findProgram(CMAKE_MAKE_PROGRAM make "${MSYS2_DIR}/usr/bin")
#	else()
#		dk_findProgram(CMAKE_MAKE_PROGRAM make)
#	endif()
#	
#elseif(emscripten)
#	if(WIN_HOST)
#		dk_validate(MSYS2 "dk_depend(msys2)")
#		dk_installPackage(make)
#		#dk_findProgram(CMAKE_MAKE_PROGRAM make "${MSYS2_DIR}/usr/bin")
#	else()
#		#dk_findProgram(CMAKE_MAKE_PROGRAM make)
#	endif()
#	
#elseif(win_arm64_clang)
#	dk_validate(MSYS2 "dk_depend(msys2)")
#	dk_installPackage("make")
#	#dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2_DIR}/clangarm64/bin")
#	
#elseif(win_x86_clang)
#	dk_validate(MSYS2 "dk_depend(msys2)")
#	dk_installPackage("make")
#	#dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2_DIR}/clang32/bin")
#	
#elseif(win_x86_64_clang)
#	dk_validate(MSYS2 "dk_depend(msys2)")
#	dk_installPackage("make")
#	#dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2_DIR}/clang64/bin")
#	
#elseif(win_x86_gcc)
#	dk_validate(MSYS2 "dk_depend(msys2)")
#	dk_installPackage("make")
#	#dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2_DIR}/mingw32/bin")
#	
#elseif(win_x86_64_gcc)
#	dk_validate(MSYS2 "dk_depend(msys2)")
#	dk_installPackage("make")
#	#dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2_DIR}/mingw64/bin")
#	
#elseif(win_x86_64_ucrt)
#	dk_validate(MSYS2 "dk_depend(msys2)")
#	dk_installPackage("make")
#	#dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2_DIR}/ucrt64/bin")
#
#elseif(win_x86_msvc)
#	dk_depend(visualstudio)
#	#dk_findProgram(CMAKE_MAKE_PROGRAM msbuild ${VISUAL_CPP_BUILD_TOOLS})
#	
#elseif(win_x86_64_msvc)
#	dk_depend(visualstudio)
#	#dk_findProgram(CMAKE_MAKE_PROGRAM msbuild ${VISUAL_CPP_BUILD_TOOLS})
#	
#endif()
#
#if(NOT CMAKE_MAKE_PROGRAM)
	#dk_findProgram(CMAKE_MAKE_PROGRAM make)
#endif()


#dk_assertVar(CMAKE_MAKE_PROGRAM)
