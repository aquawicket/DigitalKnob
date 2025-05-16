#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")


############ cmake ############
# https://cmake.org
# https://github.com/Kitware/CMake
# https://github.com/Kitware/CMake/releases/download/v3.21.1/cmake-3.21.1-windows-i386.msi
# https://developer.android.com/studio/projects/configure-cmake
# https://discourse.cmake.org/t/cmake-silent-install-with-options-help/1475/2
# https://askubuntu.com/questions/355565/how-do-i-install-the-latest-version-of-cmake-from-the-command-line 	# How to get latest version on ubuntu
# https://github.com/Kitware/CMake/releases

### BINARY DISTRIBUTIONS (PORTABLE) ###
if("$ENV{WSL_DISTRO_NAME}" STREQUAL "Alpine")
	dk_set(CMAKE_IMPORT cmake)
	if(NOT EXIST ${CMAKE_EXE})
		dk_installPackage(${CMAKE_IMPORT})
		dk_findProgram(CMAKE_EXE cmake)
	endif()

endif()

###### CMAKE_IMPORT ######
dk_validate			(DKIMPORTS_DIR 			"dk_DKIMPORTS_DIR()")
dk_getFileParams	("$ENV{DKIMPORTS_DIR}/cmake/dkconfig.txt")
dk_validate			(Host_Tuple 			"dk_Host_Tuple()")
dk_assertVar		(CMAKE_WIN_X86_64_IMPORT)
dk_if				(Android_Host			"dk_set(CMAKE_IMPORT ${CMAKE_LINUX_AARCH64_IMPORT})")
dk_if				(Linux_Arm64_Host		"dk_set(CMAKE_IMPORT ${CMAKE_LINUX_AARCH64_IMPORT})")
dk_if				(Linux_X86_64_Host		"dk_set(CMAKE_IMPORT ${CMAKE_LINUX_X86_64_IMPORT})")
dk_if				(Mac_Host				"dk_set(CMAKE_IMPORT ${CMAKE_MAC_10_IMPORT})")
dk_if				(Windows_Arm64_Host		"dk_set(CMAKE_IMPORT ${CMAKE_WIN_ARM64_IMPORT})")
dk_if				(Windows_X86_Host		"dk_set(CMAKE_IMPORT ${CMAKE_WIN_X86_IMPORT})")
dk_if				(Windows_X86_64_Host	"dk_set(CMAKE_IMPORT ${CMAKE_WIN_X86_64_IMPORT})")
dk_assertVar		(CMAKE_IMPORT)



###### UNINSTALL ######
dk_validate			(ENV{DKIMPORTS_DIR} "dk_DKIMPORTS_DIR()")
dk_getFileParams	("$ENV{DKIMPORTS_DIR}/cmake/dkconfig.txt")
dk_validate			(DKTOOLS_DIR 		"dk_DKTOOLS_DIR()")
dk_importVariables	(${CMAKE_IMPORT} NAME cmake ROOT ${DKTOOLS_DIR})

message("CMAKE = $ENV{CMAKE}")
dk_assertPath("$ENV{CMAKE}")
dk_delete			("$ENV{CMAKE}")


