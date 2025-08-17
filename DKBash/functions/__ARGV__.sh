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


##################################################################################
# __ARGV__(<frame>)
#
__ARGV__() {
	#dk_debugFunc 0 1
	[ -z ${1-} ] && local frame=0 || local frame=${1}
	
	local marker=0
	for (( i=0; i<frame; i++ )); do
		marker=$(($marker + ${BASH_ARGC[${i}]-}))
	done
#	local n=0
#	while [ ${n} -lt ${frame} ]; do
#		marker=$(($marker + ${BASH_ARGC[${n}]-}))
#		n=$((${n}+1))
#	done

	

	local argv=()	
	local argc=${BASH_ARGC[${frame}]-}
	local begin=$(($marker+$argc-1))
	for (( i=$begin; i>((begin-argc)); i-- )); do
		argv+=(${BASH_ARGV[${i}]-})
	done
#	local n=$begin
#	while [ ${n} -gt $((${begin} - ${argc})) ]; do
#		argv+=(${BASH_ARGV[${n}]-})
#		n=$((${n}-1))
#	done


	[ ${argc} = 0 ] && return
	
	local argv_string=${argv[@]}
	dk_return "${argv_string}"; return
}





test_function(){
	#dk_debugFunc 0
	
	echo "ARGV = $(__ARGV__ 1)"					# as a string
	ARGV=($(__ARGV__ 1))						# as an array
	for ((i=0; i < ${#ARGV[@]}; i++ )); do 
		echo "ARGV[$i] = ${ARGV[$i]}";
	done
}

###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	#dk_debugFunc
	
	test_function abc 123
}