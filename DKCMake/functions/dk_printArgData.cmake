include_guard()

###############################################################################
# dk_printArgData()
#
#	Print the current CMake scripte path and ARG* variables
#
macro(dk_printArgData)
	DKDEBUGFUNC(${ARGV})
	dk_debug(" ")
	dk_debug("************************************************************")
	dk_debug(" ")
	dk_debug(CMAKE_CURRENT_LIST_DIR)
	dk_debug("*** ARG Variables ***")
	dk_debug(ARGC)
	dk_debug(ARGN)
	dk_debug(ARGV)
	dk_debug(ARGV0)
	dk_debug(ARGV1)
	math(EXPR ARGC_LAST "${ARGC}-1")
	dk_debug(ARGC_LAST)
	set(ARGV_LAST ${ARGV${ARGC_LAST}})
	dk_debug(ARGV_LAST)
	dk_debug(" ")
endmacro()