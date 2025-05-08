#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


################################################################################
# dk_fileToGrid(path associative_array)
#
#
dk_fileToGrid() {
	dk_debugFunc 2

	OLDIFS=${IFS}
	IFS=$'\n' read -d '' -r -a lines < ${1} || $(true)
	
	local -n array=$2
	row=0
	for line in "${lines[@]}"
	do
		# WARNING: This does not get the last word correctly on files with CRLF line endings
		IFS=$'\t' read -r -a words <<< "${line}"
		read -a words <<< "${line}"
		column=0
		for word in "${words[@]}"
		do
			array[$row,$column]=${word}
			((column+=1))
		done
		((row+=1))
	done
	IFS=${OLDIFS}
	
	### return value ###
	#[ ${#} -gt 1 ] && eval ${2}='array' && return  	# return using parameter rtn_var
	#dk_return "${array[@]}" && return							# FIXME
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

	declare -A myArray
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR"
	dk_call dk_fileToGrid "${DKBRANCH_DIR}/build_list.txt" myArray
	#dk_call dk_printVar myArray
	
	echo "${myArray[0,0]:0:1}"
	echo "myArray[0,0] = ${myArray[0,0]}"
	echo "myArray[1,1] = ${myArray[1,1]}"
	echo "myArray[2,2] = ${myArray[2,2]}"
	
	for key in "${!myArray[@]}"; do
		echo "$key: ${myArray[$key]}"
	done
}	
