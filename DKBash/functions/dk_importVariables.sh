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
#	Url.																https://github.com/madler/zlib.git     							* github repository link
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
#	IMPORT_PATH (optional)											C:/Users/Administrator/DigitalKnob/Development/3rdParty/_DKImportS/zlib
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
# dk_call dk_debugFunc 1 9
	
	dk_call dk_getParameterValue PRINTVARS "$@";
	if [ -n "${PRINTVARS}" ]; then
		dk_call dk_unset PRINTVARS;
		PRINTVARS;
		return;
	fi
	
	dk_call dk_unset PLUGIN;
	dk_call dk_unset PLUGIN[Args];
	dk_call dk_unset PLUGIN[Build_Dir];
	dk_call dk_unset PLUGIN[Config_Dir];
	dk_call dk_unset PLUGIN[Debug_Dir];
	dk_call dk_unset PLUGIN[Id];
	dk_call dk_unset PLUGIN[Import.Dirname];
	dk_call dk_unset PLUGIN[Import.Name];
	dk_call dk_unset PLUGIN[Import.Name_Lower];
	dk_call dk_unset PLUGIN[Import.Name_Upper];
	dk_call dk_unset PLUGIN[Import.Path];
	dk_call dk_unset PLUGIN[Install.Dirname];
	dk_call dk_unset PLUGIN[Install.Name];
	dk_call dk_unset PLUGIN[Install.Path];
	dk_call dk_unset PLUGIN[Release_Dir];
	dk_call dk_unset PLUGIN[Tuple_Dir];
	dk_call dk_unset PLUGIN[Url];
	dk_call dk_unset PLUGIN[Url.Basename];
	dk_call dk_unset PLUGIN[Url.Extension];
	dk_call dk_unset PLUGIN[Url.Name];
	dk_call dk_unset PLUGIN[Url.Name_Lower];
	dk_call dk_unset PLUGIN[Version];
	
	# https://stackoverflow.com/a/78128262/688352
	### PLUGIN(hashtable) 
	declare -A -x PLUGIN;
	####################
																	###### EXAMPLE ######
	### IMPORT_ROOT (PLUGIN.Import.Dirname)							/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKImportS
	dk_call dk_unset IMPORT_ROOT;
	dk_call dk_getParameterValue IMPORT_ROOT "$@";
	dk_call dk_echo "IMPORT_ROOT = '${IMPORT_ROOT}'";	
	PLUGIN[Import.Dirname]="${IMPORT_ROOT-}";

	### IMPORT_NAME (PLUGIN.Import.Name)							zlib
	dk_call dk_unset IMPORT_NAME;
	dk_call dk_getParameterValue IMPORT_NAME "$@";
	dk_call dk_echo "IMPORT_NAME = '${IMPORT_NAME}'";
	PLUGIN[Import.Name]="${IMPORT_NAME-}";
	
	### IMPORT_PATH (PLUGIN.Import.Path)							/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKImportS/zlib
	dk_call dk_unset IMPORT_PATH
	dk_call dk_getParameterValue IMPORT_PATH "$@";
	dk_call dk_echo "IMPORT_PATH = '${IMPORT_PATH-}'"
	PLUGIN[Import.Path]="${IMPORT_PATH-}";
	
	### INSTALL_ROOT (PLUGIN.Install.Dirname)						/c/Users/Administrator/DigitalKnob/Development/3rdParty
	dk_call dk_unset INSTALL_ROOT
	dk_call dk_getParameterValue INSTALL_ROOT "$@";
	dk_call dk_echo "INSTALL_ROOT = '${INSTALL_ROOT-}'"
	PLUGIN[Install.Dirname]="${INSTALL_ROOT-}";

	### INSTALL_NAME (PLUGIN.Install.Name)							zlib-master
	dk_call dk_unset INSTALL_NAME
	dk_call dk_getParameterValue INSTALL_NAME "$@";
	dk_call dk_echo "INSTALL_NAME = '${INSTALL_NAME-}'"
	PLUGIN[Install.Name]="${INSTALL_NAME-}";

	### INSTALL_PATH (PLUGIN.Install.Path)							/c/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	dk_call dk_unset INSTALL_PATH
	dk_call dk_getParameterValue INSTALL_PATH "$@";
	dk_call dk_echo "INSTALL_PATH = '${INSTALL_PATH-}'"
	PLUGIN[Install.Path]="${INSTALL_PATH-}";

	### VERSION (PLUGIN.Version)									v1.3.1
	dk_call dk_unset VERSION
	dk_call dk_getParameterValue VERSION "$@";
	dk_call dk_echo "VERSION = '${VERSION-}'";
	PLUGIN[Version]="${VERSION-}"

	### BRANCH (PLUGIN.Branch)										master
	dk_call dk_unset BRANCH
	dk_call dk_getParameterValue BRANCH	"$@";
	dk_call dk_echo "BRANCH = '${BRANCH-}'";
	PLUGIN[Branch]="${BRANCH-}";
	
	### PLUGIN.Args													"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	dk_call dk_unset PLUGIN[Args];
	PLUGIN[Args]=$*;
	dk_call dk_echo "PLUGIN[Args] = '${PLUGIN[Args]}'";
		
	### PLUGIN.Url													"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	dk_call dk_unset PLUGIN[Url];
	PLUGIN[Url]="$1";
	dk_call dk_echo "PLUGIN[Url] = '${PLUGIN[Url]}'";
		
	### PLUGIN.Url.Protocol
	#dk_call dk_Protocol			${PLUGIN[Url]}  			PLUGIN[Url.protocol]	# protocol, drive
	#dk_call dk_echo "PLUGIN[Url.Protocol] = '${PLUGIN[Url.Protocol]}'";

