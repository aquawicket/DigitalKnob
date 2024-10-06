#!/bin/sh
echo "DK.h()"
[ -n "${DKINIT-}" ] && return 0 || export DKINIT=1  # include_guard

[ -n "$(command -v "sudo")" ] && export SUDO_EXE="sudo" || export SUDO_EXE=" "
##################################################################################
# DKINIT()
#
#
DK() {
	echo "DK($*)"
    #[ -n "${WSLENV+1}" ] && echo "WSLENV is on"
    
    ###### Initialize Language specifics ######
    dkinit
    
	# TODO: reload if not in bash shell
    ###### Reload Main Script with bash ######
#    dkreloadWithBash ${*}

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
    dk_DKSCRIPT_VARS

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
    dk_source dk_onExit        # EXIT handler
    dk_source dk_onError       # ERR handler
    dk_call dk_color
    dk_call dk_logo
    dk_source dk_download

	dk_call dk_validateDK || export RELOADED="" && dk_DKSCRIPT_VARS "${1-}" $*
	
    #dk_source dk_basename
    #dk_source "${DKSCRIPT_PATH}"
    #${DKSCRIPT_NAME} ${DKSCRIPT_ARGS}

    ###### DKTEST MODE ######
    [ "${DKSCRIPT_DIR}" = "${DKBASH_FUNCTIONS_DIR}" ] || return 0
    [ "${DKSCRIPT_EXT}" = ".sh" ] || return 0
        dk_source dk_call
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
        dk_call dk_exit ${?}
}

##################################################################################
# dkreloadWithBash()
#
dkreloadWithBash(){
	echo "dkreloadWithBash($*)"
    if [ ${RELOAD_WITH_BASH-1} -eq 1 ]; then
        export RELOAD_WITH_BASH=0
        echo "reloading with bash . . . ${0}"
        unset DKINIT
        export DKINIT=""
        dk_commandExists bash || dk_installPackage bash
        exec bash "${0}"
    fi
}

##################################################################################
# dkinit()
#     default functions and variables
#
dkinit(){
	echo "dkinit($*)"
    echo "Loading DKBash DigitalKnob . . ."
    $(command -v dk_commandExists)       || dk_commandExists(){ $(command -v ${1} 1>/dev/null); }
    dk_commandExists builtin             && export builtin="builtin"
    #dk_commandExists dk_defined          || dk_commandExists     eval   && dk_defined(){ ${builtin} eval value='$'{${1}+x}; [ -n "${value}" ]; }  # dk_defined variable
    #dk_commandExists dk_export           || dk_commandExists     export && dk_export() { ${builtin} export ${1}="${2}"; }                         # dk_export variable value
    #dk_commandExists dk_echo             || dk_commandExists     echo   && dk_echo()   { ${builtin} echo "${*}"; }                                # dk_echo "test dk_echo"
    #dk_commandExists dk_pause            || dk_commandExists     read   && dk_pause()  { dk_echo "Press enter to continue..."; read -rp ''; }     # dk_pause
    #dk_commandExists dk_log              || dk_log()             { [ -n $2 ] && dk_echo "${2}${clr}" || dk_echo "${1}${clr}"; }                   # dk_warning "test dk_warning";
    #dk_commandExists dk_warning          || dk_warning()         { dk_echo "${yellow}WARNING: ${1}${clr}"; }                                      # dk_warning "test dk_warning";
    #dk_commandExists dk_info             || dk_info()            { dk_echo "${clr}   INFO: ${1}${clr}"; }                                         # dk_info "test dk_info";
    #dk_commandExists dk_debug            || dk_debug()           { dk_echo "${blue}  DEBUG: ${1}${clr}"; }                                        # dk_debug "test dk_debug";
    #dk_commandExists dk_verbose          || dk_verbose()         { dk_echo "${cyan}VERBOSE: ${1}${clr}"; }                                        # dk_verbose "test dk_verbose";
    #dk_commandExists dk_error            || dk_error()           { dk_echo "${red}  ERROR: ${1}${clr}"; dk_pause; }                               # dk_error "test dk_error";
    #dk_commandExists dk_fatal            || dk_fatal()           { dk_echo "${red}  FATAL: ${1}${clr}"; dk_pause; exit; }                         # dk_fatal "test dk_fatal";
    #dk_commandExists dk_printVar         || dk_printVar()        { dk_echo "${cyan}${1} = ${blue}${!1-}${clr}"; }                                 # dk_printVar variable
    #dk_commandExists dk_pathExists       || dk_pathExists()      { [ -e "${1}" ]; }                                                               # dk_pathExists "/usr/bin"
    #dk_commandExists dk_stringContains   || dk_stringContains()  { [ "${1#*"$2"}" != "${1}" ]; }                                                  # dk_stringContains string search
    #dk_commandExists dk_unset            || dk_commandExists     unset    && dk_unset()   { ${builtin} unset "${1}"; }                            # dk_unset variable
    dk_commandExists dk_basename         || dk_commandExists basename  && dk_basename(){ ${builtin-} echo $(basename ${1-}); }                       # dk_basename path
    dk_commandExists dk_dirname          || dk_commandExists dirname   && dk_dirname() { ${builtin} echo $(dirname ${1}); }                        # dk_dirname path
    dk_commandExists dk_realpath         || dk_commandExists realpath  && dk_realpath(){ ${builtin} echo $(realpath ${1}); } || dk_realpath(){ ${builtin} echo $(cd $(dk_dirname ${1}); pwd -P)/$(dk_basename ${1}); }
    dk_commandExists dk_debugFunc        || dk_debugFunc(){
        [ "${ENABLE_dk_debugFunc-0}" -eq "1" ] && echo "$(dk_basename ${BASH_SOURCE[1]-}):${BASH_LINENO[1]}  ${FUNCNAME[1]}(${BASH_ARGC[1]})" || return $(true)
    }
}

