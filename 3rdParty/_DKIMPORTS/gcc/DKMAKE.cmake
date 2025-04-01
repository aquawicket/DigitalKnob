#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} ../../../DKCMake/functions/)
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ gcc ############
# https://packages.msys2.org/package/mingw-w64-x86_64-gcc?repo=mingw64
dk_validate(host_triple			"dk_host_triple()")
dk_validate(ENV{target_triple}	"dk_target_triple()")
dk_set($ENV{target_triple}		1)

#dk_getFileParam("$ENV{DKIMPORTS_DIR}/clang/dkconfig.txt" VERSION)
#if(clang OR mingw OR ucrt)
if(MSYSTEM)
	dk_validate(MSYS2 "dk_depend(msys2)")
endif()
dk_installPackage(gcc)

if(win_x86_gcc)
	dk_validate(MSYS2 			"dk_depend(msys2)")
	dk_set(MINGW32_BIN		  	"${MSYS2}/mingw32/bin")
	dk_set(GCC_C_COMPILER   	"${MINGW32_BIN}/gcc.exe")
	dk_set(GCC_CXX_COMPILER		"${MINGW32_BIN}/g++.exe")
	dk_set(GCC_RC_COMPILER  	"${MINGW32_BIN}/windres.exe")
elseif(win_x86_64_gcc)
	dk_validate(MSYS2 			"dk_depend(msys2)")
	dk_set(MINGW64_BIN		  	"${MSYS2}/mingw64/bin")
	dk_set(GCC_C_COMPILER   	"${MINGW64_BIN}/gcc.exe")
	dk_set(GCC_CXX_COMPILER 	"${MINGW64_BIN}/g++.exe")
	dk_set(GCC_RC_COMPILER  	"${MINGW64_BIN}/windres.exe")
endif()
#if(win_x86_clang)
#	dk_set(GCC_C_COMPILER   	${MSYS2_DIR}/clang32/bin/gcc.exe)
#	dk_set(GCC_CXX_COMPILER 	${MSYS2_DIR}/clang32/bin/g++.exe)
#	dk_set(GCC_RC_COMPILER  	${MSYS2_DIR}/clang32/bin/windres.exe)		# TODO:  move to DKIMPORTS/windres
#elseif(win_x86_64_clang)
#	dk_set(GCC_C_COMPILER   	${MSYS2_DIR}/clang64/bin/gcc.exe)
#	dk_set(GCC_CXX_COMPILER 	${MSYS2_DIR}/clang64/bin/g++.exe)
#	dk_set(GCC_RC_COMPILER  	${MSYS2_DIR}/clang64/bin/windres.exe)		# TODO:  move to DKIMPORTS/windres
#elseif(win_arm64_clang)
#	dk_set(GCC_C_COMPILER   	${MSYS2_DIR}/clangarm64/bin/gcc.exe)
#	dk_set(GCC_CXX_COMPILER 	${MSYS2_DIR}/clangarm64/bin/g++.exe)
#	dk_set(GCC_RC_COMPILER  	${MSYS2_DIR}/clangarm64/bin/windres.exe)	# TODO:  move to DKIMPORTS/windres
#elseif(win_x86_gcc)
#	dk_set(GCC_C_COMPILER   	${MSYS2_DIR}/mingw32/bin/gcc.exe)
#	dk_set(GCC_CXX_COMPILER 	${MSYS2_DIR}/mingw32/bin/g++.exe)
#	dk_set(GCC_RC_COMPILER  	${MSYS2_DIR}/mingw32/bin/windres.exe)		# TODO:  move to DKIMPORTS/windres
#elseif(win_x86_64_gcc)
#	dk_set(GCC_C_COMPILER   	${MSYS2_DIR}/mingw64/bin/gcc.exe)
#	dk_set(GCC_CXX_COMPILER 	${MSYS2_DIR}/mingw64/bin/g++.exe)
#	dk_set(GCC_RC_COMPILER  	${MSYS2_DIR}/mingw64/bin/windres.exe)		# TODO:  move to DKIMPORTS/windres
#elseif(win_x86_64_ucrt)
#	dk_set(GCC_C_COMPILER   	${MSYS2_DIR}/ucrt64/bin/gcc.exe)
#	dk_set(GCC_CXX_COMPILER 	${MSYS2_DIR}/ucrt64/bin/g++.exe)
#	dk_set(GCC_RC_COMPILER  	${MSYS2_DIR}/ucrt64/bin/windres.exe)		# TODO:  move to DKIMPORTS/windres
#elseif(LINUX_HOST)
#	if(EXISTS /usr/bin/gcc)
#		dk_set(GCC_C_COMPILER	/usr/bin/gcc)
#	elseif(EXISTS /usr/local/bin/gcc)
#		dk_set(GCC_C_COMPILER	/usr/local/bin/gcc)
#	endif()
#
#	if(EXISTS /usr/bin/g++)
#		dk_set(GCC_CXX_COMPILER	/usr/bin/g++)
#	elseif(EXISTS /usr/local/bin/g++)
#		dk_set(GCC_CXX_COMPILER	/usr/local/bin/g++)
#	endif()
#endif()




###### set GLOBAL CMAKE VARIABLES ######
#if(NOT CMAKE_C_COMPILER)
#	dk_set(CMAKE_C_COMPILER		${GCC_C_COMPILER})
#endif()
#if(NOT CMAKE_CXX_COMPILER)
#	dk_set(CMAKE_CXX_COMPILER	${GCC_CXX_COMPILER})
#endif()
#dk_set(CMAKE_RC_COMPILER	${GCC_RC_COMPILER})			# TODO:  move to DKIMPORTS/windres
#
#dk_set(DKCONFIGURE_CC		${CMAKE_C_COMPILER})
#dk_set(DKCONFIGURE_CXX		${CMAKE_CXX_COMPILER})