#	### PLUGIN.Url.Dirname
#	%dk_call% dk_dirname			%PLUGIN.Url%  			PLUGIN.Url.Dirname		&:: dirname, directory, parent
#	%dk_call% dk_echo "PLUGIN.Url.Dirname = '%PLUGIN.Url.Dirname%'"
	
#	### PLUGIN.Url.Basename
#	%dk_call% dk_basename			%PLUGIN.Url%  			PLUGIN.Url.Basename		&:: basename, filename
#	dk_call dk_echo "PLUGIN.Url.Basename = '%PLUGIN.Url.Basename%'"
	
#	### PLUGIN.Url.Name
#	%dk_call% dk_removeExtension	%PLUGIN.Url.Basename%	PLUGIN.Url.Name			&:: name, file  (no extension)
#	%dk_call% dk_echo "PLUGIN.Url.Name = '%PLUGIN.Url.Name%'"
	
#	### PLUGIN.Url.Extension
#	%dk_call% dk_getExtension		%PLUGIN.Url.Basename%	PLUGIN.Url.Extension	&:: extention
#	%dk_call% dk_echo "PLUGIN.Url.Extension = '%PLUGIN.Url.Extension%'"
	
#	::### DEFAULT.Import.Dirname
#	if not defined PLUGIN.Import.Dirname (
#		if not defined PLUGIN.Import.Path (
#			%dk_call% dk_validate DKIMPORTS_DIR	"%dk_call% dk_DKIMPORTS_DIR"
#			set "PLUGIN.Import.Dirname=!DKIMPORTS_DIR!"
#			%dk_call% dk_echo "PLUGIN.Import.Dirname = '!PLUGIN.Import.Dirname!'"
#		)
#	)
#
#	::### DEFAULT.Install.Dirname
#	if not defined PLUGIN.Install.Dirname (
#		if not defined PLUGIN.Install.Path (
#			%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
#			set "PLUGIN.Install.Dirname=!DK3RDPARTY_DIR!"
#			%dk_call% dk_echo "PLUGIN.Install.Dirname = '!PLUGIN.Install.Dirname!'"
#		)
#	)
	
	export PLUGIN_EXPORT=$(declare -p PLUGIN);
	#"${PLUGIN[@]@A}" && declare -A -x ${PLUGIN[ID]}="${_#*=}";
	
	PLUGIN_Id;	
	source <(printf "%s" "${PLUGIN_EXPORT}");
	
	#export PLUGIN_EXPORT=$(declare -p PLUGIN);
	PLUGIN_Install_Path;
	source <(printf "%s" "${PLUGIN_EXPORT}");
	
	### PLUGIN[Tuple_Dir]											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang
	PLUGIN[Tuple_Dir]="${PLUGIN[INSTALL_PATH]-}/${Target_Tuple-}";
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
	
	export PLUGIN="${PLUGIN[Id]}";
	export ${PLUGIN}="${PLUGIN[Install.Path]}";
	
	### Export the PLUGIN hashtable
	export PLUGIN_EXPORT=$(declare -p PLUGIN);
	
	#source <(printf "%s" "${PLUGIN_EXPORT}");
	### Create <PLUGIN[ID]> hashtable from PLUGIN hashtable
	#eval "${PLUGIN_EXPORT/PLUGIN/${PLUGIN[ID]}}";					# Import the PLUGIN[ID] hashtable, Using 'eval'
	#source <(printf "%s" "${PLUGIN_EXPORT/PLUGIN/${PLUGIN[ID]}}");	# Import the PLUGIN[ID] hashtable, Using 'source'
	"${PLUGIN[@]@A}" && declare -A -x ${PLUGIN[Id]}="${_#*=}"		# Import the PLUGIN[ID] hashtable, Using 'copy routine'  #https://stackoverflow.com/a/78068508/688352
}



