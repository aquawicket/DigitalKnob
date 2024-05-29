#!/bin/sh
# Conditional expressions for POSIX shell   https://www.ibm.com/docs/zh-tw/aix/7.2?topic=shell-conditional-expressions-korn-posix
#[ -n "${DKINIT}" ] && exit


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
		if [ -z "$(command -v "bash")" ]; then
			[ -z "$(command -v "tce-load")"] && tce-load -wi bash
			[ -z "$(command -v "bash")" ] && [$(read -rp 'bash command not found, press enter to exit')] || exit;
		fi
		echo "reloading with bash . . ."
		exec bash "$0" 
	fi
	[ -n "${DKINIT}" ] && return || export readonly DKINIT=1
		
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
		
	###### Script loader ######
	#if [ -n "${ENABLE_dk_load}" ]; then
		###### download if missing ######
		[ -e ${DKBASH_DIR}/functions/dk_load.sh ] || curl -Lo DKBash/functions/dk_load.sh https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBash/functions/dk_load.sh
		[ -e ${DKBASH_DIR}/functions/dk_load.sh ] || wget -P DKBash/functions https://raw.githubusercontent.com/aquawicket/Digitalknob/Development/DKBash/functions/dk_load.sh
		[ -e ${DKBASH_DIR}/functions/dk_load.sh ] || [$(read -rp 'dk_load not found, press enter to exit')] || exit;
		
		#. ${DKBASH_DIR}/functions/dk_onExit.sh    # trap EXIT handler
		#. ${DKBASH_DIR}/functions/dk_onError.sh   # trap ERR handler
		. ${DKBASH_DIR}/functions/dk_return.sh
		. ${DKBASH_DIR}/functions/__FILE__.sh
		. ${DKBASH_DIR}/functions/__LINE__.sh
		. ${DKBASH_DIR}/functions/__FUNCTION__.sh
		. ${DKBASH_DIR}/functions/__ARGC__.sh
		. ${DKBASH_DIR}/functions/__ARGV__.sh
		. ${DKBASH_DIR}/functions/__CALLER__.sh
		. ${DKBASH_DIR}/functions/dk_debugFunc.sh
		. ${DKBASH_DIR}/functions/dk_onExit.sh    # trap EXIT handler
		. ${DKBASH_DIR}/functions/dk_onError.sh   # trap ERR handler
		. ${DKBASH_DIR}/functions/dk_load.sh
		#dk_load dk_signalHandler

		dk_load dk_escapeSequences
		dk_escapeSequences
		
		#dk_load ${DKBASH_DIR}/dk_errorStatus
		#dk_errorStatus
		
		dk_load ${DKSCRIPT_PATH}
		
	#else	
	#dk_escapeSequences
	#fi
		
		
	#	dk_load dk_bundleSource
	#	dk_bundleSource ${dk_load_list} builder_bundle.sh

	###### DKTEST MODE ######
	if [ "${ENABLE_DKTEST}" = "1" ]; then
		if [ "${DKSCRIPT_DIR}" = "${DKBASH_DIR}/functions" ]; then
			export ENABLE_dk_debugFunc=1
			echo ""
			echo "###### DKTEST MODE ###### ${DKSCRIPT_NAME} ###### DKTEST MODE ######"
			echo ""
			#. ${DKSCRIPT_PATH}
			#echo $(type DKTEST | sed '1,1d') 			# print DKTEST() code
			DKTEST
			echo ""
			echo "########################## END TEST ################################"
			echo ""
			exit
			#dk_load dk_exit
			#dk_exit 0
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
