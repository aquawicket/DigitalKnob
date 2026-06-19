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
	dk_set(cmake_Import cmake)
	if(NOT EXIST ${cmake_exe})
		dk_installPackage(${cmake_Import})
		dk_findProgram(cmake_exe cmake)
	endif()

endif()

###### cmake_Import ######
set					(cmake_Import "${CMake_${Host_Tuple}_Import}")
dk_assertVar		(cmake_Import)

###### UNINSTALL ######
dk_validate			(DKTOOLS_DIR 		"dk_DKTOOLS_DIR()")
dk_importVariables	(${cmake_Import} NAME cmake ROOT ${DKTOOLS_DIR})

message("cmake = $ENV{cmake}")
dk_assertPath("$ENV{cmake}")
dk_delete	("$ENV{cmake}")
