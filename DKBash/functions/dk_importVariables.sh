#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)      || export PATH=/bin
	(command -v 'cygpath' 1>/dev/null) && HOME=$(cygpath -u $USERPROFILE)                                 && echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null) && CMD_EXE=$(command -v 'cmd.exe')                                 && echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]            && USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')      && echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null) && HOME=$(wslpath -u ${USERPROFILE})                               && echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)    && export BASH_EXE=$(command -v bash)                              && echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]                  || export DK_SH=$(find "${HOME}" -name "DK.sh")                    && echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]               && exec "${BASH_EXE}" "${DK_SH}" "$0" $* || exec "${DK_SH}" "$0" $*
fi
##################################################################################


#################################################################################
# dk_importVariables(PLUGIN_URL rtn_var) BRANCH FOLDER NAME PATH ROOT TAG VERSION
#
#	PLUGIN_URL												###### EXAMPLES ######
#		This url of the plugin to import.					https://github.com/madler/zlib.git     							* github repository link
#															https://github.com/madler/zlib/archive/refs/heads/master.zip	* github sourcecode download
#															https://github.com/madler/zlib        							* github page
#															https://zlib.net/zlib-1.3.1.tar.gz								* library sourcecode download
#															https://website.com/executable.exe              				* executable file
#
#	IMPORT_PATH  optional 
#
#															C:/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
#	BRANCH (optional)
#															develop
#															master
#
#	FOLDER (optional)
#															zlib-develop
#															zlib-master
#
#	NAME (optional)
#															zlib
#															myZLIB
#
#	PATH (optional)
#															C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
#															C:/Users/Administrator/DigitalKnob/Development/3rdParty/myZLIB
#
#	ROOT (optional)
#															C:/Users/Administrator/DigitalKnob/Development/3rdParty
#															C:/Users/Administrator/MyLibraries
#
#	TAG (optional)
#															v1.3.1
#															v1.2.13
#
#	VERSION (optional)
#															master
#
dk_importVariables() {

	#dk_debugFunc 1 9

	URL="${1}";
	dk_call dk_assertVar URL;
	# dk_call dk_printVar URL;
	
	IMPORT_PATH="";
	dk_call dk_getParameterValue IMPORT_PATH 	"$@";		# /c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
	#if defined IMPORT_PATH (set "IMPORT_PATH=%IMPORT_PATH:\=/%")
	# dk_call dk_printVar IMPORT_PATH;
	
	BRANCH=""
	dk_call dk_getParameterValue BRANCH			"$@";		# master
	# dk_call dk_printVar BRANCH;
	
	FOLDER=""
	dk_call dk_getParameterValue  FOLDER		"$@";     	# zlib-master
	# dk_call dk_printVar FOLDER;
	
	NAME=""
	dk_call dk_getParameterValue  NAME			"$@";     	# zlib
	# dk_call dk_printVar NAME;
	
	DIR=""
	dk_call dk_getParameterValue  DIR			"$@";     	# C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	# dk_call dk_printVar DIR;
	
	ROOT=""
	dk_call dk_getParameterValue  ROOT			"$@";     	# C:/Users/Administrator/DigitalKnob/Development/3rdParty
	# dk_call dk_printVar ROOT;
	
	TAG=""
	dk_call dk_getParameterValue  TAG			"$@";     	# v1.3.1
	# dk_call dk_printVar TAG;
	
	VERSION=""
	dk_call dk_getParameterValue  VERSION		"$@";     	# master
	# dk_call dk_printVar VERSION;

	###### POPULATE VARIABLES ######
	# PLUGIN_URL				- from arg:url														: https://github.com/madler/zlib/archive/refs/heads/master.zip
	# PLUGIN_URL_LIST			- from PLUGIN_URL													: https:;github.com;madler;zlib;archive;refs;heads;master.zip
	# PLUGIN_URL_LENGTH			- from PLUGIN_URL_LIST												: 8
	# PLUGIN_URL_NODE n 		- from PLUGIN_URL_LIST												: [0]https: [1]github.com [2]madler [3]zlib [4]archive [5]refs [6]heads [7]master.zip
	# PLUGIN_URL_FILENAME   	- from PLUGIN_URL													: master.zip
	# PLUGIN_URL_EXTENSION  	- from PLUGIN_URL_FILENAME											: .zip
	# PLUGIN_URL_FILE      		- from PLUGIN_URL_FILENAME											: master
	
	# PLUGIN_IMPORT				- from CMAKE_CURRENT_LIST_DIR										: 1
	# PLUGIN_IMPORT_PATH		- from CMAKE_CURRENT_LIST_DIR										: C:/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
	# PLUGIN_IMPORT_NAME		- from PLUGIN_IMPORT_PATH											: zlib
	
	# PLUGIN_GIT				- from PLUGIN_URL													: 1
	# PLUGIN_GIT_FILENAME		- from PLUGIN_URL													: zlib
	# PLUGIN_GIT_NAME			- from PLUGIN_GIT_FILENAME											: zlib
	# PLUGIN_GIT_BRANCH			- from default:master OR arg:BRANCH									: master
	# PLUGIN_GIT_TAG			- from default: OR arg:TAG
	
	# PLUGIN_INSTALL_NAME		- from PLUGIN_IMPORT_NAME, PLUGIN_GIT_NAME or PLUGIN_URL_NAME		: zlib
	# PLUGIN_INSTALL_VERSION	- from PLUGIN_URL_FILE and PLUGIN_IMPORT_NAME						: master
	# PLUGIN_INSTALL_FOLDER    	- from PLUGIN_INSTALL_NAME amd PLUGIN_INSTALL_VERSION				: zlib-master
	# PLUGIN_INSTALL_ROOT		- from default:DK3RDPARTY OR arg:ROOT								: C:/Users/Administrator/DigitalKnob/Development/3rdParty
	# PLUGIN_INSTALL_PATH		- from PLUGIN_INSTALL_ROOT and PLUGIN_INSTALL_FOLDER				: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	
	# <PLUGIN>					- from PLUGIN_IMPORT_NAME						:ZLIB   			: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	# <CURRENT_PLUGIN>			- from <PLUGIN>									:ZLIB				: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	# <PLUGIN>_DIR				- from PLUGIN_INSTALL_PATH						:ZLIB_DIR			: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	# <PLUGIN>_URL				- from PLUGIN_URL								:ZLIB_URL			: https://github.com/madler/zlib/archive/refs/heads/master.zip
	# <PLUGIN>_IMPORT_FILE			- from PLUGIN_URL_FILENAME						:ZLIB_IMPORT_FILE		: master.zip
	# <PLUGIN>_VERSION        	- from PLUGIN_INSTALL_VERSION					:ZLIB_VERSION		: master
	# <PLUGIN>_FOLDER			- from PLUGIN_INSTALL_FOLDER					:ZLIB_FOLDER		: zlib-master
	# <PLUGIN>_IMPORT_NAME		- from PLUGIN_IMPORT_NAME						:ZLIB_IMPORT_NAME	: zlib
	# <PLUGIN>_BRANCH			- from PLUGIN_GIT_BRANCH						:ZLIB_BRANCH		: master
	# <PLUGIN>_TAG				- from PLUGIN_GIT_TAG							:ZLIB_TAG			: 
	# <PLUGIN>_TUPLE_DIR		- from PLUGIN_INSTALL_PATH and Target_Tuple	:ZLIB_TUPLE_DIR	: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang
	# <PLUGIN>_CONFIG_DIR		- from PLUGIN_INSTALL_PATH and CONFIG_DIR		:ZLIB_CONFIG_DIR	: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	# <PLUGIN>_BUILD_DIR		- from PLUGIN_INSTALL_PATH and BUILD_DIR		:ZLIB_BUILD_DIR		: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	# <PLUGIN>_DEBUG_DIR		- from PLUGIN_INSTALL_PATH and Debug_Dir		:ZLIB_DEBUG_DIR		: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	# <PLUGIN>_RELEASE_DIR		- from PLUGIN_INSTALL_PATH and Release_Dir		:ZLIB_RELEASE_DIR	: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Release
		
		
	##############################################
	############ PLUGIN_URL VARIABLES ############
	##############################################
	
	### PLUGIN_URL
	# set "PLUGIN_URL="
	# set "PLUGIN_URL=${URL:\=/}"
	PLUGIN_URL="${URL}";														# PLUGIN_URL				: https://github.com/madler/zlib/archive/refs/heads/master.zip
	dk_call dk_printVar PLUGIN_URL;
	
	### PLUGIN_URL_FILENAME
	#unset PLUGIN_URL_FILENAME;
	dk_call dk_basename "${PLUGIN_URL}" PLUGIN_URL_FILENAME;					
	dk_call dk_printVar PLUGIN_URL_FILENAME;									# PLUGIN_URL_FILENAME		: master.zip
	
	### PLUGIN_URL_LIST
	unset PLUGIN_URL_LIST;
	dk_call dk_replaceAll "${PLUGIN_URL}" "/" ";" PLUGIN_URL_LIST; 					
	dk_call dk_printVar PLUGIN_URL_LIST;										# PLUGIN_URL_LIST			: https:;github.com;madler;zlib;archive;refs;heads;master.zip
	
	### PLUGIN_GIT
	unset PLUGIN_GIT;
	$(dk_call dk_includes "${PLUGIN_URL}" "https://github.com") && PLUGIN_GIT=1 || PLUGIN_GIT=0			
	dk_call dk_printVar PLUGIN_GIT;												# PLUGIN_GIT				: 1
	
	### PLUGIN_URL_EXTENSION
	unset PLUGIN_URL_EXTENSION;
	dk_call dk_getExtension "${PLUGIN_URL_FILENAME}" PLUGIN_URL_EXTENSION;			
	dk_call dk_printVar PLUGIN_URL_EXTENSION;									# PLUGIN_URL_EXTENSION		: .zip

	### PLUGIN_URL_FILE
	unset PLUGIN_URL_FILE;
	dk_call dk_removeExtension "${PLUGIN_URL_FILENAME}" PLUGIN_URL_FILE			
	dk_call dk_printVar PLUGIN_URL_FILE;										# PLUGIN_URL_FILE			: master

	### PLUGIN_URL_NODE n 
	dk_call dk_listToArray "${PLUGIN_URL_LIST}" PLUGIN_URL_ARRAY				# PLUGIN_URL_NODE n 		: [0]https: [1]github.com [2]madler [3]zlib [4]archive [5]refs [6]heads [7]master.zip
	dk_call dk_printVar PLUGIN_URL_ARRAY;
	
	### PLUGIN_URL_LENGTH
	unset PLUGIN_URL_LENGTH;
	dk_call Array/dk_length PLUGIN_URL_ARRAY dk_length;
	PLUGIN_URL_LENGTH="${arrayLength}";											# PLUGIN_URL_LENGTH		: 8
	dk_call dk_printVar PLUGIN_URL_LENGTH;



	
	#######################################################
	############### PLUGIN_IMPORT VARIABLES ###############
	#######################################################
	[ -z "${IMPORT_PATH}" ] && IMPORT_PATH="$(dk_call dk_dirname ${BASH_SOURCE[2]})"
	#[ "${IMPORT_PATH:~-1}" = "/"] && IMPORT_PATH="${IMPORT_PATH:~0,-1}"
	dk_call dk_printVar IMPORT_PATH;
	
	# PLUGIN_IMPORT
	unset PLUGIN_IMPORT;
	dk_call dk_validate DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR";
	$(dk_call dk_includes "${IMPORT_PATH}" "${DKIMPORTS_DIR}") && PLUGIN_IMPORT="1";
	dk_call dk_printVar PLUGIN_IMPORT;												# PLUGIN_IMPORT			 	: 1
	
	# PLUGIN_IMPORT_PATH
	unset PLUGIN_IMPORT_PATH;
	PLUGIN_IMPORT_PATH="${IMPORT_PATH}"	;					
	dk_call dk_printVar PLUGIN_IMPORT_PATH;											# PLUGIN_IMPORT_PATH		: C:\Users\Administrator\DigitalKnob\Development\3rdParty\_DKIMPORTS\zlib

	# PLUGIN_IMPORT_NAME
	unset PLUGIN_IMPORT_NAME;
	if [ ! "${NAME}" = "" ]; then
		PLUGIN_IMPORT_NAME="${NAME}";
	else
		dk_call dk_basename "${PLUGIN_IMPORT_PATH}" PLUGIN_IMPORT_NAME;
	fi		
	dk_call dk_printVar PLUGIN_IMPORT_NAME;											# PLUGIN_IMPORT_NAME		: zlib

	### PLUGIN_IMPORT_NAME_LOWER ###
	unset PLUGIN_IMPORT_NAME_LOWER;
	dk_call dk_toLower "${PLUGIN_IMPORT_NAME}" PLUGIN_IMPORT_NAME_LOWER				# PLUGIN_IMPORT_NAME_LOWER	: zlib
	dk_call dk_printVar PLUGIN_IMPORT_NAME_LOWER;			         	
	
	### PLUGIN_IMPORT_NAME_UPPER ###
	unset PLUGIN_IMPORT_NAME_UPPER;
	dk_call dk_toUpper "${PLUGIN_IMPORT_NAME}" PLUGIN_IMPORT_NAME_UPPER				# PLUGIN_IMPORT_NAME_UPPER	: ZLIB
	dk_call dk_printVar PLUGIN_IMPORT_NAME_UPPER;

	##############################################
	############ PLUGIN_GIT VARIABLES ############
	##############################################
	if [ ${PLUGIN_GIT} -eq 1 ]; then 
		# PLUGIN_GIT_FILENAME
		unset PLUGIN_GIT_NAME;
		dk_call Array/dk_at PLUGIN_URL_ARRAY 3;		
		PLUGIN_GIT_FILENAME="${dk_at}";
		dk_call dk_printVar PLUGIN_GIT_FILENAME;									# PLUGIN_GIT_FILENAME		: zlib
		
		# PLUGIN_GIT_NAME
		unset PLUGIN_GIT_NAME;
		dk_call dk_replaceAll "${PLUGIN_GIT_FILENAME}" ".git" "" PLUGIN_GIT_NAME 			
		dk_call dk_printVar PLUGIN_GIT_NAME;										# PLUGIN_GIT_NAME			: zlib
		
		### PLUGIN_GIT_NAME_LOWER
		unset PLUGIN_GIT_NAME_LOWER;
		dk_call dk_toLower "${PLUGIN_GIT_NAME}" PLUGIN_GIT_NAME_LOWER;				& rem PLUGIN_GIT_NAME_LOWER		: zlib
		dk_call dk_printVar PLUGIN_GIT_NAME_LOWER;
		
		# PLUGIN_GIT_BRANCH
		unset PLUGIN_GIT_BRANCH;
		if ! [ -n "${BRANCH-}" ]; then
			PLUGIN_GIT_BRANCH="${BRANCH}";
		fi 
		#dk_call dk_getGitBranchName ${PLUGIN_URL} PLUGIN_GIT_BRANCH 					
		if ! [ -n "${PLUGIN_GIT_BRANCH-}" ]; then
			PLUGIN_GIT_BRANCH="master"
		fi  
		dk_call dk_printVar PLUGIN_GIT_BRANCH;										# PLUGIN_GIT_BRANCH			: master
		
		### PLUGIN_GIT_TAG
		unset PLUGIN_GIT_TAG;
		if [ -n "${TAG-}" ]; then
			PLUGIN_GIT_TAG="${TAG}";
		fi
		dk_call dk_printVar PLUGIN_GIT_TAG;
	fi  

	##################################################
	############ PLUGIN_INSTALL VARIABLES ############
	##################################################
	
	### PLUGIN_INSTALL_NAME
	unset PLUGIN_INSTALL_NAME;
	if [ -n "${NAME-}" ]; then
		PLUGIN_INSTALL_NAME="${NAME}"
	elif [ -n "${PLUGIN_IMPORT_NAME-}" ]; then
		PLUGIN_INSTALL_NAME="${PLUGIN_IMPORT_NAME}"
	elif [ -n "${PLUGIN_GIT_NAME-}" ]; then
		PLUGIN_INSTALL_NAME="${PLUGIN_GIT_NAME}"
	elif [ -n "${PLUGIN_URL_NAME-}" ]; then 
		PLUGIN_INSTALL_NAME="${PLUGIN_URL_NAME}"						
	fi  
	#dk_call dk_convertToCIdentifier "${PLUGIN_INSTALL_NAME}" PLUGIN_INSTALL_NAME
	dk_call dk_printVar PLUGIN_INSTALL_NAME;									# PLUGIN_INSTALL_NAME		: zlib

	### PLUGIN_INSTALL_VERSION
	unset PLUGIN_INSTALL_VERSION;
	if ! [ -n "${VERSION-}" ]; then 
		PLUGIN_INSTALL_VERSION="${VERSION-}";
	elif [ -n "${PLUGIN_IMPORT_NAME-}" ] && [ -n "${PLUGIN_URL_FILE-}" ]; then
		dk_call dk_toLower "${PLUGIN_IMPORT_NAME}" PLUGIN_IMPORT_NAME_LOWER;
		dk_call dk_toLower "${PLUGIN_URL_FILE}" PLUGIN_URL_FILE_LOWER;
		# deduce the plugin version		
		dk_call dk_replaceAll "${PLUGIN_URL_FILE_LOWER}" "${PLUGIN_IMPORT_NAME_LOWER}" "" PLUGIN_INSTALL_VERSION; 	
		if [ "${PLUGIN_IMPORT_NAME_LOWER}" = "${PLUGIN_URL_FILE_LOWER}" ]; then
			if [ -n "${PLUGIN_GIT_TAG}" ]; then 
				PLUGIN_INSTALL_VERSION="${PLUGIN_GIT_TAG}";
			elif [ -n "${PLUGIN_GIT_BRANCH}" ]; then 
				PLUGIN_INSTALL_VERSION="${PLUGIN_GIT_BRANCH}";
			else  
				PLUGIN_INSTALL_VERSION="master";
			fi  
		fi  
#		string FIND ${PLUGIN_INSTALL_VERSION} - index 
#		if [ ${index} -eq 0 ]; then
#			string SUBSTRING ${PLUGIN_INSTALL_VERSION} 1 -1 PLUGIN_INSTALL_VERSION 
#		fi  
#		string FIND ${PLUGIN_INSTALL_VERSION} _ index 
#		if [ ${index} -eq 0 ]; then
#			string SUBSTRING ${PLUGIN_INSTALL_VERSION} 1 -1 PLUGIN_INSTALL_VERSION 
#		fi  
	fi  
	dk_call dk_printVar PLUGIN_INSTALL_VERSION;										# PLUGIN_INSTALL_VERSION	: master

	### PLUGIN_INSTALL_FOLDER
	unset PLUGIN_INSTALL_FOLDER;
	if [ -n "${FOLDER-}" ]; then
		PLUGIN_INSTALL_FOLDER="${FOLDER-}";
	elif [ -n "${PLUGIN_INSTALL_VERSION-}" ]; then 
		PLUGIN_INSTALL_FOLDER="${PLUGIN_INSTALL_NAME-}-${PLUGIN_INSTALL_VERSION-}";
	else  
		PLUGIN_INSTALL_FOLDER="${PLUGIN_INSTALL_NAME-}";
	fi  
	dk_call dk_printVar PLUGIN_INSTALL_FOLDER;										# PLUGIN_INSTALL_FOLDER		: zlib-master

	# PLUGIN_INSTALL_ROOT
	unset PLUGIN_INSTALL_ROOT;
	if ! [ "${ROOT-}" ]; then 
		PLUGIN_INSTALL_ROOT="${ROOT-}";
		unset ROOT;
	if ! [ "${PLUGIN_INSTALL_ROOT-}" ]; then 
		dk_call dk_assertPath DK3RDPARTY_DIR; 
		PLUGIN_INSTALL_ROOT="${DK3RDPARTY_DIR-}";
	fi  
	dk_call dk_printVar PLUGIN_INSTALL_ROOT;										# PLUGIN_INSTALL_ROOT		: C:/Users/Administrator/DigitalKnob/Development/3rdParty

	# PLUGIN_INSTALL_PATH
	unset PLUGIN_INSTALL_PATH;
	if ! [ "${DIR-}" ]; then 
		PLUGIN_INSTALL_PATH="${DIR-}";	
	else;
		dk_call dk_assertPath PLUGIN_INSTALL_ROOT; 
		dk_call dk_assertVar PLUGIN_INSTALL_FOLDER; 
		PLUGIN_INSTALL_PATH="${PLUGIN_INSTALL_ROOT-}/${PLUGIN_INSTALL_FOLDER-}";		
	fi  
	dk_call dk_printVar PLUGIN_INSTALL_PATH;										# PLUGIN_INSTALL_PATH		: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master

	
	
	
	##############################################
	############# <PLUGIN>_VARIABLES #############
	##############################################
	
	if [ -n "${PLUGIN_IMPORT_NAME_LOWER-}" ];then 
		if [ -n "${PLUGIN_GIT_NAME_LOWER-}" ]; then   
			if ! [ "${PLUGIN_IMPORT_NAME_LOWER}" = "${PLUGIN_GIT_NAME_LOWER}" ]; then
				dk_call dk_warning "PLUGIN_IMPORT_NAME:${PLUGIN_IMPORT_NAME_LOWER} and PLUGIN_GIT_NAME:${PLUGIN_GIT_NAME_LOWER} do not match"; 
			fi
		fi
	fi  

	### <CURRENT_PLUGIN>
	${CURRENT_PLUGIN}="${PLUGIN_IMPORT_NAME_UPPER}";
	dk_call dk_convertToCIdentifier ${CURRENT_PLUGIN} CURRENT_PLUGIN;
	if [ "${PLUGIN_IMPORT_NAME_UPPER}" != "${CURRENT_PLUGIN}" ]; then 
		dk_call dk_notice "'${PLUGIN_IMPORT_NAME_UPPER}' contains non-alphanumeric characters and is changed to '${CURRENT_PLUGIN}'" 
	fi  
	dk_call dk_printVar CURRENT_PLUGIN;												
	
	### <PLUGIN>
	${CURRENT_PLUGIN}="${PLUGIN_INSTALL_PATH}";								 		# ZLIB						: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	dk_call dk_printVar ${CURRENT_PLUGIN};	

	### <PLUGIN>_DIR
	if [ ! "${CURRENT_PLUGIN}" = "GIT" ]; then	### DO NOT USE GIT_DIR ###
		${CURRENT_PLUGIN}_DIR="${PLUGIN_INSTALL_PATH-}"; 
		dk_call dk_printVar ${CURRENT_PLUGIN}_DIR; #   !!! BAD SUBSTITUTION !!!		# ZLIB_DIR					: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	fi
	
	### <PLUGIN>_URL
	${CURRENT_PLUGIN}_URL="${PLUGIN_URL-}";
	dk_call dk_printVar ${CURRENT_PLUGIN}_URL;										# ZLIB_URL					: https://github.com/madler/zlib/archive/refs/heads/master.zip
	
	### <PLUGIN>_IMPORT_FILE
	unset ${CURRENT_PLUGIN}_IMPORT_FILE;
	${CURRENT_PLUGIN}_IMPORT_FILE="${PLUGIN_URL_FILENAME-}"; 
	dk_call dk_printVar ${CURRENT_PLUGIN}_IMPORT_FILE;								# ZLIB_IMPORT_FILE 			: master.zip
	
	### <PLUGIN>_VERSION
	unset ${CURRENT_PLUGIN}_VERSION;
	${CURRENT_PLUGIN}_VERSION="${PLUGIN_INSTALL_VERSION-}"; 
	dk_call dk_printVar ${CURRENT_PLUGIN}_VERSION;									# ZLIB_VERSION  			: master

	### <PLUGIN>_FOLDER
	unset ${CURRENT_PLUGIN}_FOLDER;
	${CURRENT_PLUGIN}_FOLDER="${PLUGIN_INSTALL_FOLDER-}"; 
	dk_call dk_printVar ${CURRENT_PLUGIN}_FOLDER;									# ZLIB_FOLDER				: zlib-master

	### <PLUGIN>_IMPORT_NAME
	unset ${CURRENT_PLUGIN}_IMPORT_NAME;	
	${CURRENT_PLUGIN}_IMPORT_NAME="${PLUGIN_IMPORT_NAME_LOWER-}"; 
	dk_call dk_printVar ${CURRENT_PLUGIN}_IMPORT_NAME;								# ZLIB_IMPORT_NAME			: zlib
		
	### <PLUGIN>_BRANCH
	unset ${CURRENT_PLUGIN}_BRANCH;
	if [ -n "${PLUGIN_GIT_BRANCH-}" ]; then
		${CURRENT_PLUGIN}_BRANCH="${PLUGIN_GIT_BRANCH-}"; 
		dk_call dk_printVar ${CURRENT_PLUGIN}_BRANCH;	 							# ZLIB_BRANCH				: master
	fi  
	
	### <PLUGIN>_TAG
	unset ${CURRENT_PLUGIN}_TAG;
	if [ -n "${PLUGIN_GIT_TAG-}" ]; then 
		${CURRENT_PLUGIN}_TAG="${PLUGIN_GIT_TAG-}"; 
		dk_call dk_printVar ${CURRENT_PLUGIN}_TAG;									# ZLIB_TAG					: v1.2
	fi  
	
	
	#####################################################
	############# TARGET <PLUGIN>_VARIABLES #############
	#####################################################

	### <PLUGIN>_TUPLE_DIR
	unset ${CURRENT_PLUGIN}_TUPLE_DIR;
	if [ -n "${Target_Tuple-}" ]; then 
		${CURRENT_PLUGIN}_TUPLE_DIR="${PLUGIN_INSTALL_PATH}/${Target_Tuple}"; 
		dk_call dk_printVar ${CURRENT_PLUGIN}_TUPLE_DIR;							# ZLIB_TUPLE_DIR	: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang
	fi  
	
	### <PLUGIN>_CONFIG_DIR
	unset ${CURRENT_PLUGIN}_CONFIG_DIR;
	if [ -n "${CONFIG_PATH-}" ]; then
		${CURRENT_PLUGIN}_CONFIG_DIR="${PLUGIN_INSTALL_PATH}/${CONFIG_PATH}"; 
		dk_call dk_printVar ${CURRENT_PLUGIN}_CONFIG_DIR;							# ZLIB_CONFIG_DIR	: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	fi  
	
	### <PLUGIN>_BUILD_DIR
	unset ${CURRENT_PLUGIN}_BUILD_DIR;
	if [ -n "${BUILD_PATH-}" ]; then
		${CURRENT_PLUGIN}_BUILD_DIR="${PLUGIN_INSTALL_PATH}/${BUILD_PATH}"; 
		dk_call dk_printVar ${CURRENT_PLUGIN}_BUILD_DIR;							# ZLIB_BUILD_DIR	: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	fi  
	
	### <PLUGIN>_DEBUG_DIR
	unset ${CURRENT_PLUGIN}_DEBUG_DIR;
	if [ -n "${Debug_Dir-}" ]; then 
		${CURRENT_PLUGIN}_DEBUG_DIR="${PLUGIN_INSTALL_PATH}/${Target_Tuple}/${Debug_Dir}"; 
		dk_call dk_printVar ${CURRENT_PLUGIN}_DEBUG_DIR;							# ZLIB_DEBUG_DIR	: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	fi  
	
	### <PLUGIN>_RELEASE_DIR
	unset ${CURRENT_PLUGIN}_RELEASE_DIR;
	if [ -n "${Release_Dir-}" ]; then 
		${CURRENT_PLUGIN}_RELEASE_DIR="${PLUGIN_INSTALL_PATH}/${Target_Tuple}/${Release_Dir}"; 
		dk_call dk_printVar ${CURRENT_PLUGIN}_RELEASE_DIR;							# ZLIB_RELEASE_DIR	: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Release
	fi  
	
	#eval "$2='${CURRENT_PLUGIN}'";
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

	dk_debugFunc 0
	
	dk_call dk_validate DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR";
	dk_call dk_importVariables "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe"	NAME git	ROOT "${DKTOOLS_DIR}";
	dk_call dk_echo "CURRENT_PLUGIN  = ${CURRENT_PLUGIN}";
	dk_call dk_echo "GIT             = ${GIT}";
	dk_call dk_echo "GIT_DIR         = ${GIT_DIR}";
	dk_call dk_echo "GIT_URL         = ${GIT_URL}";
	dk_call dk_echo "GIT_IMPORT_FILE = ${GIT_IMPORT_FILE}";
	dk_call dk_echo "GIT_VERSION     = ${GIT_VERSION}";
	dk_call dk_echo "GIT_FOLDER      = ${GIT_FOLDER}";
	dk_call dk_echo "GIT_IMPORT_NAME = ${GIT_IMPORT_NAME}";
	dk_call dk_echo "GIT_BRANCH      = ${GIT_BRANCH}";
	dk_call dk_echo "GIT_TAG         = ${GIT_TAG}";
}
