#!/bin/sh
[ -n "${DKINIT-}" ] && return || export DKINIT=1	# include_guard

##################################################################################
# DKINIT()
#
#
DK (){
	#dk_debugFunc
	
	
	###### Initialize Language specifics ######
	dk_init
	#dk_echo "DKINIT(${*})"


	###### Reload Main Script with bash ######
	dk_reloadWithBash ${*}


	############ Get DKBASH variables ############
	dk_DKBASH_VARS
	#dk_printVar DKBASH_DIR
	#dk_printVar DKBASH_FUNCTIONS_DIR


	############ Get DKHTTP variables ############
	dk_DKHTTP_VARS
	#dk_printVar DKHTTP_DKBASH_FUNCTIONS_DIR


	############ Setup dk_callStack ############
	#dk_setupCallstack
	#dk_callStack
	#:dk_callStackReturn


	############ Get DKSCRIPT variables ############
	dk_DKSCRIPT_VARS
	#dk_printVar DKSCRIPT_PATH
	#dk_printVar DKSCRIPT_ARGS
	#dk_printVar DKSCRIPT_DIR
	#dk_printVar DKSCRIPT_NAME


	############ Setup KeepOpen ############
	#dk_setupKeepOpen


	##### CD into the DKSCRIPT_DIR directory #####
	#cd "${DKSCRIPT_DIR}"


	############ Set Options ############
	dk_setOptions


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
	dk_source dk_load
	dk_load dk_exit
	dk_load dk_onExit    	# EXIT handler
	dk_load dk_onError   	# ERR handler
	dk_load dk_color
	dk_call dk_logo
	dk_load "${DKSCRIPT_PATH}"
	
	###### DKTEST MODE ######
	if [ "${ENABLE_DKTEST-1}" = "1" ]; then
		if [ "${DKSCRIPT_DIR}" = "${DKBASH_FUNCTIONS_DIR}" ]; then
			dk_echo
			dk_echo "${bg_magenta-}${white-}###### DKTEST MODE ###### ${DKSCRIPT_NAME} ###### DKTEST MODE ######${clr-}"
			dk_echo
			#dk_echo $(type DKTEST | sed '1,1d') 			# print DKTEST() code
			DKTEST
			dk_echo
			dk_echo "${bg_magenta-}${white-}########################## END TEST ################################${clr-}"
			dk_echo
			dk_call dk_pause
			dk_exit 0
		fi
	fi
}




##################################################################################
# dk_init()
#
dk_init(){
	#dk_debugFunc
	
	###### fallback functions ######
	$(command -v dk_commandExists) || dk_commandExists(){ $(command -v ${1} 1>/dev/null); }
	dk_commandExists "dk_echo"           || dk_echo()           { echo ${*};                                                                                                        }
	dk_commandExists "dk_error"          || dk_error()          { dk_echo "${red}ERROR: ${1}${clr}"; [$(read -rp "press enter to exit")] || exit;                                 }
	dk_commandExists "dk_warning"        || dk_warning()        { dk_echo "${yellow}WARNING: ${1}${clr}";                                                                         }
	dk_commandExists "dk_info"           || dk_info()           { dk_echo "${1}";                                                                                                 }
	dk_commandExists "dk_debug"          || dk_debug()          { dk_echo "${blue}${1}${clr}";                                                                                    }
	dk_commandExists "dk_verbose"        || dk_verbose()        { dk_echo "${cyan}${1}${clr}";                                                                                    }
	dk_commandExists "dk_printVar"       || dk_printVar()       { dk_echo "${blue}${1} = ${!1-}${clr}";                                                                           }
	dk_commandExists "dk_pathExists"     || dk_pathExists()     { [ -e "${1}" ];                                                                                                  }
	dk_commandExists "dk_stringContains" || dk_stringContains() { [ "${1#*"$2"}" != "${1}" ];                                                                                     }
	dk_commandExists "dk_unset"          || dk_unset()          { dk_commandExists "unset"    && unset "${1}";                                                                    }
	dk_commandExists "dk_export"         || dk_export()         { dk_commandExists "export"   && export ${1}="${2}";                                                                }
	dk_commandExists "dk_defined"        || dk_defined()        { dk_commandExists "eval"     && eval value='$'{${1}+x}; [ -n "${value}" ];                                         }
	dk_commandExists "dk_basename"       || dk_basename()       { dk_commandExists "basename" && echo $(basename ${1}) || dk_error "basename is not implemented";                 }
	dk_commandExists "dk_dirname"        || dk_dirname()        { dk_commandExists "dirname"  && echo $(dirname ${1})  || dk_error "dirname is not implemented";                  }
	dk_commandExists "dk_realpath"       || dk_realpath()       { dk_commandExists "realpath" && echo $(realpath ${1}) || echo $(cd $(dirname ${1}); pwd -P)/$(dk_basename ${1}); }
	dk_commandExists "dk_debugFunc"      || dk_debugFunc()      { dk_echo "${cyan}$(basename ${BASH_SOURCE[0]}):${BASH_LINENO[0]}  ${blue}${FUNCNAME[0]}(${BASH_ARGC[0]})${clr}"; }

	###### default variables ######
	dk_defined ESC        || dk_export ESC        ""
	dk_defined clr        || dk_export clr        "${ESC}[0m"
	dk_defined black      || dk_export black      "${ESC}[30m"
	dk_defined red        || dk_export red        "${ESC}[31m"
	dk_defined yellow     || dk_export yellow     "${ESC}[33m"
	dk_defined blue       || dk_export blue       "${ESC}[34m"
	dk_defined cyan       || dk_export cyan       "${ESC}[36m"
	dk_defined bg_magenta || dk_export bg_magenta "${ESC}[45m"
}

