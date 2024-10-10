#!/bin/sh
[ -n "${DKINIT-}" ] && return  || export DKINIT=1  # include_guard

##################################################################################
# DKINIT()
#
DK(){
	[ -e "${SUDO_EXE-}" ] || export SUDO_EXE=$(command -v sudo &>/dev/null) || true
	[ -e "${SUDO_EXE-}" ] && echo "SUDO_EXE = '${SUDO_EXE}'" || unset SUDO_EXE
	
    #[ -n "${WSLENV+1}" ] && echo "WSLENV is on"
    
	###### Reload Main Script with bash ######
    [ -z "${BASH}" ] && dkreloadWithBash ${*}
    
	############ Set Options ############
    dksetOptions
	
	############ load dk_source ######
	export DKHTTP_DKBASH_FUNCTIONS_DIR="https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBash/functions"
    export DKBASH_FUNCTIONS_DIR=$(cd -- "$(dirname "${BASH_SOURCE-}")"; pwd -P)
    [ -e "${DKBASH_FUNCTIONS_DIR}/dk_source.sh" ] || dk_download ${DKHTTP_DKBASH_FUNCTIONS_DIR}/dk_source.sh ${DKBASH_FUNCTIONS_DIR}/dk_source.sh
    [ -e "${DKBASH_FUNCTIONS_DIR}/dk_source.sh" ] && . "${DKBASH_FUNCTIONS_DIR}/dk_source.sh"
    
    ############ LOAD FUNCTION FILES ############
	#dk_source dk_callStack
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
    dk_source dk_onExit        # EXIT handler
    dk_source dk_onError       # ERR handler
	dk_source dk_realpath
	dk_source dk_call
	dk_source dk_download
    dk_call dk_color
    dk_call dk_logo
    
	############ Get DKSCRIPT variables ############
    DKSCRIPT_VARS

    ###### DKTEST MODE ######
    [ "${DKSCRIPT_DIR}" = "${DKBASH_FUNCTIONS_DIR}" ] || return 0
    [ "${DKSCRIPT_EXT}" = ".sh" ] || return 0
        dk_call dk_echo
        dk_call dk_echo "${bg_magenta-}${white-}###### DKTEST MODE ###### ${DKSCRIPT_NAME} ###### DKTEST MODE ######${clr-}"
        #dk_call dk_echo "${bg_RGB}20;20;20m"
        dk_source "${DKSCRIPT_PATH}"
        #dk_call dk_echo "$(type DKTEST | sed '1,1d')"             # print DKTEST() code
        #dk_call dk_echo "${clr}"
        DKTEST
        dk_call dk_echo
        dk_call dk_echo "${bg_magenta-}${white-}########################## END TEST ################################${clr-}"
        dk_call dk_echo
        dk_call dk_pause
        dk_call dk_exit 0
}

##################################################################################
# dkreloadWithBash()
#
dkreloadWithBash(){
	(command -v bash &>/dev/null) || dk_installPackage bash
	(command -v bash &>/dev/null) || echo "ERROR: bash not found" || exit 1
	
	export BASH_EXE=$(command -v bash)
	echo "BASH_EXE = ${BASH_EXE}"
	echo "Reloading ${0} with ${BASH_EXE} . . ."
	unset DKINIT
	exec ${BASH_EXE} "${0}"
}

##################################################################################
# dkinit()
#
dkinit(){
    echo "Loading DKBash DigitalKnob . . ."
#   (command -v dk_commandExists &>/dev/null)   || dk_commandExists(){ (command -v ${1} &>/dev/null); }
#   (command -v builtin &>/dev/null)			&& export builtin="builtin"
#   (command -v dk_basename &>/dev/null)        || dk_commandExists basename  && dk_basename(){ ${builtin-} echo $(basename ${1-}); }
#   (command -v dk_dirname &>/dev/null)         || dk_commandExists dirname   && dk_dirname() { ${builtin} echo $(dirname ${1}); }
#   (command -v dk_realpath &>/dev/null)        || dk_commandExists realpath  && dk_realpath(){ ${builtin} echo $(realpath ${1}); } || dk_realpath(){ ${builtin} echo $(cd $(dk_dirname ${1}); pwd -P)/$(dk_basename ${1}); }
#   (command -v dk_debugFunc &>/dev/null)       || dk_debugFunc(){
#        [ "${ENABLE_dk_debugFunc-0}" -eq "1" ] && echo "$(dk_basename ${BASH_SOURCE[1]-}):${BASH_LINENO[1]}  ${FUNCNAME[1]}(${BASH_ARGC[1]})" || return $(true)
#   }
}

##################################################################################
# dk_download(url, destination)
#
#
dk_download() {
    if [ -e "${2-}" ]; then
        echo "WARNING: dk_download(): ${2} already exists"
        return 0
    fi
    echo "Downloading $(basename ${1}) . . ."
    parentdir="$(dirname "${2}")"
    OLDPWD=${PWD}
    cd "${parentdir}"
    
    #dk_commandExists "wget" || dk_installPackage wget
    #dk_commandExists "curl" || dk_installPackage curl
    [ ! -e "${2}" ] && (command -v wget &>/dev/null) && ${SUDO_EXE} wget -P "${parentdir}" "${1}"
    [ ! -e "${2}" ] && (command -v curl &>/dev/null) && ${SUDO_EXE} curl --silent -Lo "${2}" "${1}"
    
    cd "${OLDPWD}"
}

