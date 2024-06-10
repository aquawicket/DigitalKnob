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
		if [ -z ${_string_-} ]; then
			_string_="${arry[$i]}"
		else
		    _string_="${_string_}${2}${arry[$i]}"
		fi
	done

	rtn_var="${_string_}"
	eval "$3=${rtn_var}"
}




DKTEST () { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	array[0]="a"
	array[1]="b"
	array[2]="c"
	array[3]="d"
	array[4]="e"
	
	dk_arrayJoin array "," string
	echo "string = ${string}"
}
