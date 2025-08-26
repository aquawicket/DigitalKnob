if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_importVariables_ps1){ $dk_importVariables_ps1 = 1; } else{ return; } #include guard


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
function Global:dk_importVariables() {
	#dk_debugFunc 1 9;

	if("$args" -eq "PRINTVARS"){
		PRINTVARS;
		return;
	}

	### PLUGIN(hashtable)
	${global:PLUGIN}=@{};

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

																	###### EXAMPLE ######
	### IMPORT_ROOT (PLUGIN_Import_Dirname)							/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS
	dk_call dk_unset IMPORT_ROOT;
	dk_call dk_getParameterValue IMPORT_ROOT @args;
	dk_call dk_echo "IMPORT_ROOT = '${IMPORT_ROOT}'";
	${global:PLUGIN_Import_Dirname}="${IMPORT_ROOT}";

	### IMPORT_NAME (PLUGIN_Import_Name)							zlib
	dk_call dk_unset IMPORT_NAME;
	dk_call dk_getParameterValue IMPORT_NAME @args;
	dk_call dk_echo "IMPORT_NAME = '${IMPORT_NAME}'";
	${global:PLUGIN_Import_Name}="${IMPORT_NAME}";

	### IMPORT_PATH (PLUGIN_Import_Path)							/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
	dk_call dk_unset IMPORT_PATH;
	dk_call dk_getParameterValue IMPORT_PATH @args;
	dk_call dk_echo "IMPORT_PATH = '${IMPORT_PATH}'";
	${global:PLUGIN_Import_Path}="${IMPORT_PATH}";

	### INSTALL_ROOT (PLUGIN_Install_Dirname)						/c/Users/Administrator/DigitalKnob/Development/3rdParty
	dk_call dk_unset INSTALL_ROOT;
	dk_call dk_getParameterValue INSTALL_ROOT @args;
	dk_call dk_echo "INSTALL_ROOT = '${INSTALL_ROOT}'";
	${global:PLUGIN_Install_Dirname}="${INSTALL_ROOT}";

	### INSTALL_NAME (PLUGIN_Install_Name)							zlib-master
	dk_call dk_unset INSTALL_NAME;
	dk_call dk_getParameterValue INSTALL_NAME @args;
	dk_call dk_echo "INSTALL_NAME = '${INSTALL_NAME}'";
	${global:PLUGIN_Install_Name}="${INSTALL_NAME}";

	### INSTALL_PATH (PLUGIN_Install_Path)							/c/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	dk_call dk_unset INSTALL_PATH;
	dk_call dk_getParameterValue INSTALL_PATH @args;
	dk_call dk_echo "INSTALL_PATH = '${INSTALL_PATH}'";
	${global:PLUGIN_Install_Path}="${INSTALL_PATH}";

	### VERSION (PLUGIN_Version)									v1.3.1
	dk_call dk_unset VERSION;
	dk_call dk_getParameterValue VERSION @args;
	dk_call dk_echo "VERSION = '${VERSION}'";
	${global:PLUGIN_Version}="${VERSION}";

	### BRANCH (PLUGIN_Branch)										master
	dk_call dk_unset BRANCH;
	dk_call dk_getParameterValue BRANCH	@args;
	dk_call dk_echo "BRANCH = '${BRANCH}'";
	${global:PLUGIN_Branch}="${BRANCH}";

	### PLUGIN_Args													"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	dk_call dk_unset PLUGIN_Args;
	${global:PLUGIN_Args}=${args};
	dk_call dk_echo "PLUGIN_Args = '${PLUGIN_Args}'";

	### PLUGIN_Url													"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	dk_call dk_unset PLUGIN_Url;
	${global:PLUGIN_Url}=${args}[0];
	dk_call dk_echo "PLUGIN_Url = '${PLUGIN_Url}'";


	PLUGIN_Id;
	PLUGIN_Url_Extension;
	PLUGIN_Import_Dirname;
	PLUGIN_Install_Path;

	### PLUGIN_Tuple_Dir]											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang
	${global:PLUGIN_Tuple_Dir}="${PLUGIN_Install_Path}/${Target_Tuple}";
	#dk_call dk_echo "PLUGIN_Tuple_Dir = '${PLUGIN_Tuple_Dir}'";

	### PLUGIN_Config_Dir}											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	${global:PLUGIN_Config_Dir}="${PLUGIN_Install_Path}/${Config_Path}";
	#dk_call dk_echo "PLUGIN_Config_Dir = '${PLUGIN_Config_Dir}'";

	### PLUGIN_Build_Dir}											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	${global:PLUGIN_Build_Dir}="${PLUGIN_Install_Path}/${Build_Path}";
	#dk_call dk_echo "PLUGIN_Build_Dir = '${PLUGIN_Build_Dir}'";

	### PLUGIN_Debug_Dir}											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	${global:PLUGIN_Debug_Dir}="${PLUGIN_Install_Path}/${Target_Tuple}/${Debug_Dir}";
	#dk_call dk_echo "PLUGIN_Debug_Dir = '${PLUGIN_Debug_Dir}'";

	### PLUGIN_Release_Dir}											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Release
	${global:PLUGIN_Release_Dir}="${PLUGIN_Install_Path}/${Target_Tuple}/${Release_Dir}";
	#dk_call dk_echo "PLUGIN_Release_Dir = '${PLUGIN_Release_Dir}'";

	${global:PLUGIN}="${PLUGIN_Id}";
	#$(${PLUGIN})="${PLUGIN_Install_Path}";

	### Set the <PLUGIN> variable to mirror $PLUGIN
	Get-Variable -Name "PLUGIN*" | ForEach-Object {
		Set-Variable -Name $($_.Name -replace "PLUGIN", "${PLUGIN}") -Value $($_.Value) -Scope Global;
    }
	
	Set-Variable -Name ${PLUGIN} -Value ${PLUGIN_Install_Path} -Scope Global;

}

