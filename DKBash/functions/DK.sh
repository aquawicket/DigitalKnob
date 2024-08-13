#!/bin/sh
[ -n "${DKINIT-}" ] && return || export DKINIT=1	# include_guard

[ -n "$(command -v "sudo")" ] && export dksudo="sudo" || export dksudo=" "
##################################################################################
# DKINIT()
#
#
DK(){
	#dk_debugFunc 0
	
	###### Initialize Language specifics ######
	dkinit
	#dk_echo "DKINIT(${*})"
	
	
	###### Reload Main Script with bash ######
	dkreloadWithBash ${*}


	############ Get DKBASH variables ############
	DKBASH_VARS
	

	############ Get DKHTTP variables ############
	DKHTTP_VARS


	############ get dk_source and dk_call ######
	dk_initFiles
	
	
	############ Setup dk_callStack ############
	#dksetupCallstack
	#dk_callStack
	#:dk_callStackReturn


	############ Get DKSCRIPT variables ############
	DKSCRIPT_VARS


	##### CD into the DKSCRIPT_DIR directory #####
	#cd "${DKSCRIPT_DIR}"


	############ Set Options ############
	dksetOptions


	############ LOAD FUNCTION FILES ############
	dk_source dk_return
	dk_source __TIME__
	dk_source __FILE__
	dk_source __LINE__
	dk_source __FUNCTION__
	dk_source __ARGC__
	dk_source __ARGV__
	dk_source __ARG__
	dk_source __CALLER__
	dk_source dk_debugFunc
	dk_source dk_onExit    	# EXIT handler
	dk_source dk_onError   	# ERR handler
	dk_call dk_color
	dk_call dk_logo
	. "${DKSCRIPT_PATH}"

	dk_call dk_echo "${bg_RGB}0;0;10m    bg_RGB test (0;0;10)      ${clr}"
	
	###### DKTEST MODE ######
	if [ "${ENABLE_DKTEST-1}" = "1" ]; then
		if [ "${DKSCRIPT_DIR}" = "${DKBASH_FUNCTIONS_DIR}" ]; then
			dk_call dk_echo
			dk_call dk_echo "${bg_magenta-}${white-}###### DKTEST MODE ###### ${DKSCRIPT_NAME} ###### DKTEST MODE ######${clr-}"
			#dk_call dk_echo "${bg_RGB}20;20;20m"
			dk_source "${DKSCRIPT_PATH}"
			#dk_call dk_echo "$(type DKTEST | sed '1,1d')" 			# print DKTEST() code
			#dk_call dk_echo "${clr}"
			DKTEST
			dk_call dk_echo
			dk_call dk_echo "${bg_magenta-}${white-}########################## END TEST ################################${clr-}"
			dk_call dk_echo
			dk_call dk_pause
			dk_call dk_exit 0
		fi
	fi
}

##################################################################################
# dkreloadWithBash()
#
dkreloadWithBash(){
	if [ ${RELOAD_WITH_BASH-1} -eq 1 ]; then
		export RELOAD_WITH_BASH=0
		echo "reloading with bash . . ."
		unset DKINIT
		export DKINIT=""
		dk_commandExists bash || dk_install bash
		exec bash "${0}" #dk_call bash "${0}"
	fi
}