######################
PLUGIN_Import_Name() {
	source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -n "${PLUGIN[Import.Name]-}" ] && return;
		
	PLUGIN_Import_Path;
	source <(printf "%s" "${PLUGIN_EXPORT}");
	#[ -z "${PLUGIN[Import.Path]-}" ] && dk_call dk_error "PLUGIN[Import.Path] is invalid";
	dk_call dk_debug "PLUGIN[Import.Path] = '${PLUGIN[Import.Path]}'";

	if [ -n "${PLUGIN[Import.Path]}" ]; then
		dk_call dk_basename	"${PLUGIN[Import.Path]}";	PLUGIN[Import.Name]="${dk_basename}";
		[ -z "${PLUGIN[Import.Name]-}" ] && dk_call dk_error "PLUGIN[Import.Name] is invalid";
		dk_call dk_debug "PLUGIN[Import.Name] = '${PLUGIN[Import.Name]}'";
		
	elif dk_call dk_includes "${PLUGIN[Url]}" "https://github.com"; then
		dk_call dk_replaceAll 	${PLUGIN[Url]} 			"/" 	";"; 	PLUGIN[Url.List]="${dk_replaceAll}";
		dk_call dk_replaceAll 	${PLUGIN[Url.List]} 	";;" 	";"; 	PLUGIN[Url.List]="${dk_replaceAll}";
		[ -z "${PLUGIN[Url.List]-}" ] && dk_call dk_error "PLUGIN[Url.List] is invalid";
		dk_call dk_debug "PLUGIN[Url.List] = '${PLUGIN[Url.List]}'";
		
		dk_call dk_listToArray 	"${PLUGIN[Url.List]}"  PLUGIN_Url_Array;
		dk_call dk_printVar PLUGIN_Url_Array;
		[ -z "${PLUGIN_Url_Array-}" ] && dk_call dk_error "PLUGIN_Url_Array is invalid";
		dk_call dk_debug "PLUGIN_Url_Array = '${PLUGIN_Url_Array}'";
		
		dk_call dk_arrayAt		PLUGIN_Url_Array	3;				PLUGIN[Import.Name]="${dk_arrayAt}";
		[ -z "${PLUGIN[Import.Name]-}" ] && dk_call dk_error "PLUGIN[Import.Name] is invalid";
		dk_call dk_debug "PLUGIN[Import.Name] = '${PLUGIN[Import.Name]}'";
	fi
	
	export PLUGIN_EXPORT=$(declare -p PLUGIN);
}

