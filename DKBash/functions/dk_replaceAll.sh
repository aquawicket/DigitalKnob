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



##################################################################################
# dk_replaceAll("input" "searchValue" "newValue" <output_variable>)
#
#
dk_replaceAll() {
	dk_debugFunc 3 4
	
    input="${1}"
	searchValue="${2}"
	newValue="${3}"
    _replaceAll_=
		
    while [ -n "${input}" ]; do
        LEFT=${input%%"${searchValue}"*}

        if [ "${LEFT}" = "${input}" ]; then
            _replaceAll_=${_replaceAll_}${input}
			break
        fi

        _replaceAll_=${_replaceAll_}${LEFT}${newValue}
        input=${input#*"$searchValue"}
    done
	
	### return value ###
	#dk_call dk_printVar _replaceAll_
	[ ${#} -gt 3 ] && eval "${4}='${_replaceAll_}'" && return  # return value when using rtn_var parameter 
	dk_return ${_replaceAll_}; return						  # return value when using command substitution
	
#DEBUG
#	dk_printVar _replaceAll_
}


###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	string_var="AZC AZC Zannana Zread"
	echo "string before:  ${string_var}"
	
	dk_replaceAll "${string_var}" "Z" "B" string_var
	
	echo "string after:  ${string_var}"
}