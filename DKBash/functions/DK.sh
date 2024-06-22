#!/bin/sh
[ -n "${DKINIT-}" ] && return || export DKINIT=1	# include_guard

##################################################################################
# DKINIT()
#
#
DK (){
	dk_echo "DKINIT($*)"
	
	
	###### Initialize Language specifics ######
	dk_init


	###### Reload Main Script with bash ######
	dk_reloadWithBash $*
	
	
	############ Get DKBASH variables ############
	dk_DKBASH_VARS
	dk_echo "DKBASH_DIR = ${DKBASH_DIR}"
	dk_echo "DKBASH_FUNCTIONS_DIR = ${DKBASH_FUNCTIONS_DIR}"


	############ Get DKHTTP variables ############
	dk_DKHTTP_VARS
	dk_echo "DKHTTP_DKBASH_FUNCTIONS_DIR = ${DKHTTP_DKBASH_FUNCTIONS_DIR}"


	############ Setup dk_callStack ############
	#dk_setupCallstack
	#call dk_callStack
	#:dk_callStackReturn


	############ Get DKSCRIPT variables ############
	dk_DKSCRIPT_VARS
	dk_echo "DKSCRIPT_PATH = ${DKSCRIPT_PATH}"
	dk_echo "DKSCRIPT_ARGS = ${DKSCRIPT_ARGS}"
	dk_echo "DKSCRIPT_DIR = ${DKSCRIPT_DIR}"
	dk_echo "DKSCRIPT_NAME = ${DKSCRIPT_NAME}"
	
	
	############ Setup KeepOpen ############
	#dk_setupKeepOpen
	
	
	##### CD into the DKSCRIPT_DIR directory #####
	#cd "${DKSCRIPT_DIR}"


	############ Set Options ############
	dk_setOptions
	
	
	###### Script loader ######
	dk_source dk_return
	dk_source __TIME__
	dk_source __FILE__
	dk_source __LINE__
	dk_source __FUNCTION__
	dk_source __ARGC__
	dk_source __ARGV__
	dk_source __CALLER__
	dk_source dk_debugFunc
	dk_source dk_load
	dk_load dk_onExit    	# EXIT handler
	dk_load dk_onError   	# ERR handler
	
	dk_call dk_color
		
	dk_load ${DKSCRIPT_PATH}
				
	
	


	###### DKTEST MODE ######
	if [ "${ENABLE_DKTEST-1}" = "1" ]; then
		if [ "${DKSCRIPT_DIR}" = "${DKBASH_FUNCTIONS_DIR}" ]; then
			#export ENABLE_dk_debugFunc=1
			echo ""
			echo "${bg_white}${black}###### DKTEST MODE ###### ${DKSCRIPT_NAME} ###### DKTEST MODE ######${clr}"
			echo ""
			#. ${DKSCRIPT_PATH}
			#echo $(type DKTEST | sed '1,1d') 			# print DKTEST() code
			DKTEST
			echo ""
			echo "${bg_white}${black}########################## END TEST ################################${clr}"
			echo ""
			dk_source dk_pause && dk_pause
			exit
		fi
	fi
}




##################################################################################
# dk_echo()
#
dk_echo(){
	echo $*
}

##################################################################################
# dk_init()
#
dk_init(){
	dk_echo "### DKBash ###"
}

##################################################################################
# dk_reloadWithBash()
#
dk_reloadWithBash(){
	if [ ${RELOAD_WITH_BASH-1} = 1 ]; then
		export RELOAD_WITH_BASH=0
		echo "reloading with bash . . ."
		unset DKINIT
		export readonly DKINIT
		dk_command bash "$0"
	fi
}

