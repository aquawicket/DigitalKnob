include_guard()

###############################################################################
# dk_set(variable value)
#	
#	https://stackoverflow.com/a/29250496/688352
#
#	@variable	- The name of a variable to declair
#	@value		- The value to set the variable to. 
#
function(dk_set variable)# value)
	#DKDEBUGFUNC(${ARGV})
	
	if(NOT DEFINED ARGV0)
		dk_error("dk_set(!INVALID!): ARGV0 is invalid")
		return()
	endif()
	if(NOT DEFINED ARGV1)
		dk_error("dk_set(${ARGV0} ARGV1): ARGV1 is invalid!")
		return()
	endif()

	#set(${variable} ${value} ${ARGN} CACHE INTERNAL "")
	set(${ARGV} CACHE INTERNAL "")
#	###### print library versions ############
#	dk_includes(${variable} "_VERSION" includes)
#	if(${includes})
#		dk_debug(${variable})
#	endif()
#	##########################################
endfunction()
dk_createOsMacros("dk_set")
