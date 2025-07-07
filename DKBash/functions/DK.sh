#!/bin/bash
echo "DK.sh"
[ -z "${DK_SH-}" ] && export DK_SH=1 || return

clear
echo "SHLVL = ${SHLVL}"
echo "DKBASH_RELOADED = ${DKBASH_RELOADED}"

if [ -z "${DKSCRIPT_PATH-}" ]; then
	[ -e "${1-}" ] && export DKSCRIPT_PATH="${1-}" #|| export DKSCRIPT_PATH="${0}"
fi


##################################################################################
# DK()
#
DK(){
	echo "DK()"
	
	DKSCRIPT_PATH=$(realpath ${DKSCRIPT_PATH});
	echo "DKSCRIPT_PATH = ${DKSCRIPT_PATH}"

	### Print Shell Path and Version ###
	export ESC=""  # escape character
	[ -n "${BASH-}" ] && export DKSHELL_PATH=${BASH-} || export DKSHELL_PATH=${SHELL-}
	export DKSHELL=$(basename ${DKSHELL_PATH})
	export DKSHELL_VERSION="$($DKSHELL_PATH --help 2>&1 | head -1)"
	echo ""
	echo "${ESC}[45m ${ESC}[30m ${DKSHELL} Version ${DKSHELL_VERSION} ${ESC}[0m"
	#echo "DKSHELL_PATH  ${DKSHELL_PATH}"
	#echo "DKSCRIPT_PATH  ${DKSCRIPT_PATH-}"
	echo ""
	
	###### SUDO_EXE ######
	SUDO_EXE(){
		[ -e "${SUDO_EXE-}" ]	|| export SUDO_EXE=$(command -v sudo) || $(true)
		[ -e "${SUDO_EXE-}" ]	&& echo "${SUDO_EXE}" || unset SUDO_EXE
		echo "SUDO_EXE = '${SUDO_EXE-}'" >&2
	}
    
	###### Reload Main Script with bash ######
	[ -z "${DKBASH_RELOADED-}" ] && dkreloadWithBash
	echo "left dkreloadWithBash"
	#[ $# -eq 0 ] && dkreloadWithBash || dkreloadWithBash $*

	############ Set Options ############
    dksetOptions
	echo "left dksetOptions"
	
	############ load dk_source ######
#	[ ! -n "${DKBRANCH-}" ]						&& export DKBRANCH="Development"
	
#	[ ! -n "${DKHTTP_DKHOME_DIR-}" ]			&& export DKHTTP_DKHOME_DIR="https://raw.githubusercontent.com/aquawicket"
#	[ ! -n "${DKHTTP_DIGITALKNOB_DIR-}" ]		&& export DKHTTP_DIGITALKNOB_DIR="${DKHTTP_DKHOME_DIR}/DigitalKnob"
#	[ ! -n "${DKHTTP_DKBRANCH_DIR-}" ]			&& export DKHTTP_DKBRANCH_DIR="${DKHTTP_DIGITALKNOB_DIR}/${DKBRANCH}"
#	[ ! -n "${DKHTTP_DKBASH_DIR-}" ]			&& export DKHTTP_DKBASH_DIR="${DKHTTP_DKBRANCH_DIR}/DKBash"
#	[ ! -n "${DKHTTP_DKBASH_FUNCTIONS_DIR-}" ]	&& export DKHTTP_DKBASH_FUNCTIONS_DIR="${DKHTTP_DKBASH_DIR}/functions"
	[ ! -n "${DKHTTP_DKBASH_FUNCTIONS_DIR-}" ]	&& export DKHTTP_DKBASH_FUNCTIONS_DIR="https://raw.githubusercontent.com/aquawicket/DigitalKnob/Development/DKBash/functions";
	[ ! -n "${DKHTTP_DKBASH_FUNCTIONS_DIR_-}" ]	&& export DKHTTP_DKBASH_FUNCTIONS_DIR_="${DKHTTP_DKBASH_FUNCTIONS_DIR}/";
	echo "DKHTTP_DKBASH_FUNCTIONS_DIR_ = ${DKHTTP_DKBASH_FUNCTIONS_DIR_}"

	######   DKHOME_DIR()  ######
	(command -v wslpath) && (command -v cmd.exe) && export DKHOME_DIR=$(wslpath -u $(cmd.exe /c echo "%USERPROFILE%" | tr -d '\r'));
	echo "DKHOME_DIR = ${DKHOME_DIR-}"
	(command -v cmd.exe) && (command -v cygpath) && export DKHOME_DIR=$(cygpath -u $(cmd.exe "/c echo "%USERPROFILE%" | tr -d '\r'"));
	echo "DKHOME_DIR = ${DKHOME_DIR-}"
	[ ! -e "${DKHOME_DIR-}" ] && [ -e "${HOME}" ] 		 	           && export DKHOME_DIR="${HOME}";
	echo "DKHOME_DIR = ${DKHOME_DIR-}"
	[   -e "${DKHOME_DIR-}" ] && echo "${DKHOME_DIR-}" || (echo "DKHOME_DIR-NOTFOUND"; exit ${BASH_LINENO[0]};) 
	echo "DKHOME_DIR = ${DKHOME_DIR-}"

	[ ! -n "${DKBASH_FUNCTIONS_DIR-}" ]		&& export DKBASH_FUNCTIONS_DIR="${DKHOME_DIR}/DigitalKnob/Development/DKBash/functions";
	[ ! -n "${DKBASH_FUNCTIONS_DIR_-}" ]	&& export DKBASH_FUNCTIONS_DIR_="${DKBASH_FUNCTIONS_DIR}/";
	echo "DKBASH_FUNCTIONS_DIR_ = ${DKBASH_FUNCTIONS_DIR_}"

#   export DKBASH_FUNCTIONS_DIR=$(cd -- "$(dirname "${BASH_SOURCE-}")"; pwd -P)

#	[ -e "${DKBASH_FUNCTIONS_DIR_}DK.sh" ] || (echo "ERROR: DKBASH_FUNCTIONS_DIR:'${DKBASH_FUNCTIONS_DIR}' is incorrect"; exit 1)
    [ ! -e "${DKBASH_FUNCTIONS_DIR_}dk_source.sh" ] && dk_download ${DKHTTP_DKBASH_FUNCTIONS_DIR_}dk_source.sh ${DKBASH_FUNCTIONS_DIR_}dk_source.sh
	. ${DKBASH_FUNCTIONS_DIR_}dk_source.sh
	echo "loaded dk_source"
	
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

	############ dkconfig.txt settings ###########
	dk_call dk_validate DKBRANCH_DIR "dk_call dk_DKBRANCH_DIR"
	[ -e "${DKSCRIPT_DIR}/dkconfig.txt" ] && dk_call dk_getFileParams "${DKSCRIPT_DIR}/dkconfig.txt"
	[ -e "${DKBRANCH_DIR}/dkconfig.txt" ] && dk_call dk_getFileParams "${DKBRANCH_DIR}/dkconfig.txt"

    ###### DKTEST MODE ######
    [ ! "${DKSCRIPT_EXT}" = ".sh" ] && echo "${DKSCRIPT_EXT} != .sh"  && return
	if dk_call dk_fileContains "${DKSCRIPT_PATH}" "DKTEST()"; then
		dk_call dk_echo
		dk_call dk_echo "${bg_magenta-}${white-}###### DKTEST MODE ###### ${DKSCRIPT_NAME} ###### DKTEST MODE ######${clr-}"
		dk_call dk_echo
		dk_source "${DKSCRIPT_PATH}" || echo "'dk_source ${DKSCRIPT_NAME}' failed"
		(command -v DKTEST) && DKTEST || echo "'DKTEST' failed"
		dk_call dk_echo
		dk_call dk_echo "${bg_magenta-}${white-}########################## END TEST ################################${clr-}"
		dk_call dk_echo
		dk_call dk_exit 0
	fi
}

