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
# dk_getFiles(<path> <output>)
#
#   reference: https://stackoverflow.com/a/21668536/688352
#
dk_getFiles() {
	dk_debugFunc 1 2;
	
	contents=($1/*);

	# Fill dk_getFiles with FILES from contents
	dk_getFiles=();
	for ((i=0; i<${#contents[@]}; i++)); do
		if [[ -f ${contents[$i]} ]]; then
			dk_getFiles+=(${contents[$i]})
		fi
	done
	
	dk_getFiles=("${dk_getFiles[@]##*/}")   # This removes the path prefix, leaving just the file names

	### Loop counter through the array
	#for ((i=0; i<${#dk_getFiles[@]}; i++)); do
	#	echo "dk_getFiles[$i] = ${dk_getFiles[$i]}"
	#done
	
	### Iterate through the array
	#for f in "${dk_getFiles[@]}"; do
	#	echo "$f";
	#done
	
	###### return ######
	eval dk_getFiles='("${dk_getFiles[@]}")';
	if [ -n "${2-}" ]; then
		eval ${2-}='("${dk_getFiles[@]}")';
	else
		builtin echo "${dk_getFiles[@]}";
	fi
	return $?;
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0;
	
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR";
	echo "";
	echo "### Result as global variable"
	dk_call dk_getFiles "${DKBRANCH_DIR}";
	for ((i=0; i<${#dk_getFiles[@]}; i++)); do
		echo "dk_getFiles[$i] = ${dk_getFiles[$i]}"
	done

	echo "";
	echo "### Result as variable parameter"
	dk_call dk_getFiles "${DKBRANCH_DIR}" resultB;
	for ((i=0; i<${#resultB[@]}; i++)); do
		echo "resultB[$i] = ${resultB[$i]}"
	done
	
	echo "";
	echo "### Result as return value"
	resultC=($(dk_call dk_getFiles "${DKBRANCH_DIR}"));
	for ((i=0; i<${#resultC[@]}; i++)); do
		echo "resultC[$i] = ${resultC[$i]}"
	done
}
