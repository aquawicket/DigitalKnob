@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::################################################################################
::dk_findProgram (<VAR> name [path1 path2 ...])
::#
::#
:dk_findProgram
	call dk_debugFunc
	set "VAR=%~1"
	set "VAL=!%VAR%!"
	set "name=%~2"
	
	if exist "%VAL%" call dk_debug("already FOUND %name% at %VAL%") && goto:eof

::	if("${${VAR}}" STREQUAL "${VAR}-NOTFOUND")
::		set(${VAR}_second_pass 1)
::	endif()
::	
::	if(${VAR})
::		dk_error("error {VAR} already set to ${VAR}")
::	endif()
::	
::	if(ARGN)
::		dk_getSubdirectories("${ARGN}" SEARCH_DIRS) # Recursive search
::		list(REMOVE_DUPLICATES SEARCH_DIRS)
::	endif()
::	if(SEARCH_DIRS)
::		dk_info("Searching Provided Paths recursivley with NO_DEFAULT_PATH set . . .")
::		#dk_debug("find_program(${VAR} ${name} ${ARGN};${SEARCH_DIRS} NO_DEFAULT_PATH)")
::		find_program(${VAR} ${name} ${ARGN};${SEARCH_DIRS} NO_DEFAULT_PATH NO_SYSTEM_ENVIRONMENT_PATH)
::	elseif(ARGN)
::		dk_info("Searching Provided Path with NO_DEFAULT_PATH set . . .")
::		dk_info("find_program(${VAR} ${name} ${ARGN} NO_DEFAULT_PATH)")
::		#dk_debug("find_program(${VAR} ${name} ${ARGN} NO_DEFAULT_PATH)")
::		find_program(${VAR} ${name} ${ARGN} NO_DEFAULT_PATH NO_SYSTEM_ENVIRONMENT_PATH)
::	else()
::		dk_info("Searching Default Paths. . .")
::		find_program(${VAR} ${name})
::	endif()
::	
::	if(EXISTS ${${VAR}})
::		dk_info("FOUND ${name} at ${${VAR}}")
::		dk_set(${VAR} "${${VAR}}")
::		set(${VAR} "${${VAR}}" PARENT_SCOPE)
::		return()
::	elseif(${VAR}_second_pass)
::		dk_error("COULD NOT FIND ${name}")
::		return()
::	endif()
::	
::	dk_notice("COULD NOT FIND ${name}")
::	set(${VAR} "${${VAR}}" PARENT_SCOPE)
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc

	call dk_findProgram POWERSHELL_EXE "pwsh.exe"
goto:eof