##################################################################################
# dkinit()
#	 default functions and variables
#
dkinit(){
	echo "Loading DKBatch DigitalKnob . . ."
	
	#$(command -v dk)                    || dk_try(){ $($* &>/dev/null) && $@ || echo "$* failed"; }
	$(command -v dk_commandExists)       || dk_commandExists(){ $(command -v ${1} 1>/dev/null); }
	dk_commandExists builtin			 && builtin="builtin"
	dk_commandExists dk_defined          || dk_commandExists     eval   && dk_defined(){ ${builtin} eval value='$'{${1}+x}; [ -n "${value}" ]; }  # dk_defined variable
	dk_commandExists dk_export           || dk_commandExists     export && dk_export() { ${builtin} export ${1}="${2}"; }                         # dk_export variable value
	dk_commandExists dk_echo             || dk_commandExists     echo   && dk_echo()   { ${builtin} echo "${*}"; }                                # dk_echo "test dk_echo"
	dk_commandExists dk_pause            || dk_commandExists     read   && dk_pause()  { dk_echo "Press enter to continue..."; read -rp ''; }     # dk_pause
#	dk_defined       true                || export true=0                                                                                         # true
#	dk_defined       false               || export false=1                                                                                        # false
#	dk_defined       ESC                 || export ESC=""                                                                                      # Escape character
#	dk_defined       clr                 || export clr="${ESC}[0m"
#	dk_defined       black               || export black="${ESC}[30m"
#	dk_defined       red                 || export red="${ESC}[31m"
#	dk_defined       yellow              || export yellow="${ESC}[33m"
#	dk_defined       blue                || export blue="${ESC}[34m"
#	dk_defined       cyan                || export cyan="${ESC}[36m"
#	dk_defined       bg_magenta          || export bg_magenta="${ESC}[45m"
	dk_commandExists dk_log              || dk_log()             { [ -n $2 ] && dk_echo "${2}${clr}" || dk_echo "${1}${clr}"; }                # dk_warning "test dk_warning";
	dk_commandExists dk_warning          || dk_warning()         { dk_echo "${yellow}WARNING: ${1}${clr}"; }                                   # dk_warning "test dk_warning";
	dk_commandExists dk_info             || dk_info()            { dk_echo "${clr}   INFO: ${1}${clr}"; }                                      # dk_info "test dk_info";
	dk_commandExists dk_debug            || dk_debug()           { dk_echo "${blue}  DEBUG: ${1}${clr}"; }                                     # dk_debug "test dk_debug";
	dk_commandExists dk_verbose          || dk_verbose()         { dk_echo "${cyan}VERBOSE: ${1}${clr}"; }                                     # dk_verbose "test dk_verbose";
	dk_commandExists dk_error            || dk_error()           { dk_echo "${red}  ERROR: ${1}${clr}"; dk_pause; exit; }                      # dk_error "test dk_error";
	dk_commandExists dk_printVar         || dk_printVar()        { dk_echo "${cyan}${1} = ${blue}${!1-}${clr}"; }                              # dk_printVar variable
    dk_commandExists dk_pathExists       || dk_pathExists()      { [ -e "${1}" ]; }                                                            # dk_pathExists "/usr/bin"
    dk_commandExists dk_stringContains   || dk_stringContains()  { [ "${1#*"$2"}" != "${1}" ]; }                                               # dk_stringContains string search
    dk_commandExists dk_unset            || dk_commandExists     unset    && dk_unset()   { ${builtin} unset "${1}"; }                            # dk_unset variable
    dk_commandExists dk_basename         || dk_commandExists     basename && dk_basename(){ ${builtin} echo $(basename ${1}); }                   # dk_basename path
    dk_commandExists dk_dirname          || dk_commandExists     dirname  && dk_dirname() { ${builtin} echo $(dirname ${1}); }                    # dk_dirname path
    dk_commandExists dk_realpath         || dk_commandExists     realpath && dk_realpath(){ ${builtin} echo $(realpath ${1}); } || dk_realpath(){ ${builtin} echo $(cd $(dk_dirname ${1}); pwd -P)/$(dk_basename ${1}); }
    dk_commandExists dk_debugFunc        || dk_debugFunc(){
		[ "${ENABLE_dk_debugFunc-0}" -eq "1" ] && dk_echo "${cyan}$(dk_basename ${BASH_SOURCE[1]}):${BASH_LINENO[1]}  ${blue}${FUNCNAME[1]}(${BASH_ARGC[1]})${clr}" || return 0
	}
}