############################################
function Global:PLUGIN_Import_Name_Lower() {
	if(${PLUGIN_Import_Name_Lower}){ return; }

	PLUGIN_Import_Name;

	if(!(${PLUGIN_Import_Name})) { dk_call dk_error "PLUGIN_Import_Name is invalid"; }
	dk_call dk_debug "PLUGIN_Import_Name = '${PLUGIN_Import_Name}'";

	dk_call dk_toLower 	"${PLUGIN_Import_Name}"	PLUGIN_Import_Name_Lower;
	if(!(${PLUGIN_Import_Name_Lower})) { dk_call dk_error "PLUGIN_Import_Name_Lower is invalid"; }
	dk_call dk_debug "PLUGIN_Import_Name_Lower = '${PLUGIN_Import_Name_Lower}'";
}

##########################################
function Global:PLUGIN_Install_Dirname() {
	if(${PLUGIN_Install_Dirname}){ return; }

	dk_call dk_validate env:DK3RDPARTY_DIR "dk_call dk_DK3RDPARTY_DIR";
	${global:PLUGIN_Install_Dirname}="${env:DK3RDPARTY_DIR}";
	if(!(${PLUGIN_Install_Dirname})){ dk_call dk_error "PLUGIN_Install_Dirname is invalid"; }
	dk_call dk_debug "PLUGIN_Install_Dirname = '${PLUGIN_Install_Dirname}'";
}

#######################################
function Global:PLUGIN_Url_Basename() {
	if(${PLUGIN_Url_Basename}){ return; }

	if(${PLUGIN_Url}){
		dk_call dk_basename	"${PLUGIN_Url}" PLUGIN_Url_Basename;				# basename, filename
	}
	if(!(${PLUGIN_Url_Basename})){ dk_call dk_error "PLUGIN_Url_Basename is invalid"; }
	dk_call dk_debug "PLUGIN_Url_Basename = '${PLUGIN_Url_Basename}'";
}

###################################
function Global:PLUGIN_Url_Name() {
	if(${PLUGIN_Url_Name}){ return; }

	PLUGIN_Url_Basename;

	if(!(${PLUGIN_Url_Basename})){ dk_call dk_error "PLUGIN_Url_Basename is invalid"; }
	dk_call dk_debug "PLUGIN_Url_Basename = '${PLUGIN_Url_Basename}'";

	dk_call dk_removeExtension	"${PLUGIN_Url_Basename}" PLUGIN_Url_Name;	# name, file  (no extension)
	if(!(${PLUGIN_Url_Name})){ dk_call dk_error "PLUGIN_Url_Name is invalid"; }
	dk_call dk_debug "PLUGIN_Url_Name = '${PLUGIN_Url_Name}'";
}

