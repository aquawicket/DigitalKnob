#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)



############ make #############
# https://packages.msys2.org/base/make
dk_load(dk_builder)

#if(CMAKE_MAKE_PROGRAM)
#	return()
#endif()

#if(WIN_HOST)
#	if(DEFINED ENV{MSYSTEM})
#		dk_set(MSYSTEM "$ENV{MSYSTEM}")
#		dk_set($ENV{MSYSTEM} 1)
#		dk_validate(MSYS2 "dk_depend(msys2)")
#	endif()
#endif()



if(android)
	if(WIN_HOST)
		dk_validate(MSYS2 "dk_depend(msys2)")
		dk_installPackage("make")
		dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2_DIR}/clang64/bin")
	else()
		dk_findProgram(CMAKE_MAKE_PROGRAM make)
	endif()

elseif(cosmo)
	if(WIN_HOST)
		dk_validate(PACMAN_EXE "dk_depend(pacman)")
		dk_installPackage(make)
		dk_findProgram(CMAKE_MAKE_PROGRAM make "${MSYS2_DIR}/usr/bin")
		dk_exportVars(PATH "${MSYS2_DIR}/usr/bin;$ENV{PATH}")
	else()
		dk_findProgram(CMAKE_MAKE_PROGRAM make)
	endif()
	
elseif(emscripten)
	if(WIN_HOST)
		dk_validate(PACMAN_EXE "dk_depend(pacman)")
		dk_installPackage(make)
		dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2_DIR}/usr/bin")
	else()
		dk_findProgram(CMAKE_MAKE_PROGRAM make /usr/bin)
	endif()
	
elseif(win_arm64_clang)
	dk_validate(MSYS2 "dk_depend(msys2)")
	dk_installPackage("make")
	dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2_DIR}/clangarm64/bin")
	
elseif(win_x86_clang)
	dk_validate(MSYS2 "dk_depend(msys2)")
	dk_installPackage("make")
	dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2_DIR}/clang32/bin")
	
elseif(win_x86_64_clang)
	dk_validate(MSYS2 "dk_depend(msys2)")
	dk_installPackage("make")
	dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2_DIR}/clang64/bin")
	
elseif(win_x86_mingw)
	dk_validate(MSYS2 "dk_depend(msys2)")
	dk_installPackage("make")
	dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2_DIR}/mingw32/bin")
	
elseif(win_x86_64_mingw)
	dk_validate(MSYS2 "dk_depend(msys2)")
	dk_installPackage("make")
	dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2_DIR}/mingw64/bin")
	
elseif(win_x86_64_ucrt)
	dk_validate(MSYS2 "dk_depend(msys2)")
	dk_installPackage("make")
	dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2_DIR}/ucrt64/bin")

elseif(win_x86_msvc)
	dk_validate(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
	#dk_validate(VISUALSTUDIO "dk_load(${DKIMPORTS_DIR}/visual-cpp-build-tools/DKMAKE.cmake)")
	dk_validate(VISUALSTUDIO "dk_depend(visual-cpp-build-tools)")
	dk_findProgram(CMAKE_MAKE_PROGRAM msbuild ${VISUAL_CPP_BUILD_TOOLS})
	
elseif(win_x86_64_msvc)
	dk_validate(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
	#dk_validate(VISUALSTUDIO "dk_load(${DKIMPORTS_DIR}/visual-cpp-build-tools/DKMAKE.cmake)")
	dk_validate(VISUALSTUDIO "dk_depend(visual-cpp-build-tools)")
	dk_findProgram(CMAKE_MAKE_PROGRAM msbuild ${VISUAL_CPP_BUILD_TOOLS})
	
else()
	dk_findProgram(CMAKE_MAKE_PROGRAM make /usr/bin)
	
endif()

if(NOT CMAKE_MAKE_PROGRAM)
	dk_findProgram(CMAKE_MAKE_PROGRAM make)
endif()


dk_assertVar(CMAKE_MAKE_PROGRAM)