##################################################################################
# DKBASH_VARS()
#
DKBASH_VARS(){
	echo "DKBASH_VARS($*)"
    #export BASH_SOURCE_DIR=$( cd -- "$(dk_dirname "${BASH_SOURCE-}")"; pwd -P )
    #export DKBASH_DIR=$( cd -- "$(dk_dirname "${BASH_SOURCE_DIR}")" &>/dev/null; pwd -P )
    export DKBASH_FUNCTIONS_DIR="${DKBASH_DIR}/functions"
    export DKBASH_FUNCTIONS_DIR_="${DKBASH_DIR}/functions/"
    [ -e "${DKBASH_FUNCTIONS_DIR}/DK.sh" ] || echo "ERROR: ${DKBASH_FUNCTIONS_DIR}/DK.sh not found"
	[ -e "${DKBASH_FUNCTIONS_DIR_}/DK.sh" ] || echo "ERROR: ${DKBASH_FUNCTIONS_DIR_}/DK.sh not found"
    #export PATH=${PATH}:${DKBASH_FUNCTIONS_DIR}
}

##################################################################################
# DKHTTP_VARS()
#
DKHTTP_VARS(){
	echo "DKHTTP_VARS($*)"
    export DKHTTP_DIGITALKNOB_DIR="https://raw.githubusercontent.com/aquawicket/DigitalKnob"
    export DKHTTP_DKBRANCH_DIR="${DKHTTP_DIGITALKNOB_DIR}/Development"
    export DKHTTP_DKBASH_DIR="${DKHTTP_DKBRANCH_DIR}/DKBash"
    export DKHTTP_DKBASH_FUNCTIONS_DIR="${DKHTTP_DKBASH_DIR}/functions"
}

