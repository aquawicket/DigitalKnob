#!/bin/sh
###### DK.sh #####################################################################
if [ -z "${DK_LOADED-}" ]; then
	(command -v 'sh' 1>/dev/null)		|| export PATH=/bin
	(command -v 'cygpath' 1>/dev/null)	&& export HOME=$(cygpath -u $USERPROFILE)								&& echo "cygpath: HOME = ${HOME}"
	(command -v 'cmd.exe' 1>/dev/null)	&& export CMD_EXE=$(command -v 'cmd.exe')								&& echo "CMD_EXE = ${CMD_EXE}"
	[ -z "${USERPROFILE}" ]				&& export USERPROFILE=$($CMD_EXE /c echo %USERPROFILE% | tr -d '\r')	&& echo "cmd.exe: USERPROFILE = ${USERPROFILE}"
	(command -v 'wslpath' 1>/dev/null)	&& export HOME=$(wslpath -u ${USERPROFILE})								&& echo "wslpath: HOME = ${HOME}"
	(command -v 'bash' 1>/dev/null)		&& export BASH_EXE=$(command -v bash)									&& echo "BASH_EXE = ${BASH_EXE}"
	[ -e "${DK_SH}" ]					|| export DK_SH="$(dirname $0)/DK.sh"									&& echo "DK_SH = ${DK_SH}"
	[ -e "${DK_SH}" ]					|| export DK_SH=$(find "${HOME}" -name "DK.sh")							&& echo "DK_SH = ${DK_SH}"
	[ -e "${BASH_EXE}" ]				&& exec "${BASH_EXE}" "${DK_SH}" "$0" $*								|| exec "${DK_SH}" "$0" $*
fi
##################################################################################


