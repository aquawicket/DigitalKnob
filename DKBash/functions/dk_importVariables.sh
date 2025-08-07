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


#######################################################################################################################################
# dk_importVariables(PLUGIN[URL] rtn_var) IMPORT_ROOT IMPORT_NAME IMPORT_PATH INSTALL_ROOT INSTALL_NAME INSTALL_PATH VERSION BRANCH TAG
#
#															###### EXAMPLES ######
#	PLUGIN_URL												https://github.com/madler/zlib.git     							* github repository link
#															https://github.com/madler/zlib/archive/refs/heads/master.zip	* github sourcecode download
#															https://github.com/madler/zlib        							* github page
#															https://zlib.net/zlib-1.3.1.tar.gz								* library sourcecode download
#															https://website.com/executable.exe              				* executable file
#
#
#	IMPORT_ROOT	(optional)									C:/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS
#
#
#	IMPORT_NAME (optional)									zlib
#
#
#	IMPORT_PATH (optional)									C:/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
#
#
#	INSTALL_ROOT (optional)									C:/Users/Administrator/DigitalKnob/Development/DKTools
#
#
#	INSTALL_NAME (optional)									zlib-8-5-2025
#															myZLIB
#
#	INSTALL_PATH (optional)									C:/Users/Administrator/DigitalKnob/Development/DKTools/zlib-8-5-2025
#															C:/Users/Administrator/DigitalKnob/Development/DKTools/myZLIB
#
#	VERSION (optional)										master
#
#
#	BRANCH (optional)										develop
#															master
#
#	TAG (optional)											v1.3.1
#															v1.2.13
#
dk_importVariables() {
	#dk_debugFunc 1 9
	
	# https://stackoverflow.com/a/78128262/688352
	### PLUGIN(hashtable) 
	declare -A -x PLUGIN
	####################

															###### EXAMPLE ######
	### IMPORT_ROOT											/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS
	dk_call dk_unset IMPORT_ROOT;
	dk_call dk_getParameterValue IMPORT_ROOT "$@";
	PLUGIN[IMPORT_ROOT]=${IMPORT_ROOT-};
	#dk_call dk_echo "PLUGIN[IMPORT_ROOT] = '${PLUGIN[IMPORT_ROOT]}'";
	
	### IMPORT_NAME											zlib
	dk_call dk_unset IMPORT_NAME;
	dk_call dk_getParameterValue IMPORT_NAME "$@";
	PLUGIN[IMPORT_NAME]=${IMPORT_NAME-};
	#dk_call dk_echo "PLUGIN[IMPORT_NAME] = '${PLUGIN[IMPORT_NAME]}'";
	
	### IMPORT_PATH											/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
	dk_call dk_unset IMPORT_PATH;
	dk_call dk_getParameterValue IMPORT_PATH "$@";
	PLUGIN[IMPORT_PATH]=${IMPORT_PATH-};
	#dk_call dk_echo "PLUGIN[IMPORT_PATH] = '${PLUGIN[IMPORT_PATH]}'";
	
	### INSTALL_ROOT										/c/Users/Administrator/DigitalKnob/Development/3rdParty
	dk_call dk_unset INSTALL_ROOT;
	dk_call dk_getParameterValue INSTALL_ROOT "$@";
	PLUGIN[INSTALL_ROOT]=${INSTALL_ROOT-};
	#dk_call dk_echo "PLUGIN[INSTALL_ROOT] = '${PLUGIN[INSTALL_ROOT]}'";
	
	### INSTALL_NAME										zlib-master
	dk_call dk_unset INSTALL_NAME;
	dk_call dk_getParameterValue INSTALL_NAME "$@";
	PLUGIN[INSTALL_NAME]=${INSTALL_NAME-};
	#dk_call dk_echo "PLUGIN[INSTALL_NAME] = '${PLUGIN[INSTALL_NAME]}'";
	
	### INSTALL_PATH										/c/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	dk_call dk_unset INSTALL_PATH;
	dk_call dk_getParameterValue INSTALL_PATH "$@";
	PLUGIN[INSTALL_PATH]=${INSTALL_PATH-};
	#dk_call dk_echo "PLUGIN[INSTALL_PATH] = '${PLUGIN[INSTALL_PATH]}'";
	
	### VERSION												master
	dk_call dk_unset VERSION;
	dk_call dk_getParameterValue VERSION "$@";
	PLUGIN[VERSION]=${VERSION-};
	#dk_call dk_echo "PLUGIN[VERSION] = '${PLUGIN[VERSION]}'";
	
	### BRANCH												master
	dk_call dk_unset BRANCH;
	dk_call dk_getParameterValue BRANCH	"$@";
	PLUGIN[BRANCH]=${BRANCH-};
	#dk_call dk_echo "PLUGIN[BRANCH] = '${PLUGIN[BRANCH]}'";
	
	### TAG													v1.3.1
	dk_call dk_unset TAG;
	dk_call dk_getParameterValue TAG "$@";
	PLUGIN[TAG]=${TAG-};
	#dk_call dk_echo "PLUGIN[TAG] = '${PLUGIN[TAG]}'";

		
		
		
		
	############### PLUGIN ##################
	
	### PLUGIN[IMPORT_PATH]										/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
	if [ -z "${PLUGIN[IMPORT_PATH]}" ]; then	
		dk_call dk_getcwd;
		PLUGIN[IMPORT_PATH]=${DKPWD};
	fi
	#dk_call dk_echo "PLUGIN[IMPORT_PATH] = '${PLUGIN[IMPORT_PATH]}'";
	
	### PLUGIN[IMPORT_ROOT]										/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS
	if [ -z "${PLUGIN[IMPORT_ROOT]}" ]; then
		dk_call dk_dirname			${PLUGIN[IMPORT_PATH]};			PLUGIN[IMPORT_ROOT]=${dk_dirname};
	fi
	#dk_call dk_echo "PLUGIN[IMPORT_ROOT] = '${PLUGIN[IMPORT_ROOT]}'";

	### PLUGIN[IMPORT_NAME]											zlib
	if [ -z "${PLUGIN[IMPORT_NAME]}" ]; then
		dk_call dk_basename			${PLUGIN[IMPORT_PATH]};			PLUGIN[IMPORT_NAME]=${dk_basename};
	fi
	#dk_call dk_echo "PLUGIN[IMPORT_NAME] = '${PLUGIN[IMPORT_NAME]}'";

	### PLUGIN[IMPORT_NAME_Upper]									ZLIB
	dk_call dk_toUpper				${PLUGIN[IMPORT_NAME]};			PLUGIN[IMPORT_NAME_Upper]=${dk_toUpper};
	#dk_call dk_echo "PLUGIN[IMPORT_NAME_Upper] = '${PLUGIN[IMPORT_NAME_Upper]}'";

	### PLUGIN[IMPORT_C_Name]										ZLIB
	dk_call dk_convertToCIdentifier ${PLUGIN[IMPORT_NAME_Upper]}; 	PLUGIN[IMPORT_NAME_Alphanumeric]=${dk_convertToCIdentifier};
	#dk_call dk_echo "PLUGIN[IMPORT_NAME_Alphanumeric] = '${PLUGIN[IMPORT_NAME_Alphanumeric]}'";

	### PLUGIN[ID]
	PLUGIN[ID]=${PLUGIN[IMPORT_NAME_Upper]};
	if [ "${PLUGIN[ID]}" = "${PLUGIN[IMPORT_NAME_Alphanumeric]}" ]; then
		dk_call dk_notice "${PLUGIN[ID]} contains non-alphanumeric characters and will be set to ${PLUGIN[IMPORT_NAME_Alphanumeric]}";
		PLUGIN[ID]=${PLUGIN[IMPORT_NAME_Alphanumeric]};
	fi
	#dk_call dk_echo "PLUGIN[ID] = '${PLUGIN[ID]}'";

	### PLUGIN[ARGS]															"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	PLUGIN[ARGS]=${*};
	#dk_call dk_echo "PLUGIN[ARGS] = '${PLUGIN[ARGS]}'";

	### PLUGIN[URL]																"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	PLUGIN[URL]=${1};
	#dk_call dk_echo "PLUGIN[URL] = '${PLUGIN[URL]}'";

	### PLUGIN[IMPORT]												1
	dk_call dk_validate 		DKIMPORTS_DIR 			"dk_call dk_DKIMPORTS_DIR";
	dk_call dk_includes 		${PLUGIN[IMPORT_PATH]} ${DKIMPORTS_DIR} 		&& PLUGIN[IMPORT]="1";
	#dk_call dk_echo "PLUGIN[IMPORT] = '${PLUGIN[IMPORT]}'";

	### PLUGIN[URL_Filename]													master.zip
	dk_call dk_basename			${PLUGIN[URL]};					PLUGIN[URL_Filename]=${dk_basename};
	#dk_call dk_echo "PLUGIN[URL_Filename] = '${PLUGIN[URL_Filename]}'";

	### PLUGIN[URL_List]														https:;github.com;madler;zlib;archive;refs;heads;master.zip
	dk_call dk_replaceAll 		${PLUGIN[URL]} 			"/" 	";"; 	PLUGIN[URL_List]=${dk_replaceAll};
	dk_call dk_replaceAll 		${PLUGIN[URL_List]} 	";;" 	";"; 	PLUGIN[URL_List]=${dk_replaceAll};
	#dk_call dk_echo "PLUGIN[URL_List] = '${PLUGIN[URL_List]}'";
	
	### PLUGIN[GIT]															1
	dk_call dk_includes 		${PLUGIN[URL]} 			"https://github.com" 	&& PLUGIN[GIT]="1";
	#dk_call dk_echo "PLUGIN[GIT] = '${PLUGIN[GIT]}'";
	
	### PLUGIN[URL_Extension]													.zip
	dk_call dk_getExtension		${PLUGIN[URL_Filename]};		PLUGIN[URL_Extension]=${dk_getExtension};
	#dk_call dk_echo "PLUGIN[URL_Extension] = '${PLUGIN[URL_Extension]}'";
	
	### PLUGIN[URL_File]														master
	dk_call dk_removeExtension	${PLUGIN[URL_Filename]};		PLUGIN[URL_File]=${dk_removeExtension};
	#dk_call dk_echo "PLUGIN[URL_File] = '${PLUGIN[URL_File]}'";
	
	### PLUGIN[URL_File_Lower]													master
	dk_call dk_toLower 			${PLUGIN[URL_File]}; 			PLUGIN[URL_File_Lower]=${dk_toLower};
	#dk_call dk_echo "PLUGIN[URL_File_Lower] = '${PLUGIN[URL_File_Lower]}'";
	
	### PLUGIN[URL_Array]														[0]https: [1]github.com [2]madler [3]zlib [4]archive [5]refs [6]heads [7]master.zip	
	dk_call dk_listToArray 		${PLUGIN[URL_List]}; 			PLUGIN_URL_Array=(${dk_listToArray[@]});
	#dk_call dk_echo "PLUGIN_URL_Array = '${PLUGIN_URL_Array[*]}'";
	
	### PLUGIN[URL_Length]														8
	dk_call dk_arrayLength 		PLUGIN_URL_Array;				PLUGIN[URL_Length]=${dk_arrayLength};
	#dk_call dk_echo "dk_arrayLength = '${dk_arrayLength}'";
	
	### PLUGIN[IMPORT_NAME_Lower]												zlib
	dk_call dk_toLower 			${PLUGIN[IMPORT_NAME]}; 		PLUGIN[IMPORT_NAME_Lower]=${dk_toLower};
	#dk_call dk_echo "PLUGIN[IMPORT_NAME_Lower] = '${PLUGIN[IMPORT_NAME_Lower]}'";
	
	
	###############################################
	############ PLUGIN[GIT_Variables] ###########
	###############################################
	if [ "${PLUGIN[GIT]}" = "1" ]; then
	
		### PLUGIN[GIT_NAME]													zlib
		dk_call dk_arrayAt 		PLUGIN_URL_Array 	3;			PLUGIN[GIT_NAME]=${dk_arrayAt};
		#dk_call dk_echo "PLUGIN[GIT_NAME] = '${PLUGIN[GIT_NAME]}'";
	
		### PLUGIN[GIT_NAME_Lower]												zlib
		dk_call dk_toLower 		${PLUGIN[GIT_NAME]}; 			PLUGIN[GIT_NAME_Lower]=${dk_toLower};
		#dk_call dk_echo "PLUGIN[GIT_NAME_Lower] = '${PLUGIN[GIT_NAME_Lower]}'";
		
		### PLUGIN[GIT_BRANCH]													master
		if [ -n "${PLUGIN[BRANCH]}" ]; then
			#dk_call dk_getGitBRANCHName ${PLUGIN[URL]}; 	PLUGIN_BRANCH=${dk_getGitBRANCHName};
			PLUGIN[BRANCH]="master";
		fi
		#dk_call dk_echo "PLUGIN[BRANCH] = '${PLUGIN[BRANCH]}'";
		
		### PLUGIN[GIT_TAG]													TODO
		#if [ -z "${PLUGIN[TAG]}" ]; then
			### TODO ###
		#fi
		#dk_call dk_echo "PLUGIN[GIT_TAG] = '${PLUGIN[GIT_TAG]}'";
	fi
	
	
	###################################################
	############ PLUGIN[INSTALL_Variables] ###########
	###################################################
	
	### PLUGIN[NAME]
	[ -z "${PLUGIN[NAME]-}" ] && PLUGIN[NAME]=${PLUGIN[IMPORT_NAME]}; 
	[ -z "${PLUGIN[NAME]-}" ] && PLUGIN[NAME]=${PLUGIN[GIT_NAME]};
	[ -z "${PLUGIN[NAME]-}" ] && PLUGIN[NAME]=${PLUGIN[URL_NAME]};
	[ -z "${PLUGIN[NAME]-}" ] && dk_call dk_error "PLUGIN[NAME] invalid";
	# dk_call dk_convertToCIdentifier	$PLUGIN[INSTALL_NAME];	PLUGIN[INSTALL_NAME]=${dk_convertToCIdentifier};
	#dk_call dk_echo "PLUGIN[NAME] = '${PLUGIN[NAME]}'";
	
	### PLUGIN[VERSION]													master
	[ -z "${PLUGIN[VERSION]}" ] && PLUGIN[VERSION]=${VERSION}; 
	if ([ -z "${PLUGIN[VERSION]}" ] && [ -n "${PLUGIN[URL_File_Lower]}" ] && [ -n "${PLUGIN[IMPORT_NAME_Lower]}" ]); then
		dk_call dk_replaceAll "${PLUGIN[URL_File_Lower]}" 	"${PLUGIN[IMPORT_NAME_Lower]}" 	""; 	PLUGIN[VERSION]=${dk_replaceAll};
		[ -z "${PLUGIN[VERSION]}" ] && PLUGIN[VERSION]=${PLUGIN[TAG]}; 
		[ -z "${PLUGIN[VERSION]}" ] && PLUGIN[VERSION]=${PLUGIN[BRANCH]}; 
	fi
	[ -z "${PLUGIN[VERSION]}" ] &&  PLUGIN[VERSION]="master";
	[ -z "${PLUGIN[VERSION]}" ] && dk_call dk_error "PLUGIN[VERSION] invalid";
	#dk_call dk_echo "PLUGIN[VERSION] = '${PLUGIN[VERSION]}'";
	
#	string FIND ${PLUGIN_INSTALL_Version} - index;
#	if [ ${index} -eq 0 ]; then
#		string SUBSTRING ${PLUGIN_INSTALL_Version} 1 -1 PLUGIN[INSTALL_Version];
#	fi  
#	string FIND ${PLUGIN[INSTALL_Version]} _ index;
#	if [ ${index} -eq 0 ]; then
#		string SUBSTRING ${PLUGIN[INSTALL_Version]} 1 -1 PLUGIN[INSTALL_Version];
#	fi  
 
	### PLUGIN[INSTALL_NAME]													zlib-master
	if ([ -z "${PLUGIN[INSTALL_NAME]}" ] && [ -n "${PLUGIN[NAME]}" ] && [ -n "${PLUGIN[VERSION]}" ]); then
		PLUGIN[INSTALL_NAME]="${PLUGIN[NAME]}-${PLUGIN[VERSION]}";
	fi
	[ -z "${PLUGIN[INSTALL_NAME]}" ] && PLUGIN[INSTALL_NAME]=${PLUGIN[NAME]};
	[ -z "${PLUGIN[INSTALL_NAME]}" ] && dk_call dk_error "PLUGIN[INSTALL_NAME] invalid";
	#dk_call dk_echo "PLUGIN[INSTALL_NAME] = '${PLUGIN[INSTALL_NAME]}'";
	
	### PLUGIN[INSTALL_ROOT]														C:/Users/Administrator/DigitalKnob/Development/3rdParty
	if [ -z "${PLUGIN[INSTALL_ROOT]}" ]; then
		dk_call dk_validate DK3RDPARTY_DIR "dk_call dk_DK3RDPARTY_DIR";
		PLUGIN[INSTALL_ROOT]=${DK3RDPARTY_DIR};
	fi
	[ -z "${PLUGIN[INSTALL_ROOT]}" ] && dk_call dk_error "PLUGIN[INSTALL_ROOT] invalid";
	#dk_call dk_echo "PLUGIN[INSTALL_ROOT] = '${PLUGIN[INSTALL_ROOT]}'";

	### PLUGIN[INSTALL_PATH]														C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	[ -z "${PLUGIN[INSTALL_PATH]}" ] && PLUGIN[INSTALL_PATH]="${PLUGIN[INSTALL_ROOT]}/${PLUGIN[INSTALL_NAME]}";
	[ -z "${PLUGIN[INSTALL_PATH]}" ] && dk_call dk_error "PLUGIN[INSTALL_PATH] invalid";
	#dk_call dk_echo "PLUGIN[INSTALL_PATH] = '${PLUGIN[INSTALL_PATH]}'";
 
	##############################################
	############# PLUGIN[Variables] #############
	##############################################
 
#	if( [ -n "${PLUGIN[IMPORT_NAME_Lower]-}" ] && [ -n "${PLUGIN[GIT_NAME_Lower]-}" ] ); then
#		if [ "${PLUGIN[IMPORT_NAME_Lower]}" != "${PLUGIN[GIT_NAME_Lower]}" ]; then
#			dk_call dk_warning "PLUGIN[IMPORT_NAME_Lower]:${PLUGIN[IMPORT_NAME_Lower]} and PLUGIN[GIT_NAME_Lower]:PLUGIN[GIT_NAME_Lower] do not match";
#		fi
#	fi
	
#	### PLUGIN[DIR]											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
#	if ! [ "${PLUGIN[DIR]}" = "GIT" ]; then	### DO NOT USE GIT_DIR ###
#		PLUGIN[DIR]=${PLUGIN[INSTALL_PATH]};
#	fi
#	#dk_call dk_echo "PLUGIN[DIR] = '${PLUGIN[DIR]}'";
	

	#####################################################
	############# TARGET $PLUGIN[Variables #############
	#####################################################

	### PLUGIN[Tuple_Dir]											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang
	PLUGIN[Tuple_Dir]="${PLUGIN[INSTALL_PATH]}/${Target_Tuple-}";
	#dk_call dk_echo "PLUGIN[Tuple_Dir] = '${PLUGIN[Tuple_Dir]}'";
	
	### PLUGIN[Config_Dir]											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	PLUGIN[Config_Dir]="${PLUGIN[INSTALL_PATH]-}/${Config_Path-}";
	#dk_call dk_echo "PLUGIN[Config_Dir] = '${PLUGIN[Config_Dir]}'";
	
	### PLUGIN[Build_Dir]											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	PLUGIN[Build_Dir]="${PLUGIN[INSTALL_PATH]-}/${Build_Path-}";
	#dk_call dk_echo "PLUGIN[Build_Dir] = '${PLUGIN[Build_Dir]}'";
	
	### PLUGIN[Debug_Dir]											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	PLUGIN[Debug_Dir]="${PLUGIN[INSTALL_PATH]-}/${Target_Tuple-}/${Debug_Dir-}";
	#dk_call dk_echo "PLUGIN[Debug_Dir] = '${PLUGIN[Debug_Dir]}'";
	
	### PLUGIN[Release_Dir]											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Release
	PLUGIN[Release_Dir]="${PLUGIN[INSTALL_PATH]-}/${Target_Tuple-}/${Release_Dir-}";
	#dk_call dk_echo "PLUGIN[Release_Dir] = '${PLUGIN[Release_Dir]}'";
	
	### Export the PLUGIN hashtable
	export PLUGIN_EXPORT=$(declare -p PLUGIN);
	
	### Create <PLUGIN[ID]> hashtable from PLUGIN hashtable
	#eval "${PLUGIN_EXPORT/PLUGIN/${PLUGIN[ID]}}";					# Import the PLUGIN[ID] hashtable, Using 'eval'
	#source <(printf "%s" "${PLUGIN_EXPORT/PLUGIN/${PLUGIN[ID]}}");	# Import the PLUGIN[ID] hashtable, Using 'source'
	"${PLUGIN[@]@A}" && declare -A -x ${PLUGIN[ID]}="${_#*=}"		# Import the PLUGIN[ID] hashtable, Using 'copy routine'  #https://stackoverflow.com/a/78068508/688352
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

	dk_debugFunc 0
	
	dk_call dk_validate DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR"
	dk_call dk_validate DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR"
	dk_call dk_chdir "${DKIMPORTS_DIR}/git";
	dk_call dk_importVariables "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe" IMPORT_NAME git ROOT "${DKTOOLS_DIR}";
	
	### Import PLUGIN and <PLUGIN_NAME> hashtables #################
	#eval "${PLUGIN_EXPORT}";										# Import the PLUGIN hashtable, Using 'eval'
	source <(printf "%s" "${PLUGIN_EXPORT}");						# Import the PLUGIN hashtable, Using 'source'
	
	### Create <PLUGIN[ID]> hashtable from PLUGIN hashtable			# Example: if plugin is 'GIT'. We can now use GIT[var] instead of PLUGIN[var]
	#eval "${PLUGIN_EXPORT/PLUGIN/${PLUGIN[ID]}}";					# Import the PLUGIN[ID] hashtable, Using 'eval'
	#source <(printf "%s" "${PLUGIN_EXPORT/PLUGIN/${PLUGIN[ID]}}");	# Import the PLUGIN[ID] hashtable, Using 'source'
	"${PLUGIN[@]@A}" && declare -A ${PLUGIN[ID]}="${_#*=}"			# Import the PLUGIN[ID] hashtable, Using 'copy routine' #https://stackoverflow.com/a/78068508/688352
																	
	dk_call dk_echo;
	dk_call dk_echo "IMPORT_ROOT                      = ${IMPORT_ROOT}";
	dk_call dk_echo "IMPORT_NAME                      = ${IMPORT_NAME}";
	dk_call dk_echo "IMPORT_PATH                      = ${IMPORT_PATH}";
	dk_call dk_echo "INSTALL_ROOT                     = ${INSTALL_ROOT}";
	dk_call dk_echo "INSTALL_NAME                     = ${INSTALL_NAME}";
	dk_call dk_echo "INSTALL_PATH                     = ${INSTALL_PATH}";
	dk_call dk_echo "VERSION                          = ${VERSION}";
	dk_call dk_echo "BRANCH                           = ${BRANCH}";
	dk_call dk_echo "TAG                              = ${TAG}";
	dk_call dk_echo "";
	dk_call dk_echo "PLUGIN[ID]                       = ${PLUGIN[ID]}";
	dk_call dk_echo "PLUGIN[ARGS]                     = ${PLUGIN[ARGS]}";
	dk_call dk_echo "PLUGIN[IMPORT_ROOT]              = ${PLUGIN[IMPORT_ROOT]}";
	dk_call dk_echo "PLUGIN[IMPORT_NAME]              = ${PLUGIN[IMPORT_NAME]}";
	dk_call dk_echo "PLUGIN[IMPORT_PATH]              = ${PLUGIN[IMPORT_PATH]}";
	dk_call dk_echo "PLUGIN[INSTALL_ROOT]             = ${PLUGIN[INSTALL_ROOT]}";
	dk_call dk_echo "PLUGIN[INSTALL_NAME]             = ${PLUGIN[INSTALL_NAME]}";
	dk_call dk_echo "PLUGIN[INSTALL_PATH]             = ${PLUGIN[INSTALL_PATH]}";
	dk_call dk_echo "PLUGIN[VERSION]                  = ${PLUGIN[VERSION]}";
	dk_call dk_echo "PLUGIN[BRANCH]                   = ${PLUGIN[BRANCH]}";
	dk_call dk_echo "PLUGIN[TAG]                      = ${PLUGIN[TAG]}";
	dk_call dk_echo "";
	dk_call dk_echo "PLUGIN[URL]                      = ${PLUGIN[URL]}";
	dk_call dk_echo "PLUGIN[URL_Filename]             = ${PLUGIN[URL_Filename]}";
	dk_call dk_echo "PLUGIN[URL_File]                 = ${PLUGIN[URL_File]}";
	dk_call dk_echo "PLUGIN[URL_Extension]            = ${PLUGIN[URL_Extension]}";
	dk_call dk_echo "PLUGIN[URL_List]                 = ${PLUGIN[URL_List]}";
	dk_call dk_echo "PLUGIN[URL_Array]                = ${PLUGIN[URL_Array]-}";
	dk_call dk_echo "PLUGIN[URL_Length]               = ${PLUGIN[URL_Length]}";
	dk_call dk_echo "";
	dk_call dk_echo "PLUGIN[GIT]                      = ${PLUGIN[GIT]}";
	dk_call dk_echo "PLUGIN[GIT_NAME]                 = ${PLUGIN[GIT_NAME]}";
	dk_call dk_echo "";
	dk_call dk_echo "PLUGIN[IMPORT]                   = ${PLUGIN[IMPORT]}";
	dk_call dk_echo "PLUGIN[IMPORT_NAME_Lower]        = ${PLUGIN[IMPORT_NAME_Lower]}";
	dk_call dk_echo "PLUGIN[IMPORT_NAME_Upper]        = ${PLUGIN[IMPORT_NAME_Upper]}";	
	dk_call dk_echo "PLUGIN[IMPORT_NAME_Alphanumeric] = ${PLUGIN[IMPORT_NAME_Alphanumeric]}";
	dk_call dk_echo "";
	dk_call dk_echo "PLUGIN[Build_Dir]                = ${PLUGIN[Build_Dir]}";
	dk_call dk_echo "PLUGIN[Config_Dir]               = ${PLUGIN[Config_Dir]}";
	dk_call dk_echo "PLUGIN[Debug_Dir]                = ${PLUGIN[Debug_Dir]}";
	dk_call dk_echo "PLUGIN[Release_Dir]              = ${PLUGIN[Release_Dir]}";
	dk_call dk_echo "PLUGIN[Tuple_Dir]                = ${PLUGIN[Tuple_Dir]}";
	dk_call dk_echo "";
	dk_call dk_echo "GIT[ID]                          = ${GIT[ID]}";	
}
