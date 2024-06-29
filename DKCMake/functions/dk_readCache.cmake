include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_readCache()
#
#
function(dk_readCache)
	dk_debugFunc(${ARGV})
	if(NOT ${ARGC} EQUAL 0)
		dk_error("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()
	
	if(NOT EXISTS "${DKBRANCH_DIR}/cache")
		return()
	endif()
	dk_unset(_APP_)
	dk_unset(_TARGET_OS_)
	dk_unset(_TYPE_)
	
	dk_echo("reading cache...")
	set(count 0)
	
	dk_fixme()
#	while read p; do
#		if [ "${count}" = "0" ]; then 
#			_APP_=$(builtin echo "${p}" | tr -d '\r')
#			#dk_printVar _APP_
#		fi
#		if [ "${count}" = "1" ]; then
#			_TARGET_OS_=$(builtin echo "${p}" | tr -d '\r')
#			#dk_printVar _TARGET_OS_ 
#		fi
#		if [ "${count}" = "2" ]; then
#			_TYPE_=$(builtin echo "${p}" | tr -d '\r')
#			#dk_printVar _TYPE_
#		fi
#		#if [ "${count}" = "3" ]; then
#		#	_DKENV_=$(echo ${p} | tr -d '\r')
#		#	#dk_printVar _DKENV_
#		#fi
#		count=$((count + 1))
#	done < "${DKBRANCH_DIR}"/cache
endfunction()



DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_readCache
}