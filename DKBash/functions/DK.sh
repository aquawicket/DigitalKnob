#!/bin/sh
[ -n "${DKINIT-}" ] && return  || export DKINIT=1  # include_guard
echo "0 = $0"
### Print Shell Path ad Version ###
export ESC=""  # escape character
[ -n "${BASH-}" ] && export DKSHELL_PATH=${BASH-} || export DKSHELL_PATH=${SHELL-}
export DKSHELL=$(basename ${DKSHELL_PATH})
export DKSHELL_VERSION="$($DKSHELL_PATH --help 2>&1 | head -1)"
echo ""
echo "${ESC}[45m ${ESC}[30m ${DKSHELL} Version ${DKSHELL_VERSION} ${ESC}[0m"
echo "DKSHELL_PATH  ${DKSHELL_PATH}"
echo "DKSCRIPT_PATH  ${DKSCRIPT_PATH-}"
echo ""

##################################################################################
# DKINIT()
#
DK(){
	###### SUDO_EXE ######
	SUDO_EXE(){
		[ -e "${SUDO_EXE-}" ]	|| export SUDO_EXE=$(command -v sudo) || true
		[ -e "${SUDO_EXE-}" ]	&& echo "${SUDO_EXE}" || unset SUDO_EXE
		echo "SUDO_EXE = '${SUDO_EXE-}'" >&2
	}
    
	###### Reload Main Script with bash ######
	[ $# -eq 0 ] && dkreloadWithBash || dkreloadWithBash $*
    
	############ Set Options ############
    dksetOptions
	
	############ load dk_source ######
	export DKHTTP_DKBASH_FUNCTIONS_DIR="https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBash/functions"
    export DKBASH_FUNCTIONS_DIR=$(cd -- "$(dirname "${BASH_SOURCE-}")"; pwd -P)
	export DKBASH_FUNCTIONS_DIR_="${DKBASH_FUNCTIONS_DIR}/"
    [ -e "${DKBASH_FUNCTIONS_DIR_}dk_source.sh" ] || dk_download ${DKHTTP_DKBASH_FUNCTIONS_DIR}/dk_source.sh ${DKBASH_FUNCTIONS_DIR_}dk_source.sh
    [ -e "${DKBASH_FUNCTIONS_DIR_}dk_source.sh" ] && . "${DKBASH_FUNCTIONS_DIR_}dk_source.sh"
    
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
	dk_source dk_isChildPathOf
    dk_call dk_color
    dk_call dk_logo
    
#	dk_call dk_wslFixNet
#	dk_call dk_wslFixFileAccess
#	sudo apt-get update
#	sudo apt-get upgrade
#	/mnt/c/Windows/System32/cmd.exe /c 'wsl --shutdown'

	
	
	############ Get DKSCRIPT variables ############
    DKSCRIPT_VARS

    ###### DKTEST MODE ######
	echo "DKSCRIPT_DIR = ${DKSCRIPT_DIR}"
	echo "DKBASH_FUNCTIONS_DIR = ${DKBASH_FUNCTIONS_DIR}"
	echo "DKBASH_FUNCTIONS_DIR_ = ${DKBASH_FUNCTIONS_DIR_}"
#    [ "${DKSCRIPT_DIR}" = "${DKBASH_FUNCTIONS_DIR}" ] || return 0
	if ! dk_isChildPathOf "$DKSCRIPT_DIR" "$DKBASH_FUNCTIONS_DIR"; then 
		return 0;
	fi
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
	[ -n "${BASH-}" ] && return
	(command -v bash &>/dev/null) || dk_installPackage bash
	(command -v bash &>/dev/null) && export BASH_EXE=$(command -v bash) || echo "ERROR: bash not found" || exit 1
	echo "Reloading ${0} with ${BASH_EXE} . . ."
	unset DKINIT
	exec ${BASH_EXE} "${0}"
	#exec env -i HOME="$HOME" PATH="$PATH" BASH_EXE="${BASH_EXE}" ${BASH_EXE} -l -c '${0}'
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
    [ ! -e "${2}" ] && (command -v wget &>/dev/null) && $(SUDO_EXE) wget -P "${parentdir}" "${1}"
    [ ! -e "${2}" ] && (command -v curl &>/dev/null) && $(SUDO_EXE) curl --silent -Lo "${2}" "${1}"
    
    cd "${OLDPWD}"
}

##################################################################################
# WSLPATH_EXE()
#
WSLPATH_EXE(){
	(command -v wslpath >&2) || echo "wslpath Not Found"  >&2
}

##################################################################################
# CYGPATH_EXE()
#
CYGPATH_EXE(){
	(command -v cygpath >&2) || echo "cygpath Not Found"  >&2
}

##################################################################################
# DKSCRIPT_VARS()
#
DKSCRIPT_VARS(){
	#echo "0 = ${0}"
	[ ! -e "${DKSCRIPT_PATH-}" ] && [ -e "$(WSLPATH_EXE)" ] && export DKSCRIPT_PATH=$($(WSLPATH_EXE) -u $(dk_realpath ${0})) 	# Windows subsystem for linux
	[ ! -e "${DKSCRIPT_PATH-}" ] && [ -e "$(CYGPATH_EXE)" ] && export DKSCRIPT_PATH=$($(CYGPATH_EXE) -u $(dk_realpath ${0}))	# Git for Windows
	[ ! -e "${DKSCRIPT_PATH-}" ] && export DKSCRIPT_PATH=$(dk_realpath ${0})													# Default
	echo "DKSCRIPT_PATH = ${DKSCRIPT_PATH}"
    [ -e "${DKSCRIPT_PATH}" ]	 && echo "DKSCRIPT_PATH = ${DKSCRIPT_PATH}" || echo "ERROR: DKSCRIPT_PATH:${DKSCRIPT_PATH} not found" || exit 1    
    export DKSCRIPT_ARGS=$(${*})							&& echo "DKSCRIPT_ARGS = ${DKSCRIPT_ARGS}"						
    export DKSCRIPT_DIR=$(dirname "${DKSCRIPT_PATH}")		&& echo "DKSCRIPT_DIR = ${DKSCRIPT_DIR}"
    export DKSCRIPT_NAME=$(basename "${DKSCRIPT_PATH}")		&& echo "DKSCRIPT_NAME = ${DKSCRIPT_NAME}"
    export DKSCRIPT_EXT=".${DKSCRIPT_NAME##*.}"				&& echo "DKSCRIPT_EXT = ${DKSCRIPT_EXT}"
} 

##################################################################################
# dksetOptions()
#
dksetOptions(){
    # https://pubs.opengroup.org/onlinepubs/007904875/utilities/set.html
	# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
    # $(set -a) && set -a	# Each variable or function that is created or modified is given the export attribute and marked for export to the environment of subsequent commands.
    # $(set -b) && set -b	# Cause the status of terminated background jobs to be reported immediately, rather than before printing the next primary prompt.
    # $(set -C) && set -C	# Prevent output redirection using ‘>’, ‘>&’, and ‘<>’ from overwriting existing files.
    # $(set -e) && set -e	# Exit immediately if a pipeline, which may consist of a single simple command, a list, or a compound command returns a non-zero status. 
    # $(set -f) && set -f	# Disable filename expansion (globbing).
    # $(set -h) && set -h	# Locate and remember (hash) commands as they are looked up for execution. This option is enabled by default.
    # $(set -m) && set -m	# Job control is enabled. All processes run in a separate process group. When a background job completes, the shell prints a line containing its exit status.
    # $(set -n) && set -n	# Read commands but do not execute them. This may be used to check a script for syntax errors. This option is ignored by interactive shells.
    # $(set -o) && set -o	# Set the option corresponding to option-name:
    # $(set -o) && set +o	# Unset the option corresponding to option-name:
    # $(set -u) && set -u	# Treat unset variables and parameters other than the special parameters ‘@’ or ‘*’, as an error when performing parameter expansion.
    # $(set -v) && set -v	# Print shell input lines as they are read.
    # $(set -x) && set -x	# Print a trace of simple commands, for commands, case commands, select commands, and arithmetic for commands and their arguments or associated word lists.
	
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
    (command -v apk)           					&& ${SUDO_EXE} apk add ${1} && return				# Alpine Package Keeper (alpine linux)
	(command -v apt-get)       					&& ${SUDO_EXE} apt-get -y install ${1} && return	# Apt-get (debian)
	(command -v apt)           					&& ${SUDO_EXE} apt -y install ${1} && return		# Apt (debian)
	(command -v brew)          					&& ${SUDO_EXE} brew install ${1} && return			# Homebrew (MacOS)
	(command -v dnf)           					&& ${SUDO_EXE} dnf install ${1} && return			# Dnf (yum)
	(command -v emerge &>/dev/null)        		&& ${SUDO_EXE} merge ${1} && return					# Portage
	(command -v nix-env &>/dev/null)       		&& ${SUDO_EXE} nix-env -i ${1} && return			# Nix
	(command -v ohpm &>/dev/null)          		&& ${SUDO_EXE} ohpm install ${1} && return			# Ohpm
	(command -v pkg &>/dev/null)           		&& ${SUDO_EXE} pkg install ${1} && return			# Termux
	(command -v pacman &>/dev/null)        		&& ${SUDO_EXE} pacman -S ${1} && return				# Pacman
	(command -v swupd &>/dev/null)         		&& ${SUDO_EXE} swupd bundle-add ${1} && return		# Swupd
	(command -v tce-load &>/dev/null)      		&& ${SUDO_EXE} tce-load -wil ${1} && return 	   	# Tiny core linux
	(command -v winget &>/dev/null)        		&& ${SUDO_EXE} winget install ${1} && return		# WinGet
	(command -v xbps-install &>/dev/null)		&& ${SUDO_EXE} xbps-install ${1} && return			# Xbps
	(command -v zypper &>/dev/null)				&& ${SUDO_EXE} zypper in ${1} && return				# Zypper
	(command -v dk_installPackage &>/dev/null)  && echo "ERROR: No package managers found." && exit 1 

	${dk_installPackage} ${1}
	(command -v ${1} &>/dev/null) || echo "ERROR: ${1}: command not found" || exit 1
}

##################################################################################
# run DK()
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