############################
PLUGIN_Import_Name_Lower() {
	source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -n "${PLUGIN[Import.Name_Lower]-}" ] && return;
	
	PLUGIN_Import_Name;
	source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -z "${PLUGIN[Import.Name]-}" ] && dk_call dk_error "PLUGIN[Import.Name] is invalid";
	dk_call dk_debug "PLUGIN[Import.Name] = '${PLUGIN[Import.Name]}'";
	
	dk_call dk_toLower 	"${PLUGIN[Import.Name]}"; 	PLUGIN[Import.Name_Lower]="${dk_toLower}";
	[ -z "${PLUGIN[Import.Name_Lower]-}" ] && dk_call dk_error "PLUGIN[Import.Name_Lower] is invalid";
	dk_call dk_debug "PLUGIN[Import.Name_Lower] = '${PLUGIN[Import.Name_Lower]}'";
	
	export PLUGIN_EXPORT=$(declare -p PLUGIN);
}

##########################
PLUGIN_Install_Dirname() {
	source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -n "${PLUGIN[Install.Dirname]-}" ] && return;
	
	dk_call dk_validate DK3RDPARTY_DIR "dk_call dk_DK3RDPARTY_DIR";
	PLUGIN[Install.Dirname]="${DK3RDPARTY_DIR}";
	[ -z "${PLUGIN[Install.Dirname]-}" ] && dk_call dk_error "PLUGIN[Install.Dirname] is invalid";
	dk_call dk_debug "PLUGIN[Install.Dirname] = '${PLUGIN[Install.Dirname]}'";
	
	export PLUGIN_EXPORT=$(declare -p PLUGIN);
}

#######################
PLUGIN_Url_Basename() {
	source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -n "${PLUGIN[Url.Basename]-}" ] && return;

	dk_call dk_basename	"${PLUGIN[Url]}";  PLUGIN[Url.Basename]="${dk_basename}";				# basename, filename
	[ -z "${PLUGIN[Url.Basename]-}" ] && dk_call dk_error "PLUGIN[Url.Basename] is invalid";
	dk_call dk_debug "PLUGIN[Url.Basename] = '${PLUGIN[Url.Basename]}'";
	
	export PLUGIN_EXPORT=$(declare -p PLUGIN);
}

####################
PLUGIN_Url_Name() {
	source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -n "${PLUGIN[Url.Name]-}" ] && return;
	
	PLUGIN_Url_Basename;
	source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -z "${PLUGIN[Url.Basename]-}" ] && dk_call dk_error "PLUGIN[Url.Basename] is invalid";
	dk_call dk_debug "PLUGIN[Url.Basename] = '${PLUGIN[Url.Basename]}'";
	
	dk_call dk_removeExtension	"${PLUGIN[Url.Basename]}";	PLUGIN[Url.Name]="${dk_removeExtension}";	# name, file  (no extension)
	[ -z "${PLUGIN[Url.Name]-}" ] && dk_call dk_error "PLUGIN[Url.Name] is invalid";
	dk_call dk_debug "PLUGIN[Url.Name] = '${PLUGIN[Url.Name]}'";
	
	export PLUGIN_EXPORT=$(declare -p PLUGIN);
}

#########################
PLUGIN_Url_Name_Lower() {
	source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -n "${PLUGIN[Url.Name_Lower]-}" ] && return;
	
	PLUGIN_Url_Name;
	source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -z "${PLUGIN[Url.Name]-}" ] && dk_call dk_error "PLUGIN[Url.Name] is invalid";
	dk_call dk_debug "PLUGIN[Url.Name] = '${PLUGIN[Url.Name]}'";
	
	dk_call dk_toLower ${PLUGIN[Url.Name]}; 	PLUGIN[Url.Name_Lower]="${dk_toLower}";
	[ -z "${PLUGIN[Url.Name_Lower]-}" ] && dk_call dk_error "PLUGIN[Url.Name_Lower] is invalid";
	dk_call dk_debug "PLUGIN[Url.Name_Lower] = '${PLUGIN[Url.Name_Lower]}'";
	
	export PLUGIN_EXPORT=$(declare -p PLUGIN);
}

