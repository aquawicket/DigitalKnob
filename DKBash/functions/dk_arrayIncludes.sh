#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DKINIT_sh-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export cmd_exe=$(command -v 'cmd.exe')									&& echo "cmd_exe = ${cmd_exe}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($cmd_exe /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export bash_exe=$(command -v bash)										&& echo "bash_exe = ${bash_exe}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/Digital Knob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${bash_exe}" ]				&& exec "${bash_exe}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


################################################################################
# dk_arrayIncludes(array, searchElement)
# dk_arrayIncludes(array, searchElement, fromIndex)
#
#    The includes() method of Array instances determines whether an array includes a certain value among its entries, returning true or false as appropriate.
#
#    PARAMETERS
#    searchElement
#        The value to search for.
#
#    fromIndex :optional
#        Zero-based index at which to start searching, converted to an integer.
#            Negative index counts back from the end of the array — if -array.length <= fromIndex < 0, fromIndex + array.length is used. However, 
#            the array is still searched from front to back in this case.
#            If fromIndex < -array.length or fromIndex is omitted, 0 is used, causing the entire array to be searched.
#            If fromIndex >= array.length, the array is not searched and false is returned.
#
#    RETURN VALUE
#    A boolean value which is true if the value searchElement is found within the array (or the part of the array indicated by the index fromIndex, if specified).
#
#    REFERENCE
#    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/includes
#
dk_arrayIncludes() {
	dk_debugFunc 2 3
	#dk_call dk_validateArgs array string
	
	eval local array='("${'$1'[@]}")'			#typeset -n array=${1}
	local searchElement="${2}"
	[ -n "${3-}" ] && local fromIndex=${3-} || local fromIndex=0
	
	for ((index=${fromIndex}; index < ${#array[@]}; index++ )); do
		if [ "${searchElement}" = "${array[${index}]}" ]; then
			
			### return true ###
			eval dk_arrayIncludes="true"
			return $($dk_arrayIncludes)
		fi
	done
	
	### return false ###
	eval dk_arrayIncludes='false'
    set +o errexit
	trap '' ERR
	return $($dk_arrayIncludes) & set -o errexit
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	myArray=(1 2 3 NaN)
	dk_call dk_arrayIncludes myArray 2 1
	dk_call dk_printVar dk_arrayIncludes
	[ "$dk_arrayIncludes" = "true" ] && dk_call dk_success "dk_arrayIncludes() suceeded" || dk_call dk_echo "dk_arrayIncludes() failed"
	$($dk_arrayIncludes) && dk_call dk_success "dk_arrayIncludes() suceeded" || dk_call dk_echo "dk_arrayIncludes() failed"
	
	dk_call dk_arrayIncludes myArray 4
	dk_call dk_printVar dk_arrayIncludes
	[ "$dk_arrayIncludes" = "false" ] && dk_call dk_success "dk_arrayIncludes() suceeded" || dk_call dk_echo "dk_arrayIncludes() failed"
	$($dk_arrayIncludes) && dk_call dk_echo "dk_arrayIncludes() failed" || dk_call dk_success "dk_arrayIncludes() suceeded"
	
	dk_call dk_arrayIncludes myArray NaN
	dk_call dk_printVar dk_arrayIncludes
	[ "$dk_arrayIncludes" = "true" ] && dk_call dk_success "dk_arrayIncludes() suceeded" || dk_call dk_echo "dk_arrayIncludes() failed"
	$($dk_arrayIncludes) && dk_call dk_success "dk_arrayIncludes() suceeded" || dk_call dk_echo "dk_arrayIncludes() failed"
	
	myArrayB=("1" "2" "3")
	dk_call dk_arrayIncludes myArrayB 3
	dk_call dk_printVar dk_arrayIncludes
	[ "$dk_arrayIncludes" = "false" ] && dk_call dk_success "dk_arrayIncludes() suceeded" || dk_call dk_echo "dk_arrayIncludes() failed"
	$($dk_arrayIncludes) && dk_call dk_echo "dk_arrayIncludes() failed" || dk_call dk_success "dk_arrayIncludes() suceeded"
}