###########################################################################################################################
# dk_importVariables(Url Rtn_Var) IMPORT_ROOT Import.Name IMPORT_PATH INSTALL_ROOT INSTALL_NAME INSTALL_PATH VERSION BRANCH 
#
#																	###### EXAMPLES ######
#	Url																https://github.com/madler/zlib.git     							* github repository link
#																	https://github.com/madler/zlib/archive/refs/heads/master.zip	* github sourcecode download
#																	https://github.com/madler/zlib        							* github page
#																	https://zlib.net/zlib-1.3.1.tar.gz								* library sourcecode download
#																	https://website.com/executable.exe              				* executable file
#
#
#	IMPORT_ROOT	(optional)											C:/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS
#
#
#	Import.Name (optional)											zlib
#
#
#	IMPORT_PATH (optional)											C:/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
#
#
#	INSTALL_ROOT (optional)											C:/Users/Administrator/DigitalKnob/Development/DKTools
#
#
#	INSTALL_NAME (optional)											zlib-8-5-2025
#																	myZLIB
#
#	INSTALL_PATH (optional)											C:/Users/Administrator/DigitalKnob/Development/DKTools/zlib-8-5-2025
#																	C:/Users/Administrator/DigitalKnob/Development/DKTools/myZLIB
#
#	VERSION (optional)												master
#
#
#	BRANCH (optional)												develop
#																	master
#################################################################################
#	
#	PRINTVARS - specifying PRINTVARS will dump the current variable values of the current PLUGIN
#
dk_importVariables() {
# dk_debugFunc 1 9
	
	dk_call dk_getParameterValue PRINTVARS "$@";
	if [ -n "${PRINTVARS}" ]; then
		dk_call dk_unset PRINTVARS;
		PRINTVARS;
		return;
	fi
	
	dk_call dk_unset PLUGIN;
	dk_call dk_unset PLUGIN_Args;
	dk_call dk_unset PLUGIN_Build_Dir;
	dk_call dk_unset PLUGIN_Config_Dir;
	dk_call dk_unset PLUGIN_Debug_Dir;
	dk_call dk_unset PLUGIN_Id;
	dk_call dk_unset PLUGIN_Import_Dirname;
	dk_call dk_unset PLUGIN_Import_Name;
	dk_call dk_unset PLUGIN_Import_Name_Lower;
	dk_call dk_unset PLUGIN_Import_Name_Upper;
	dk_call dk_unset PLUGIN_Import_Path;
	dk_call dk_unset PLUGIN_Install_Dirname;
	dk_call dk_unset PLUGIN_Install_Name;
	dk_call dk_unset PLUGIN_Install_Path;
	dk_call dk_unset PLUGIN_Release_Dir;
	dk_call dk_unset PLUGIN_Tuple_Dir;
	dk_call dk_unset PLUGIN_Url;
	dk_call dk_unset PLUGIN_Url_Basename;
	dk_call dk_unset PLUGIN_Url_Extension;
	dk_call dk_unset PLUGIN_Url_Name;
	dk_call dk_unset PLUGIN_Url_Name_Lower;
	dk_call dk_unset PLUGIN_Version;
	
	# https://stackoverflow.com/a/78128262/688352
	### PLUGIN(hashtable) 
	declare -A -x PLUGIN;
	####################
																	###### EXAMPLE ######
	### IMPORT_ROOT (PLUGIN_Import_Dirname)							/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS
	dk_call dk_unset IMPORT_ROOT;
	dk_call dk_getParameterValue IMPORT_ROOT "$@";
	dk_call dk_echo "IMPORT_ROOT = '${IMPORT_ROOT}'";	
	PLUGIN_Import_Dirname="${IMPORT_ROOT-}";

	### IMPORT_NAME (PLUGIN_Import_Name)							zlib
	dk_call dk_unset IMPORT_NAME;
	dk_call dk_getParameterValue IMPORT_NAME "$@";
	dk_call dk_echo "IMPORT_NAME = '${IMPORT_NAME}'";
	PLUGIN_Import_Name="${IMPORT_NAME-}";
	
	### IMPORT_PATH (PLUGIN_Import_Path)							/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
	dk_call dk_unset IMPORT_PATH
	dk_call dk_getParameterValue IMPORT_PATH "$@";
	dk_call dk_echo "IMPORT_PATH = '${IMPORT_PATH-}'"
	PLUGIN_Import_Path="${IMPORT_PATH-}";
	
	### INSTALL_ROOT (PLUGIN_Install_Dirname)						/c/Users/Administrator/DigitalKnob/Development/3rdParty
	dk_call dk_unset INSTALL_ROOT
	dk_call dk_getParameterValue INSTALL_ROOT "$@";
	dk_call dk_echo "INSTALL_ROOT = '${INSTALL_ROOT-}'"
	PLUGIN_Install_Dirname="${INSTALL_ROOT-}";

	### INSTALL_NAME (PLUGIN_Install_Name)							zlib-master
	dk_call dk_unset INSTALL_NAME
	dk_call dk_getParameterValue INSTALL_NAME "$@";
	dk_call dk_echo "INSTALL_NAME = '${INSTALL_NAME-}'"
	PLUGIN_Install_Name="${INSTALL_NAME-}";

	### INSTALL_PATH (PLUGIN_Install_Path)							/c/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	dk_call dk_unset INSTALL_PATH
	dk_call dk_getParameterValue INSTALL_PATH "$@";
	dk_call dk_echo "INSTALL_PATH = '${INSTALL_PATH-}'"
	PLUGIN_Install_Path="${INSTALL_PATH-}";

	### VERSION (PLUGIN_Version)									v1.3.1
	dk_call dk_unset VERSION
	dk_call dk_getParameterValue VERSION "$@";
	dk_call dk_echo "VERSION = '${VERSION-}'";
	PLUGIN_Version="${VERSION-}"

	### BRANCH (PLUGIN_Branch)										master
	dk_call dk_unset BRANCH
	dk_call dk_getParameterValue BRANCH	"$@";
	dk_call dk_echo "BRANCH = '${BRANCH-}'";
	PLUGIN_Branch="${BRANCH-}";
	
	### PLUGIN_Args													"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	dk_call dk_unset PLUGIN_Args;
	PLUGIN_Args=$*;
	dk_call dk_echo "PLUGIN_Args = '${PLUGIN_Args}'";
		
	### PLUGIN_Url													"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	dk_call dk_unset PLUGIN_Url;
	PLUGIN_Url="$1";
	dk_call dk_echo "PLUGIN_Url = '${PLUGIN_Url}'";
		
	export PLUGIN_EXPORT=$(declare -p PLUGIN);
	#"${PLUGIN_@]@A}" && declare -A -x ${PLUGIN_ID}="${_#*=}";
	
	PLUGIN_Id;	
	#source <(printf "%s" "${PLUGIN_EXPORT}");
	
	#export PLUGIN_EXPORT=$(declare -p PLUGIN);
	PLUGIN_Install_Path;
	#source <(printf "%s" "${PLUGIN_EXPORT}");
	
	### PLUGIN_Tuple_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang
	PLUGIN_Tuple_Dir="${PLUGIN_INSTALL_PATH-}/${Target_Tuple-}";
	#dk_call dk_echo "PLUGIN_Tuple_Dir = '${PLUGIN_Tuple_Dir}'";
	
	### PLUGIN_Config_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	PLUGIN_Config_Dir="${PLUGIN_INSTALL_PATH-}/${Config_Path-}";
	#dk_call dk_echo "PLUGIN_Config_Dir = '${PLUGIN_Config_Dir}'";
	
	### PLUGIN_Build_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	PLUGIN_Build_Dir="${PLUGIN_INSTALL_PATH-}/${Build_Path-}";
	#dk_call dk_echo "PLUGIN_Build_Dir = '${PLUGIN_Build_Dir}'";
	
	### PLUGIN_Debug_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	PLUGIN_Debug_Dir="${PLUGIN_INSTALL_PATH-}/${Target_Tuple-}/${Debug_Dir-}";
	#dk_call dk_echo "PLUGIN_Debug_Dir = '${PLUGIN_Debug_Dir}'";
	
	### PLUGIN_Release_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Release
	PLUGIN_Release_Dir="${PLUGIN_INSTALL_PATH-}/${Target_Tuple-}/${Release_Dir-}";
	#dk_call dk_echo "PLUGIN_Release_Dir = '${PLUGIN_Release_Dir}'";
	
	export PLUGIN="${PLUGIN_Id}";
	export ${PLUGIN}="${PLUGIN_Install_Path}";
	
	### Export the PLUGIN hashtable
	export PLUGIN_EXPORT=$(declare -p PLUGIN);
	
	#source <(printf "%s" "${PLUGIN_EXPORT}");
	### Create <PLUGIN_ID> hashtable from PLUGIN hashtable
	#eval "${PLUGIN_EXPORT/PLUGIN/${PLUGIN_ID}}";					# Import the PLUGIN_ID hashtable, Using 'eval'
	#source <(printf "%s" "${PLUGIN_EXPORT/PLUGIN/${PLUGIN_ID}}");	# Import the PLUGIN_ID hashtable, Using 'source'
	#"${PLUGIN_@]@A}" && declare -A -x ${PLUGIN_Id}="${_#*=}"		# Import the PLUGIN_ID hashtable, Using 'copy routine'  #https://stackoverflow.com/a/78068508/688352
}



