#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-}DK.sh"

################################################################################
# dk_assertPath(path)
#
dk_assertPath() {
    dk_debugFunc 1 99
	
    [ -e "${1}" ] && return 0
	
	# is a valid variable name check
	[[ "$1" =~ ^[a-z][a-zA-Z0-9_]*$ ]] && [ -e "${!1}" ] && return 0
	
	dk_call dk_error "Assertion failed: ${1} is not found!"
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() { 
	dk_debugFunc 0
	
	### UNIX ###
	# unix path
	dk_call dk_assertPath "/c/Program Files/Common Files"		# OK
	dk_call dk_echo "Found /c/Program Files/Common Files"
	
	# windows path (UPPER CASE)
	dk_call dk_assertPath "/C/PROGRAM FILES/COMMON FILES"		# OK
	dk_call dk_echo "Found /C/PROGRAM FILES/COMMON FILES"
	
	# lower case
	dk_call dk_assertPath "/c/program files/common files"		# OK
	dk_call dk_echo "Found /c/program files/common files"
	
	### As Variable ###
    dk_call dk_set myPath "/c/Program Files/Common Files"
	
	# As a variable with %_%
    dk_call dk_assertPath "${myPath}"							# OK
	dk_call dk_echo "Found ${myPath}"	
	
	# As a variable name
    dk_call dk_assertPath myPath								# OK
	dk_call dk_echo "Found myPath"
	
	# As a variable name quoted
    dk_call dk_assertPath "myPath"								# OK
	dk_call dk_echo "Found myPath"
	
	
	### Windows ###
	# CMD.exe
	dk_call dk_assertPath "${COMSPEC}"							# OK
	dk_call dk_echo "Found ${COMSPEC}"
	
	# windows path
	dk_call dk_assertPath "C:\Program Files\Common Files"		# OK
	dk_call dk_echo "Found C:\Program Files\Common Files"
	
	# windows path (foward slashes)
	dk_call dk_assertPath "C:/Program Files/Common Files"		# OK
	dk_call dk_echo "Found C:/Program Files/Common Files"
	
	
	### ASSERTS ###
	# non existent
    dk_call dk_assertPath "C:/NonExistentPath"					# ASSERT
	dk_call dk_echo "Found C:/NonExistentPath"

	# unix path (backslashes)
	dk_call dk_assertPath "\c\Program Files\Common Files"		# ASSERT
	dk_call dk_echo "Found \c\Program Files\Common Files"
	
	# No quotes
	dk_call dk_assertPath /C/PROGRAM FILES/COMMON FILES			# ASSERT
	dk_call dk_echo "Found /C/PROGRAM FILES/COMMON FILES"
	
	# As a variable with ${_} without quotes
	dk_call dk_assertPath ${myPath}								# ASSERT
	dk_call dk_echo "Found ${myPath}"	
}