##################################################################################
# dk_DKBASH_VARS()
#
dk_DKBASH_VARS(){
	export BASH_SOURCE_DIR=$( cd -- "$(dirname "$BASH_SOURCE")" >/dev/null 2>&1 ; pwd -P )
	export DKBASH_DIR=$( cd -- "$(dirname "$BASH_SOURCE_DIR")" >/dev/null 2>&1 ; pwd -P )
	export DKBASH_FUNCTIONS_DIR="${DKBASH_DIR}/functions"
	[ -e ${DKBASH_FUNCTIONS_DIR}/DK.sh ] || [$(read -rp '${DKBASH_FUNCTIONS_DIR}/DK.sh not found, press enter to exit')] || exit;
	chmod 777 ${DKBASH_FUNCTIONS_DIR}/*
	#export PATH=${PATH}:${DKBASH_FUNCTIONS_DIR}
	
	###### set true and false variables ######
	export readonly true=0
	export readonly false=1
}

##################################################################################
# dk_DKHTTP_VARS()
#
dk_DKHTTP_VARS(){
	export DKHTTP_DIGITALKNOB_DIR="https://raw.githubusercontent.com/aquawicket/DigitalKnob"
	export DKHTTP_DKBRANCH_DIR="${DKHTTP_DIGITALKNOB_DIR}/Development"
	export DKHTTP_DKBASH_DIR="${DKHTTP_DKBRANCH_DIR}/DKBash"
	export DKHTTP_DKBASH_FUNCTIONS_DIR="${DKHTTP_DKBASH_DIR}/functions"
}

##################################################################################
# dk_setupCallstack()
#
dk_setupCallstack(){
	[ -e ${DKBASH_FUNCTIONS_DIR}/dk_callStack.sh ] || dk_command curl -Lo DKBash/functions/dk_callStack.sh ${DKHTTP_DKBASH_FUNCTIONS_DIR}/dk_callStack.sh
}

##################################################################################
# dk_DKSCRIPT_VARS()
#
dk_DKSCRIPT_VARS(){
	[ -e $(cd "$(dirname "$0")"; pwd -P)/$(basename $0) ] && export DKSCRIPT_PATH=$(cd "$(dirname "$0")"; pwd -P)/$(basename $0)
	[ -n "$(command -v "cygpath")" ] && DKSCRIPT_PATH=$(cygpath -u "${DKSCRIPT_PATH}")
	[ -e ${DKSCRIPT_PATH} ] || [$(read -rp 'DKSCRIPT_PATH:${DKSCRIPT_PATH} not found, press enter to exit')] || exit;
	export DKSCRIPT_ARGS=$($*)
	export DKSCRIPT_DIR=$(dirname ${DKSCRIPT_PATH})
	[ -d ${DKSCRIPT_DIR} ] || [$(read -rp 'DKSCRIPT_DIR:${DKSCRIPT_DIR} not found, press enter to exit')] || exit;
	export DKSCRIPT_NAME=$(basename ${DKSCRIPT_PATH})
}

##################################################################################
# dk_setupKeepOpen()
#
dk_setupKeepOpen(){
	dk_echo ""
	#if "%KEEP_CONSOLE_OPEN%" equ "1" if not defined in_subprocess (cmd /k set in_subprocess=y ^& set "DKINIT=" ^& "%DKSCRIPT_PATH%" %DKSCRIPT_ARGS%) & set "DKINIT=1" & exit )
}

##################################################################################
# dk_setOptions()
#
dk_setOptions(){
	###### Set and check posix mode ######
	$(set -o posix) && set -o posix && case :$SHELLOPTS: in
	  *:posix:*) echo "POSIX mode enabled" ;;
	  *)         echo "POSIX mode not enabled" ;;
	esac
	
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
	[ -n "$(command -v "$1")" ] && return 					# if the command already exists, return
	[ -n "$(command -v "apk")" ] && apk add $1				# AlpineLinux package installer
	[ -n "$(command -v "tce-load")" ] && tce-load -wil $1	# TinyCoreLinux package installer: -l flag means don't add to boot
	[ -n "$(command -v "$1")" ] || [$(read -rp '$1 command not found, press enter to exit')] || exit;
}

##################################################################################
# dk_source()
#
#	source a DKBash function. Download it first if it's missing
#
dk_source(){
	[ -e ${DKBASH_FUNCTIONS_DIR}/$1.sh ] || dk_command curl -Lo DKBash/functions/$1.sh ${DKHTTP_DKBASH_FUNCTIONS_DIR}/$1.sh
	[ -e ${DKBASH_FUNCTIONS_DIR}/$1.sh ] || [$(read -rp '$1 command not found, press enter to exit')] || exit;
	chmod 777 ${DKBASH_FUNCTIONS_DIR}/$1.sh
	. ${DKBASH_FUNCTIONS_DIR}/$1.sh
}

##################################################################################
# dk_call()
#
#	call a DKBash function. dk_load it first if needed.
#
dk_call(){
	[ -z "$(command -v "dk_load")" ] && dk_source dk_load
	[ -z "$(command -v "$1")" ] && dk_load $1
	[ -n "$(command -v "$1")" ] || [$(read -rp '$1 command not found, press enter to exit')] || exit;
	echo "$@"
	"$@"
}

##################################################################################
# dk_command()
#
#	run a unix command. Install it first if it's missing
#
dk_command(){
	[ -z "$(command -v "$1")" ] && dk_install $1
	[ -n "$(command -v "$1")" ] || [$(read -rp '$1 command not found, press enter to exit')] || exit;
	echo "$@"
	"$@"
}

DK

#DK_TRY_CATCH (){
	# Don't pipe the subshell into anything or we won't be able to see its exit status
#	set +e; ( set -e
#		DK
#	); err_status=$?; set -e
#
#	if [ "${err_status}" -ne "0" ]; then
#		echo "ERROR_STATUS: ${err_status}"
#		#read -rp 'press enter to exit'
#		exit ${err_status}
#	fi
#}


#if $(ps -o >/dev/null 2>&1);then  
#	THIS_PATH=$(ps -o args= $PID | tail -n 6 | awk 'FNR==1 {print $2}')
#	$echo "    THIS_PATH = $THIS_PATH"
#	PARENT_PATH=$(ps -o args= $PPID | awk '{print $2}')
#	$echo "    PARENT_PATH = $PARENT_PATH"
#else
#	#echo "ps -o NOT AVAILABLE"
#	echo $(ps -p -f $PPID)
#fi