##################################################################################
# dkreloadWithBash()
#
dkreloadWithBash() {
	[ -n "${DKBASH_RELOADED-}" ] && echo "returning from dkreloadWithBash" && return 0;
	echo "dkreloadWithBash($*)";
	#[ -n "${BASH-}" ] && return;
	#[ "${DKSHELL-}" = "bash" ] && return;
	
	(command -v bash) &>/dev/null || dk_installPackage bash || (echo "ERROR: dk_installPackage bash failed"; exit ${BASH_LINENO[0]};)
	(command -v bash) &>/dev/null && export BASH_EXE=$(command -v bash) || (echo "ERROR: 'bash' not found"; exit ${BASH_LINENO[0]};)
	echo "Reloading ${DKSCRIPT_PATH} with ${BASH_EXE} . . .";
	unset DK_SH;
	export DKBASH_RELOADED=1;
	[ -e "${DKSCRIPT_PATH}" ] && exec "${BASH_EXE}" "${DKSCRIPT_PATH}" || (echo "ERROR: 'dkreloadWithBash' failed"; exit ${BASH_LINENO[0]};)
	#[ -e "${DKSCRIPT_PATH}" ] && exec /usr/bin/bash "${DKSCRIPT_PATH}";
	#exec env -i HOME="$HOME" PATH="$PATH" BASH_EXE="${BASH_EXE}" ${BASH_EXE} -l -c '${0}';
}