######################
PLUGIN_Import_Name() {
	#source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -n "${PLUGIN_Import_Name-}" ] && return;
		
	PLUGIN_Import_Path;
	#source <(printf "%s" "${PLUGIN_EXPORT}");
	#[ -z "${PLUGIN_Import_Path-}" ] && dk_call dk_error "PLUGIN_Import_Path] is invalid";
	dk_call dk_debug "PLUGIN_Import_Path = '${PLUGIN_Import_Path}'";

	if [ -n "${PLUGIN_Import_Path}" ]; then
		dk_call dk_basename	"${PLUGIN_Import_Path}";	PLUGIN_Import_Name="${dk_basename}";
		[ -z "${PLUGIN_Import_Name-}" ] && dk_call dk_error "PLUGIN_Import_Name is invalid";
		dk_call dk_debug "PLUGIN_Import_Name = '${PLUGIN_Import_Name}'";
		
	elif dk_call dk_includes "${PLUGIN_Url}" "https://github.com"; then
		dk_call dk_replaceAll 	${PLUGIN_Url} 			"/" 	";"; 	PLUGIN_Url_List="${dk_replaceAll}";
		dk_call dk_replaceAll 	${PLUGIN_Url_List} 	";;" 	";"; 	PLUGIN_Url_List="${dk_replaceAll}";
		[ -z "${PLUGIN_Url_List-}" ] && dk_call dk_error "PLUGIN_Url_List is invalid";
		dk_call dk_debug "PLUGIN_Url_List = '${PLUGIN_Url_List}'";
		
		dk_call dk_listToArray 	"${PLUGIN_Url_List}"  PLUGIN_Url_Array;
		dk_call dk_printVar PLUGIN_Url_Array;
		[ -z "${PLUGIN_Url_Array-}" ] && dk_call dk_error "PLUGIN_Url_Array is invalid";
		dk_call dk_debug "PLUGIN_Url_Array = '${PLUGIN_Url_Array}'";
		
		dk_call dk_arrayAt		PLUGIN_Url_Array	3;				PLUGIN_Import_Name="${dk_arrayAt}";
		[ -z "${PLUGIN_Import_Name-}" ] && dk_call dk_error "PLUGIN_Import_Name is invalid";
		dk_call dk_debug "PLUGIN_Import_Name = '${PLUGIN_Import_Name}'";
	fi
	
	export PLUGIN_EXPORT=$(declare -p PLUGIN);
}