##################################################################################
# dk_reloadWithBash()
#
dk_reloadWithBash(){
	#dk_debugFunc
	
	if [ ${RELOAD_WITH_BASH-1} = 1 ]; then
		dk_export  RELOAD_WITH_BASH 0
		#dk_echo   "reloading with bash . . ."
		dk_unset   DKINIT
		dk_export  DKINIT
		dk_command bash "${0}"
	fi
}

##################################################################################
# dk_DKBASH_VARS()
#
dk_DKBASH_VARS(){
	#dk_debugFunc
	
	dk_export BASH_SOURCE_DIR      $( cd -- "$(dirname "$BASH_SOURCE")"; pwd -P )
	dk_export DKBASH_DIR           $( cd -- "$(dirname "$BASH_SOURCE_DIR")" &>/dev/null; pwd -P )
	dk_export DKBASH_FUNCTIONS_DIR "${DKBASH_DIR}/functions"
	dk_pathExists "${DKBASH_FUNCTIONS_DIR}/DK.sh" || dk_error "${DKBASH_FUNCTIONS_DIR}/DK.sh not found"
	dk_call ${dksudo} chmod 777 ${DKBASH_FUNCTIONS_DIR}/*
	#dk_export PATH ${PATH}:${DKBASH_FUNCTIONS_DIR}

	###### set true and false variables ######
	dk_export true 0
	dk_export false 1
}

##################################################################################
# dk_DKHTTP_VARS()
#
dk_DKHTTP_VARS(){
	#dk_debugFunc
	
	dk_export DKHTTP_DIGITALKNOB_DIR      "https://raw.githubusercontent.com/aquawicket/DigitalKnob"
	dk_export DKHTTP_DKBRANCH_DIR         "${DKHTTP_DIGITALKNOB_DIR}/Development"
	dk_export DKHTTP_DKBASH_DIR           "${DKHTTP_DKBRANCH_DIR}/DKBash"
	dk_export DKHTTP_DKBASH_FUNCTIONS_DIR "${DKHTTP_DKBASH_DIR}/functions"
}

##################################################################################
# dk_setupCallstack()
#
dk_setupCallstack(){
	#dk_debugFunc
	
	dk_pathExists "${DKBASH_FUNCTIONS_DIR}/dk_callStack.sh" || dk_command curl -Lo ${DKBASH_FUNCTIONS_DIR}/dk_callStack.sh ${DKHTTP_DKBASH_FUNCTIONS_DIR}/dk_callStack.sh
}

##################################################################################
# dk_DKSCRIPT_VARS()
#
dk_DKSCRIPT_VARS(){
	#dk_debugFunc
	
	#dk_pathExists   $(cd "$(dirname "${0}")"; pwd -P)/$(basename ${0}) && export DKSCRIPT_PATH=$(cd "$(dirname "${0}")"; pwd -P)/$(basename ${0})
	dk_pathExists    $(dk_realpath ${0}) && dk_export   DKSCRIPT_PATH   $(dk_realpath ${0})
	dk_commandExists "cygpath"           && DKSCRIPT_PATH=$(cygpath -u "${DKSCRIPT_PATH}")
	dk_pathExists    "${DKSCRIPT_PATH}"  || dk_error "DKSCRIPT_PATH:${DKSCRIPT_PATH} not found"
	dk_export        DKSCRIPT_ARGS       $(${*})
	dk_export        DKSCRIPT_DIR        $(dirname ${DKSCRIPT_PATH})
	dk_pathExists    "${DKSCRIPT_DIR}"   || dk_error "DKSCRIPT_DIR:${DKSCRIPT_DIR} not found"
	dk_export        DKSCRIPT_NAME       $(basename ${DKSCRIPT_PATH})
}

##################################################################################
# dk_setupKeepOpen()
#
dk_setupKeepOpen(){
	#dk_debugFunc
	
	dk_echo
	#if "%KEEP_CONSOLE_OPEN%" equ "1" if not defined in_subprocess (cmd /k set in_subprocess=y ^& set "DKINIT=" ^& "%DKSCRIPT_PATH%" %DKSCRIPT_ARGS%) & set "DKINIT=1" & exit )
}

##################################################################################
# dk_setOptions()
#
dk_setOptions(){
	#dk_debugFunc
	
	###### Set and check posix mode ######
	$(set -o posix) && set -o posix
#	case :${SHELLOPTS}: in
#	  *:posix:*) echo "POSIX mode enabled" ;;
#	  *)         echo "POSIX mode not enabled" ;;
#	esac

	###### Set error trace options ######
	# https://pubs.opengroup.org/onlinepubs/007904875/utilities/set.html
	$(set -o pipefail) && set -o pipefail  	# trace ERR through pipes
	$(set -o errtrace) && set -o errtrace 	# set -E : trace ERR through 'time command' and other functions
	$(set -o nounset)  && set -o nounset  	# set -u : exit the script if you try to use an uninitialised variable
	$(set -o errexit)  && set -o errexit  	# set -e : exit the script if any statement returns a non-true

	###### shopt ######
	shopt -s extdebug
	#shopt -s expand_aliases
}










##################################################################################
# dk_install()
#
#	install a unix package
#
dk_install(){
	#dk_debugFunc
	
	dk_commandExists ${1}      && return 					        # if the command already exists, return
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
# dk_source()
#
#	source a DKBash function. Download it first if it's missing
#
dk_source(){
	#dk_debugFunc
	
	dk_stringContains ${1} ".sh"  && local funcPath=${1}              ||      local funcPath=${1}.sh
	dk_pathExists "${funcPath}" && local funcPath="${funcPath}"
	dk_pathExists "${PWD}/$(basename ${funcPath})"                  && local funcPath="${PWD}/$(basename ${funcPath})"
	dk_pathExists "${DKBASH_FUNCTIONS_DIR}/$(basename ${funcPath})" || dk_command curl -Lo "${DKBASH_FUNCTIONS_DIR}/$(basename ${funcPath})" "${DKHTTP_DKBASH_FUNCTIONS_DIR}/$(basename ${funcPath})"
	dk_pathExists "${DKBASH_FUNCTIONS_DIR}/$(basename ${funcPath})" && local funcPath="${DKBASH_FUNCTIONS_DIR}/$(basename ${funcPath})"
	dk_pathExists "${funcPath}" || dk_error "Unable to fine funcPath:${funcPath}"
	chmod 777 ${funcPath}
	. ${funcPath}
}

##################################################################################
# dk_call()
#
#	call a DKBash function. dk_load it first if needed.
#
dk_call(){
	#dk_debugFunc
	
	if ! dk_commandExists "${1}"; then
		dk_commandExists dk_load  || dk_source dk_load
		dk_commandExists ${1}     || dk_load ${1}
		dk_commandExists ${1}     || dk_error "${1}: command not found"
	fi
	#dk_echo "${@}"
	"${@}"
}

##################################################################################
# dk_command()
#
#	run a unix command. Install it first if it's missing
#
dk_command(){
	#dk_debugFunc
	
	dk_commandExists ${1} || dk_install ${1}
	dk_commandExists ${1} || dk_error "${1}: command not found"
	#dk_echo "${@}"
	"${@}"
}


##################################################################################
# run DK() function
DK









#DK_TRY_CATCH (){
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
#	$echo "    THIS_PATH = $THIS_PATH"
#	PARENT_PATH=$(ps -o args= $PPID | awk '{print ${2}}')
#	$echo "    PARENT_PATH = $PARENT_PATH"
#else
#	#echo "ps -o NOT AVAILABLE"
#	echo $(ps -p -f $PPID)
#fi
