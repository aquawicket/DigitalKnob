#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_readCache()
#
#
function(dk_readCache)
#	dk_debugFunc(3)
	
	dk_validate(DKCACHE_DIR "dk_DKCACHE_DIR()")
	if(NOT EXISTS "${DKCACHE_DIR}/DKBuilder.cache")
		dk_return()
	endif()
	#dk_unset(_target_app_)
	#dk_unset(_target_triple_)
	#dk_unset(_target_type_)
	
	dk_echo("reading DKBuilder.cache...")
	set(count 0)
#	while read p; do
#		[ "${count}" = "0" ] && _target_app_=$(builtin echo "${p}" | tr -d '\r')
#		[ "${count}" = "1" ] && _target_triple_=$(builtin echo "${p}" | tr -d '\r')
#		[ "${count}" = "2" ] &&	_target_type_=$(builtin echo "${p}" | tr -d '\r')
#		[ "${count}" = "3" ] && _target_env_=$(echo ${p} | tr -d '\r')
#		count=$((count + 1))
#	done < "${DKCACHE_DIR}"/DKBuilder.cache

#	file(STRINGS "${DKCACHE_DIR}/DKBuilder.cache" lines)
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
	
	#dk_echo("target_app = ${target_app}, target_triple = ${target_triple}, target_type = ${target_type}")
	#set(${target_app}		"${target_app}")
	#set(${target_triple} 	"${target_triple}")
	#set(${target_type}		"${target_type}")
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	#dk_readCache(target_app target_triple target_type)
	#dk_printVar(target_app)
	#dk_printVar(target_triple)
	#dk_printVar(target_type)
endfunction()
