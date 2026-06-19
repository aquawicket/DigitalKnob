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


####################################################################
# DKINSTALL()
#
function(DKINSTALL)
dk_debugFunc(0 1)

	if(NOT Windows_Host)
		dk_disable(cygpath)
		dk_return()
	endif()
	
	### Test if already valid
	if(EXISTS "${cygpath_exe}")
		execute_process(COMMAND ${cygpath_exe} --version RESULT_VARIABLE exit_code OUTPUT_QUIET)
		if(NOT ${exit_code})
			return()
		endif()
	endif()

	if(EXISTS "${cygpath_exe}")
		message("cygpath_exe:'${cygpath_exe}' already exists")
		dk_return()
	endif()

	###### GET cygpath_exe ######
	if(NOT EXISTS "${cygpath_exe}")
		dk_validate(msys2 "dk_depend(msys2)")
		dk_findProgram(cygpath_exe cygpath.exe "${msys2}/usr/bin")
	endif()

	if(NOT EXISTS "${cygpath_exe}")
		dk_validate(git "dk_depend(git)")
		dk_findProgram(cygpath_exe cygpath.exe "${git}/usr/bin")
	endif()

	#if(NOT EXISTS "${cygpath_exe}")
	#	dk_validate(git "dk_depend(git)")
	#	dk_findProgram(cygpath_exe cygpath.exe "${GIT_DIR_}/../../../")
	#endif()
	if(NOT EXISTS "${cygpath_exe}")
		dk_findProgram(cygpath_exe cygpath)
	endif()
	#if(NOT EXISTS "${cygpath_exe}")
	#	dk_debug("DKSHELL = ${DKSHELL}")
	#	execute_process(COMMAND $ENV{DKSHELL} -c "command -v cygpath" OUTPUT_VARIABLE cygpath_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
	#endif()

	####### CHECK cygpath_exe ######
	if(NOT EXISTS "${cygpath_exe}")
		dk_fatal("cygpath_exe:${cygpath_exe} NOT FOUND")
	endif()
	
	### Test command
	execute_process(COMMAND "${cygpath_exe}" --version RESULT_VARIABLE exit_code OUTPUT_QUIET)
	if(${exit_code})
		dk_error("cygpath_exe:${cygpath_exe} failed to run")
		return()
	endif()
	
	dk_set(cygpath_exe "${cygpath_exe}")

endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_envList(PLUGIN POP)
	dk_unset(cygpath_exe)
	
	dk_validate(cygpath_exe "dk_depend(cygpath_exe)")
	dk_debug("cygpath_exe = ${cygpath_exe}")
	
	dk_validate(cygpath_exe "dk_depend(cygpath_exe)")
	dk_debug("cygpath_exe = ${cygpath_exe}")
endfunction()	