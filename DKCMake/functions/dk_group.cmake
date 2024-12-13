#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

set(group_funcs "")
set(group_level 0)
set(group_label 0)
################################################################################
# console.group()
# console.group(label)
#
#    https://developer.mozilla.org/en-US/docs/Web/API/console/group_static
#
function(dk_group)
	dk_debugFunc(0 1)
	set(group_label "${ARGV}")
  
	if(NOT DEFINED group_level)
		dk_set(group_level 0)
	else()
		math(EXPR group_level "${group_level}+1")
	endif()
	set(group_level ${group_level} PARENT_SCOPE)
	set(group_label ${group_label} PARENT_SCOPE)

	foreach(func in group_funcs)
		message("group_func: ${func}")
	endforeach()
endfunction()

function(addGroupFunction func)
	list(APPEND group_funcs ${func})
endfunction()




function(onGroup)
	message("onGroup()")
endfunction()

function(dk_echo)
	dk_debugFunc(1)
	
	unset(indent)
	foreach(i RANGE ${group_level})
		if(${i} GREATER 0)
			set(indent "${indent}    ")
		endif()
	endforeach()
	
	message("${indent}${ARGV}")
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	
	addGroupFunction("onGroup")
	
	dk_echo("ROOT")
	
		dk_group()
		dk_echo("Group ${group_level}")
		dk_groupEnd()
			
		dk_group()
		dk_echo("Group ${group_level}")
			dk_group()
			dk_echo("Group ${group_level}")
			dk_groupEnd()
		dk_groupEnd()
		
		dk_group()
		dk_echo("Group ${group_level}")
			dk_group()
			dk_echo("Group ${group_level}")
				dk_group()
				dk_echo("Group ${group_level}")
			dk_groupEnd()
		dk_groupEnd()	

	dk_echo("/ROOT")
endfunction()