#########################################
function Global:PLUGIN_Url_Name_Lower() {
	if(${PLUGIN_Url_Name_Lower}){ return; }

	PLUGIN_Url_Name;

	if(!(${PLUGIN_Url_Name})){ dk_call dk_error "PLUGIN_Url_Name is invalid"; }
	dk_call dk_debug "PLUGIN_Url_Name = '${PLUGIN_Url_Name}'";

	dk_call dk_toLower ${PLUGIN_Url_Name} PLUGIN_Url_Name_Lower;
	if(!(${PLUGIN_Url_Name_Lower})){ dk_call dk_error "PLUGIN_Url_Name_Lower is invalid"; }
	dk_call dk_debug "PLUGIN_Url_Name_Lower = '${PLUGIN_Url_Name_Lower}'";
}

########################################
function Global:PLUGIN_Url_Extension() {
	if(${PLUGIN_Url_Extension}){ return; }

	PLUGIN_Url_Basename;

	if(!(${PLUGIN_Url_Basename})){ dk_call dk_error "PLUGIN_Url_Basename is invalid"; }
	dk_call dk_debug "PLUGIN_Url_Basename = '${PLUGIN_Url_Basename}'";

	dk_call dk_getExtension	"${PLUGIN_Url_Basename}" PLUGIN_Url_Extension;
	if(!(${PLUGIN_Url_Extension})){ dk_call dk_error "PLUGIN_Url_Extension is invalid"; }
	dk_call dk_debug "PLUGIN_Url_Extension = '${PLUGIN_Url_Extension}'";
}

#######################################
function Global:PLUGIN_Install_Name() {
	if(${PLUGIN_Install_Name}){ return; }

	PLUGIN_Import_Name;

	if(!(${PLUGIN_Import_Name})){ dk_call dk_error "PLUGIN_Import_Name is invalid"; }
	dk_call dk_debug "PLUGIN_Import_Name = '${PLUGIN_Import_Name}'";

	PLUGIN_Version;

	#if(!(${PLUGIN_Version})){ dk_call dk_error "PLUGIN_Version is invalid"; }
	dk_call dk_debug "PLUGIN_Version = '${PLUGIN_Version}'";

	if(${PLUGIN_Import_Name} -AND ${PLUGIN_Version}){
		${global:PLUGIN_Install_Name}="${PLUGIN_Import_Name}-${PLUGIN_Version}";
	}
	elseif(!(${PLUGIN_Install_Name})){
		${global:PLUGIN_Install_Name}="${PLUGIN_Import_Name}";
	}
	if(!(${PLUGIN_Install_Name})){ dk_call dk_error "PLUGIN_Install_Name is invalid"; }
	dk_call dk_debug "PLUGIN_Install_Name = '${PLUGIN_Install_Name}'";
}

#######################################
function Global:PLUGIN_Install_Path() {
	if(${PLUGIN_Install_Path}){ return; }

	PLUGIN_Install_Dirname;

	if(!(${PLUGIN_Install_Dirname})){ dk_call dk_error "PLUGIN_Install_Dirname is invalid"; }
	dk_call dk_debug "PLUGIN_Install_Dirname = '${PLUGIN_Install_Dirname}'";

	PLUGIN_Install_Name;

	if(!(${PLUGIN_Install_Name})){ dk_call dk_error "PLUGIN_Install_Name is invalid"; }
	dk_call dk_debug "PLUGIN_Install_Name = '${PLUGIN_Install_Name}'";

	${global:PLUGIN_Install_Path}="${PLUGIN_Install_Dirname}/${PLUGIN_Install_Name}";
	if(!(${PLUGIN_Install_Path})){ dk_call dk_error "PLUGIN_Install_Path is invalid"; }
	dk_call dk_debug "PLUGIN_Install_Path = '${PLUGIN_Install_Path}'";
}

