#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

#################################################################################


################################################################################
# dk_listToArray(<list>, <rtn_var:OPTIONAL>)
#
#
dk_listToArray() {
    dk_debugFunc 2
    
	OLDIFS=${IFS}
	IFS=";"
	arr=($1)
	IFS=${OLDIFS}
	#for i in ${arr[@]}; do echo $i; done
	
	### return value ###
	[ ${#} -gt 1 ] && eval ${2}='("${arr[@]}")' && return
	
	# TODO
	#dk_return "${arr[@]}" && return	
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

    dk_call dk_set myList "a;b;c;d;e;f;g"
	dk_call dk_printVar myList
    dk_call dk_listToArray "${myList}" myArrayA
	dk_call dk_printVar myArrayA
	
	dk_call dk_set myListB "https:;;github.com;notepad-plus-plus;notepad-plus-plus;releases;download;v8.6.5;npp.8.6.5.portable.x64.zip"
	dk_call dk_printVar myListB
	dk_call dk_listToArray "${myListB}" myArrayB
    dk_call dk_printVar myArrayB

#	TODO	
#	dk_call dk_set myListC "a;b;c;d;e;f;g"
#	dk_call dk_printVar myListC
#	myArrayC=($(dk_call dk_listToArray "${myListC}"))
#   dk_call dk_printVar myArrayC
}
