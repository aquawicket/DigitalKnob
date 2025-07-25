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
# dk_isEmpty(directory)
#
#
dk_isEmpty() {
	dk_debugFunc 1

	
	if [ -d "${1}" ] && files=$(ls -qAH -- "${1}") && [ -z "${files}" ]; then
		#printf '%s\n' "$dir is an empty directory"
		return $(true)
	else
		#printf >&2 '%s\n' "$dir is not empty, or is not a directory" \
        #           "or is not readable or searchable in which case" \
        #            "you should have seen an error message from ls above."
		return $(false)
	fi
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_echo "PWD = $PWD"
	mkdir empty
	dk_echo "The created empty folder is ...."
    $(dk_isEmpty "${PWD}/empty") && dk_echo "Empty" || dk_echo "NOT Empty"
	dk_echo "the current directory is ..."
	$(dk_isEmpty "${PWD}") && dk_echo "Empty" || dk_echo "NOT Empty"
}
