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


#################################################################################
# dk_importVariables(PLUGIN_URL rtn_var) BRANCH FOLDER IMPORT_Name PATH ROOT TAG VERSION
#
#															###### EXAMPLES ######
#	PLUGIN_URL												https://github.com/madler/zlib.git     							* github repository link
#															https://github.com/madler/zlib/archive/refs/heads/master.zip	* github sourcecode download
#															https://github.com/madler/zlib        							* github page
#															https://zlib.net/zlib-1.3.1.tar.gz								* library sourcecode download
#															https://website.com/executable.exe              				* executable file
#
#	IMPORT_Path (optional)									C:/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
#
#															
#	BRANCH (optional)										develop
#															master
#
#	FOLDER (optional)										zlib-develop
#															zlib-master
#
#	IMPORT_Name (optional)									zlib
#															myZLIB
#
#	PATH (optional)											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
#															C:/Users/Administrator/DigitalKnob/Development/3rdParty/myZLIB
#
#	ROOT (optional)											C:/Users/Administrator/DigitalKnob/Development/3rdParty
#															C:/Users/Administrator/MyLibraries
#
#	TAG (optional)											v1.3.1
#															v1.2.13
#
#	VERSION (optional)										master
#
dk_importVariables() {
	#dk_debugFunc 1 9
	
	# https://stackoverflow.com/a/78128262/688352
	### Create hashtable
	declare -A -x PLUGIN
	####################

															###### EXAMPLE ######
	### IMPORT_Path											/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
	dk_call dk_unset IMPORT_Path;
	dk_call dk_getParameterValue IMPORT_Path "$@";
	
	### IMPORT_Name											zlib
	dk_call dk_unset IMPORT_Name;
	dk_call dk_getParameterValue IMPORT_Name "$@";
	
	### BRANCH												master
	dk_call dk_unset BRANCH;
	dk_call dk_getParameterValue BRANCH	"$@";
	
	### FOLDER												zlib-master
	dk_call dk_unset FOLDER;
	dk_call dk_getParameterValue FOLDER "$@";
	
	### DIR													C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	dk_call dk_unset DIR;
	dk_call dk_getParameterValue DIR "$@";
	
	### ROOT												C:/Users/Administrator/DigitalKnob/Development/3rdParty
	dk_call dk_unset ROOT;
	dk_call dk_getParameterValue ROOT "$@";
	
	### TAG													v1.3.1
	dk_call dk_unset TAG;
	dk_call dk_getParameterValue TAG "$@";
	
	### VERSION												master
	dk_call dk_unset VERSION;
	dk_call dk_getParameterValue VERSION "$@";


		
	############### $PLUGIN ##################
	### $PLUGIN[IMPORT_Path]
	[ -z "${PLUGIN[IMPORT_Path]-}"] && PLUGIN[IMPORT_Path]=${IMPORT-};
	if [ -z "${PLUGIN[IMPORT_Path]-}"]; then 
		dk_call dk_getcwd;
		PLUGIN[IMPORT_Path]=${DKPWD};
	fi
	
	### $PLUGIN[IMPORT_Name]									zlib
	dk_call dk_basename				${PLUGIN[IMPORT_Path]};		PLUGIN[IMPORT_Name]=${dk_basename};
	
	### $PLUGIN[Name]
	dk_call dk_toUpper				${PLUGIN[IMPORT_Name]};		PLUGIN[Name]=${dk_toUpper};
	dk_call dk_convertToCIdentifier ${PLUGIN[Name]}; 			PLUGIN[IMPORT_C_Name]=${dk_convertToCIdentifier};
	
	if [ "${PLUGIN[Name]}" = "${PLUGIN[IMPORT_C_Name]}" ]; then
		dk_call dk_notice "${PLUGIN[Name]} contains non-alphanumeric characters and will be changed to ${PLUGIN[IMPORT_C_Name]}";
		PLUGIN[Name]=${PLUGIN[IMPORT_C_Name]};
	fi  

	### Set the <PLUGIN>[Name] variable to mirror $PLUGIN
	### Example $ZLIB[variable] will be the same as $PLUGIN[variable] when importing zlib
#	Set-Variable -Name $PLUGIN[Name] -Value ${PLUGIN} -Scope Global;
	############### $PLUGIN ##################

	
	### $PLUGIN[ARGS]															"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	PLUGIN[ARGS]="${*}";
	
	### $PLUGIN[URL]															"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	PLUGIN[URL]="${1}";
	
	### $PLUGIN[IMPORT]															1
	dk_call dk_validate DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR";
	if dk_call dk_includes "${IMPORT_Path}" "${DKIMPORTS_DIR}"; then 
		PLUGIN[IMPORT]="1";
	fi
	
	### $PLUGIN[URL_Filename]													master.zip
	dk_call dk_basename		${PLUGIN[URL]};		PLUGIN[URL_Filename]=${dk_basename};				
	
	### $PLUGIN[URL_List]														https:;github.com;madler;zlib;archive;refs;heads;master.zip
	dk_call dk_replaceAll ${PLUGIN[URL]} 		"/" 	";"; 	PLUGIN[URL_List]=${dk_replaceAll};
	dk_call dk_replaceAll ${PLUGIN[URL_List]} 	";;" 	";"; 	PLUGIN[URL_List]=${dk_replaceAll};
	
	### $PLUGIN[GIT]															1
	if dk_call dk_includes ${PLUGIN[URL]} "https://github.com"; then
		PLUGIN[GIT]="1";
	fi
	
	### $PLUGIN[URL_Extension]													.zip
	dk_call dk_getExtension		${PLUGIN[URL_Filename]};	PLUGIN[URL_Extension]=${dk_getExtension};

	### $PLUGIN[URL_File]														master
	dk_call dk_removeExtension	${PLUGIN[URL_Filename]};	PLUGIN[URL_File]=${dk_removeExtension};
	
	### $PLUGIN[URL_File_Lower]													master
	dk_call dk_toLower 			${PLUGIN[URL_File]}; 		PLUGIN[URL_File_Lower]=${dk_toLower};
	
	### $PLUGIN[URL_Array]														[0]https: [1]github.com [2]madler [3]zlib [4]archive [5]refs [6]heads [7]master.zip	
	dk_call dk_listToArray 		${PLUGIN[URL_List]}; 		PLUGIN_URL_Array=(${dk_listToArray[@]});
	
	### $PLUGIN[URL_Length]														8
	dk_call dk_arrayLength 		PLUGIN_URL_Array; 			PLUGIN[URL_Length]=${dk_arrayLength};
	
	### $PLUGIN[IMPORT_Name_Lower]												zlib
	dk_call dk_toLower 			${PLUGIN[IMPORT_Name]}; 	PLUGIN[IMPORT_Name_Lower]=${dk_toLower};
	
	### $PLUGIN[IMPORT_Name_Upper]												ZLIB
	dk_call dk_toUpper			${PLUGIN[IMPORT_Name]};		PLUGIN[IMPORT_Name_Upper]=${dk_toUpper};


	###############################################
	############ $PLUGIN[GIT_Variables ############
	###############################################
	if [ "${PLUGIN[GIT]-}" = "1" ]; then 

		### $PLUGIN[GIT_Filename]												todo
		dk_call dk_basename		${PLUGIN[URL]};		PLUGIN[GIT_Filename]=${dk_basename};
		
		### $PLUGIN[GIT_Name]													zlib
		dk_call dk_arrayAt 		PLUGIN_URL_Array 	3;  PLUGIN[GIT_Name]=${dk_arrayAt};
		
		### $PLUGIN[GIT_Name_Lower]												zlib
		dk_call dk_toLower 		${PLUGIN[GIT_Name]}; 	PLUGIN[GIT_Name_Lower]=${dk_toLower};
		
		### $PLUGIN[GIT_Branch]													master
		if [ -n "${BRANCH}" ]; then
			PLUGIN[GIT_Branch]=${BRANCH};
		else
			#dk_call dk_getGitBranchName ${PLUGIN[URL]}; PLUGIN[GIT_Branch]=${dk_getGitBranchName}; 					
			PLUGIN[GIT_Branch]="master";
		fi  
		
		### $PLUGIN[GIT_Tag]													TODO
		PLUGIN[GIT_Tag]="${TAG-}";
	fi

	##################################################
	############ $PLUGIN[INSTALL_Variables] ##########
	##################################################
	
	### $PLUGIN[INSTALL_Name]														zlib
	[ -z "${PLUGIN[INSTALL_Name]-}" ] && PLUGIN[INSTALL_Name]=${IMPORT_Name};
	[ -z "${PLUGIN[INSTALL_Name]-}" ] && PLUGIN[INSTALL_Name]=${PLUGIN[IMPORT_Name]};
	[ -z "${PLUGIN[INSTALL_Name]-}" ] && PLUGIN[INSTALL_Name]=${PLUGIN[GIT_Name]};
	[ -z "${PLUGIN[INSTALL_Name]-}" ] && PLUGIN[INSTALL_Name]=${PLUGIN[URL_Name]};
	[ -z "${PLUGIN[INSTALL_Name]-}" ] && dk_call dk_error "PLUGIN[INSTALL_Name] invalid";
	#dk_call dk_convertToCIdentifier	${PLUGIN[INSTALL_Name]};	PLUGIN[INSTALL_Name]=${dk_convertToCIdentifier};

	### $PLUGIN[INSTALL_Version]													master
	if [ -n "${VERSION-}" ]; then 
		PLUGIN[INSTALL_Version]=${VERSION};
	elif [ -n "${PLUGIN[URL_File_Lower]-}" ] && [ -n "${PLUGIN[IMPORT_Name_Lower]-}" ]; then
		# deduce the plugin version		
		dk_call dk_replaceAll 	${PLUGIN[URL_File_Lower]} 	${PLUGIN[IMPORT_Name_Lower]} 	""; 	PLUGIN[INSTALL_Version]=${dk_replaceAll};
		if [ "${PLUGIN[URL_File_Lower]-}" = "${PLUGIN[IMPORT_Name_Lower]-}" ]; then
			if [ -n "${PLUGIN[GIT_Tag]-}" ]; then
				PLUGIN[INSTALL_Version]=$PLUGIN[GIT_Tag];
			elif [ -n "${PLUGIN[GIT_Branch]-}" ]; then
				PLUGIN[INSTALL_Version]=$PLUGIN[GIT_Branch];
			else
				PLUGIN[INSTALL_Version]="master";
			fi
		fi 
	else
		dk_call dk_error "ERROR: setting PLUGIN[INSTALL_Version]";
	fi

#		string FIND ${PLUGIN_INSTALL_Version} - index;
#		if [ ${index} -eq 0 ]; then
#			string SUBSTRING ${PLUGIN_INSTALL_Version} 1 -1 PLUGIN[INSTALL_Version];
#		fi  
#		string FIND ${PLUGIN[INSTALL_Version]} _ index;
#		if [ ${index} -eq 0 ]; then
#			string SUBSTRING ${PLUGIN[INSTALL_Version]} 1 -1 PLUGIN[INSTALL_Version];
#		fi  
#	} 

	### $PLUGIN[INSTALL_Folder]													zlib-master
	if [ -n "${FOLDER}" ]; then
		PLUGIN[INSTALL_Folder]=${FOLDER};
	elif [ -n "${PLUGIN[INSTALL_Name]-}" ] && [ -n "${PLUGIN[INSTALL_Version]-}" ]; then
		PLUGIN[INSTALL_Folder]="${PLUGIN[INSTALL_Name]-}-${PLUGIN[INSTALL_Version]-}";
	elif [ -n "${PLUGIN[INSTALL_Name]-}" ]; then
		PLUGIN[INSTALL_Folder]=${PLUGIN[INSTALL_Name]};
	else
		dk_call dk_error "ERROR: setting PLUGIN[INSTALL_Folder]";
	fi

	### $PLUGIN[INSTALL_Root]														C:/Users/Administrator/DigitalKnob/Development/3rdParty
	if [ -n "${ROOT}" ]; then 
		PLUGIN[INSTALL_Root]=${ROOT};
	else
		dk_call dk_validate DK3RDPARTY_DIR "dk_call dk_DK3RDPARTY_DIR";
		PLUGIN[INSTALL_Root]=${DK3RDPARTY_DIR};
	fi

	### $PLUGIN[INSTALL_Path]														C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	if [ -n "${DIR}" ]; then
		PLUGIN[INSTALL_Path]=${DIR};
	else
		PLUGIN[INSTALL_Path]="${PLUGIN[INSTALL_Root]-}/${PLUGIN[INSTALL_Folder]-}";
	fi


	##############################################
	############# $PLUGIN[Variables #############
	##############################################

	if [ -n "${PLUGIN[IMPORT_Name_Lower]-}" ] && [ -n "${PLUGIN[GIT_Name_Lower]-}" ]; then
		if ! [ "${PLUGIN[IMPORT_Name_Lower]-}" = "${PLUGIN[GIT_Name_Lower]-}" ]; then
			dk_call dk_warning "PLUGIN[IMPORT_Name_Lower]:${PLUGIN[IMPORT_Name_Lower]-} and PLUGIN[GIT_Name_Lower]:${PLUGIN[GIT_Name_Lower]-} do not match";
		fi
	fi
	
	### $PLUGIN[Dir]												C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	if ! [ "${PLUGIN-}" = "GIT" ]; then	### DO NOT USE GIT_DIR ###
		PLUGIN[Dir]=${PLUGIN[INSTALL_Path]};
	fi
	
	### $PLUGIN[Url]												https://github.com/madler/zlib/archive/refs/heads/master.zip
	PLUGIN[Url]=${PLUGIN[URL]};
	
	### $PLUGIN[Import_File]										master.zip
	PLUGIN[Import_File]=${PLUGIN[URL_Filename]-};

	### $PLUGIN[Version]											master
	PLUGIN[Version]=${PLUGIN[INSTALL_Version]-};

	### $PLUGIN[Folder]												zlib-master
	PLUGIN[Folder]=${PLUGIN[INSTALL_Folder]-};

	### $PLUGIN[Import_Name]										zlib
	PLUGIN[Import_Name]=${PLUGIN[IMPORT_Name_Lower]-};
		
	### $PLUGIN[Branch]												master
	PLUGIN[Branch]=${PLUGIN[GIT_Branch]-};
	
	### $PLUGIN[Tag]												v1.2
	PLUGIN[Tag]=${PLUGIN[GIT_Tag]-};

		
	#####################################################
	############# TARGET $PLUGIN[Variables #############
	#####################################################

	### $PLUGIN[Tuple_Dir]											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang
	PLUGIN[Tuple_Dir]="${PLUGIN[INSTALL_Path]-}/${Target_Tuple-}";
	
	### $PLUGIN[Config_Dir]											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	PLUGIN[Config_Dir]="${PLUGIN[INSTALL_Path]-}/${Config_Path-}";
	
	### $PLUGIN[Build_Dir]											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	PLUGIN[Build_Dir]="${PLUGIN[INSTALL_Path]-}/${Build_Path-}";
	
	### $PLUGIN[Debug_Dir]											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	PLUGIN[Debug_Dir]="${PLUGIN[INSTALL_Path]-}/${Target_Tuple-}/${Debug_Dir-}";
	
	### $PLUGIN[Release_Dir]										C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Release
	PLUGIN[Release_Dir]="${PLUGIN[INSTALL_Path]-}/${Target_Tuple-}/${Release_Dir-}";


	### Export hashtable ####################
	export PLUGIN_EXPORT=$(declare -p PLUGIN)
	#########################################
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

	dk_debugFunc 0
	
	#dk_call dk_validate DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR"
	dk_call dk_DKIMPORTS_DIR;
	dk_call dk_DKTOOLS_DIR;
	dk_call dk_chdir "${DKIMPORTS_DIR}/git";
	dk_call dk_importVariables "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe" IMPORT_Name git ROOT "${DKTOOLS_DIR}";
	### Import hashtable #################
	source <(printf "%s" "$PLUGIN_EXPORT")
	######################################
	
	
	dk_call dk_echo;
	dk_call dk_echo "BRANCH                   = ${BRANCH-}";
	dk_call dk_echo "DIR                      = ${DIR-}";
	dk_call dk_echo "FOLDER                   = ${FOLDER-}";
	dk_call dk_echo "ROOT                     = ${ROOT-}";
	dk_call dk_echo "TAG                      = ${TAG-}";
	dk_call dk_echo "VERSION                  = ${VERSION-}";
	dk_call dk_echo "IMPORT_Name              = ${IMPORT_Name-}";
	dk_call dk_echo "IMPORT_Path              = ${IMPORT_Path-}";
	dk_call dk_echo "";
	dk_call dk_echo "PLUGIN[NAME]              = ${PLUGIN[NAME]-}";
	dk_call dk_echo "PLUGIN[ARGS]              = ${PLUGIN[ARGS]-}";
	dk_call dk_echo "PLUGIN[GIT]               = ${PLUGIN[GIT]-}";
	dk_call dk_echo "PLUGIN[GIT_Branch]        = ${PLUGIN[GIT_Branch]-}";
	dk_call dk_echo "PLUGIN[GIT_Filename]      = ${PLUGIN[GIT_Filename]-}";
	dk_call dk_echo "PLUGIN[GIT_Name]          = ${PLUGIN[GIT_Name]-}";
	dk_call dk_echo "PLUGIN[GIT_Lower]         = ${PLUGIN[GIT_Lower]-}";
	dk_call dk_echo "PLUGIN[GIT_Tag]           = ${PLUGIN[GIT_Tag]-}";
	dk_call dk_echo "PLUGIN[IMPORT]            = ${PLUGIN[IMPORT]-}";
	dk_call dk_echo "PLUGIN[IMPORT_Name]       = ${PLUGIN[IMPORT_Name]-}";
	dk_call dk_echo "PLUGIN[IMPORT_Name_Lower] = ${PLUGIN[IMPORT_Name_Lower]-}";
	dk_call dk_echo "PLUGIN[IMPORT_Name_Upper] = ${PLUGIN[IMPORT_Name_Upper]-}";
	dk_call dk_echo "PLUGIN[IMPORT_Path]       = ${PLUGIN[IMPORT_Path]-}";
	dk_call dk_echo "PLUGIN[INSTALL_Folder]    = ${PLUGIN[INSTALL_Folder]-}";
	dk_call dk_echo "PLUGIN[INSTALL_Name]      = ${PLUGIN[INSTALL_Name]-}";
	dk_call dk_echo "PLUGIN[INSTALL_Path]      = ${PLUGIN[INSTALL_Path]-}";
	dk_call dk_echo "PLUGIN[INSTALL_Root]      = ${PLUGIN[INSTALL_Root]-}";
	dk_call dk_echo "PLUGIN[INSTALL_Version]   = ${PLUGIN[INSTALL_Version]-}";
	dk_call dk_echo "PLUGIN[URL]               = ${PLUGIN[URL]-}";
	dk_call dk_echo "PLUGIN[URL_Array]         = ${PLUGIN[URL_Array]-}";
	dk_call dk_echo "PLUGIN[URL_Extension]     = ${PLUGIN[URL_Extension]-}";
	dk_call dk_echo "PLUGIN[URL_File]          = ${PLUGIN[URL_File]-}";
	dk_call dk_echo "PLUGIN[URL_Filename]      = ${PLUGIN[URL_Filename]-}";
	dk_call dk_echo "PLUGIN[URL_Length]        = ${PLUGIN[URL_Length]-}";
	dk_call dk_echo "PLUGIN[URL_List]          = ${PLUGIN[URL_List]-}";
	dk_call dk_echo "PLUGIN[Branch]            = ${PLUGIN[Branch]-}";
	dk_call dk_echo "PLUGIN[Build_Dir]         = ${PLUGIN[Build_Dir]-}";
	dk_call dk_echo "PLUGIN[Config_Dir]        = ${PLUGIN[Config_Dir]-}";
	dk_call dk_echo "PLUGIN[Debug_Dir]         = ${PLUGIN[Debug_Dir]-}";
	dk_call dk_echo "PLUGIN[Dir]               = ${PLUGIN[Dir]-}";
	dk_call dk_echo "PLUGIN[Folder]            = ${PLUGIN[Folder]-}";
	dk_call dk_echo "PLUGIN[Import_File]       = ${PLUGIN[Import_File]-}";
	dk_call dk_echo "PLUGIN[Import_Name]       = ${PLUGIN[Import_Name]-}";
	dk_call dk_echo "PLUGIN[Release_Dir]       = ${PLUGIN[Release_Dir]-}";
	dk_call dk_echo "PLUGIN[Tag]               = ${PLUGIN[Tag]-}";
	dk_call dk_echo "PLUGIN[Tuple_Dir]         = ${PLUGIN[Tuple_Dir]-}";
	dk_call dk_echo "PLUGIN[Url]               = ${PLUGIN[Url]-}";
	dk_call dk_echo "PLUGIN[Version]           = ${PLUGIN[Version]-}";
	#dk_call dk_echo "GIT[ARGS]                 = ${GIT[ARGS]-}";	
}