##################################################################################
# DKBASH_VARS()
#
DKBASH_VARS(){
	export BASH_SOURCE_DIR=$( cd -- "$(dk_dirname "$BASH_SOURCE")"; pwd -P )
	export DKBASH_DIR=$( cd -- "$(dk_dirname "$BASH_SOURCE_DIR")" &>/dev/null; pwd -P )
	export DKBASH_FUNCTIONS_DIR="${DKBASH_DIR}/functions"
	dk_pathExists "${DKBASH_FUNCTIONS_DIR}/DK.sh" || dk_error "${DKBASH_FUNCTIONS_DIR}/DK.sh not found"
	#dk_export PATH ${PATH}:${DKBASH_FUNCTIONS_DIR}
}

##################################################################################
# DKHTTP_VARS()
#
DKHTTP_VARS(){
	export DKHTTP_DIGITALKNOB_DIR="https://raw.githubusercontent.com/aquawicket/DigitalKnob"
	export DKHTTP_DKBRANCH_DIR="${DKHTTP_DIGITALKNOB_DIR}/Development"
	export DKHTTP_DKBASH_DIR="${DKHTTP_DKBRANCH_DIR}/DKBash"
	export DKHTTP_DKBASH_FUNCTIONS_DIR="${DKHTTP_DKBASH_DIR}/functions"
}

##################################################################################
# DKHTTP_VARS()
#
dk_initFiles(){
	dk_pathExists "${DKBASH_FUNCTIONS_DIR}/dk_source.sh" || dk_download ${DKHTTP_DKBASH_FUNCTIONS_DIR}/dk_source.sh ${DKBASH_FUNCTIONS_DIR}/dk_source.sh
	dk_pathExists "${DKBASH_FUNCTIONS_DIR}/dk_source.sh" && . "${DKBASH_FUNCTIONS_DIR}/dk_source.sh"
	dk_pathExists "${DKBASH_FUNCTIONS_DIR}/dk_call.sh"   || dk_download ${DKHTTP_DKBASH_FUNCTIONS_DIR}/dk_call.sh ${DKBASH_FUNCTIONS_DIR}/dk_call.sh
	dk_pathExists "${DKBASH_FUNCTIONS_DIR}/dk_call.sh"   && . "${DKBASH_FUNCTIONS_DIR}/dk_call.sh"
}

##################################################################################
# dk_download(url, destination)
#
#
dk_download() {
	dk_debugFunc 2

	if dk_pathExists "${2}"; then
		dk_warning "dk_download(): ${2} already exists"
		return 0
	fi
	dk_info "Downloading $(dk_basename ${1}) . . ."
	parentdir="$(dk_dirname "${2}")"
	OLDPWD=${PWD}
	cd "${parentdir}" #|| dk_error "cd ${parentdir} failed!"
	
	dk_pathExists "${1}" || dk_commandExists "wget" && ${dksudo} wget -P "${parentdir}" "${1}"
	dk_pathExists "${1}" || dk_commandExists "curl" && ${dksudo} curl --silent -Lo "${2}" "${1}"
	
	cd "${OLDPWD}" #|| dk_error "cd ${OLDPWD} failed!"
	#[ "${input}" = "" ]
}

##################################################################################
# dksetupCallstack()
#
dksetupCallstack(){
	dk_debugFunc 0
	
	#dk_pathExists "${DKBASH_FUNCTIONS_DIR}/dk_callStack.sh" || dk_call curl -Lo ${DKBASH_FUNCTIONS_DIR}/dk_callStack.sh ${DKHTTP_DKBASH_FUNCTIONS_DIR}/dk_callStack.sh
	dk_pathExists "${DKBASH_FUNCTIONS_DIR}/dk_callStack.sh" || dk_download ${DKHTTP_DKBASH_FUNCTIONS_DIR}/dk_callStack.sh ${DKBASH_FUNCTIONS_DIR}/dk_callStack.sh
}

