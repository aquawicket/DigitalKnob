#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ clang ############
# https://packages.msys2.org/package/mingw-w64-x86_64-clang?repo=mingw64

dk_validate(host_triple "dk_host_triple()")
dk_validate(target_triple "dk_target_triple()")

#dk_getFileParam("${DKIMPORTS_DIR}/clang/clang.txt" VERSION)
if(clang OR mingw OR ucrt)
	dk_depend(msys2)
endif()
dk_installPackage(clang)
	
#if(win_x86_clang)
#	dk_set(CLANG_C_COMPILER   	"${MSYS2_DIR}/clang32/bin/clang.exe")
#	dk_set(CLANG_CXX_COMPILER	"${MSYS2_DIR}/clang32/bin/clang++.exe")
#	dk_set(CLANG_RC_COMPILER  	"${MSYS2_DIR}/clang32/bin/windres.exe")
#elseif(win_x86_64_clang)
#	dk_depend(msys2)
#	dk_set(MSYS2_BIN		 	"${MSYS2}/usr/bin")
#	dk_assertPath(MSYS2_BIN)
#	dk_set(CLANG64_BIN		  	"${MSYS2}/clang64/bin")
#	dk_assertPath(CLANG64_BIN)
#	dk_set(CLANG_C_COMPILER   	"${CLANG64_BIN}/clang.exe")
#	dk_assertPath(CLANG_C_COMPILER)
#	dk_set(CLANG_CXX_COMPILER 	"${CLANG64_BIN}/clang++.exe")
#	dk_assertPath(CLANG_CXX_COMPILER)
#	dk_set(CLANG_RC_COMPILER  	"${CLANG64_BIN}/windres.exe")
#	dk_assertPath(CLANG_RC_COMPILER)
#	
#	dk_replaceAll("${MSYS2}" 	"/" "\\" 	MSYS2_WIN)
#	dk_set(MSYS2_WIN "${MSYS2_WIN}") # globalize
#	
#	dk_replaceAll("${CLANG64_BIN}" 	"/" "\\" 	CLANG64_BIN_WIN)
#	dk_set(CLANG64_BIN_WIN "${CLANG64_BIN_WIN}") # globalize
#	
#	dk_replaceAll("${MSYS2_BIN}" 	"/" "\\"	MSYS2_BIN_WIN)
#	
#elseif(win_arm64_clang)
#	dk_set(CLANG_C_COMPILER   ${MSYS2_DIR}/clangarm64/bin/clang.exe)
#	dk_set(CLANG_CXX_COMPILER ${MSYS2_DIR}/clangarm64/bin/clang++.exe)
#	dk_set(CLANG_RC_COMPILER  ${MSYS2_DIR}/clangarm64/bin/windres.exe)
#elseif(win_x86_mingw)
#	dk_set(CLANG_C_COMPILER   ${MSYS2_DIR}/mingw32/bin/clang.exe)
#	dk_set(CLANG_CXX_COMPILER ${MSYS2_DIR}/mingw32/bin/clang++.exe)
#	dk_set(CLANG_RC_COMPILER  ${MSYS2_DIR}/mingw32/bin/windres.exe)
#elseif(win_x86_64_mingw)
#	dk_set(CLANG_C_COMPILER   ${MSYS2_DIR}/mingw64/bin/clang.exe)
#	dk_set(CLANG_CXX_COMPILER ${MSYS2_DIR}/mingw64/bin/clang++.exe)
#	dk_set(CLANG_RC_COMPILER  ${MSYS2_DIR}/mingw64/bin/windres.exe)
#elseif(win_x86_64_ucrt)
#	dk_set(CLANG_C_COMPILER   ${MSYS2_DIR}/ucrt64/bin/clang.exe)
#	dk_set(CLANG_CXX_COMPILER ${MSYS2_DIR}/ucrt64/bin/clang++.exe)
#	dk_set(CLANG_RC_COMPILER  ${MSYS2_DIR}/ucrt64/bin/windres.exe)
#elseif(LINUX_HOST)
#	if(EXISTS /usr/bin/clang)
#		dk_set(CLANG_C_COMPILER	/usr/bin/clang)
#	elseif(EXISTS /usr/local/bin/clang)
#		dk_set(CLANG_C_COMPILER	/usr/local/bin/clang)
#	endif()
#
#	if(EXISTS /usr/bin/clang++)
#		dk_set(CLANG_CXX_COMPILER	/usr/bin/clang++)
#	elseif(EXISTS /usr/local/bin/clang++)
#		dk_set(CLANG_CXX_COMPILER	/usr/local/bin/clang++)
#	endif()
#endif()




###### set GLOBAL CMAKE VARIABLES ######
#if(NOT CMAKE_C_COMPILER)
#	dk_set(CMAKE_C_COMPILER		${CLANG_C_COMPILER})
#endif()
#if(NOT CMAKE_CXX_COMPILER)
#	dk_set(CMAKE_CXX_COMPILER	${CLANG_CXX_COMPILER})
#ndif()
#if(NOT CMAKE_RC_COMPILER)
#	dk_set(CMAKE_RC_COMPILER	${CLANG_RC_COMPILER})
#endif()

#dk_set(DKCONFIGURE_CC			${CMAKE_C_COMPILER})
#dk_set(DKCONFIGURE_CXX			${CMAKE_CXX_COMPILER})
