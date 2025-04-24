<<<<<<< HEAD
#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()


dk_echo(STATUS "####################################################################")
dk_echo(STATUS "################ win_x86_msvc_toolchain.cmake ######################")
dk_echo(STATUS "####################################################################")

###### Get DKCMAKE_DIR ######
if(NOT DKCMAKE_DIR)
	dk_dirname(${CMAKE_CURRENT_LIST_DIR} DKCMAKE_DIR)
	set(DKCMAKE_FUNCTIONS_DIR ${DKCMAKE_DIR}/functions)
	dk_dirname(${DKCMAKE_DIR} DKBRANCH_DIR)
	set(DK3RDPARTY ${DKBRANCH_DIR}/3rdParty)
	set(DKIMPORTS_DIR ${DK3RDPARTY}/_DKIMPORTS)
endif()

#dk_load(${DKIMPORTS_DIR}/msys2/DKMAKE.cmake)
#set(CLANG64_DIR "${MSYS2_DIR}/clang64")
#set(CMAKE_MAKE_PROGRAM ${CLANG64_DIR}/bin/mingw32-make.exe CACHE FILEPATH "")
#set(CMAKE_C_COMPILER ${CLANG64_DIR}/bin/clang.exe)
#set(CMAKE_CXX_COMPILER ${CLANG64_DIR}/bin/clang++.exe)
=======
message("############################################################################")
message("################### windoows_x86_msvc_toolchain.cmake ######################")
message("############################################################################")

if(NOT WIN_HOST)
	dk_exit()
endif()

dk_depend(visualstudio)

dk_set(CMAKE_GENERATOR				${VS_GENERATOR})
dk_set(CMAKE_MAKE_PROGRAM 			${VS_MAKE_PROGRAM})

dk_set(CMAKE_GENERATOR_PLATFORM		${VS_X86_GENERATOR_PLATFORM})
dk_set(CMAKE_CXX_COMPILER			${VS_X86_COMPILER})
dk_set(CMAKE_C_COMPILER				${VS_X86_COMPILER})
dk_set(CMAKE_DUMPBIN				${VS_X86_DUMPBIN})
dk_set(CMAKE_LINKER					${VS_X86_LINKER})

#dk_append(DKCONFIGURE_FLAGS		--build=i686-msvc)

dk_append(CMAKE_C_FLAGS				/DWIN /DWIN_X86 /D_WINDOWS /D_CRT_SECURE_NO_WARNINGS /D_USING_V110_SDK71_ /std:c17 /nologo /Zm500 /Zc:__cplusplus /bigobj)   #/MACHINE:X86 /D_WIN32_WINNT=0x0600
dk_append(CMAKE_CXX_FLAGS			/DWIN /DWIN_X86 /D_WINDOWS /D_CRT_SECURE_NO_WARNINGS /D_USING_V110_SDK71_ /std:c++17 /nologo /Zm500 /Zc:__cplusplus /bigobj) #/MACHINE:X86 /D_WIN32_WINNT=0x0600
>>>>>>> Development
