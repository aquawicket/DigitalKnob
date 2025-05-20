#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "../../../DKCMake/functions/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")

message("cygpath/DKINSTALL.cmake")
dk_validate(Host_Os "dk_HostOs()")
############ cygpath ############
if(NOT Windows_Host)
	dk_undepend(cygpath)
	dk_return()
endif()

if(EXISTS "${CYGPATH_EXE}")
	message("CYGPATH_EXE:'${CYGPATH_EXE}' already exists")
	dk_return()
endif()

###### GET CYGPATH_EXE ######
if(NOT EXISTS "${CYGPATH_EXE}")
	dk_validate(MSYS2 "dk_depend(msys2)")
	dk_findProgram(CYGPATH_EXE cygpath.exe "${MSYS2_DIR}/usr/bin")
endif()

if(NOT EXISTS "${CYGPATH_EXE}")
	dk_depend(git)
	dk_findProgram(CYGPATH_EXE cygpath.exe "${GIT}/usr/bin")
endif()

#if(NOT EXISTS "${CYGPATH_EXE}")
#	dk_depend(git)
#	dk_findProgram(CYGPATH_EXE cygpath.exe "${GIT_DIR_}/../../../")
#endif()
if(NOT EXISTS "${CYGPATH_EXE}")
	dk_findProgram(CYGPATH_EXE cygpath)
endif()
#if(NOT EXISTS "${CYGPATH_EXE}")
#	dk_printVar(DKSHELL)
#	execute_process(COMMAND $ENV{DKSHELL} -c "command -v cygpath" OUTPUT_VARIABLE CYGPATH_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
#endif()

####### CHECK CYGPATH_EXE ######
if(EXISTS "${CYGPATH_EXE}")
	dk_set(CYGPATH_EXE "${CYGPATH_EXE}")
else()
	dk_fatal("CYGPATH_EXE:${CYGPATH_EXE} not found")
endif()
