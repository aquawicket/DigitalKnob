#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)						&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export CMD_EXE=$(command -v 'cmd.exe')						&& echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')	&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})								&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export BASH_EXE=$(command -v bash)									&& echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]					|| export DK_SH=$(find "${HOME}" -name "DK.sh")							&& echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]				&& exec "${BASH_EXE}" "${DK_SH}" "$0" $*								|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


################################################################################
# dk_listToArray(<list>, <rtn_var:OPTIONAL>)
#
#
dk_listToArray() {
    dk_debugFunc 2
    
	OLDIFS=${IFS}
	IFS=";"
	arr=(${1/;;/;}) #NOTE: ${1/;;/;} fixes the issue of empty array items from strings containng ";;"
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
