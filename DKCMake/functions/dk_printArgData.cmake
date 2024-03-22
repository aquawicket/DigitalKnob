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
	dk_debug(CMAKE_CURRENT_LIST_DIR		PRINTVAR)
	dk_debug("*** ARG Variables ***")
	dk_debug(ARGC	PRINTVAR)
	dk_debug(ARGN	PRINTVAR)
	dk_debug(ARGV	PRINTVAR)
	dk_debug(ARGV0	PRINTVAR)
	dk_debug(ARGV1	PRINTVAR)
	math(EXPR ARGC_LAST "${ARGC}-1")
	dk_debug(ARGC_LAST	PRINTVAR)
	set(ARGV_LAST ${ARGV${ARGC_LAST}})
	dk_debug(ARGV_LAST	PRINTVAR)
	dk_debug(" ")
endmacro()