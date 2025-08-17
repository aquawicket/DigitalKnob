#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export CMD_EXE=$(command -v 'cmd.exe')									&& echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export BASH_EXE=$(command -v bash)										&& echo "BASH_EXE = ${BASH_EXE}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/DigitalKnob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]				&& exec "${BASH_EXE}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


################################################################################
# dk_getDirectories(<path> <output>)
#
#   reference: https://stackoverflow.com/a/138581
#
dk_getDirectories() {
	dk_debugFunc 1 2

	dk_getDirectories=($1/*/);							# This creates an array of the full paths to all subdirs
	dk_getDirectories=("${dk_getDirectories[@]%/}")     # This removes the trailing slash on each item
	dk_getDirectories=("${dk_getDirectories[@]##*/}")   # This removes the path prefix, leaving just the dir names
	
	### Loop counter through the array
	#for ((i=0; i<${#dk_getDirectories[@]}; i++)); do
	#	echo "dk_getDirectories[$i] = ${dk_getDirectories[$i]}"
	#done
	
	### Iterate through the array
	#for f in "${dk_getDirectories[@]}"; do
	#	echo "$f";
	#done
	
	###### output ######
	eval dk_getDirectories='("${dk_getDirectories[@]}")';
	if [ -n "${2-}" ]; then
		eval ${2-}='("${dk_getDirectories[@]}")';
	else
		builtin echo "${dk_getDirectories[@]}";
	fi
	return $?;
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR";
	echo "";
	echo "### Result as global variable"
	dk_call dk_getDirectories "${DKBRANCH_DIR}";
	for ((i=0; i<${#dk_getDirectories[@]}; i++)); do
		echo "dk_getDirectories[$i] = ${dk_getDirectories[$i]}"
	done

	echo "";
	echo "### Result as variable parameter"
	dk_call dk_getDirectories "${DKBRANCH_DIR}" resultB;
	for ((i=0; i<${#resultB[@]}; i++)); do
		echo "resultB[$i] = ${resultB[$i]}"
	done
	
	echo "";
	echo "### Result as return value"
	resultC=($(dk_call dk_getDirectories "${DKBRANCH_DIR}"));
	for ((i=0; i<${#resultC[@]}; i++)); do
		echo "resultC[$i] = ${resultC[$i]}"
	done
}