##################################################################################
# dk_initFiles()
#
dk_initFiles(){
	echo "dk_initFiles($*)"
    [ -e "${DKBASH_DIR}/functions/dk_source.sh" ] || dk_download ${DKHTTP_DKBASH_FUNCTIONS_DIR}/dk_source.sh ${DKBASH_FUNCTIONS_DIR}/dk_source.sh
    [ -e "${DKBASH_DIR}/functions/dk_source.sh" ] && . "${DKBASH_DIR}/functions/dk_source.sh"
    [ -e "${DKBASH_DIR}/functions/dk_call.sh"   ] || dk_download ${DKHTTP_DKBASH_FUNCTIONS_DIR}/dk_call.sh ${DKBASH_FUNCTIONS_DIR}/dk_call.sh
    [ -e "${DKBASH_DIR}/functions/dk_call.sh"   ] && . "${DKBASH_DIR}/functions/dk_call.sh"
}

##################################################################################
# dk_download(url, destination)
#
#
dk_download() {
	echo "dk_download($*)"
    if [ -e "${2-}" ]; then
        echo "WARNING: dk_download(): ${2} already exists"
        return ${?}
    fi
    echo "Downloading $(dk_basename ${1}) . . ."
    parentdir="$(dk_dirname "${2-}")"
    OLDPWD=${PWD}
    cd "${parentdir}"
    
    dk_commandExists "wget" || dk_installPackage wget
    dk_commandExists "curl" || dk_installPackage curl
    [ -e "${2}" ] || dk_commandExists "wget" && ${SUDO_EXE} wget -P "${parentdir}" "${1}"
    [ -e "${2}" ] || dk_commandExists "curl" && ${SUDO_EXE} curl --silent -Lo "${2}" "${1}"
    
    cd "${OLDPWD}"
}

##################################################################################
# dksetupCallstack()
#
dksetupCallstack(){ 
	echo "dksetupCallstack($*)"   
    #[ -e "${DKBASH_FUNCTIONS_DIR}/dk_callStack.sh" ] || dk_call curl --silent -Lo ${DKBASH_FUNCTIONS_DIR}/dk_callStack.sh ${DKHTTP_DKBASH_FUNCTIONS_DIR}/dk_callStack.sh
    [ -e "${DKBASH_FUNCTIONS_DIR}/dk_callStack.sh" ] || dk_download ${DKHTTP_DKBASH_FUNCTIONS_DIR}/dk_callStack.sh ${DKBASH_FUNCTIONS_DIR}/dk_callStack.sh
}