##################################
function Global:PLUGIN_Version() {
	if(${PLUGIN_Version}){ return; }

	PLUGIN_Url_Name_Lower;

	if(!(${PLUGIN_Url_Name_Lower})){ dk_call dk_error "PLUGIN_Url_Name_Lower is invalid"; }
	dk_call dk_debug "PLUGIN_Url_Name_Lower = '${PLUGIN_Url_Name_Lower}'";

	PLUGIN_Import_Name_Lower;

	if(!(${PLUGIN_Import_Name_Lower})){ dk_call dk_error "PLUGIN_Import_Name_Lower is invalid"; }
	dk_call dk_debug "PLUGIN_Import_Name_Lower = '${PLUGIN_Import_Name_Lower}'";

	if(${PLUGIN_Url_Name_Lower} -AND ${PLUGIN_Import_Name_Lower}){
		dk_call dk_replaceAll  "${PLUGIN_Url_Name_Lower}"  "${PLUGIN_Import_Name_Lower}"  ""  PLUGIN_Version;
		# if(!(${PLUGIN_Version})){ PLUGIN_Version=${PLUGIN_TAG}; }
		# if(!(${PLUGIN_Version})){ PLUGIN_Version=${PLUGIN_Branch}; }
	}

	dk_call dk_trimNonAlphaNumeric "${PLUGIN_Version}"  PLUGIN_Version;

	#if(!(${PLUGIN_Version})){ dk_call dk_error "PLUGIN_Version is invalid"; }
	dk_call dk_debug "PLUGIN_Version = '${PLUGIN_Version}'";
}

######################################
function Global:PLUGIN_Import_Path() {
	if(${PLUGIN_Import_Path}){ return; }

	if(${PLUGIN_Import_Name}){
		dk_call dk_validate env:DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR";
		${global:PLUGIN_Import_Path}="${env:DKIMPORTS_DIR}/${PLUGIN_Import_Name}";
	} elseif(dk_call dk_includes "${CURRENT_IMPORT}" "${env:DKIMPORTS_DIR}"){
		${global:PLUGIN_Import_Path}="${CURRENT_IMPORT}";
	}

	#if(!(${PLUGIN_Import_Path})){ dk_call dk_error "PLUGIN_Import_Path is invalid"; }
	dk_call dk_debug "PLUGIN_Import_Path = '${PLUGIN_Import_Path}'";
}

#########################################
function Global:PLUGIN_Import_Dirname() {
	if(${PLUGIN_Import_Dirname}){ return; }

	#if(!(${PLUGIN_Import_Path}){ dk_call dk_error "PLUGIN_Import_Path is invalid"};
	dk_call dk_debug "PLUGIN_Import_Path = '${PLUGIN_Import_Path}'";
	
	dk_call dk_dirname	"${PLUGIN_Import_Path}" PLUGIN_Import_Dirname;
	if(!(${PLUGIN_Import_Dirname})){ dk_call dk_error "PLUGIN_Import_Dirname is invalid"; }
	dk_call dk_debug "PLUGIN_Import_Dirname = '${PLUGIN_Import_Dirname}'";
}

######################################
function Global:PLUGIN_Import_Name() {
	if(${PLUGIN_Import_Name}){ return; }

	PLUGIN_Import_Path;

	#if(!(${PLUGIN_Import_Path}){ dk_call dk_error "PLUGIN_Import_Path is invalid"};
	dk_call dk_debug "PLUGIN_Import_Path = '${PLUGIN_Import_Path}'";

	if(${PLUGIN_Import_Path}) {
		dk_call dk_basename	"${PLUGIN_Import_Path}" PLUGIN_Import_Name;
		if(!(${PLUGIN_Import_Name})){ dk_call dk_error "PLUGIN_Import_Name is invalid"; }
		dk_call dk_debug "PLUGIN_Import_Name = '${PLUGIN_Import_Name}'";

	} elseif(dk_call dk_includes "${PLUGIN_Url}" "https://github.com"){
		dk_call dk_replaceAll 	${PLUGIN_Url} 		"/" 	";" 	PLUGIN_Url_List;
		dk_call dk_replaceAll 	${PLUGIN_Url_List} 	";;" 	";" 	PLUGIN_Url_List;
		if(!(${PLUGIN_Url_List})){ dk_call dk_error "PLUGIN_Url_List is invalid"; }
		dk_call dk_debug "PLUGIN_Url_List = '${PLUGIN_Url_List}'";

		dk_call dk_listToArray 	"${PLUGIN_Url_List}"  PLUGIN_Url_Array;
		dk_call dk_printVar PLUGIN_Url_Array;
		if(!(${PLUGIN_Url_Array})){ dk_call dk_error "PLUGIN_Url_Array is invalid"; }
		dk_call dk_debug "PLUGIN_Url_Array = '${PLUGIN_Url_Array}'";

		dk_call dk_arrayAt		PLUGIN_Url_Array	3				PLUGIN_Import_Name;
		if(!(${PLUGIN_Import_Name})){ dk_call dk_error "PLUGIN_Import_Name is invalid"; }
		dk_call dk_debug "PLUGIN_Import_Name = '${PLUGIN_Import_Name}'";
	}
}

