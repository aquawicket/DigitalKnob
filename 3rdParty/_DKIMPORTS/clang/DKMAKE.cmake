#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ clang ############
# https://packages.msys2.org/package/mingw-w64-x86_64-clang?repo=mingw64

dk_load(dk_builder)
#dk_validate(DKIMPORTS_DIR "dk_DKBRANCH_DIR()")
#dk_getFileParam("${DKIMPORTS_DIR}/clang/clang.txt" VERSION)
if(clang OR mingw OR ucrt)
	dk_validate(MSYS2  		"dk_depend(msys2)")
endif()
dk_installPackage(clang)
	
if(win_x86_clang)
	dk_set(CLANG_C_COMPILER   ${MSYS2_DIR}/clang32/bin/clang.exe)
	dk_set(CLANG_CXX_COMPILER ${MSYS2_DIR}/clang32/bin/clang++.exe)
	dk_set(CLANG_RC_COMPILER  ${MSYS2_DIR}/clang32/bin/windres.exe)
elseif(win_x86_64_clang)
	dk_set(CLANG_C_COMPILER   ${MSYS2_DIR}/clang64/bin/clang.exe)
	dk_set(CLANG_CXX_COMPILER ${MSYS2_DIR}/clang64/bin/clang++.exe)
	dk_set(CLANG_RC_COMPILER  ${MSYS2_DIR}/clang64/bin/windres.exe)
elseif(win_arm64_clang)
	dk_set(CLANG_C_COMPILER   ${MSYS2_DIR}/clangarm64/bin/clang.exe)
	dk_set(CLANG_CXX_COMPILER ${MSYS2_DIR}/clangarm64/bin/clang++.exe)
	dk_set(CLANG_RC_COMPILER  ${MSYS2_DIR}/clangarm64/bin/windres.exe)
elseif(win_x86_mingw)
	dk_set(CLANG_C_COMPILER   ${MSYS2_DIR}/mingw32/bin/clang.exe)
	dk_set(CLANG_CXX_COMPILER ${MSYS2_DIR}/mingw32/bin/clang++.exe)
	dk_set(CLANG_RC_COMPILER  ${MSYS2_DIR}/mingw32/bin/windres.exe)
elseif(win_x86_64_mingw)
	dk_set(CLANG_C_COMPILER   ${MSYS2_DIR}/mingw64/bin/clang.exe)
	dk_set(CLANG_CXX_COMPILER ${MSYS2_DIR}/mingw64/bin/clang++.exe)
	dk_set(CLANG_RC_COMPILER  ${MSYS2_DIR}/mingw64/bin/windres.exe)
elseif(win_x86_64_ucrt)
	dk_set(CLANG_C_COMPILER   ${MSYS2_DIR}/ucrt64/bin/clang.exe)
	dk_set(CLANG_CXX_COMPILER ${MSYS2_DIR}/ucrt64/bin/clang++.exe)
	dk_set(CLANG_RC_COMPILER  ${MSYS2_DIR}/ucrt64/bin/windres.exe)
elseif(LINUX_HOST)
	if(EXISTS /usr/bin/clang)
		dk_set(CLANG_C_COMPILER	/usr/bin/clang)
	elseif(EXISTS /usr/local/bin/clang)
		dk_set(CLANG_C_COMPILER	/usr/local/bin/clang)
	endif()

	if(EXISTS /usr/bin/clang++)
		dk_set(CLANG_CXX_COMPILER	/usr/bin/clang++)
	elseif(EXISTS /usr/local/bin/clang++)
		dk_set(CLANG_CXX_COMPILER	/usr/local/bin/clang++)
	endif()
endif()




###### set GLOBAL CMAKE VARIABLES ######
if(NOT CMAKE_C_COMPILER)
	dk_set(CMAKE_C_COMPILER		${CLANG_C_COMPILER})
endif()
if(NOT CMAKE_CXX_COMPILER)
	dk_set(CMAKE_CXX_COMPILER	${CLANG_CXX_COMPILER})
endif()
dk_set(CMAKE_RC_COMPILER	${CLANG_RC_COMPILER})

dk_set(DKCONFIGURE_CC		${CMAKE_C_COMPILER})
dk_set(DKCONFIGURE_CXX		${CMAKE_CXX_COMPILER})