##################################################################################
# dk_DKSCRIPT_VARS()
#
dk_DKSCRIPT_VARS(){
	echo "dk_DKSCRIPT_VARS($*)"
    ### DKSCRIPT_PATH ###
    dk_call dk_defined           DKSCRIPT_PATH           || export DKSCRIPT_PATH="$(dk_call dk_realpath ${0})"
    dk_call dk_pathExists    "${DKSCRIPT_PATH}"          || export DKSCRIPT_PATH="$(dk_call dk_realpath ${1})"
    #dk_call dk_commandExists "cygpath"                   && dk_call dk_pathExists    "${DKSCRIPT_PATH}"          || DKSCRIPT_PATH=$(cygpath -u "${DKSCRIPT_PATH}")
    dk_call dk_pathExists    "${DKSCRIPT_PATH}"          || dk_call dk_fatal "DKSCRIPT_PATH:${DKSCRIPT_PATH} not found"
    #dk_call dk_pathExists    "${DKSCRIPT_PATH}"          && echo "DKSCRIPT_PATH = ${DKSCRIPT_PATH}"
    dk_call dk_printVar  DKSCRIPT_PATH

    ### DKSCRIPT_ARGS ###
    dk_call dk_defined         DKSCRIPT_ARGS                 || export DKSCRIPT_ARGS $(${*})
    #dk_call dk_defined         DKSCRIPT_ARGS                 && echo "DKSCRIPT_ARGS = ${DKSCRIPT_ARGS}"
    
    ### DKSCRIPT_DIR ###
    dk_call dk_export DKSCRIPT_DIR $(dk_call dk_dirname "${DKSCRIPT_PATH}")
    dk_call dk_pathExists    "${DKSCRIPT_DIR}"           || dk_call dk_fatal "DKSCRIPT_DIR:${DKSCRIPT_DIR} not found"
    #dk_call dk_pathExists    "${DKSCRIPT_DIR}"           && echo "DKSCRIPT_DIR = ${DKSCRIPT_DIR}"
    
    ### DKSCRIPT_NAME ###
    dk_call dk_export DKSCRIPT_NAME $(dk_call dk_basename "${DKSCRIPT_PATH}")
    #dk_call dk_defined         DKSCRIPT_NAME                 && echo "DKSCRIPT_NAME = ${DKSCRIPT_NAME}"
    
    ### DKSCRIPT_EXT ###
    dk_call dk_export DKSCRIPT_EXT ".${DKSCRIPT_NAME##*.}"
    #dk_call dk_defined         DKSCRIPT_EXT                 && echo "DKSCRIPT_EXT = ${DKSCRIPT_EXT}"
    
    ### DKBRANCH_DIR ###
    dk_call dk_pathExists    "${DKBRANCH_DIR}"           || export DKBRANCH_DIR $(dk_dirname "${DKBASH_DIR}")
    #dk_call dk_pathExists    "${DKBRANCH_DIR}"           && echo "DKBRANCH_DIR = ${DKBRANCH_DIR}"
    
    ### DKBRANCH ###
    dk_call dk_pathExists    "${DKBRANCH}"               || export DKBRANCH $(dk_call dk_basename "${DKBRANCH_DIR}")
    #dk_call dk_pathExists    "${DKBRANCH}"               && echo "DKBRANCH = ${DKBRANCH}"
    
    ### DIGITALKNOB_DIR ###
    dk_call dk_pathExists    "${DIGITALKNOB_DIR}"        || export DIGITALKNOB_DIR $(dk_call dk_dirname "${DKBRANCH_DIR}")
    #dk_call dk_pathExists    "${DIGITALKNOB_DIR}"        && echo "DIGITALKNOB_DIR = ${DIGITALKNOB_DIR}"
    
    ### DIGITALKNOB ###
    dk_call dk_defined         DIGITALKNOB                 || export DIGITALKNOB $(dk_call dk_basename "${DIGITALKNOB_DIR}")
    #dk_call dk_pathExists    "${DIGITALKNOB_DIR}"        && echo "DIGITALKNOB = ${DIGITALKNOB}"
    
    ### DKDOWNLOAD_DIR ###
    dk_call dk_pathExists    "${DKDOWNLOAD_DIR}"         || export DKDOWNLOAD_DIR "${DIGITALKNOB_DIR}/download"
    #dk_call dk_pathExists    "${DKDOWNLOAD_DIR}"         && echo "DKDOWNLOAD_DIR = ${DKDOWNLOAD_DIR}"
    
    ### DKHOME_DIR ###
    dk_call dk_pathExists    "${DKHOME_DIR}"                || export DKHOME_DIR $(dk_call dk_dirname "${DIGITALKNOB_DIR}")
    #dk_call dk_pathExists    "${DKHOME_DIR}"             && echo "DKHOME_DIR = ${DKHOME_DIR}"
    
    ### HOME ###
    dk_call dk_pathExists    "${HOME}"                    || export HOME "${DKHOME_DIR}"
    #dk_call dk_pathExists    "${HOME}"                    && echo "HOME = ${HOME}"
    
    ### DKCACHE_DIR ###
    dk_call dk_pathExists    "${DKCACHE_DIR}"            || DKCACHE_DIR="${DKHOME_DIR}/.dk"
    dk_call dk_pathExists    "${DKCACHE_DIR}"            || mkdir "${DKCACHE_DIR}"
    #dk_call dk_pathExists    "${DKCACHE_DIR}"            && echo "DKCACHE_DIR = ${DKCACHE_DIR}"
    
#    ### DKTEMP_DIR ###
#    dk_call dk_pathExists   "${DKTEMP_DIR}"              || DKTEMP_DIR="${TMP}"
#    dk_call dk_pathExists   "${DKTEMP_DIR}"              || DKTEMP_DIR="${TMPDIR}"
#    dk_call dk_pathExists   "${DKTEMP_DIR}"              || DKTEMP_DIR="${TMP_DIR}"
#    dk_call dk_pathExists   "${DKTEMP_DIR}"              || DKTEMP_DIR="${DIGITALKNOB_DIR}/.dk"
#    dk_call dk_pathExists   "${DKTEMP_DIR}"              && DKTEMP_DIR="${DKTEMP_DIR}/.dk"
#    dk_call dk_pathExists   "${DKTEMP_DIR}"              || mkdir "${DKTEMP_DIR}"
#    dk_call dk_pathExists   "${DKTEMP_DIR}"              || echo "ERROR: DKTEMP_DIR:${DKTEMP_DIR} does not exist"
#    dk_call dk_pathExists   "${DKTEMP_DIR}"              && cp "${DKSCRIPT_PATH}" "${DKTEMP_DIR}" 1>nul 2>nul
#    dk_call dk_pathExists   "${DKTEMP_DIR}"              && echo "DKTEMP_DIR = ${DKTEMP_DIR}"
    
    ### ASSETS ###
    #[ -e "${DKASSETS_DIR}" ] &&   DKASSETS_DIR="${DKSCRIPT_DIR}/assets"
    #[ -e "${DKASSETS_DIR}" ] &&   PATH="${DKASSETS_DIR}:${PATH}"
}