#######################
PLUGIN_Install_Name() {
	source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -n "${PLUGIN[Install.Name]}" ] && return;
	
	#export PLUGIN_EXPORT=$(declare -p PLUGIN);
	PLUGIN_Import_Name;
	source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -z "${PLUGIN[Import.Name]-}" ] && dk_call dk_error "PLUGIN[Import.Name] is invalid";
	dk_call dk_debug "PLUGIN[Import.Name] = '${PLUGIN[Import.Name]}'";
	
	#export PLUGIN_EXPORT=$(declare -p PLUGIN);
	PLUGIN_Version;
	source <(printf "%s" "${PLUGIN_EXPORT}");
	#[ -z "${PLUGIN[Version]-}" ] && dk_call dk_error "PLUGIN[Version] is invalid";
	dk_call dk_debug "PLUGIN[Version] = '${PLUGIN[Version]}'";
	
	if [ -n "${PLUGIN[Import.Name]}" ] && [ -n "${PLUGIN[Version]}" ]; then
		PLUGIN[Install.Name]="${PLUGIN[Import.Name]}-${PLUGIN[Version]}";
	elif [ -z "${PLUGIN[Install.Name]}" ]; then	
		PLUGIN[Install.Name]="${PLUGIN[Import.Name]}";
	fi
	[ -z "${PLUGIN[Install.Name]-}" ] && dk_call dk_error "PLUGIN[Install.Name] is invalid";
	dk_call dk_debug "PLUGIN[Install.Name] = '${PLUGIN[Install.Name]}'";
	
	export PLUGIN_EXPORT=$(declare -p PLUGIN);
}

#######################
PLUGIN_Install_Path() {
	source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -n "${PLUGIN[Install.Path]}" ] && return;
	
	#export PLUGIN_EXPORT=$(declare -p PLUGIN);
	PLUGIN_Install_Dirname;
	source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -z "${PLUGIN[Install.Dirname]-}" ] && dk_call dk_error "PLUGIN[Install.Dirname] is invalid";
	dk_call dk_debug "PLUGIN[Install.Dirname] = '${PLUGIN[Install.Dirname]}'";
	
	#export PLUGIN_EXPORT=$(declare -p PLUGIN);
	PLUGIN_Install_Name;
	source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -z "${PLUGIN[Install.Name]-}" ] && dk_call dk_error "PLUGIN[Install.Name] is invalid";
	dk_call dk_debug "PLUGIN[Install.Name] = '${PLUGIN[Install.Name]}'";
	
	PLUGIN[Install.Path]="${PLUGIN[Install.Dirname]}/${PLUGIN[Install.Name]}";
	[ -z "${PLUGIN[Install.Path]-}" ] && dk_call dk_error "PLUGIN[Install.Path] is invalid";
	dk_call dk_debug "PLUGIN[Install.Path] = '${PLUGIN[Install.Path]}'";
	
	export PLUGIN_EXPORT=$(declare -p PLUGIN);
}

######################
PLUGIN_Import_Path() {	
	source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -n "${PLUGIN[Import.Path]}" ] && return;
	
	if [ -n "${PLUGIN[Import.Name]}" ]; then
		dk_call dk_validate DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR";
		PLUGIN[Import.Path]="${DKIMPORTS_DIR}/${PLUGIN[Import.Name]}";
	elif dk_call dk_includes "${PWD}" "${DKIMPORTS_DIR}"; then
		PLUGIN[Import.Path]="${PWD}";
	fi
	
	#[ -z "${PLUGIN[Import.Path]-}" ] && dk_call dk_error "PLUGIN[Import.Path] is invalid";
	dk_call dk_debug "PLUGIN[Import.Path] = '${PLUGIN[Import.Path]}'";
	
	export PLUGIN_EXPORT=$(declare -p PLUGIN);
}