############################################
function Global:PLUGIN_Import_Name_Upper() {
	if(${PLUGIN_Import_Name_Upper}){ return; }

	PLUGIN_Import_Name;

	if(!(${PLUGIN_Import_Name})){ dk_call dk_error "PLUGIN_Import_Name is invalid"; }
	dk_call dk_debug "PLUGIN_Import_Name = '${PLUGIN_Import_Name}'";

	dk_call dk_toUpper	"${PLUGIN_Import_Name}" PLUGIN_Import_Name_Upper;
	if(!(${PLUGIN_Import_Name_Upper})){ dk_call dk_error "PLUGIN_Import_Name_Upper is invalid"; }
	dk_call dk_debug "PLUGIN_Import_Name_Upper = '${PLUGIN_Import_Name_Upper}'";
}

#############################
function Global:PLUGIN_Id() {
	if(${PLUGIN_Id}){ return; }

	PLUGIN_Import_Name_Upper;

	if(!(${PLUGIN_Import_Name_Upper})){ dk_call dk_error "PLUGIN_Import_Name_Upper is invalid"; }
	dk_call dk_debug "PLUGIN_Import_Name_Upper = '${PLUGIN_Import_Name_Upper}'";

	dk_call dk_convertToCIdentifier	"${PLUGIN_Import_Name_Upper}" 	PLUGIN_Id;
	if(!(${PLUGIN_Id})){ dk_call dk_error "PLUGIN_Id is invalid"; }
	dk_call dk_debug "PLUGIN_Id = '${PLUGIN_Id}'";
}