##################################################################################
# dk_download(url, destination)
#
#
dk_download() {
	echo "dk_download($*)"
	
    [ -e "${2-}" ] && (echo "WARNING: dk_download(): ${2} already exists"; return 0;)
    echo "Downloading $(basename ${1}) . . ."
	echo "${1} ->  ${2}"
    parentdir="$(dirname "${2}")"
    # OLDPWD=${PWD}
    # cd "${parentdir}"
    
    #dk_commandExists "wget" || dk_installPackage wget
    #dk_commandExists "curl" || dk_installPackage curl
	[ ! -e "${2}" ] && (command -v curl &>/dev/null) && $(SUDO_EXE) curl --silent -Lo "${2}" "${1}"
    [ ! -e "${2}" ] && (command -v wget &>/dev/null) && $(SUDO_EXE) wget -P "${parentdir}" "${1}"
   
    # cd "${OLDPWD}"
}

##################################################################################
# WSLPATH_EXE()
#
WSLPATH_EXE(){
	#echo "WSLPATH_EXE()"
	
	(command -v wslpath >&2) || echo "wslpath Not Found" >&2
}

##################################################################################
# CYGPATH_EXE()
#
CYGPATH_EXE(){
	builtin echo "CYGPATH_EXE()"
	
	(command -v cygpath >&2) || echo "cygpath Not Found" >&2
}

##################################################################################
# DKSCRIPT_VARS()
#
DKSCRIPT_VARS(){
	#echo "DKSCRIPT_VARS()"
	
	[ ! -e "${DKSCRIPT_PATH-}" ] && [ -e "$(WSLPATH_EXE)" ] && export DKSCRIPT_PATH=$($(WSLPATH_EXE) -u $(dk_realpath ${0}))	 	# Windows subsystem for linux
	[ ! -e "${DKSCRIPT_PATH-}" ] && [ -e "$(CYGPATH_EXE)" ] && export DKSCRIPT_PATH=$($(CYGPATH_EXE) -u $(dk_realpath ${0}))		# Git for Windows	
	[ ! -e "${DKSCRIPT_PATH-}" ] && export DKSCRIPT_PATH=$(dk_realpath ${0})														# Default
    [ -e "${DKSCRIPT_PATH}" ]	 && echo "DKSCRIPT_PATH = ${DKSCRIPT_PATH}" || (echo "ERROR: DKSCRIPT_PATH:${DKSCRIPT_PATH} not found"; exit ${BASH_LINENO[0]};)    
    export DKSCRIPT_ARGS=$(${*})							&& echo "DKSCRIPT_ARGS = ${DKSCRIPT_ARGS}"				
    export DKSCRIPT_DIR=$(dirname "${DKSCRIPT_PATH}")		&& echo "DKSCRIPT_DIR = ${DKSCRIPT_DIR}"	
    export DKSCRIPT_NAME=$(basename "${DKSCRIPT_PATH}")		&& echo "DKSCRIPT_NAME = ${DKSCRIPT_NAME}"	
    export DKSCRIPT_EXT=".${DKSCRIPT_NAME##*.}"				&& echo "DKSCRIPT_EXT = ${DKSCRIPT_EXT}"
} 

##################################################################################
# dksetOptions()
#
dksetOptions(){
	#echo "dksetOptions()"
	
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
    # $(set +o) && set +o	# Unset the option corresponding to option-name:
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
	#echo "dk_installPackage()"
	
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
	(command -v dk_installPackage &>/dev/null)  && (echo "ERROR: No package managers found."; exit ${BASH_LINENO[0]};)

	${dk_installPackage} ${1}
	(command -v ${1} &>/dev/null) || (echo "ERROR: ${1}: command not found"; exit ${BASH_LINENO[0]};) 
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