############################
PLUGIN_Import_Name_Lower() {
	#source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -n "${PLUGIN_Import_Name_Lower-}" ] && return;
	
	PLUGIN_Import_Name;
	#source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -z "${PLUGIN_Import_Name-}" ] && dk_call dk_error "PLUGIN_Import_Name is invalid";
	dk_call dk_debug "PLUGIN_Import_Name = '${PLUGIN_Import_Name}'";
	
	dk_call dk_toLower 	"${PLUGIN_Import_Name}"; 	PLUGIN_Import_Name_Lower="${dk_toLower}";
	[ -z "${PLUGIN_Import_Name_Lower-}" ] && dk_call dk_error "PLUGIN_Import_Name_Lower is invalid";
	dk_call dk_debug "PLUGIN_Import_Name_Lower = '${PLUGIN_Import_Name_Lower}'";
	
	export PLUGIN_EXPORT=$(declare -p PLUGIN);
}

##########################
PLUGIN_Install_Dirname() {
	#source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -n "${PLUGIN_Install_Dirname-}" ] && return;
	
	dk_call dk_validate DK3RDPARTY_DIR "dk_call dk_DK3RDPARTY_DIR";
	PLUGIN_Install_Dirname="${DK3RDPARTY_DIR}";
	[ -z "${PLUGIN_Install_Dirname-}" ] && dk_call dk_error "PLUGIN_Install_Dirname is invalid";
	dk_call dk_debug "PLUGIN_Install_Dirname = '${PLUGIN_Install_Dirname}'";
	
	export PLUGIN_EXPORT=$(declare -p PLUGIN);
}

#######################
PLUGIN_Url_Basename() {
	#source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -n "${PLUGIN_Url_Basename-}" ] && return;

	dk_call dk_basename	"${PLUGIN_Url}";  PLUGIN_Url_Basename="${dk_basename}";				# basename, filename
	[ -z "${PLUGIN_Url_Basename-}" ] && dk_call dk_error "PLUGIN_Url_Basename is invalid";
	dk_call dk_debug "PLUGIN_Url_Basename = '${PLUGIN_Url_Basename}'";
	
	export PLUGIN_EXPORT=$(declare -p PLUGIN);
}

####################
PLUGIN_Url_Name() {
	#source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -n "${PLUGIN_Url_Name-}" ] && return;
	
	PLUGIN_Url_Basename;
	#source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -z "${PLUGIN_Url_Basename-}" ] && dk_call dk_error "PLUGIN_Url_Basename is invalid";
	dk_call dk_debug "PLUGIN_Url_Basename = '${PLUGIN_Url_Basename}'";
	
	dk_call dk_removeExtension	"${PLUGIN_Url_Basename}";	PLUGIN_Url_Name="${dk_removeExtension}";	# name, file  (no extension)
	[ -z "${PLUGIN_Url_Name-}" ] && dk_call dk_error "PLUGIN_Url_Name is invalid";
	dk_call dk_debug "PLUGIN_Url_Name = '${PLUGIN_Url_Name}'";
	
	export PLUGIN_EXPORT=$(declare -p PLUGIN);
}

