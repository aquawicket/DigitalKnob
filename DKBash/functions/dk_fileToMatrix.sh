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
# dk_fileToMatrix(path associative_array)
#
#
dk_fileToMatrix() {
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
	
	###### return ######
	#[ ${#} -gt 1 ] && eval ${2}='array' && return  	# return using parameter rtn_var
	#dk_return "${array[@]}" && return							# FIXME
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

	declare -A myArray
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR"
	dk_call dk_fileToMatrix "${DKBRANCH_DIR}/build_list.txt" myArray
	#dk_call dk_printVar myArray
	
	echo "${myArray[0,0]:0:1}"
	echo "myArray[0,0] = ${myArray[0,0]}"
	echo "myArray[1,1] = ${myArray[1,1]}"
	echo "myArray[2,2] = ${myArray[2,2]}"
	
	for key in "${!myArray[@]}"; do
		echo "$key: ${myArray[$key]}"
	done
}	
