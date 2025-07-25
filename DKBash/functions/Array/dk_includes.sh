#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)      || export PATH=/bin
	(command -v 'cygpath' 1>/dev/null) && HOME=$(cygpath -u $USERPROFILE)                                 && echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null) && CMD_EXE=$(command -v 'cmd.exe')                                 && echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]            && USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')      && echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null) && HOME=$(wslpath -u ${USERPROFILE})                               && echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)    && export BASH_EXE=$(command -v bash)                              && echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]                  || export DK_SH="$(dirname $(dirname $0))/DK.sh"                   && echo "DK_SH = ${DK_SH}"
	[ -e "${DK_SH}" ]                  || export DK_SH=$(find "${HOME}" -name "DK.sh")                    && echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]               && exec "${BASH_EXE}" "${DK_SH}" "$0" $* || exec "${DK_SH}" "$0" $*
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
	
	eval local array='("${'$1'[@]}")';
	for ((index=0; index < ${#array[@]}; index++ )); do
		[ "${2}" = "${array[${index}]}" ] && return $(true);
	done
	return $(false);
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	array123=(1 2 3)
	dk_call dk_arrayIncludes array123 2     && echo "'array123' includes '2' = true"     || echo "'array123' includes '2' = false";
	dk_call dk_arrayIncludes array123 4     && echo "'array123' includes '4' = true"     || echo "'array123' includes '4' = false";
	#dk_call dk_arrayIncludes array123 3 3  && echo "'array123' includes '3 3' = true"   || echo "'array123' includes '3 3' = false";
	#dk_call dk_arrayIncludes array123 3 -1 && echo "'array123' includes '3 -1' = true"  || echo "'array123' includes '3 -1' = false";
	array12NaN=(1 2 NaN);
	dk_call dk_arrayIncludes array12NaN NaN && echo "'array12NaN' includes 'NaN' = true" || echo "'array12NaN' includes 'NaN' = false";
	array123q=("1" "2" "3");
	dk_call dk_arrayIncludes array123q 3    && echo "'array123q' includes '3' = true"    || echo "'array123q' includes '3' = false";
}