#########################
PLUGIN_Url_Name_Lower() {
	#source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -n "${PLUGIN_Url_Name_Lower-}" ] && return;
	
	PLUGIN_Url_Name;
	#source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -z "${PLUGIN_Url_Name-}" ] && dk_call dk_error "PLUGIN_Url_Name is invalid";
	dk_call dk_debug "PLUGIN_Url_Name = '${PLUGIN_Url_Name}'";
	
	dk_call dk_toLower ${PLUGIN_Url_Name}; 	PLUGIN_Url_Name_Lower="${dk_toLower}";
	[ -z "${PLUGIN_Url_Name_Lower-}" ] && dk_call dk_error "PLUGIN_Url_Name_Lower is invalid";
	dk_call dk_debug "PLUGIN_Url_Name_Lower = '${PLUGIN_Url_Name_Lower}'";
	
	export PLUGIN_EXPORT=$(declare -p PLUGIN);
}

#######################
PLUGIN_Install_Name() {
	#source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -n "${PLUGIN_Install_Name}" ] && return;
	
	#export PLUGIN_EXPORT=$(declare -p PLUGIN);
	PLUGIN_Import_Name;
	#source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -z "${PLUGIN_Import_Name-}" ] && dk_call dk_error "PLUGIN_Import_Name is invalid";
	dk_call dk_debug "PLUGIN_Import_Name = '${PLUGIN_Import_Name}'";
	
	#export PLUGIN_EXPORT=$(declare -p PLUGIN);
	PLUGIN_Version;
	#source <(printf "%s" "${PLUGIN_EXPORT}");
	#[ -z "${PLUGIN_Version-}" ] && dk_call dk_error "PLUGIN_Version is invalid";
	dk_call dk_debug "PLUGIN_Version = '${PLUGIN_Version}'";
	
	if [ -n "${PLUGIN_Import_Name}" ] && [ -n "${PLUGIN_Version}" ]; then
		PLUGIN_Install_Name="${PLUGIN_Import_Name}-${PLUGIN_Version}";
	elif [ -z "${PLUGIN_Install_Name}" ]; then	
		PLUGIN_Install_Name="${PLUGIN_Import_Name}";
	fi
	[ -z "${PLUGIN_Install_Name-}" ] && dk_call dk_error "PLUGIN_Install_Name is invalid";
	dk_call dk_debug "PLUGIN_Install_Name = '${PLUGIN_Install_Name}'";
	
	export PLUGIN_EXPORT=$(declare -p PLUGIN);
}

#######################
PLUGIN_Install_Path() {
	#source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -n "${PLUGIN_Install_Path}" ] && return;
	
	#export PLUGIN_EXPORT=$(declare -p PLUGIN);
	PLUGIN_Install_Dirname;
	#source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -z "${PLUGIN_Install_Dirname-}" ] && dk_call dk_error "PLUGIN_Install_Dirname is invalid";
	dk_call dk_debug "PLUGIN_Install_Dirname = '${PLUGIN_Install_Dirname}'";
	
	#export PLUGIN_EXPORT=$(declare -p PLUGIN);
	PLUGIN_Install_Name;
	#source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -z "${PLUGIN_Install_Name-}" ] && dk_call dk_error "PLUGIN_Install_Name is invalid";
	dk_call dk_debug "PLUGIN_Install_Name = '${PLUGIN_Install_Name}'";
	
	PLUGIN_Install_Path="${PLUGIN_Install_Dirname}/${PLUGIN_Install_Name}";
	[ -z "${PLUGIN_Install_Path-}" ] && dk_call dk_error "PLUGIN_Install_Path is invalid";
	dk_call dk_debug "PLUGIN_Install_Path = '${PLUGIN_Install_Path}'";
	
	export PLUGIN_EXPORT=$(declare -p PLUGIN);
}