#############################
function Global:PRINTVARS() {
	dk_call dk_echo;
	dk_call dk_echo "#################### PLUGIN_variables #####################";
	dk_call dk_echo "PLUGIN                            = '${PLUGIN}'";
	dk_call dk_echo "PLUGIN_Args                       = '${PLUGIN_Args}";
	dk_call dk_echo "PLUGIN_Id                         = '${PLUGIN_Id}'";
	dk_call dk_echo "PLUGIN_Version                    = '${PLUGIN_Version}'";
	dk_call dk_echo "PLUGIN_Url                        = '${PLUGIN_Url}'";
	dk_call dk_echo "PLUGIN_Url_Basename               = '${PLUGIN_Url_Basename}'";
	dk_call dk_echo "PLUGIN_Url_Name                   = '${PLUGIN_Url_Name}'";
	dk_call dk_echo "PLUGIN_Url_Extension              = '${PLUGIN_Url_Extension}'";
	dk_call dk_echo "PLUGIN_Import_Dirname             = '${PLUGIN_Import_Dirname}'";
	dk_call dk_echo "PLUGIN_Import_Name                = '${PLUGIN_Import_Name}'";
	dk_call dk_echo "PLUGIN_Import_Path                = '${PLUGIN_Import_Path}'";
	dk_call dk_echo "PLUGIN_Install_Dirname            = '${PLUGIN_Install_Dirname}'";
	dk_call dk_echo "PLUGIN_Install_Name               = '${PLUGIN_Install_Name}'";
	dk_call dk_echo "PLUGIN_Install_Path               = '${PLUGIN_Install_Path}'";
	dk_call dk_echo "PLUGIN_Tuple_Dir                  = '${PLUGIN_Tuple_Dir}'";
	dk_call dk_echo "PLUGIN_Build_Dir                  = '${PLUGIN_Build_Dir}'";
	dk_call dk_echo "PLUGIN_Config_Dir                 = '${PLUGIN_Config_Dir}'";
	dk_call dk_echo "PLUGIN_Debug_Dir                  = '${PLUGIN_Debug_Dir}'";
	dk_call dk_echo "PLUGIN_Release_Dir                = '${PLUGIN_Release_Dir}'";
	dk_call dk_echo;
	dk_call dk_echo;
	dk_call dk_echo "################## ${PLUGIN}_variables ######################"
	dk_call dk_echo "${PLUGIN}                         = $(gv -Name ${PLUGIN} -ValueOnly)";
	dk_call dk_echo "${PLUGIN}_Args                    = $(gv -Name ${PLUGIN}_Args -ValueOnly)";
	dk_call dk_echo "${PLUGIN}_Id                      = $(gv -Name ${PLUGIN}_Id -ValueOnly)";
	dk_call dk_echo "${PLUGIN}_Version                 = $(gv -Name ${PLUGIN}_Version -ValueOnly)";
	dk_call dk_echo "${PLUGIN}_Url                     = $(gv -Name ${PLUGIN}_Url -ValueOnly)";
	dk_call dk_echo "${PLUGIN}_Url_Basename            = $(gv -Name ${PLUGIN}_Url_Basename -ValueOnly)";
	dk_call dk_echo "${PLUGIN}_Url_Name                = $(gv -Name ${PLUGIN}_Url_Name -ValueOnly)";
	dk_call dk_echo "${PLUGIN}_Url_Extension           = $(gv -Name ${PLUGIN}_Url_Extension -ValueOnly)";
	dk_call dk_echo "${PLUGIN}_Import_Dirname          = $(gv -Name ${PLUGIN}_Import_Dirname -ValueOnly)";
	dk_call dk_echo "${PLUGIN}_Import_Name             = $(gv -Name ${PLUGIN}_Import_Name -ValueOnly)";
	dk_call dk_echo "${PLUGIN}_Import_Path             = $(gv -Name ${PLUGIN}_Import_Path -ValueOnly)";
	dk_call dk_echo "${PLUGIN}_Install_Dirname         = $(gv -Name ${PLUGIN}_Install_Dirname -ValueOnly)";
	dk_call dk_echo "${PLUGIN}_Install_Name            = $(gv -Name ${PLUGIN}_Install_Name -ValueOnly)";
	dk_call dk_echo "${PLUGIN}_Install_Path            = $(gv -Name ${PLUGIN}_Install_Path -ValueOnly)";
	dk_call dk_echo "${PLUGIN}_Tuple_Dir               = $(gv -Name ${PLUGIN}_Tuple_Dir -ValueOnly)";
	dk_call dk_echo "${PLUGIN}_Build_Dir               = $(gv -Name ${PLUGIN}_Build_Dir -ValueOnly)";
	dk_call dk_echo "${PLUGIN}_Config_Dir              = $(gv -Name ${PLUGIN}_Config_Dir -ValueOnly)";
	dk_call dk_echo "${PLUGIN}_Debug_Dir               = $(gv -Name ${PLUGIN}_Debug_Dir -ValueOnly)";
	dk_call dk_echo "${PLUGIN}_Release_Dir             = $(gv -Name ${PLUGIN}_Release_Dir -ValueOnly)";
	dk_call dk_echo;
}
















###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;

	dk_call dk_validate env:DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR";
	dk_call dk_validate env:DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR";

	${global:CURRENT_IMPORT} = "${env:DKIMPORTS_DIR}/msys2";
	dk_call dk_importVariables "https://repo.msys2.org/distrib/x86_64/msys2-base-x86_64-20241208.tar.xz";
	dk_call dk_importVariables PRINTVARS;

	${global:CURRENT_IMPORT} = "${env:DKIMPORTS_DIR}/git";
	dk_call dk_importVariables "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe" INSTALL_ROOT "${env:DKTOOLS_DIR}";
	dk_call dk_importVariables PRINTVARS;

	${global:CURRENT_IMPORT} = "${env:DKIMPORTS_DIR}/php-src";
	dk_call dk_importVariables "https://windows.php.net/downloads/releases/php-8.4.11-Win32-vs17-x64.zip";
	dk_call dk_importVariables PRINTVARS;
}	
