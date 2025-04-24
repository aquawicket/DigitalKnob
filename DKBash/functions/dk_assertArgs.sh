<<<<<<< HEAD
#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"
=======
#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"
>>>>>>> Development

##################################################################################
# dk_assertArgs()
#
#
dk_assertArgs() {
	#dk_debugFunc 0
	
	# frame 1 holds the argument checking information
	dk_call dk_echo "dk_assertArgs:FUNCTION = $(__FUNCTION__ 1)"
	dk_call dk_echo "dk_assertArgs:ARGC = $(__ARGC__ 1)"
	dk_call dk_echo "dk_assertArgs:ARGV = $(__ARGV__ 1)"
	
	# frame 2 holds the arguments to check against
	dk_call dk_echo ""
	dk_call dk_echo "dk_assertArgs:FUNCTION = $(__FUNCTION__ 2)"
	dk_call dk_echo "dk_assertArgs:ARGC = $(__ARGC__ 2)"
	dk_call dk_echo "dk_assertArgs:ARGV = $(__ARGV__ 2)"
	
	# check if we have less than the minimum argument count
	# ARGC - optional args = min arg count
	ARGV=($(__ARGV__ 1))
	minimumArgCount=$(__ARGC__ 1)
	for ((i=0; i < ${#ARGV[@]}; i++ )); do
	    [ "${ARGV[${i}]}" = "optional" ] && minimumArgCount=$((minimumArgCount-1))
	done
	dk_call dk_echo "dk_assertArgs:minimumArgCount = ${minimumArgCount}"
	if [ $(__ARGC__ 2) -lt ${minimumArgCount} ]; then
		dk_call dk_error "$(__FUNCTION__ 2)($(__ARGV__ 2)): not enough arguments. Minimum is $(__ARGC__ 1)"
	fi
	
	# check if we have exceeded the maximum argument count
	maximumArgCount=$(__ARGC__ 1)
	dk_call dk_echo "dk_assertArgs:maximumArgCount = ${maximumArgCount}"
	if [ $(__ARGC__ 2) -gt ${maximumArgCount} ]; then
		dk_call dk_error "$(__FUNCTION__ 2)($(__ARGV__ 2)): too many arguments. Max is $(__ARGC__ 1)"
	fi
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
test_function() {
	dk_debugFunc 3
	
	dk_call dk_assertArgs int string optional
}


DKTEST() { 
	dk_debugFunc 0

	test_function 123 abc
}	