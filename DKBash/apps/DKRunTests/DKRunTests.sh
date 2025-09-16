#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)									&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export cmd_exe=$(command -v 'cmd.exe')									&& echo "cmd_exe = ${cmd_exe}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($cmd_exe /c echo %USERPROFILE% | tr -d '\r')		&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})									&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export bash_exe=$(command -v bash)										&& echo "bash_exe = ${bash_exe}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH="${HOME}/DigitalKnob/Development/DKBash/functions/DK.sh"	&& echo "DK_SH = ${DK_SH}"
	[ ! -e "${DK_SH}" ]					&& export DK_SH=$(find "${HOME}" -name "DK.sh")								&& echo "DK_SH = ${DK_SH}"
	[ -e "${bash_exe}" ]				&& exec "${bash_exe}" "${DK_SH}" "$0" $*									|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


#####################################
RUNTEST() {
	if ! [ "#${disabled/;${1};//}#" = "#${disabled}#" ]; then
		echo "${yellow} ######### ${1} is disabled ######### ${clr}";
		return;
	fi
	echo "######## ${DKBASH_FUNCTIONS_DIR_}${1} #######";
	[ ! -e "${DKBASH_FUNCTIONS_DIR_}${1}" ] && return -1
	dk_call dk_fileContains "${DKBASH_FUNCTIONS_DIR_}${1}" "DKTEST(" || return -1
	
	CURRENT_TEST_FILE="${1}";
	echo "">> 								$(dirname $0)/log.txt
	echo "######### ${1} #########">> 		$(dirname $0)/log.txt
	#title TESTING "### %~nx1 ###"
	echo "";
	echo "${bg_magenta}${white}###### DKTEST MODE ###### ${1} ###### DKTEST MODE ######${clr}";
	echo "";
	. "${DKBASH_FUNCTIONS_DIR_}${1}";
	DKTEST && (
		echo "        ### passed status:$?">> 		$(dirname $0)/log.txt
	) || (
		echo "        ### FAILED status:$?">> 		$(dirname $0)/log.txt
	)
	echo "";
	echo "${bg_magenta}${white}######## END TEST ####### ${1} ######## END TEST #######${clr}";
	echo "";
}

#####################################
DKRunTests() {
	DISABLE __ARGC__.sh;
	DISABLE __ARG__.sh;
	DISABLE __ARGV__.sh;
	
	dk_call dk_validate DKBASH_FUNCTIONS_DIR_ "dk_call dk_DKBRANCH_DIR";
	dk_call dk_getFiles ${DKBASH_FUNCTIONS_DIR_} _files_;
	
	### Clear log.txt
	echo "" > $(dirname $0)/log.txt
	
	#set "dk_log_ERROR_CALLBACK=call %~f0 :CALLBACK"
	#set "dk_log_FATAL_CALLBACK=call %~f0 :CALLBACK"
	
	#set "READY=1"
	for ((i=0; i<${#_files_[@]}; i++)); do
		echo "RUNTEST ${_files_[$i]}";
		RUNTEST "${_files_[$i]}";
	done
}

#####################################
DISABLE() {
	export disabled="${disabled-};${1};"
}



#####################################
CALLBACK() {
	echo "CALLBACK()"
}

#####################################
#DK TEST() {
#	echo "DK TEST()"
#	read -p '';
#}