##################################################################################
# dksetOptions()
#
dksetOptions(){
	echo "dksetOptions($*)"
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
    $(set -o pipefail) && set -o pipefail      # trace ERR through pipes
    $(set -o errtrace) && set -o errtrace     # set -E : trace ERR through 'time command' and other functions
    $(set -o nounset)  && set -o nounset      # set -u : exit the script if you try to use an uninitialised variable
    $(set -o errexit)  && set -o errexit      # set -e : exit the script if any statement returns a non-true

    ###### shopt ######
    $(shopt -s extdebug) && shopt -s extdebug
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
return
	echo "dk_installPackage($*)"
    # dk_debugFunc 1
    
    #if dk_call dk_packageInstalled ${1}; then
    #    dk_call dk_warning "${1} already installed"
    #    return $(true);
    #fi
    
    dk_call dk_commandExists ${1} && return $(true)
    
    echo "installing ${1}. . ."
    if dk_call dk_commandExists apk; then
        dk_call apk add "${1}"                    # Alpine Package Keeper (alpine linux)
    elif dk_call dk_commandExists apt-get; then
        dk_call apt-get -y install "${1}"        # Apt-get (debian)
    elif dk_call dk_commandExists apt; then    
        dk_call apt -y install "${1}"            # Apt (debian)
    elif dk_call dk_commandExists brew; then    
        dk_call brew install "${1}"                # Homebrew (MacOS)
    elif dk_call dk_commandExists dnf; then
        dk_call dnf install "${1}"                # Dnf (yum)
    elif dk_call dk_commandExists emerge; then    
        dk_call emerge "${1}"                    # Portage
    elif dk_call dk_commandExists nix-env; then    
        dk_call nix-env -i "${1}"                # Nix
    elif dk_call dk_commandExists ohpm; then    
        dk_call ohpm install "${1}"                # Ohpm
    elif dk_call dk_commandExists pkg; then
        dk_call pkg install "${1}"                # Termux
    elif dk_call dk_commandExists pacman; then
        dk_call pacman -S "${1}" --noconfirm    # Pacman
    elif dk_call dk_commandExists swupd; then
        dk_call swupd bundle-add "${1}"            # Swupd
    elif dk_call dk_commandExists tce-load; then
        dk_call tce-load -wil "${1}"             # Tiny core linux
    elif dk_call dk_commandExists winget; then
        dk_call dk_call winget install "${1}"    # WinGet
    elif dk_call dk_commandExists xbps-install; then
        dk_call xbps-install "${1}"                # Xbps
    elif dk_call dk_commandExists zypper; then
        dk_call zypper in "${1}"                # Zypper
    else
        dk_call dk_error "ERROR: no package managers found"
    fi
    
    dk_commandExists ${1} || dk_fatal "${1}: command not found"
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