##################
PLUGIN_Version() {
	source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -n "${PLUGIN[Version]}" ] && return;
		
	PLUGIN_Url_Name_Lower;
	source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -z "${PLUGIN[Url.Name_Lower]-}" ] && dk_call dk_error "PLUGIN[Url.Name_Lower] is invalid";
	dk_call dk_debug "PLUGIN[Url.Name_Lower] = '${PLUGIN[Url.Name_Lower]}'";
	
	export PLUGIN_EXPORT=$(declare -p PLUGIN);
	PLUGIN_Import_Name_Lower;
	source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -z "${PLUGIN[Import.Name_Lower]-}" ] && dk_call dk_error "PLUGIN[Import.Name_Lower] is invalid";
	dk_call dk_debug "PLUGIN[Import.Name_Lower] = '${PLUGIN[Import.Name_Lower]}'";
	
	echo "dk_replaceAll  ${PLUGIN[Url.Name_Lower]} 	${PLUGIN[Import.Name_Lower]}";
	if [ -n "${PLUGIN[Url.Name_Lower]}" ] && [ -n "${PLUGIN[Import.Name_Lower]}" ]; then
		dk_call dk_replaceAll "${PLUGIN[Url.Name_Lower]}" 	"${PLUGIN[Import.Name_Lower]}" 	""; 	PLUGIN[Version]="${dk_replaceAll}";
		# [ -z "${PLUGIN.Version]}" ] && PLUGIN[Version]=${PLUGIN[TAG]};
		# [ -z "${PLUGIN.Version]}" ] && PLUGIN[Version]=${PLUGIN[Branch]}; 
	fi
	
	dk_call dk_trimNonAlphaNumeric "${PLUGIN[Version]}";  PLUGIN[Version]="${dk_trimNonAlphaNumeric}";
	
	#[ -z "${PLUGIN[Version]-}" ] && dk_call dk_error "PLUGIN[Version] is invalid";
	dk_call dk_debug "PLUGIN[Version] = '${PLUGIN[Version]}'";

	export PLUGIN_EXPORT=$(declare -p PLUGIN);
}

############################
PLUGIN_Import_Name_Upper() {
	source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -n "${PLUGIN[Import.Name_Upper]-}" ] && return;
	
	PLUGIN_Import_Name;
	source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -z "${PLUGIN[Import.Name]-}" ] && dk_call dk_error "PLUGIN[Import.Name] is invalid";
	dk_call dk_debug "PLUGIN[Import.Name] = '${PLUGIN[Import.Name]}'";
	
	dk_call dk_toUpper	"${PLUGIN[Import.Name]}";		PLUGIN[Import.Name_Upper]="${dk_toUpper}";
	[ -z "${PLUGIN[Import.Name_Upper]-}" ] && dk_call dk_error "PLUGIN[Import.Name_Upper] is invalid";
	dk_call dk_debug "PLUGIN[Import.Name_Upper] = '${PLUGIN[Import.Name_Upper]}'";
	
	export PLUGIN_EXPORT=$(declare -p PLUGIN);
}

#############
PLUGIN_Id() {
	source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -n "${PLUGIN[Id]-}" ] && return;
	
	
	PLUGIN_Import_Name_Upper;
	source <(printf "%s" "${PLUGIN_EXPORT}");
	[ -z "${PLUGIN[Import.Name_Upper]-}" ] && dk_call dk_error "PLUGIN[Import.Name_Upper] is invalid";
	dk_call dk_debug "PLUGIN[Import.Name_Upper] = '${PLUGIN[Import.Name_Upper]}'";
	
	dk_call dk_convertToCIdentifier	"${PLUGIN[Import.Name_Upper]}"; 	PLUGIN[Id]="${dk_convertToCIdentifier}";
	[ -z "${PLUGIN[Id]-}" ] && dk_call dk_error "PLUGIN[Id] is invalid";
	dk_call dk_debug "PLUGIN[Id] = '${PLUGIN[Id]}'";
	
	export PLUGIN_EXPORT=$(declare -p PLUGIN);
}