######################
PLUGIN_Import_Path() {	
	#source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -n "${PLUGIN_Import_Path}" ] && return;
	
	if [ -n "${PLUGIN_Import_Name}" ]; then
		dk_call dk_validate DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR";
		PLUGIN_Import_Path="${DKIMPORTS_DIR}/${PLUGIN_Import_Name}";
	elif dk_call dk_includes "${CURRENT_IMPORT-}" "${DKIMPORTS_DIR}"; then
		PLUGIN_Import_Path="${CURRENT_IMPORT}";
	fi
	
	#[ -z "${PLUGIN_Import_Path-}" ] && dk_call dk_error "PLUGIN_Import_Path is invalid";
	dk_call dk_debug "PLUGIN_Import_Path = '${PLUGIN_Import_Path}'";
	
	export PLUGIN_EXPORT=$(declare -p PLUGIN);
}

##################
PLUGIN_Version() {
	#source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -n "${PLUGIN_Version}" ] && return;
		
	PLUGIN_Url_Name_Lower;
	#source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -z "${PLUGIN_Url_Name_Lower-}" ] && dk_call dk_error "PLUGIN_Url_Name_Lower is invalid";
	dk_call dk_debug "PLUGIN_Url_Name_Lower = '${PLUGIN_Url_Name_Lower}'";
	
	export PLUGIN_EXPORT=$(declare -p PLUGIN);
	PLUGIN_Import_Name_Lower;
	#source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -z "${PLUGIN_Import_Name_Lower-}" ] && dk_call dk_error "PLUGIN_Import_Name_Lower is invalid";
	dk_call dk_debug "PLUGIN_Import_Name_Lower = '${PLUGIN_Import_Name_Lower}'";
	
	echo "dk_replaceAll  ${PLUGIN_Url_Name_Lower} 	${PLUGIN_Import_Name_Lower}";
	if [ -n "${PLUGIN_Url_Name_Lower}" ] && [ -n "${PLUGIN_Import_Name_Lower}" ]; then
		dk_call dk_replaceAll "${PLUGIN_Url_Name_Lower}" 	"${PLUGIN_Import_Name_Lower}" 	""; 	PLUGIN_Version="${dk_replaceAll}";
		# [ -z "${PLUGIN_Version}" ] && PLUGIN_Version=${PLUGIN_TAG};
		# [ -z "${PLUGIN_Version}" ] && PLUGIN_Version=${PLUGIN_Branch}; 
	fi
	
	dk_call dk_trimNonAlphaNumeric "${PLUGIN_Version}";  PLUGIN_Version="${dk_trimNonAlphaNumeric}";
	
	#[ -z "${PLUGIN_Version-}" ] && dk_call dk_error "PLUGIN_Version is invalid";
	dk_call dk_debug "PLUGIN_Version = '${PLUGIN_Version}'";

	export PLUGIN_EXPORT=$(declare -p PLUGIN);
}

############################
PLUGIN_Import_Name_Upper() {
	#source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -n "${PLUGIN_Import_Name_Upper-}" ] && return;
	
	PLUGIN_Import_Name;
	#source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -z "${PLUGIN_Import_Name-}" ] && dk_call dk_error "PLUGIN_Import_Name is invalid";
	dk_call dk_debug "PLUGIN_Import_Name = '${PLUGIN_Import_Name}'";
	
	dk_call dk_toUpper	"${PLUGIN_Import_Name}";		PLUGIN_Import_Name_Upper="${dk_toUpper}";
	[ -z "${PLUGIN_Import_Name_Upper-}" ] && dk_call dk_error "PLUGIN_Import_Name_Upper is invalid";
	dk_call dk_debug "PLUGIN_Import_Name_Upper = '${PLUGIN_Import_Name_Upper}'";
	
	export PLUGIN_EXPORT=$(declare -p PLUGIN);
}

#############
PLUGIN_Id() {
	#source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -n "${PLUGIN_Id-}" ] && return;
	
	
	PLUGIN_Import_Name_Upper;
	#source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -z "${PLUGIN_Import_Name_Upper-}" ] && dk_call dk_error "PLUGIN_Import_Name_Upper is invalid";
	dk_call dk_debug "PLUGIN_Import_Name_Upper = '${PLUGIN_Import_Name_Upper}'";
	
	dk_call dk_convertToCIdentifier	"${PLUGIN_Import_Name_Upper}"; 	PLUGIN_Id="${dk_convertToCIdentifier}";
	[ -z "${PLUGIN_Id-}" ] && dk_call dk_error "PLUGIN_Id is invalid";
	dk_call dk_debug "PLUGIN_Id = '${PLUGIN_Id}'";
	
	export PLUGIN_EXPORT=$(declare -p PLUGIN);
}

