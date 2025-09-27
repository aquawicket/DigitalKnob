#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


############ pyportable ############
# https://github.com/sganis/pyportable
dk_validate(Target_Config  "dk_Target_Config()")

### INSTALL ###
if(Windows_Host)
	dk_set(python_exe ${pyportable}/python.exe)
	
	dk_import(https://github.com/sganis/pyportable/releases/download/v2.7.10rc1/pyportable-2.7.10rc1.zip)

	if(NOT EXISTS ${pyportable}/Scripts/pip.exe)
		dk_exec(${python_exe} -m ensurepip)
	endif()

	dk_prependEnvPath("${pyportable}")
	
	dk_set(Python_INCLUDE_DIRS ${pyportable}/include)
	dk_debug(Python_INCLUDE_DIRS)
	
	dk_set(Python_LIBRARIES ${pyportable}/libs)
	dk_debug(Python_LIBRARIES)
endif()

#dk_debug(python_exe)
#dk_exec(${python_exe} --version OUTPUT_VARIABLE PYTHON_VERSION ERROR_VARIABLE PYTHON_VERSION)
#dk_debug(PYTHON_VERSION)
dk_assert_path(python_exe)