#############
PRINTVARS() {
	source <(printf "%s" "${PLUGIN_EXPORT}");
	
	dk_call dk_echo;
	dk_call dk_echo;
	dk_call dk_echo "################## PLUGIN.variables ##################";
	dk_call dk_echo "PLUGIN                                  = '${PLUGIN-}'";
	dk_call dk_echo "${PLUGIN}                               = '${!PLUGIN-}'";
	dk_call dk_echo "${PLUGIN}[Args]                         = '${PLUGIN[Args]-}'";
	dk_call dk_echo "${PLUGIN}[Id]                           = '${PLUGIN[Id]-}'";
	dk_call dk_echo "${PLUGIN}[Version]                      = '${PLUGIN[Version]-}'";
	dk_call dk_echo "${PLUGIN}[Url]                          = '${PLUGIN[Url]-}'";
	dk_call dk_echo "${PLUGIN}[Url.Basename]                 = '${PLUGIN[Url.Basename]-}'";
	dk_call dk_echo "${PLUGIN}[Url.Name]                     = '${PLUGIN[Url.Name]-}'";
	dk_call dk_echo "${PLUGIN}[Url.Extension]                = '${PLUGIN[Url.Extension]-}'";
	dk_call dk_echo "${PLUGIN}[Import.Dirname]               = '${PLUGIN[Import.Dirname]-}'";
	dk_call dk_echo "${PLUGIN}[Import.Name]                  = '${PLUGIN[Import.Name]-}'";
	dk_call dk_echo "${PLUGIN}[Import.Path]                  = '${PLUGIN[Import.Path]-}'";
	dk_call dk_echo "${PLUGIN}[Install.Dirname]              = '${PLUGIN[Install.Dirname]-}'";
	dk_call dk_echo "${PLUGIN}[Install.Name]                 = '${PLUGIN[Install.Name]-}'";
	dk_call dk_echo "${PLUGIN}[Install.Path]                 = '${PLUGIN[Install.Path]-}'";
	dk_call dk_echo "${PLUGIN}[Tuple_Dir]                    = '${PLUGIN[Tuple_Dir]-}'";
	dk_call dk_echo "${PLUGIN}[Build_Dir]                    = '${PLUGIN[Build_Dir]-}'";
	dk_call dk_echo "${PLUGIN}[Config_Dir]                   = '${PLUGIN[Config_Dir]-}'";
	dk_call dk_echo "${PLUGIN}[Debug_Dir]                    = '${PLUGIN[Debug_Dir]-}'";
	dk_call dk_echo "${PLUGIN}[Release_Dir]                  = '${PLUGIN[Release_Dir]-}'";
	dk_call dk_echo
	dk_call dk_echo
	
#	dk_call dk_echo "################## ${PLUGIN-}.variables ##################"
#	dk_call dk_echo "${PLUGIN}[Id]                       = '${${PLUGIN}[Id]-}'";
#	dk_call dk_echo "${PLUGIN}[Args]                     = '${${PLUGIN}[Args]-}'";
#	dk_call dk_echo "${PLUGIN}[Id]                       = '${${PLUGIN}[Id]-}'";
#	dk_call dk_echo "${PLUGIN}[Version]                  = '${${PLUGIN}[Version]-}'";
#	dk_call dk_echo "${PLUGIN}[Url]                      = '${${PLUGIN}[Url]-}'";
#	dk_call dk_echo "${PLUGIN}[Url.Basename]             = '${${PLUGIN}[Url.Basename]-}'";
#	dk_call dk_echo "${PLUGIN}[Url.Name]                 = '${${PLUGIN}[Url.Name]-}'";
#	dk_call dk_echo "${PLUGIN}[Url.Extension]            = '${${PLUGIN}[Url.Extension]-}'";
#	dk_call dk_echo "${PLUGIN}[Import.Dirname]           = '${${PLUGIN}[Import.Dirname]-}'";
#	dk_call dk_echo "${PLUGIN}[Import.Name]              = '${${PLUGIN}[Import.Name]-}'";
#	dk_call dk_echo "${PLUGIN}[Import.Path]              = '${${PLUGIN}[Import.Path]-}'";
#	dk_call dk_echo "${PLUGIN}[Install.Dirname]          = '${${PLUGIN}[Install.Dirname]-}'";
#	dk_call dk_echo "${PLUGIN}[Install.Name]             = '${${PLUGIN}[Install.Name]-}'";
#	dk_call dk_echo "${PLUGIN}[Install.Path]             = '${${PLUGIN}[Install.Path]-}'";
#	dk_call dk_echo "${PLUGIN}[Tuple_Dir]                = '${${PLUGIN}[Tuple_Dir]-}'";
#	dk_call dk_echo "${PLUGIN}[Build_Dir]                = '${${PLUGIN}[Build_Dir]-}'";
#	dk_call dk_echo "${PLUGIN}[Config_Dir]               = '${${PLUGIN}[Config_Dir]-}'";
#	dk_call dk_echo "${PLUGIN}[Debug_Dir]                = '${${PLUGIN}[Debug_Dir]-}'";
#	dk_call dk_echo "${PLUGIN}[Release_Dir]              = '${${PLUGIN}[Release_Dir]-}'";
#	dk_call dk_echo
}













