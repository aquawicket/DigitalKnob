#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_convertToCIdentifier(<input> <output>)
#
#
dk_convertToCIdentifier () {
	dk_debugFunc
	[ $# -ne 2 ] && dk_error "${FUNCNAME}(): incorrect number of arguments"
	
	output="${1//[^[:alnum:]]/_}"			    # BASH alpha_numeric_replace
#	dk_replaceAll "${input}" "-" "_" input		# POSIX replace
#	dk_replaceAll "${input}" "." "_" output		# POSIX replace
#	dk_replaceAll "${input}" " " "_" output		# POSIX replace
#	dk_replaceAll "${input}" "=" "_" output		# POSIX replace
#	dk_replaceAll "${input}" ";" "_" output		# POSIX replace
#	dk_replaceAll "${input}" "," "_" output		# POSIX replace
#	dk_replaceAll "${input}" "!" "_" output		# POSIX replace
#	dk_replaceAll "${input}" "@" "_" output		# POSIX replace
#	dk_replaceAll "${input}" "#" "_" output		# POSIX replace
#	dk_replaceAll "${input}" "$" "_" output		# POSIX replace
#	dk_replaceAll "${input}" "%" "_" output		# POSIX replace
#	dk_replaceAll "${input}" "^" "_" output		# POSIX replace
#	dk_replaceAll "${input}" "^" "_" output		# POSIX replace
#	dk_replaceAll "${input}" "&" "_" output		# POSIX replace
#	dk_replaceAll "${input}" "*" "_" output		# POSIX replace
#	dk_replaceAll "${input}" "(" "_" output		# POSIX replace
#	dk_replaceAll "${input}" ")" "_" output		# POSIX replace
#	dk_replaceAll "${input}" "+" "_" output		# POSIX replace
#	dk_replaceAll "${input}" "|" "_" output		# POSIX replace
#	dk_replaceAll "${input}" ":" "_" output		# POSIX replace
#	dk_replaceAll "${input}" "[" "_" output		# POSIX replace
#	dk_replaceAll "${input}" "]" "_" output		# POSIX replace
#	dk_replaceAll "${input}" "\" "_" output		# POSIX replace
#	dk_replaceAll "${input}" "'" "_" output		# POSIX replace
#	dk_replaceAll "${input}" "." "_" output		# POSIX replace
#	dk_replaceAll "${input}" "/" "_" output		# POSIX replace
#	dk_replaceAll "${input}" "~" "_" output		# POSIX replace
#	dk_replaceAll "${input}" """ "_" output		# POSIX replace
#	dk_replaceAll "${input}" "?" "_" output		# POSIX replace
#	dk_replaceAll "${input}" "<" "_" output		# POSIX replace
#	dk_replaceAll "${input}" ">" "_" output		# POSIX replace
#	dk_replaceAll "${input}" "{" "_" output		# POSIX replace
#	dk_replaceAll "${input}" "}" "_" output		# POSIX replace
#	dk_replaceAll "${input}" "`" "_" output		# POSIX replace
	
	eval "$2='${output}'"
	dk_printVar "${2}"
	#[ ${input} = "" ]
}




DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	# Can't handle these characters yet->    [ ] \ ' . / ~ " ? < > { } `
	myVar="a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0 - = ; , ! @ # $ % ^ & * ( ) _ + | :"
	dk_convertToCIdentifier "${myVar}" myAlphaNumericVar
	echo "myAlphaNumericVar = ${myAlphaNumericVar}"
}