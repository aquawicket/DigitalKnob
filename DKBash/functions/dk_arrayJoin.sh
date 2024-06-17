#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

################################################################################
# dk_arrayJoin(array, separator, string)
#
#    https://www.w3schools.com/js/js_array_methods.asp#mark_join
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/join
#
dk_arrayJoin () {
	dk_debugFunc
	[ $# -ne 3 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	#_arry_="$1"
	#_separator_="$2"
	
	#local arry=("${!1}")
	typeset -n arry=$1 
	for ((i=0; i < ${#arry[@]}; i++ )); do
		if [ -z ${rtn_var-} ]; then
			rtn_var="${arry[$i]}"
		else
		    rtn_var="${rtn_var}${2}${arry[$i]}"
		fi
	done
	
	eval "$3=${rtn_var}"
}




DKTEST () { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	myArray[0]="a"
	myArray[1]="b"
	myArray[2]="c"
	myArray[3]="d"
	myArray[4]="e"
	
	dk_arrayJoin myArray "," myString
	echo "myString = ${myString}"
}
