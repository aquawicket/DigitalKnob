include_guard()
message(STATUS "****** LOADING: ${CMAKE_CURRENT_LIST_FILE} ******")

##################################################################################
# dk_Call(func) parameters
#
#	call a function and pass arguments
#
#	@func	- TODO
#
macro(dk_call func) #parameters
	dk_cmakeLanguage("${func}($ARGN)")
endmacro()
