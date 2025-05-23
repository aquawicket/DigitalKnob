#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

################################################################################
# dk_assertPath(path)
#
dk_assertPath() {
    dk_debugFunc 1
	
    [ -e "${1-}" ] && return 0
	[ -e "${!1-}" ] && return 0
	
	# is a valid variable name check
	[[ "$1" =~ ^[_a-z][a-zA-Z0-9_]*$ ]] && [ -e "${!1}" ] && return 0
	
	[[ "$1" =~ ^[_a-z][a-zA-Z0-9_]*$ ]] && dk_call dk_error "Assertion failed: ${1}:${!1} is not found!" || dk_call dk_error "Assertion failed: path:${1} is not found!"
	return 13
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc 0
	
	### UNIX ###
	# unix path
	dk_call dk_assertPath "/c/Program Files/Common Files"		# OK
	[ $? = 0 ] && dk_call dk_echo "Found /c/Program Files/Common Files"
	
	# windows path (UPPER CASE)
	dk_call dk_assertPath "/C/PROGRAM FILES/COMMON FILES"		# OK
	[ $? = 0 ] && dk_call dk_echo "Found /C/PROGRAM FILES/COMMON FILES"
	
	# lower case
	dk_call dk_assertPath "/c/program files/common files"		# OK
	[ $? = 0 ] && dk_call dk_echo "Found /c/program files/common files"
	
	### As Variable ###
    dk_call dk_set myPath "/c/Program Files/Common Files"
	
	# As a variable with %_%
    dk_call dk_assertPath "${myPath}"							# OK
	[ $? = 0 ] && dk_call dk_echo "Found ${myPath}"	
	
	# As a variable name
    dk_call dk_assertPath myPath								# OK
	[ $? = 0 ] && dk_call dk_echo "Found myPath"
	
	# As a variable name quoted
    dk_call dk_assertPath "myPath"								# OK
	[ $? = 0 ] && dk_call dk_echo "Found myPath"
	
	
	### As _Variable_ ###
    dk_call dk_set _myPath_ "/c/Program Files/Common Files"
	
	# As a variable name
    dk_call dk_assertPath _myPath_								# OK
	[ $? = 0 ] && dk_call dk_echo "Found _myPath_"
	
	### Windows ###
	# CMD.exe
	dk_call dk_assertPath "${COMSPEC}"							# OK
	[ $? = 0 ] && dk_call dk_echo "Found ${COMSPEC}"
	
	# windows path
	dk_call dk_assertPath "C:\Program Files\Common Files"		# OK
	[ $? = 0 ] && dk_call dk_echo "Found C:\Program Files\Common Files"
	
	# windows path (foward slashes)
	dk_call dk_assertPath "C:/Program Files/Common Files"		# OK
	[ $? = 0 ] && dk_call dk_echo "Found C:/Program Files/Common Files"
	
	
	### ASSERTS ###
	# non existent
    dk_call dk_assertPath "C:/NonExistentPath"					# ASSERT
	[ $? = 0 ] && dk_call dk_echo "Found C:/NonExistentPath"

	# unix path (backslashes)
	dk_call dk_assertPath "\c\Program Files\Common Files"		# ASSERT
	[ $? = 0 ] && dk_call dk_echo "Found \c\Program Files\Common Files"
	
	# No quotes
	dk_call dk_assertPath /C/PROGRAM FILES/COMMON FILES			# ASSERT
	[ $? = 0 ] && dk_call dk_echo "Found /C/PROGRAM FILES/COMMON FILES"
	
	# As a variable with ${_} without quotes
	dk_call dk_assertPath ${myPath}								# ASSERT
	[ $? = 0 ] && dk_call dk_echo "Found ${myPath}"	
}
