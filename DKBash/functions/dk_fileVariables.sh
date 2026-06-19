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


############ dk_fileVariables settings #########################################
[ -z "${dk_fileVariables_PRINT_VARIABLES-}" ] && export dk_fileVariables_PRINT_VARIABLES=1
################################################################################
# dk_fileVariables(<file>)
#
#
dk_fileVariables() {
    dk_debugFunc 1
    
	_file_="${1}"
	
	if [ "${dk_fileVariables_PRINT_VARIABLES-}" = "1" ];then
		dk_call dk_debug "### ${_file_} Parameters ###"
	fi
	
	# IFS= (or IFS='') prevents leading/trailing whitespace from being trimmed.
	# -r prevents backslash escapes from being interpreted.
	while IFS='' read -r line; do

		line="${line//\$ENV{/\${}"; # replace $ENV{ with ${
		#echo "${line%%#*}"
		IFS='=' read -r varname value <<< "${line%%#*}" # read up to # using = and 'space' as delimiters
		[ "${varname}" = "" ] && continue # if A is empty, skip
		[ "${value}" = "" ] && continue # if A is empty, skip
		
		dk_call dk_trim "${varname}" varname
		varname=$(eval 'builtin echo "$(builtin echo '${varname}')"')
		#builtin echo "varname = ${varname}"
		
		dk_call dk_trim "${value}" value
		value=$(eval 'builtin echo "$(builtin echo '${value}')"')
		#builtin echo "value = ${value}"

		export ${varname}="${value}";
		
		[ "${dk_fileVariables_PRINT_VARIABLES-}" = "1" ] && dk_call dk_debug "'${varname}' = '${!varname}'"
	done < "${_file_}"
}




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
    dk_debugFunc 0
	
	dk_call dk_validate DKCACHE_DIR "dk_call dk_DKCACHE_DIR"
	dk_call dk_fileWrite "${DKCACHE_DIR}/dk_fileVariables_TEST.txt"		"### dk_fileVariables TEST ###"
	dk_call dk_fileAppend "${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"varA=Value_of_varA"
	dk_call dk_fileAppend "${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"varB=Value_of_varB_with_trailing_comment 	# with trailing comment"
	dk_call dk_fileAppend "${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"varC=Value of varC with spaces"
	dk_call dk_fileAppend "${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	" varD=Value of varD padded with spaces "
	#dk_call dk_fileAppend "${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"varE=\"Value of varE with value enclosed inquotes\""
	#dk_call dk_fileAppend "${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"\"varF\"=Value of varF with varname enclosed in quotes"
	#dk_call dk_fileAppend "${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"\"varG=Value of varG with line enclosed in quotes\""
	dk_call dk_fileAppend "${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"varH=Value of varH"
	dk_call dk_fileAppend "${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"varI=\${varH}"
	dk_call dk_fileAppend "${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"varJ=varK"
	dk_call dk_fileAppend "${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"\${varJ}=Value of varK"
	dk_call dk_fileAppend "${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"#varL=Value of varL Commented"
	
	dk_call dk_fileAppend "${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"ComSpec=\$ENV{ComSpec}"
	dk_call dk_fileAppend "${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"USERPROFILE=\$ENV{USERPROFILE}"
	dk_call dk_fileAppend "${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"SHELL=\$ENV{SHELL}"
	dk_call dk_fileAppend "${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"HOME=\$ENV{HOME}"
	
	dk_call dk_fileAppend "${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"cmd_exe=\$(command -v 'cmd.exe')"
	dk_call dk_fileAppend "${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"bash_exe=\$(command -v 'bash')"
	dk_call dk_fileAppend "${DKCACHE_DIR}/dk_fileVariables_TEST.txt"	"HOMEDRIVE=\$(\${cmd_exe} /c echo %HOMEDRIVE% | tr -d '\r')"
	
	
	dk_call dk_debug "Testing dk_fileVariables.cmake"
	export dk_fileVariables_PRINT_VARIABLES=1
    dk_call dk_fileVariables "${DKCACHE_DIR}/dk_fileVariables_TEST.txt"
}
