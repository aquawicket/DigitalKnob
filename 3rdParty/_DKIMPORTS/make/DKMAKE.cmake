#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


dk_load(dk_builder)
# https://packages.msys2.org/base/make


#if(CMAKE_MAKE_PROGRAM)
#	return()
#endif()


if(WIN_HOST)
	if(DEFINED ENV{MSYSTEM})
		dk_set(MSYSTEM "$ENV{MSYSTEM}")
		dk_set($ENV{MSYSTEM} 1)
		dk_depend(msys2)
	endif()
endif()

dk_installPackage(make)

if(android)
	if(WIN_HOST)
		dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2_DIR}/clang64/bin")
	else()
		dk_findProgram(CMAKE_MAKE_PROGRAM make)
	endif()
	
elseif(emscripten)
	dk_validate(EMSDK "dk_depend(emsdk)")
	if(WIN_HOST)
		dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${EMSDK}/mingw/4.6.2_32bit")
	else()
		dk_findProgram(CMAKE_MAKE_PROGRAM make /usr/bin)
	endif()
	
elseif(win_arm64_clang)
	dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2_DIR}/clangarm64/bin")
	
elseif(win_x86_clang)
	dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2_DIR}/clang32/bin")
	
elseif(win_x86_64_clang)
	dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2_DIR}/clang64/bin")
	
elseif(win_x86_mingw)
	dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2_DIR}/mingw32/bin")
	
elseif(win_x86_64_mingw)
	dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2_DIR}/mingw64/bin")
	
elseif(win_x86_64_ucrt)
	dk_findProgram(CMAKE_MAKE_PROGRAM mingw32-make "${MSYS2_DIR}/ucrt64/bin")

elseif(win_x86_msvc)
	dk_validate(DKIMPORTS_DIR "dk_DKBRANCH_DIR()")
	#dk_validate(VISUALSTUDIO "dk_load(${DKIMPORTS_DIR}/visualstudio/DKMAKE.cmake)")
	dk_validate(VISUALSTUDIO "dk_depend(visualstudio)")
	dk_findProgram(CMAKE_MAKE_PROGRAM msbuild ${VISUALSTUDIO})
	
elseif(win_x86_64_msvc)
	dk_validate(DKIMPORTS_DIR "dk_DKBRANCH_DIR()")
	#dk_validate(VISUALSTUDIO "dk_load(${DKIMPORTS_DIR}/visualstudio/DKMAKE.cmake)")
	dk_validate(VISUALSTUDIO "dk_depend(visualstudio)")
	dk_findProgram(CMAKE_MAKE_PROGRAM msbuild ${VISUALSTUDIO})
	
else()
	dk_findProgram(CMAKE_MAKE_PROGRAM make)
	
endif()


#dk_assertVar(CMAKE_MAKE_PROGRAM)
