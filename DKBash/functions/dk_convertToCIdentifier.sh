#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

##################################################################################
# dk_convertToCIdentifier(<input> <output>)
#
#
dk_convertToCIdentifier() {
	dk_debugFunc 2

	output="${1//[^[:alnum:]]/_}"			    # BASH alpha_numeric_replace
#	dk_call dk_replaceAll "${input}" "-" "_" input		# POSIX replace
#	dk_call dk_replaceAll "${input}" "." "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" " " "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "=" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" ";" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "," "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "!" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "@" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "#" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "$" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "%" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "^" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "^" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "&" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "*" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "(" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" ")" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "+" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "|" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" ":" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "[" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "]" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "\" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "'" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "." "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "/" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "~" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" """ "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "?" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "<" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" ">" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "{" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "}" "_" output		# POSIX replace
#	dk_call dk_replaceAll "${input}" "`" "_" output		# POSIX replace
	
	eval "${2}='${output}'"
	dk_call dk_printVar "${2}"
	#[ ${input} = "" ]
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	# Can't handle these characters yet->    [ ] \ ' . / ~ " ? < > { } `
	myVar="a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0 - = ; , ! @ # $ % ^ & * ( ) _ + | :"
	dk_call dk_convertToCIdentifier "${myVar}" myAlphaNumericVar
	dk_call dk_echo "myAlphaNumericVar = ${myAlphaNumericVar}"
}