#############
PRINTVARS() {
	#source <(printf "%s" "${PLUGIN_EXPORT}");
	
	dk_call dk_echo;
	dk_call dk_echo;
	dk_call dk_echo "################## PLUGIN_variables ##################";
	dk_call dk_echo "PLUGIN                                  = '${PLUGIN-}'";
	dk_call dk_echo "${PLUGIN}                               = '${!PLUGIN-}'";
	dk_call dk_echo "PLUGIN_Args                         = '${PLUGIN_Args-}'";
	dk_call dk_echo "PLUGIN_Id                           = '${PLUGIN_Id-}'";
	dk_call dk_echo "PLUGIN_Version                      = '${PLUGIN_Version-}'";
	dk_call dk_echo "PLUGIN_Url                          = '${PLUGIN_Url-}'";
	dk_call dk_echo "PLUGIN_Url_Basename                 = '${PLUGIN_Url_Basename-}'";
	dk_call dk_echo "PLUGIN_Url_Name                     = '${PLUGIN_Url_Name-}'";
	dk_call dk_echo "PLUGIN_Url_Extension                = '${PLUGIN_Url_Extension-}'";
	dk_call dk_echo "PLUGIN_Import_Dirname               = '${PLUGIN_Import_Dirname-}'";
	dk_call dk_echo "PLUGIN_Import_Name                  = '${PLUGIN_Import_Name-}'";
	dk_call dk_echo "PLUGIN_Import_Path                  = '${PLUGIN_Import_Path-}'";
	dk_call dk_echo "PLUGIN_Install_Dirname              = '${PLUGIN_Install_Dirname-}'";
	dk_call dk_echo "PLUGIN_Install_Name                 = '${PLUGIN_Install_Name-}'";
	dk_call dk_echo "PLUGIN_Install_Path                 = '${PLUGIN_Install_Path-}'";
	dk_call dk_echo "PLUGIN_Tuple_Dir                    = '${PLUGIN_Tuple_Dir-}'";
	dk_call dk_echo "PLUGIN_Build_Dir                    = '${PLUGIN_Build_Dir-}'";
	dk_call dk_echo "PLUGIN_Config_Dir                   = '${PLUGIN_Config_Dir-}'";
	dk_call dk_echo "PLUGIN_Debug_Dir                    = '${PLUGIN_Debug_Dir-}'";
	dk_call dk_echo "PLUGIN_Release_Dir                  = '${PLUGIN_Release_Dir-}'";
	dk_call dk_echo
	dk_call dk_echo
	
#	dk_call dk_echo "################## ${PLUGIN-}.variables ##################"
#	dk_call dk_echo "${PLUGIN-}_Id                       = '${${PLUGIN-}_Id-}'";
#	dk_call dk_echo "${PLUGIN-}_Args                     = '${${PLUGIN-}_Args-}'";
#	dk_call dk_echo "${PLUGIN-}_Id                       = '${${PLUGIN-}_Id-}'";
#	dk_call dk_echo "${PLUGIN-}_Version                  = '${${PLUGIN-}_Version-}'";
#	dk_call dk_echo "${PLUGIN-}_Url                      = '${${PLUGIN-}_Url-}'";
#	dk_call dk_echo "${PLUGIN-}_Url_Basename             = '${${PLUGIN-}_Url_Basename-}'";
#	dk_call dk_echo "${PLUGIN-}_Url_Name                 = '${${PLUGIN-}_Url_Name-}'";
#	dk_call dk_echo "${PLUGIN-}_Url_Extension            = '${${PLUGIN-}_Url_Extension-}'";
#	dk_call dk_echo "${PLUGIN-}_Import_Dirname           = '${${PLUGIN-}_Import_Dirname-}'";
#	dk_call dk_echo "${PLUGIN-}_Import_Name              = '${${PLUGIN-}_Import_Name-}'";
#	dk_call dk_echo "${PLUGIN-}_Import_Path              = '${${PLUGIN-}_Import_Path-}'";
#	dk_call dk_echo "${PLUGIN-}_Install_Dirname          = '${${PLUGIN-}_Install_Dirname-}'";
#	dk_call dk_echo "${PLUGIN-}_Install_Name             = '${${PLUGIN-}_Install_Name-}'";
#	dk_call dk_echo "${PLUGIN-}_Install_Path             = '${${PLUGIN-}_Install_Path-}'";
#	dk_call dk_echo "${PLUGIN-}_Tuple_Dir                = '${${PLUGIN-}_Tuple_Dir-}'";
#	dk_call dk_echo "${PLUGIN-}_Build_Dir                = '${${PLUGIN-}_Build_Dir-}'";
#	dk_call dk_echo "${PLUGIN-}_Config_Dir               = '${${PLUGIN-}_Config_Dir-}'";
#	dk_call dk_echo "${PLUGIN-}_Debug_Dir                = '${${PLUGIN-}_Debug_Dir-}'";
#	dk_call dk_echo "${PLUGIN-}_Release_Dir              = '${${PLUGIN-}_Release_Dir-}'";
#	dk_call dk_echo
}













