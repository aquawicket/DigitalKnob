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

message("cygpath/DKINSTALL.cmake")
dk_validate(Host_Os "dk_Host_Os()")
############ cygpath ############
if(NOT Windows_Host)
	dk_disable(cygpath)
	dk_return()
endif()

if(EXISTS "${cygpath_exe}")
	message("cygpath_exe:'${cygpath_exe}' already exists")
	dk_return()
endif()

###### GET cygpath_exe ######
if(NOT EXISTS "${cygpath_exe}")
	dk_depend(msys2)
	dk_findProgram(cygpath_exe cygpath.exe "${msys2}/usr/bin")
endif()

if(NOT EXISTS "${cygpath_exe}")
	dk_depend(git)
	dk_findProgram(cygpath_exe cygpath.exe "${git}/usr/bin")
endif()

#if(NOT EXISTS "${cygpath_exe}")
#	dk_depend(git)
#	dk_findProgram(cygpath_exe cygpath.exe "${GIT_DIR_}/../../../")
#endif()
if(NOT EXISTS "${cygpath_exe}")
	dk_findProgram(cygpath_exe cygpath)
endif()
#if(NOT EXISTS "${cygpath_exe}")
#	dk_printVar(DKSHELL)
#	execute_process(COMMAND $ENV{DKSHELL} -c "command -v cygpath" OUTPUT_VARIABLE cygpath_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
#endif()

####### CHECK cygpath_exe ######
if(EXISTS "${cygpath_exe}")
	dk_set(cygpath_exe "${cygpath_exe}")
else()
	dk_fatal("cygpath_exe:${cygpath_exe} not found")
endif()
