#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)      || export PATH=/bin
	(command -v 'cygpath' 1>/dev/null) && HOME=$(cygpath -u $USERPROFILE)                                 && echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null) && CMD_EXE=$(command -v 'cmd.exe')                                 && echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]            && USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '')      && echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null) && HOME=$(wslpath -u ${USERPROFILE})                               && echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)    && export BASH_EXE=$(command -v bash)                              && echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]                  || export DK_SH=$(find "${HOME}" -name "DK.sh")                    && echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]               && exec "${BASH_EXE}" "${DK_SH}" "$0" $* || exec "${DK_SH}" "$0" $*
fi
##################################################################################


#####################################################################
# dk_Target_Tuple()
#
#	  Target_Tuple = TODO
#
dk_Target_Tuple() {
	dk_debugFunc 0 1

	###### SET ######
	if [ -n "${1-}" ]; then
		export Target_Tuple="${1}"
	
	###### GET ######	
	else
		[ -z "${Target_Os-}" ] 		&& dk_call dk_Target_Os
		[ -z "${Target_Arch-}" ]	&& dk_call dk_Target_Arch
		[ -z "${Target_Env-}" ] 	&& dk_call dk_Target_Env
		export Target_Tuple="${Target_Os}_${Target_Arch}"
		export ${Target_Tuple}=1
		export Target_Tuple="${Target_Arch}_${Target_Env}"
		export ${Target_Tuple}=1
		export Target_Tuple="${Target_Os}_${Target_Env}"
		export ${Target_Tuple}=1
		export Target_Tuple="${Target_Os}_${Target_Arch}_${Target_Env}"
	fi
	
	export ${Target_Tuple}=1
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0

	###### GET ######
    dk_call dk_Target_Tuple
	dk_call dk_printVar Target_Tuple
	dk_call dk_printVar ${Target_Tuple}
	
	###### SET ######
	dk_call dk_Target_Tuple "Windows_X86_64_Clang"
	dk_call dk_printVar Target_Tuple
	dk_call dk_printVar ${Target_Tuple}
	
}