###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0;
	
	dk_call dk_validate DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR";
	dk_call dk_validate DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR";
	
	export CURRENT_IMPORT="${DKIMPORTS_DIR}/msys2";
	dk_call dk_importVariables "https://repo.msys2.org/distrib/x86_64/msys2-base-x86_64-20241208.tar.xz";
	### Import PLUGIN and <PLUGIN_NAME> hashtables #################
	#eval "${PLUGIN_EXPORT}";										# Import the PLUGIN hashtable, Using 'eval'
	#source <(printf "%s" "${PLUGIN_EXPORT}");						# Import the PLUGIN hashtable, Using 'source'

################################################################	
	### Create <PLUGIN_ID> hashtable from PLUGIN hashtable			# Example: if plugin is 'GIT'. We can now use GIT_var instead of PLUGIN_var
	#eval "${PLUGIN_EXPORT/PLUGIN/${PLUGIN_ID}}";					# Import the PLUGIN_ID hashtable, Using 'eval'
	#source <(printf "%s" "${PLUGIN_EXPORT/PLUGIN/${PLUGIN_ID}}");	# Import the PLUGIN_ID hashtable, Using 'source'
	#"${PLUGIN_@@A}" && declare -A ${PLUGIN_Id}="${_#*=}"			# Import the PLUGIN_ID hashtable, Using 'copy routine' #https://stackoverflow.com/a/78068508/688352
	dk_call dk_importVariables PRINTVARS;
################################################################

	
	#dk_call dk_chdir "${DKIMPORTS_DIR}/git";
	export CURRENT_IMPORT="${DIGITALKNOB_DIR}";
	dk_call dk_importVariables "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe" INSTALL_ROOT "${DKTOOLS_DIR}";
	#source <(printf "%s" "${PLUGIN_EXPORT}");						# Import the PLUGIN hashtable, Using 'source'
	#"${PLUGIN_@]@A}" && declare -A ${PLUGIN_Id}="${_#*=}";			# Import the PLUGIN_ID hashtable, Using 'copy routine' #https://stackoverflow.com/a/78068508/688352
	dk_call dk_importVariables PRINTVARS;
	
	#dk_call dk_chdir "${DKIMPORTS_DIR}/php-src";
	export CURRENT_IMPORT="${DKIMPORTS_DIR}/php-src";
	dk_call dk_importVariables "https://windows.php.net/downloads/releases/php-8.4.11-Win32-vs17-x64.zip";
	#source <(printf "%s" "${PLUGIN_EXPORT}");						# Import the PLUGIN hashtable, Using 'source'
	#"${PLUGIN_@]@A}" && declare -A ${PLUGIN_Id}="${_#*=}";			# Import the PLUGIN_ID hashtable, Using 'copy routine' #https://stackoverflow.com/a/78068508/688352
	dk_call dk_importVariables PRINTVARS;
}
