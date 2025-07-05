#!/usr/bin/sh
###### DK.sh #####################################################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


##################################################################################
# dk_source(function_name)
#
#    @function_name	- the function name of the file to source and download if needed
#
dk_source(){
	#(command -v dk_debugFunc &>/dev/null) && dk_debugFunc 1

	# load if it's an existing full path file
#	[ -e ${1} ] && . ${1} && return ${?}

	# If it's a dk_function, download if it doesn't exist then load it
#	[ -e "${DKBASH_FUNCTIONS_DIR}/${1}.sh" ] || echo "downloading ${1} . . ."
#	[ -e "${DKBASH_FUNCTIONS_DIR}/${1}.sh" ] || curl --silent -Lo ${DKBASH_FUNCTIONS_DIR}/${1}.sh ${DKHTTP_DKBASH_FUNCTIONS_DIR}/${1}.sh || $(true)
#	[ -e "${DKBASH_FUNCTIONS_DIR}/${1}.sh" ] || echo "ERROR: failed to download ${DKHTTP_DKBASH_FUNCTIONS_DIR}/${1}.sh  TO  ${DKBASH_FUNCTIONS_DIR}/${1}.sh" || [$(read -rp 'press enter to exit')] || exit 127;
	
	#echo "${SUDO_EXE-} chmod 777 ${DKBASH_FUNCTIONS_DIR}/${1}.sh"
#	[ -e "${DKBASH_FUNCTIONS_DIR}/${1}.sh" ] && ${SUDO_EXE-} chmod 777 ${DKBASH_FUNCTIONS_DIR}/${1}.sh
#	[ -e "${DKBASH_FUNCTIONS_DIR}/${1}.sh" ] && . ${DKBASH_FUNCTIONS_DIR}/${1}.sh
	_in_=$1
	_fnc_=
	# builtin echo "func = ${_in_}";
	#############################################################################################################################
	#	FROM THIS ->                          											            			     dk_color
	#	FROM THIS ->                          C:\Users\Administrator\DigitalKnob\Development\3rdParty\_DKIMPORTS\git/dkconfig.txt
	if [ ! -e "${_in_}" ]; then 
		searchValue="\\"
		newValue="/"
		while [ -n "${_in_}" ]; do
			LEFT=${_in_%%"${searchValue}"*}
			if [ "${LEFT}" = "${_in_}" ]; then
				_fnc_=${_fnc_}${_in_}
				break
			fi
			_fnc_=${_fnc_}${LEFT}${newValue}
			_in_=${_in_#*"$searchValue"}
		done 
	#                                                                                                                dk_color
	#	                                      C:/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/git/dkconfig.txt
		_fnc__noext="${_fnc_%.*}" # remove everything past last dot
		[ "${_fnc_}" = "${_fnc__noext}" ] && _fnc_="${_fnc_}.sh";
	#                                                                                                                dk_color.sh
	#	                                      C:/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/git/dkconfig.txt
		[ ! "${1#*"${_fnc_}"}" = "/c/Users/Administrator/DigitalKnob" ] && _fnc_="/c/Users/Administrator/DigitalKnob/Development/DKBash/functions/${_fnc_}";
	#	TO THIS ->		                       C:/Users/Administrator/DigitalKnob/Development/DKPowershell/_fnc_tions/dk_color.sh
	#	TO THIS ->                            C:/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/git/dkconfig.txt
		#${HTTP_fnc_} = ${_fnc_} -replace 'C:/Users/Administrator', 'https://raw.githubusercontent.com/aquawicket';
		#HTTP_fnc_="${_fnc_}"/"/c/Users/Administrator"/"https://raw.githubusercontent.com/aquawicket";
		HTTP_fnc_=
		_in_=${_fnc_}
		searchValue="/c/Users/Administrator"
		newValue="https://raw.githubusercontent.com/aquawicket"
		while [ -n "${_in_}" ]; do
			LEFT=${_in_%%"${searchValue}"*}
			if [ "${LEFT}" = "${_in_}" ]; then
				HTTP_fnc_=${HTTP_fnc_}${_in_}
				break
			fi
			HTTP_fnc_=${HTTP_fnc_}${LEFT}${newValue}
			_in_=${_in_#*"$searchValue"}
		done
		
		
	fi
	#builtin echo "func = ${_fnc_}";
	#builtin echo " url = ${HTTP_fnc_}";
	#	TO THIS ->	     https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKPowershell/_fnc_tions/dk_color.sh
	#	TO THIS ->		https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/3rdParty/_DKIMPORTS/git/dkconfig.txt
	[ ! -e "${_fnc_}" ] && echo "downloading ${_fnc_} . . .";
	dirn=$(dirname "${_fnc_}")
	[ ! -e "${dirn}" ] && mkdir -p ${dirn}
	if [ ! -e "${_fnc_}" ]; then 
		curl --silent -Lo "${_fnc_}" "${HTTP_fnc_}"
		wget -P "${dirn}" "${HTTP_fnc_}"
	fi
	[ ! -e "${_fnc_}" ] && echo "ERROR: Failed to download ${_fnc_}" && return;
#############################################################################################################################

	if [ -e "${_fnc_}" ]; then
		[ ! "${1#*"${_fnc_}"}" = ".sh" ] && . "${_fnc_}";
		return;
	fi
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	dk_source dk_info 
	dk_info "test message using dk_source to download it first"
}