##################################################################################
# DKSCRIPT_VARS()
#
DKSCRIPT_VARS(){
	dk_debugFunc 0
	
	dk_call dk_pathExists    $(dk_call dk_realpath ${0}) && dk_call dk_export  DKSCRIPT_PATH  $(dk_call dk_realpath ${0})
	dk_call dk_commandExists "cygpath"                   && DKSCRIPT_PATH=$(cygpath -u "${DKSCRIPT_PATH}")
	dk_call dk_pathExists    "${DKSCRIPT_PATH}"          || dk_call dk_error "DKSCRIPT_PATH:${DKSCRIPT_PATH} not found"
	dk_call dk_export        DKSCRIPT_ARGS               $(${*})
	dk_call dk_export        DKSCRIPT_DIR                $(dk_call dk_dirname ${DKSCRIPT_PATH})
	dk_call dk_pathExists    "${DKSCRIPT_DIR}"           || dk_call dk_error "DKSCRIPT_DIR:${DKSCRIPT_DIR} not found"
	dk_call dk_export        DKSCRIPT_NAME               $(dk_call dk_basename ${DKSCRIPT_PATH})
}

##################################################################################
# dksetOptions()
#
dksetOptions(){
	dk_debugFunc 0
	
	# https://pubs.opengroup.org/onlinepubs/007904875/utilities/set.html
	# $(set -a) && set -a
	# $(set -b) && set -b
	# $(set -C) && set -C
	# $(set -e) && set -e
	# $(set -f) && set -f
	# $(set -h) && set -h
	# $(set -m) && set -m
	# $(set -n) && set -n
	# $(set -o) && set -o
	# $(set -o) && set +o
	# $(set -o) && set -o
	# $(set -u) && set -u
	# $(set -v) && set -v
	# $(set -x) && set -x
	
	$(set -o posix)    && set -o posix
	$(set -o pipefail) && set -o pipefail  	# trace ERR through pipes
	$(set -o errtrace) && set -o errtrace 	# set -E : trace ERR through 'time command' and other functions
	$(set -o nounset)  && set -o nounset  	# set -u : exit the script if you try to use an uninitialised variable
	$(set -o errexit)  && set -o errexit  	# set -e : exit the script if any statement returns a non-true

	###### shopt ######
	$(shopt -s extdebug) && shopt -s extdebug
	#shopt -s expand_aliases
	
	# dk_call dk_echo "SHELLOPTS = ${SHELLOPTS}"
	# dk_call dk_echo "BASHOPTS = ${BASHOPTS-}"
}

##################################################################################
# dk_install()
#
#	install a package
#
dk_install(){
	dk_debugFunc 1
	
	dk_commandExists ${1}      && return 0					        # if the command already exists, return
	dk_commandExists apk       && apk add "${1}"				    # AlpineLinux package installer
	dk_commandExists apt	   && apt -y install "${1}"
	dk_commandExists apt-get   && apt-get -y install "${1}"
	dk_commandExists brew 	   && brew install "${1}"
	dk_commandExists pacman    && pacman -S "${1}" --noconfirm
	dk_commandExists pkg	   && pkg install "${1}"
	dk_commandExists tce-load  && tce-load -wil "${1}"	            # TinyCoreLinux package installer: -l flag means don't add to boot
	dk_commandExists ${1}      || dk_error "${1}: command not found"
}

##################################################################################
# run DK() function
DK









#DK_TRY_CATCH() {
	# Don't pipe the subshell into anything or we won't be able to see its exit status
#	set +e; ( set -e
#		DK
#	); local err_status=${?}; set -e
#
#	if [ "${err_status}" -ne "0" ]; then
#		dk_echo "ERROR_STATUS: ${err_status}"
#		#read -rp 'press enter to exit'
#		exit ${err_status}
#	fi
#}


#if $(ps -o &>/dev/null);then  
#	THIS_PATH=$(ps -o args= $PID | tail -n 6 | awk 'FNR==1 {print ${2}}')
#	dk_echo "    THIS_PATH = $THIS_PATH"
#	PARENT_PATH=$(ps -o args= $PPID | awk '{print ${2}}')
#	dk_echo "    PARENT_PATH = $PARENT_PATH"
#else
#	dk_echo "ps -o NOT AVAILABLE"
#	${builtin} echo $(ps -p -f $PPID)
#fi
