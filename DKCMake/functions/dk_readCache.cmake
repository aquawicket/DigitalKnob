#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_readCache()
#
#
function(dk_readCache)
#	dk_debugFunc(3)
	
	dk_validate(DKCACHE_DIR "dk_DKCACHE_DIR()")
	if(NOT EXISTS "${DKCACHE_DIR}/cache")
		dk_return()
	endif()
	#dk_unset(_APP_)
	#dk_unset(_target_triple_)
	#dk_unset(_DKBUILD_TYPE_)
	
	dk_echo("reading cache...")
	set(count 0)
#	while read p; do
#		[ "${count}" = "0" ] && _APP_=$(builtin echo "${p}" | tr -d '\r')
#		[ "${count}" = "1" ] && _target_triple_=$(builtin echo "${p}" | tr -d '\r')
#		[ "${count}" = "2" ] &&	_DKBUILD_TYPE_=$(builtin echo "${p}" | tr -d '\r')
#		#[ "${count}" = "3" ] && _DKENV_=$(echo ${p} | tr -d '\r')
#		count=$((count + 1))
#	done < "${DKCACHE_DIR}"/cache

#	file(STRINGS "${DKCACHE_DIR}/cache" lines)
#	foreach(line ${lines})
#		if(${count} EQUAL 0)
#			set(${ARGV0} ${line})
#		endif()
#		if(${count} EQUAL 1)
#			set(${ARGV1} ${line})
#		endif()
#		if(${count} EQUAL 2)
#			set(${ARGV2} ${line})
#		endif()
#		math(EXPR count "${count}+1")
#	endforeach()
	
	#dk_echo("APP = ${APP}, target_triple = ${target_triple}, DKBUILD_TYPE = ${DKBUILD_TYPE}")
	#set(${APP}				"${APP}")
	#set(${target_triple} 	"${target_triple}")
	#set(${DKBUILD_TYPE}	"${DKBUILD_TYPE}")
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	#dk_readCache(APP target_triple DKBUILD_TYPE)
	#dk_printVar(APP)
	#dk_printVar(target_triple)
	#dk_printVar(DKBUILD_TYPE)
endfunction()
