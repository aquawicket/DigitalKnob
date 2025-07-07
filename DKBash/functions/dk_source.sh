#!/bin/sh
###### DK.sh #####################################################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


##################################################################################
# dk_source(function_name)
#
#    @function_name	- the function name of the file to source and download if needed
#
dk_source(){
	#echo "dk_source($*)"
	
	#(command -v dk_debugFunc &>/dev/null) && dk_debugFunc 1
	#echo "1 = ${1}"
	[ -z "${1}" ] && (builtin echo "ERROR: dk_source($*) argument is empty"; return;)
	
	_fnc_=$1
	#DKHOME_DIR="/c/Users/Administrator"
	[ -z "${DKHOME_DIR-}" ] && export DKHOME_DIR=$(DKHOME_DIR)
	[ -z "${DKHTTP_DIR-}" ] && export DKHTTP_DIR="https://raw.githubusercontent.com/aquawicket"
	
	#####################################################################################################################################
	# EXAMPLE INPUT                          								          			            			     dk_color
	# EXAMPLE INPUT                                   C:\Users\Administrator\DigitalKnob\Development\3rdParty\_DKIMPORTS\git/dkconfig.txt
	
	############ Correct the path delimiters ############
	if [ ! -e "${_fnc_}" ]; then 	
		###### Replace \ with / ######
		_in_=${_fnc_}
		_fnc_=
		searchValue="\\"
		newValue="/"
		while [ -n "${_in_}" ]; do
			LEFT=${_in_%%"${searchValue}"*}
			if [ "${LEFT}" = "${_in_}" ]; then _fnc_=${_fnc_}${_in_}; break; fi
			_fnc_=${_fnc_}${LEFT}${newValue}
			_in_=${_in_#*"$searchValue"}
		done 
		# EXAMPLE RESULT                                                                                                       dk_color
		# EXAMPLE RESULT	                            /c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/git/dkconfig.txt
	fi
	
	############ Get the full path and extension ############
	if [ ! -e "${_fnc_}" ]; then 	
		###### If func has no extension, append .sh ######
		_fnc__noext="${_fnc_%.*}" # remove everything past last dot
		[ "${_fnc_}" = "${_fnc__noext}" ] && _fnc_="${_fnc_}.sh";
		# EXAMPLE RESULT																									   dk_color.sh
		# EXAMPLE RESULT								/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/git/dkconfig.txt

	    ###### If func doesn't contain /c/  ...prepend /c/Users/Administrator/DigitalKnob/Development/DKBash/functions/ ######
		[ ! "${1#*"${_fnc_}"}" = "/c/" ] && _fnc_="${DKHOME_DIR}/DigitalKnob/Development/DKBash/functions/${_fnc_}";
	    # EXAMPLE RESULT                                       /c/Administrator/DigitalKnob/Development/DKPowershell/functions/dk_color.sh
	    # EXAMPLE RESULT                                /c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/git/dkconfig.txt
	fi

	############ Download the file if missing ############
	if [ ! -e "${_fnc_}" ]; then 	
		###### Replace /c/Users/Administrator with ########
		###### https://raw.githubusercontent.com/aquawicket
		_in_=${_fnc_}
		_url_=
		
		while [ -n "${_in_}" ]; do
			LEFT=${_in_%%"${DKHOME_DIR}"*}
			if [ "${LEFT}" = "${_in_}" ]; then _url_=${_url_}${_in_}; break; fi
			_url_=${_url_}${LEFT}${DKHTTP_DIR}
			_in_=${_in_#*"$DKHOME_DIR"}
		done
		# EXAMPLE RESULT                https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKPowershell/_fnc_tions/dk_color.sh
		# EXAMPLE RESULT	            https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/3rdParty/_DKIMPORTS/git/dkconfig.txt
	
		###### DOWNLOAD ######
		dirn=$(dirname "${_fnc_}")
		[ ! -e "${dirn}" ] && mkdir -p ${dirn}
		echo "downloading '${_url_}' -> '${_fnc_}'";
		[ ! -e "${_fnc_}" ] && (command -v curl) && curl --silent -Lo "${_fnc_}" "${_url_}";
		[ ! -e "${_fnc_}" ] && (command -v "wget") && wget -P "${_fnc_}" "${_url_}"
	fi
	
	############ Final Check ############
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