##################################################################################
# DKSCRIPT_VARS()
#
DKSCRIPT_VARS(){

    [ -n "${DKSCRIPT_PATH-}" ]	|| export DKSCRIPT_PATH=$(dk_realpath ${0})
    [ -e "${DKSCRIPT_PATH}" ]	|| echo "ERROR: DKSCRIPT_PATH:${DKSCRIPT_PATH} not found" || exit 1    
    export DKSCRIPT_ARGS=$(${*})
    export DKSCRIPT_DIR=$(dirname "${DKSCRIPT_PATH}")
    export DKSCRIPT_NAME=$(basename "${DKSCRIPT_PATH}")
    export DKSCRIPT_EXT=".${DKSCRIPT_NAME##*.}"
    
return	
	echo "DKSCRIPT_PATH = ${DKSCRIPT_PATH}"
	echo "DKSCRIPT_ARGS = ${DKSCRIPT_ARGS}"
	echo "DKSCRIPT_DIR = ${DKSCRIPT_DIR}"
	echo "DKSCRIPT_NAME = ${DKSCRIPT_NAME}"
	echo "DKSCRIPT_EXT = ${DKSCRIPT_EXT}"
} 


##################################################################################
# dksetOptions()
#
dksetOptions(){
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
	
	###### set -o ######
	(set -o posix)    	&& set -o posix			|| echo "(set -o posix) failed"
    (set -o pipefail) 	&& set -o pipefail  	|| echo "(set -o pipefail) failed"  # trace ERR through pipes
    (set -o errtrace) 	&& set -o errtrace  	|| echo "(set -o errtrace) failed" 	# set -E : trace ERR through 'time command' and other functions
    (set -o nounset)  	&& set -o nounset   	|| echo "(set -o nounset) failed" 	# set -u : exit the script if you try to use an uninitialised variable
    (set -o errexit)  	&& set -o errexit   	|| echo "(set -o errexit) failed" 	# set -e : exit the script if any statement returns a non-true

    ###### shopt ######
    (shopt -s extdebug) && shopt -s extdebug	|| echo "(shopt -s extdebug) failed" 
    #shopt -s expand_aliases
    
    # dk_call dk_echo "SHELLOPTS = ${SHELLOPTS}"
    # dk_call dk_echo "BASHOPTS = ${BASHOPTS-}"

}

##################################################################################
# dk_installPackage(package)
#
#   https://en.wikipedia.org/wiki/List_of_software_package_management_systems
#   https://en.wikipedia.org/wiki/Package_manager
#   https://www.digitalocean.com/community/tutorials/package-management-basics-apt-yum-dnf-pkg
#
dk_installPackage() {
    (command -v ${1} &>/dev/null) && return $(true) 
    echo "installing ${1}. . ."
    (command -v apk)           					&& dk_installPackage="apk add"				# Alpine Package Keeper (alpine linux)
	(command -v apt-get &>/dev/null)       		&& dk_installPackage="apt-get -y install"	# Apt-get (debian)
	(command -v apt &>/dev/null)           		&& dk_installPackage="apt -y install"		# Apt (debian)
	(command -v brew &>/dev/null)          		&& dk_installPackage="brew install"			# Homebrew (MacOS)
	(command -v dnf &>/dev/null)           		&& dk_installPackage="dnf install"			# Dnf (yum)
	(command -v emerge &>/dev/null)        		&& dk_installPackage="emerge"				# Portage
	(command -v nix-env &>/dev/null)       		&& dk_installPackage="nix-env -i"			# Nix
	(command -v ohpm &>/dev/null)          		&& dk_installPackage="ohpm install"			# Ohpm
	(command -v pkg &>/dev/null)           		&& dk_installPackage="pkg install"			# Termux
	(command -v pacman &>/dev/null)        		&& dk_installPackage="pacman -S"			# Pacman
	(command -v swupd &>/dev/null)         		&& dk_installPackage="swupd bundle-add"		# Swupd
	(command -v tce-load &>/dev/null)      		&& dk_installPackage="tce-load -wil"    	# Tiny core linux
	(command -v winget &>/dev/null)        		&& dk_installPackage="winget install"		# WinGet
	(command -v xbps-install &>/dev/null)		&& dk_installPackage="xbps-install"			# Xbps
	(command -v zypper &>/dev/null)				&& dk_installPackage="zypper in"			# Zypper
	(command -v dk_installPackage &>/dev/null)  && echo "No package managers found." && exit 1 

	${dk_installPackage} ${1}
	(command -v ${1} &>/dev/null) || echo "ERROR: ${1}: command not found" || exit 1
}

##################################################################################
# run DK() function
DK









#DK_TRY_CATCH() {
    # Don't pipe the subshell into anything or we won't be able to see its exit status
#    set +e; ( set -e
#        DK
#    ); local err_status=${?}; set -e
#
#    if [ "${err_status}" -ne "0" ]; then
#        dk_echo "ERROR_STATUS: ${err_status}"
#        #read -rp 'press enter to exit'
#        exit ${err_status}
#    fi
#}


#if $(ps -o &>/dev/null);then  
#    THIS_PATH=$(ps -o args= $PID | tail -n 6 | awk 'FNR==1 {print ${2}}')
#    dk_echo "    THIS_PATH = $THIS_PATH"
#    PARENT_PATH=$(ps -o args= $PPID | awk '{print ${2}}')
#    dk_echo "    PARENT_PATH = $PARENT_PATH"
#else
#    dk_echo "ps -o NOT AVAILABLE"
#    ${builtin} echo $(ps -p -f $PPID)
#fi
