#!/bin/sh
# Conditional expressions for POSIX shell   https://www.ibm.com/docs/zh-tw/aix/7.2?topic=shell-conditional-expressions-korn-posix
[ -n "${DKINIT-}" ] && return || export DKINIT=1

dk_install(){
	[ -n "$(command -v "$1")" ] && return
	[ -n "$(command -v "apk")" ] && apk add $1     # -l flag means don't add to boot
	[ -n "$(command -v "tce-load")" ] && tce-load -wil $1     # -l flag means don't add to boot
	[ -n "$(command -v "$1")" ] || [$(read -rp '$1 command not found, press enter to exit')] || exit;
}
dk_source(){
	[ -e ${DKBASH_DIR}/functions/$1.sh ] || dk_command curl -Lo DKBash/functions/$1.sh https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBash/functions/$1.sh
	[ -e ${DKBASH_DIR}/functions/$1.sh ] || [$(read -rp '$1 command not found, press enter to exit')] || exit;
	chmod 777 ${DKBASH_DIR}/functions/$1.sh
	. ${DKBASH_DIR}/functions/$1.sh
}
dk_call(){
	[ -z "$(command -v "dk_load")" ] && dk_source dk_load
	[ -z "$(command -v "$1")" ] && dk_load $1
	[ -n "$(command -v "$1")" ] || [$(read -rp '$1 command not found, press enter to exit')] || exit;
	
	echo "$@"
	"$@"
}
dk_command(){
	[ -z "$(command -v "$1")" ] && dk_install $1
	[ -n "$(command -v "$1")" ] || [$(read -rp '$1 command not found, press enter to exit')] || exit;
	
	echo "$@"
	"$@"
}
#alias dk_bash='dk_command bash'
##################################################################################
# DK(<args>)
#
#
DK () {
	#dk_debugFunc
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
	
	#echo "DK($*)"
	#echo "0 = $0"
	#echo "* = $*"
	#echo "@ = $@"
	#echo "BASH_SOURCE = ${BASH_SOURCE[@]}"
	#echo "BASH_SOURCE[0] = ${BASH_SOURCE[0]}"
	#echo "BASH_SOURCE[1] = ${BASH_SOURCE[1]}"
	#echo $(basename $(readlink /proc/$$/exe))
	#echo $(ps -p $$)
	#echo "PID = $PID"
	#echo "PPID = $PPID"
	#echo "SHLVL = $SHLVL"
	#echo "BASH_SUBSHELL = $BASH_SUBSHELL"
	#echo "BASH_EXECUTION_STRING = $BASH_EXECUTION_STRING"
	
	
	#export PS4=$'+\e[33m ${BASH_SOURCE[0]:-nofile}:${BASH_LINENO[0]:-noline} ${FUNCNAME[0]:-nofunc}()\e[0m  '
	
	[ -z ${ENABLE_DKTEST} ] && export ENABLE_DKTEST=1

	###### Reload Main Script with bash ######
	if [ ${RELOAD_WITH_BASH-1} = 1 ]; then
		export RELOAD_WITH_BASH=0
		echo "reloading with bash . . ."
		unset DKINIT
		export readonly DKINIT
		dk_command bash "$0"
	fi
		
	#if $(ps -o >/dev/null 2>&1);then  
	#	THIS_PATH=$(ps -o args= $PID | tail -n 6 | awk 'FNR==1 {print $2}')
	#	$echo "    THIS_PATH = $THIS_PATH"
	#	PARENT_PATH=$(ps -o args= $PPID | awk '{print $2}')
	#	$echo "    PARENT_PATH = $PARENT_PATH"
	#else
	#	#echo "ps -o NOT AVAILABLE"
	#	echo $(ps -p -f $PPID)
	#fi

	###### get DKSCRIPT_ variables  ######
	[ -n "$(command -v "dirname")" ]  || [$(read -rp 'dirname command not found, press enter to exit')]  || exit;
	[ -n "$(command -v "pwd")" ]      || [$(read -rp 'pwd command not found, press enter to exit')]      || exit;
	[ -n "$(command -v "basename")" ] || [$(read -rp 'basename command not found, press enter to exit')] || exit;

	#echo "\$(cd \$(dirname \$0); pwd -P)/\$(basename \$0) = $(cd "$(dirname "$0")"; pwd -P)/$(basename $0)"
	[ -e $(cd "$(dirname "$0")"; pwd -P)/$(basename $0) ] && export DKSCRIPT_PATH=$(cd "$(dirname "$0")"; pwd -P)/$(basename $0)

	[ -n "$(command -v "cygpath")" ] && DKSCRIPT_PATH=$(cygpath -u "${DKSCRIPT_PATH}")
	[ -e ${DKSCRIPT_PATH} ] || [$(read -rp 'DKSCRIPT_PATH:${DKSCRIPT_PATH} not found, press enter to exit')] || exit;
	echo "\${DKSCRIPT_PATH} = ${DKSCRIPT_PATH}"

	export DKSCRIPT_DIR=$(dirname ${DKSCRIPT_PATH})
	[ -d ${DKSCRIPT_DIR} ] || [$(read -rp 'DKSCRIPT_DIR:${DKSCRIPT_DIR} not found, press enter to exit')] || exit;
	echo "\${DKSCRIPT_DIR} = ${DKSCRIPT_DIR}"

	export DKSCRIPT_NAME=$(basename ${DKSCRIPT_PATH})
	[ -n ${DKSCRIPT_NAME} ] || [$(read -rp 'DKSCRIPT_NAME:${DKSCRIPT_NAME} is invalid, press enter to exit')] || exit;
	echo "\${DKSCRIPT_NAME} = ${DKSCRIPT_NAME}"


	##### CD into the DKSCRIPT_DIR directory #####
	cd "${DKSCRIPT_DIR}"


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
	
	
	
	###### set true and false variables ######
	export readonly true=0
	export readonly false=1


	###### get DKBASH_DIR ######
	export BASH_SOURCE_DIR=$( cd -- "$(dirname "$BASH_SOURCE")" >/dev/null 2>&1 ; pwd -P )
	[ -d ${BASH_SOURCE_DIR} ] || [$(read -rp 'BASH_SOURCE_DIR:${BASH_SOURCE_DIR} not found, press enter to exit')] || exit;

	export DKBASH_DIR=$( cd -- "$(dirname "$BASH_SOURCE_DIR")" >/dev/null 2>&1 ; pwd -P )
	[ -d ${DKBASH_DIR} ] || [$(read -rp 'DKBASH_DIR:${DKBASH_DIR} not found, press enter to exit')] || exit;
	echo "DKBASH_DIR = $DKBASH_DIR"

	chmod 777 ${DKBASH_DIR}/functions/*
	#export PATH=${PATH}:${DKBASH_DIR}/functions
	
	###### Let's see the CallStack ######
	echo "BASH_SOURCE[0]    = ${BASH_SOURCE[0]}"
	echo "FUNCNAME[0]       = ${FUNCNAME[0]}"
	#echo "BASH_ARGV[0]      = ${BASH_ARGV[0]}"
	echo "BASH_ARGC[0]      = ${BASH_ARGC[0]}"
	echo "   BASH_SOURCE[1]    = ${BASH_SOURCE[1]}"
	echo "   FUNCNAME[1]       = ${FUNCNAME[1]}"
	#echo "   BASH_ARGV[1]      = ${BASH_ARGV[1]}"
	echo "   BASH_ARGC[1]      = ${BASH_ARGC[1]}"
	  
	  
	###### Script loader ######
	dk_source dk_return
	dk_source __FILE__
	dk_source __LINE__
	dk_source __FUNCTION__
	dk_source __ARGC__
	dk_source __ARGV__
	dk_source __CALLER__
	dk_source dk_debugFunc
	dk_source dk_load
	
	dk_source dk_onExit    # trap EXIT handler
	dk_source dk_onError   # trap ERR handler
	
	dk_call dk_escapeSequences
		
	dk_load ${DKSCRIPT_PATH}
				
	#dk_bundleSource ${dk_load_list} builder_bundle.sh
	
	


	###### DKTEST MODE ######
	if [ "${ENABLE_DKTEST}" = "1" ]; then
		if [ "${DKSCRIPT_DIR}" = "${DKBASH_DIR}/functions" ]; then
			#export ENABLE_dk_debugFunc=1
			echo ""
			echo "###### DKTEST MODE ###### ${DKSCRIPT_NAME} ###### DKTEST MODE ######"
			echo ""
			#. ${DKSCRIPT_PATH}
			#echo $(type DKTEST | sed '1,1d') 			# print DKTEST() code
			DKTEST
			echo ""
			echo "########################## END TEST ################################"
			echo ""
			dk_pause
			exit
		fi
	fi
}

DK

#DK_TRY_CATCH () {
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
