#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_readCache()
#
#
function(dk_readCache)
#	dk_debugFunc(3)
	
	dk_validate(ENV{DKCACHE_DIR} "dk_DKCACHE_DIR()")
	if(NOT EXISTS "$ENV{DKCACHE_DIR}/DKBuilder.cache")
		dk_return()
	endif()
	#dk_unset(Target_App_Cache)
	#dk_unset(Target_Tuple_Cache)
	#dk_unset(_target_type_)
	
	dk_echo("reading DKBuilder.cache...")
	set(count 0)
#	while read p; do
#		[ "${count}" = "0" ] && Target_App_Cache=$(builtin echo "${p}" | tr -d '\r')
#		[ "${count}" = "1" ] && Target_Tuple_Cache=$(builtin echo "${p}" | tr -d '\r')
#		[ "${count}" = "2" ] &&	_target_type_=$(builtin echo "${p}" | tr -d '\r')
#		[ "${count}" = "3" ] && _target_env_=$(echo ${p} | tr -d '\r')
#		count=$((count + 1))
#	done < "$ENV{DKCACHE_DIR}"/DKBuilder.cache

#	file(STRINGS "$ENV{DKCACHE_DIR}/DKBuilder.cache" lines)
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
	
	#dk_echo("target_app = ${Target_App}, Target_Tuple = ${Target_Tuple}, target_type = ${Target_Type}")
	#set(${Target_App}		"${Target_App}")
	#set(${Target_Tuple} 	"${Target_Tuple}")
	#set(${Target_Type}		"${Target_Type}")
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	#dk_readCache(target_app Target_Tuple target_type)
	#dk_printVar(target_app)
	#dk_printVar(Target_Tuple)
	#dk_printVar(Target_Type)
endfunction()