###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_call dk_debugFunc 0;
	
	dk_call dk_validate DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR";
	dk_call dk_validate DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR";
	
	#dk_call dk_chdir "${DKIMPORTS_DIR}/msys2";
	cd "${DKIMPORTS_DIR}/msys2";
	dk_call dk_importVariables "https://repo.msys2.org/distrib/x86_64/msys2-base-x86_64-20241208.tar.xz";
	### Import PLUGIN and <PLUGIN_NAME> hashtables #################
	#eval "${PLUGIN_EXPORT}";										# Import the PLUGIN hashtable, Using 'eval'
	source <(printf "%s" "${PLUGIN_EXPORT}");						# Import the PLUGIN hashtable, Using 'source'
	
	### Create <PLUGIN[ID]> hashtable from PLUGIN hashtable			# Example: if plugin is 'GIT'. We can now use GIT[var] instead of PLUGIN[var]
	#eval "${PLUGIN_EXPORT/PLUGIN/${PLUGIN[ID]}}";					# Import the PLUGIN[ID] hashtable, Using 'eval'
	#source <(printf "%s" "${PLUGIN_EXPORT/PLUGIN/${PLUGIN[ID]}}");	# Import the PLUGIN[ID] hashtable, Using 'source'
	"${PLUGIN[@]@A}" && declare -A ${PLUGIN[Id]}="${_#*=}"			# Import the PLUGIN[ID] hashtable, Using 'copy routine' #https://stackoverflow.com/a/78068508/688352
	dk_call dk_importVariables PRINTVARS;
	
	#dk_call dk_chdir "${DKIMPORTS_DIR}/git";
	cd "${DIGITALKNOB_DIR}";
	dk_call dk_importVariables "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe" INSTALL_ROOT "${DKTOOLS_DIR}";
	source <(printf "%s" "${PLUGIN_EXPORT}");						# Import the PLUGIN hashtable, Using 'source'
	"${PLUGIN[@]@A}" && declare -A ${PLUGIN[Id]}="${_#*=}";			# Import the PLUGIN[ID] hashtable, Using 'copy routine' #https://stackoverflow.com/a/78068508/688352
	dk_call dk_importVariables PRINTVARS;
	
	
	
	#dk_call dk_chdir "${DKIMPORTS_DIR}/php-src";
	cd "${DKIMPORTS_DIR}/php-src";
	dk_call dk_importVariables "https://windows.php.net/downloads/releases/php-8.4.11-Win32-vs17-x64.zip";
	source <(printf "%s" "${PLUGIN_EXPORT}");						# Import the PLUGIN hashtable, Using 'source'
	"${PLUGIN[@]@A}" && declare -A ${PLUGIN[Id]}="${_#*=}";			# Import the PLUGIN[ID] hashtable, Using 'copy routine' #https://stackoverflow.com/a/78068508/688352
	dk_call dk_importVariables PRINTVARS;
}
