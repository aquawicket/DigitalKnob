#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}")
	file(TO_CMAKE_PATH "$ENV{USERPROFILE}$ENV{HOME}/digitalknob/Development/DKCMake/functions" DKCMAKE_FUNCTIONS_DIR)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "$ENV{DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()


###############################################################################
# dk_envList(<name> PUSH value)
# dk_envList(<name> POP)
#
#
function(dk_envList)
	dk_debugFunc()

	set(NAME "${ARGV0}")
	set(CMND "${ARGV1}")
	set(VALUE "${ARGV2}")
	
	# set the CURRENT_<THING>  and push it to the list.
	if("${CMND}" STREQUAL "PUSH")
		set(ENV{CURRENT_${NAME}} "${VALUE}")
		set(ENV{${NAME}_STACK} "$ENV{CURRENT_${NAME}};$ENV{${NAME}_STACK}")
		set(${NAME}_list $ENV{${NAME}_STACK})
		list(LENGTH ${NAME}_list ${NAME}_length)
		dk_notice("TOP=$ENV{CURRENT_${NAME}}       STACK=$ENV{${NAME}_STACK}     LENGTH=${${NAME}_length}")
	endif()

	# Pop the CURRENT_<THING> and drop it fom the list. Update CURRENT_<THING>
	if("${CMND}" STREQUAL "POP")
		set(${NAME}_list $ENV{${NAME}_STACK})
		list(POP_FRONT ${NAME}_list)
		list(LENGTH ${NAME}_list ${NAME}_length)
				
		if(${${NAME}_length} GREATER 0)
			list(GET ${NAME}_list 0 ${NAME}_item)
			set(ENV{CURRENT_${NAME}} ${${NAME}_item})
		else()
			unset(ENV{CURRENT_${NAME}})
		endif()
		set(ENV{${NAME}_STACK} "${${NAME}_list}")
				
		dk_notice("TOP=$ENV{CURRENT_${NAME}}       STACK=$ENV{${NAME}_STACK}     LENGTH=${${NAME}_length}")
	endif()
endfunction()














###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_envList("ABC")
endfunction()

