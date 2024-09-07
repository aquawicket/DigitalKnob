include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_readCache()
#
#
function(dk_readCache APP TARGET_OS TYPE)
	dk_debugFunc(${ARGV})
#	if(NOT ${ARGC} EQUAL 3)
#		dk_fatal("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
#	endif()
	
	dk_validate(DKBRANCH_DIR "dk_validateBranch()")
	if(NOT EXISTS "${DKBRANCH_DIR}/cache")
		return()
	endif()
	dk_unset(_APP_)
	dk_unset(_TARGET_OS_)
	dk_unset(_TYPE_)
	
	dk_echo("reading cache...")
	set(count 0)
#	while read p; do
#		[ "${count}" = "0" ] && _APP_=$(builtin echo "${p}" | tr -d '\r')
#		[ "${count}" = "1" ] && _TARGET_OS_=$(builtin echo "${p}" | tr -d '\r')
#		[ "${count}" = "2" ] &&	_TYPE_=$(builtin echo "${p}" | tr -d '\r')
#		#[ "${count}" = "3" ] && _DKENV_=$(echo ${p} | tr -d '\r')
#		count=$((count + 1))
#	done < "${DKBRANCH_DIR}"/cache

	file(STRINGS "${DKBRANCH_DIR}/cache" lines)
	foreach(line ${lines})
		if(${count} EQUAL 0)
			set(_APP_ ${line})
		endif()
		if(${count} EQUAL 1)
			set(_TARGET_OS_ ${line})
		endif()
		if(${count} EQUAL 2)
			set(_TYPE_ ${line})
		endif()
		math(EXPR count "${count}+1")
	endforeach()
	
	#dk_echo("_APP_ = ${_APP_}, _TARGET_OS_ = ${_TARGET_OS_}, _TYPE_ = ${_TYPE_}")
	set(${APP}       ${_APP_}       PARENT_SCOPE)
	set(${TARGET_OS} ${_TARGET_OS_} PARENT_SCOPE)
	set(${TYPE}      ${_TYPE_}      PARENT_SCOPE)
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_readCache(APP TARGET_OS TYPE)
	#dk_printVar(APP)
	#dk_printVar(TARGET_OS)
	#dk_printVar(TYPE)
endfunction()
