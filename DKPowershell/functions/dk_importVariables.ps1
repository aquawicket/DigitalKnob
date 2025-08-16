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
	
	Write-Host "args = $args";
	if("$args" -eq "PRINTVARS"){
		PRINTVARS;
		return;
	}
	dk_call dk_getParameterValue PRINTVARS @args;
	if(${PRINTVARS}){
		#dk_call dk_unset PRINTVARS;
		PRINTVARS;
		return;
	}
	
	### PLUGIN(hashtable) 
	${global:PLUGIN}=@{};
	
	dk_call dk_unset PLUGIN;
	dk_call dk_unset PLUGIN.Args;
	dk_call dk_unset PLUGIN.Build_Dir;
	dk_call dk_unset PLUGIN.Config_Dir;
	dk_call dk_unset PLUGIN.Debug_Dir;
	dk_call dk_unset PLUGIN.Id;
	dk_call dk_unset PLUGIN.Import.Dirname;
	dk_call dk_unset PLUGIN.Import.Name;
	dk_call dk_unset PLUGIN.Import.Name_Lower;
	dk_call dk_unset PLUGIN.Import.Name_Upper;
	dk_call dk_unset PLUGIN.Import.Path;
	dk_call dk_unset PLUGIN.Install.Dirname;
	dk_call dk_unset PLUGIN.Install.Name;
	dk_call dk_unset PLUGIN.Install.Path;
	dk_call dk_unset PLUGIN.Release_Dir;
	dk_call dk_unset PLUGIN.Tuple_Dir;
	dk_call dk_unset PLUGIN.Url;
	dk_call dk_unset PLUGIN.Url.Basename;
	dk_call dk_unset PLUGIN.Url.Extension;
	dk_call dk_unset PLUGIN.Url.Name;
	dk_call dk_unset PLUGIN.Url.Name_Lower;
	dk_call dk_unset PLUGIN.Version;
	
																	###### EXAMPLE ######
	### IMPORT_ROOT (PLUGIN.Import.Dirname)							/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS
	dk_call dk_unset IMPORT_ROOT;
	dk_call dk_getParameterValue IMPORT_ROOT @args;
	dk_call dk_echo "IMPORT_ROOT = '${IMPORT_ROOT}'";	
	${global:PLUGIN.Import.Dirname}="${IMPORT_ROOT}";

	### IMPORT_NAME (PLUGIN.Import.Name)							zlib
	dk_call dk_unset IMPORT_NAME;
	dk_call dk_getParameterValue IMPORT_NAME @args;
	dk_call dk_echo "IMPORT_NAME = '${IMPORT_NAME}'";
	${global:PLUGIN.Import.Name}="${IMPORT_NAME}";
	
	### IMPORT_PATH (PLUGIN.Import.Path)							/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
	dk_call dk_unset IMPORT_PATH;
	dk_call dk_getParameterValue IMPORT_PATH @args;
	dk_call dk_echo "IMPORT_PATH = '${IMPORT_PATH}'";
	${global:PLUGIN.Import.Path}="${IMPORT_PATH}";
	
	### INSTALL_ROOT (PLUGIN.Install.Dirname)						/c/Users/Administrator/DigitalKnob/Development/3rdParty
	dk_call dk_unset INSTALL_ROOT;
	dk_call dk_getParameterValue INSTALL_ROOT @args;
	dk_call dk_echo "INSTALL_ROOT = '${INSTALL_ROOT}'";
	${global:PLUGIN.Install.Dirname}="${INSTALL_ROOT}";

	### INSTALL_NAME (PLUGIN.Install.Name)							zlib-master
	dk_call dk_unset INSTALL_NAME;
	dk_call dk_getParameterValue INSTALL_NAME @args;
	dk_call dk_echo "INSTALL_NAME = '${INSTALL_NAME}'";
	${global:PLUGIN.Install.Name}="${INSTALL_NAME}";

	### INSTALL_PATH (PLUGIN.Install.Path)							/c/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	dk_call dk_unset INSTALL_PATH;
	dk_call dk_getParameterValue INSTALL_PATH @args;
	dk_call dk_echo "INSTALL_PATH = '${INSTALL_PATH}'";
	${global:PLUGIN.Install.Path}="${INSTALL_PATH}";

	### VERSION (PLUGIN.Version)									v1.3.1
	dk_call dk_unset VERSION;
	dk_call dk_getParameterValue VERSION @args;
	dk_call dk_echo "VERSION = '${VERSION}'";
	${global:PLUGIN.Version}="${VERSION}";

	### BRANCH (PLUGIN.Branch)										master
	dk_call dk_unset BRANCH;
	dk_call dk_getParameterValue BRANCH	@args;
	dk_call dk_echo "BRANCH = '${BRANCH}'";
	${global:PLUGIN.Branch}="${BRANCH}";
	
	### PLUGIN.Args													"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	dk_call dk_unset PLUGIN.Args;
	${global:PLUGIN.Args}=${args};
	dk_call dk_echo "PLUGIN.Args = '${PLUGIN.Args}'";
		
	### PLUGIN.Url													"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	dk_call dk_unset PLUGIN.Url;
	${global:PLUGIN.Url}=${args}[0];
	dk_call dk_echo "PLUGIN.Url = '${PLUGIN.Url}'";
	
		
	PLUGIN_Id;
	
	PLUGIN_Install_Path;
	
	### PLUGIN.Tuple_Dir]											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang
	${global:PLUGIN.Tuple_Dir}="${PLUGIN.Install.Path}/${Target_Tuple}";
	#dk_call dk_echo "PLUGIN.Tuple_Dir = '${PLUGIN.Tuple_Dir}'";
	
	### PLUGIN.Config_Dir}											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	${global:PLUGIN.Config_Dir}="${PLUGIN.Install.Path}/${Config_Path}";
	#dk_call dk_echo "PLUGIN.Config_Dir = '${PLUGIN.Config_Dir}'";
	
	### PLUGIN.Build_Dir}											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	${global:PLUGIN.Build_Dir}="${PLUGIN.Install.Path}/${Build_Path}";
	#dk_call dk_echo "PLUGIN.Build_Dir = '${PLUGIN.Build_Dir}'";
	
	### PLUGIN.Debug_Dir}											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	${global:PLUGIN.Debug_Dir}="${PLUGIN.Install.Path}/${Target_Tuple}/${Debug_Dir}";
	#dk_call dk_echo "PLUGIN.Debug_Dir = '${PLUGIN.Debug_Dir}'";
	
	### PLUGIN.Release_Dir}											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Release
	${global:PLUGIN.Release_Dir}="${PLUGIN.Install.Path}/${Target_Tuple}/${Release_Dir}";
	#dk_call dk_echo "PLUGIN.Release_Dir = '${PLUGIN.Release_Dir}'";
	
	${global:PLUGIN}="${PLUGIN.Id}";
	#$(${PLUGIN})="${PLUGIN.Install.Path}";	
}	

############################################
function Global:PLUGIN_Import_Name_Lower() {
	if(${PLUGIN.Import.Name_Lower}){ return; }
	
	PLUGIN_Import_Name;
	
	if(!(${PLUGIN.Import.Name})) { dk_call dk_error "PLUGIN.Import.Name is invalid"; }
	dk_call dk_debug "PLUGIN.Import.Name = '${PLUGIN.Import.Name}'";
	
	dk_call dk_toLower 	"${PLUGIN.Import.Name}"	PLUGIN.Import.Name_Lower;
	if(!(${PLUGIN.Import.Name_Lower})) { dk_call dk_error "PLUGIN.Import.Name_Lower is invalid"; }
	dk_call dk_debug "PLUGIN.Import.Name_Lower = '${PLUGIN.Import.Name_Lower}'";
}

##########################################
function Global:PLUGIN_Install_Dirname() {
	if(${PLUGIN.Install.Dirname}){ return; }
	
	dk_call dk_validate env:DK3RDPARTY_DIR "dk_call dk_DK3RDPARTY_DIR";
	${global:PLUGIN.Install.Dirname}="${env:DK3RDPARTY_DIR}";
	if(!(${PLUGIN.Install.Dirname})){ dk_call dk_error "PLUGIN.Install.Dirname is invalid"; }
	dk_call dk_debug "PLUGIN.Install.Dirname = '${PLUGIN.Install.Dirname}'";
}

#######################################
function Global:PLUGIN_Url_Basename() {
	if(${PLUGIN.Url.Basename}){ return; }

	if(${PLUGIN.Url}){
		dk_call dk_basename	"${PLUGIN.Url}" PLUGIN.Url.Basename;				# basename, filename
	}
	if(!(${PLUGIN.Url.Basename})){ dk_call dk_error "PLUGIN.Url.Basename is invalid"; }
	dk_call dk_debug "PLUGIN.Url.Basename = '${PLUGIN.Url.Basename}'";
}

###################################
function Global:PLUGIN_Url_Name() {
	if(${PLUGIN.Url.Name}){ return; }
	
	PLUGIN_Url_Basename;
	
	if(!(${PLUGIN.Url.Basename})){ dk_call dk_error "PLUGIN.Url.Basename is invalid"; }
	dk_call dk_debug "PLUGIN.Url.Basename = '${PLUGIN.Url.Basename}'";
	
	dk_call dk_removeExtension	"${PLUGIN.Url.Basename}" PLUGIN.Url.Name;	# name, file  (no extension)
	if(!(${PLUGIN.Url.Name})){ dk_call dk_error "PLUGIN.Url.Name is invalid"; }
	dk_call dk_debug "PLUGIN.Url.Name = '${PLUGIN.Url.Name}'";
}

#########################################
function Global:PLUGIN_Url_Name_Lower() {
	if(${PLUGIN.Url.Name_Lower}){ return; }
	
	PLUGIN_Url_Name;
	
	if(!(${PLUGIN.Url.Name})){ dk_call dk_error "PLUGIN.Url.Name is invalid"; }
	dk_call dk_debug "PLUGIN.Url.Name = '${PLUGIN.Url.Name}'";
	
	dk_call dk_toLower ${PLUGIN.Url.Name} PLUGIN.Url.Name_Lower;
	if(!(${PLUGIN.Url.Name_Lower})){ dk_call dk_error "PLUGIN.Url.Name_Lower is invalid"; }
	dk_call dk_debug "PLUGIN.Url.Name_Lower = '${PLUGIN.Url.Name_Lower}'";
}

#######################################
function Global:PLUGIN_Install_Name() {
	if(${PLUGIN.Install.Name}){ return; }
	
	PLUGIN_Import_Name;
	
	if(!(${PLUGIN.Import.Name})){ dk_call dk_error "PLUGIN.Import.Name is invalid"; }
	dk_call dk_debug "PLUGIN.Import.Name = '${PLUGIN.Import.Name}'";
	
	PLUGIN_Version;
	
	#if(!(${PLUGIN.Version})){ dk_call dk_error "PLUGIN.Version is invalid"; }
	dk_call dk_debug "PLUGIN.Version = '${PLUGIN.Version}'";
	
	if(!(${PLUGIN.Import.Name}) -AND !(${PLUGIN.Version})){
		${global:PLUGIN.Install.Name}="${PLUGIN.Import.Name}-${PLUGIN.Version}";
	} 
	elseif(!(${PLUGIN.Install.Name})){	
		${global:PLUGIN.Install.Name}="${PLUGIN.Import.Name}";
	}
	if(!(${PLUGIN.Install.Name})){ dk_call dk_error "PLUGIN.Install.Name is invalid"; }
	dk_call dk_debug "PLUGIN.Install.Name = '${PLUGIN.Install.Name}'";
}

#######################################
function Global:PLUGIN_Install_Path() {
	if(${PLUGIN.Install.Path}){ return; }
	
	PLUGIN_Install_Dirname;
	
	if(!(${PLUGIN.Install.Dirname})){ dk_call dk_error "PLUGIN.Install.Dirname is invalid"; }
	dk_call dk_debug "PLUGIN.Install.Dirname = '${PLUGIN.Install.Dirname}'";
	
	PLUGIN_Install_Name;
	
	if(!(${PLUGIN.Install.Name})){ dk_call dk_error "PLUGIN.Install.Name is invalid"; }
	dk_call dk_debug "PLUGIN.Install.Name = '${PLUGIN.Install.Name}'";
	
	${global:PLUGIN.Install.Path}="${PLUGIN.Install.Dirname}/${PLUGIN.Install.Name}";
	if(!(${PLUGIN.Install.Path})){ dk_call dk_error "PLUGIN.Install.Path is invalid"; }
	dk_call dk_debug "PLUGIN.Install.Path = '${PLUGIN.Install.Path}'";
}

##################################
function Global:PLUGIN_Version() {
	if(${PLUGIN.Version}){ return; }
		
	PLUGIN_Url_Name_Lower;
	
	if(!(${PLUGIN.Url.Name_Lower})){ dk_call dk_error "PLUGIN.Url.Name_Lower is invalid"; }
	dk_call dk_debug "PLUGIN.Url.Name_Lower = '${PLUGIN.Url.Name_Lower}'";
	
	PLUGIN_Import_Name_Lower;
	
	if(!(${PLUGIN.Import.Name_Lower})){ dk_call dk_error "PLUGIN.Import.Name_Lower is invalid"; }
	dk_call dk_debug "PLUGIN.Import.Name_Lower = '${PLUGIN.Import.Name_Lower}'";
	
	if(${PLUGIN.Url.Name_Lower} -AND ${PLUGIN.Import.Name_Lower}){
		dk_call dk_replaceAll "${PLUGIN.Url.Name_Lower}" 	"${PLUGIN.Import.Name_Lower}" 	""  PLUGIN.Version;
		# if(!(${PLUGIN.Version})){ PLUGIN.Version=${PLUGIN.TAG}; }
		# if(!(${PLUGIN.Version})){ PLUGIN.Version=${PLUGIN.Branch}; } 
	}
	
	#dk_call dk_trimNonAlphaNumeric "${PLUGIN.Version}"  PLUGIN.Version;
	
	#if(!(${PLUGIN.Version})){ dk_call dk_error "PLUGIN.Version is invalid"; }
	dk_call dk_debug "PLUGIN.Version = '${PLUGIN.Version}'";
}

######################################
function Global:PLUGIN_Import_Path() {	
	if(${PLUGIN.Import.Path}){ return; }
	
	if(${PLUGIN.Import.Name}){
		dk_call dk_validate env:DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR";
		${global:PLUGIN.Import.Path}="${env:DKIMPORTS_DIR}/${PLUGIN.Import.Name}";
	} elseif(dk_call dk_includes "${CURRENT_IMPORT}" "${env:DKIMPORTS_DIR}"){
		${global:PLUGIN.Import.Path}="${CURRENT_IMPORT}";
	}
	
	#if(!(${PLUGIN.Import.Path})){ dk_call dk_error "PLUGIN.Import.Path is invalid"; }
	dk_call dk_debug "PLUGIN.Import.Path = '${PLUGIN.Import.Path}'";	
}

######################################
function Global:PLUGIN_Import_Name() {
	if(${PLUGIN.Import.Name}){ return; }
		
	PLUGIN_Import_Path;
	
	#if(!(${PLUGIN.Import.Path}){ dk_call dk_error "PLUGIN.Import.Path is invalid"};
	dk_call dk_debug "PLUGIN.Import.Path = '${PLUGIN.Import.Path}'";

	if(${PLUGIN.Import.Path}) {
		dk_call dk_basename	"${PLUGIN.Import.Path}" PLUGIN.Import.Name;
		if(!(${PLUGIN.Import.Name})){ dk_call dk_error "PLUGIN.Import.Name is invalid"; }
		dk_call dk_debug "PLUGIN.Import.Name = '${PLUGIN.Import.Name}'";
		
	} elseif(dk_call dk_includes "${PLUGIN.Url}" "https://github.com"){
		dk_call dk_replaceAll 	${PLUGIN.Url} 		"/" 	";" 	PLUGIN.Url.List;
		dk_call dk_replaceAll 	${PLUGIN.Url.List} 	";;" 	";" 	PLUGIN.Url.List;
		if(!(${PLUGIN.Url.List})){ dk_call dk_error "PLUGIN.Url.List is invalid"; }
		dk_call dk_debug "PLUGIN.Url.List = '${PLUGIN.Url.List}'";
		
		dk_call dk_listToArray 	"${PLUGIN.Url.List}"  PLUGIN_Url_Array;
		dk_call dk_printVar PLUGIN_Url_Array;
		if(!(${PLUGIN_Url_Array})){ dk_call dk_error "PLUGIN_Url_Array is invalid"; }
		dk_call dk_debug "PLUGIN_Url_Array = '${PLUGIN_Url_Array}'";
		
		dk_call dk_arrayAt		PLUGIN_Url_Array	3				PLUGIN.Import.Name;
		if(!(${PLUGIN.Import.Name})){ dk_call dk_error "PLUGIN.Import.Name is invalid"; }
		dk_call dk_debug "PLUGIN.Import.Name = '${PLUGIN.Import.Name}'";
	}	
}

############################################
function Global:PLUGIN_Import_Name_Upper() {
	if(${PLUGIN.Import.Name_Upper}){ return; }
	
	PLUGIN_Import_Name;
	
	if(!(${PLUGIN.Import.Name})){ dk_call dk_error "PLUGIN.Import.Name is invalid"; }
	dk_call dk_debug "PLUGIN.Import.Name = '${PLUGIN.Import.Name}'";
	
	dk_call dk_toUpper	"${PLUGIN.Import.Name}" PLUGIN.Import.Name_Upper;
	if(!(${PLUGIN.Import.Name_Upper})){ dk_call dk_error "PLUGIN.Import.Name_Upper is invalid"; }
	dk_call dk_debug "PLUGIN.Import.Name_Upper = '${PLUGIN.Import.Name_Upper}'";
}

#############################
function Global:PLUGIN_Id() {
	if(${PLUGIN.Id}){ return; }
	
	PLUGIN_Import_Name_Upper;
	
	if(!(${PLUGIN.Import.Name_Upper})){ dk_call dk_error "PLUGIN.Import.Name_Upper is invalid"; }
	dk_call dk_debug "PLUGIN.Import.Name_Upper = '${PLUGIN.Import.Name_Upper}'";
	
	dk_call dk_convertToCIdentifier	"${PLUGIN.Import.Name_Upper}" 	PLUGIN.Id;
	if(!(${PLUGIN.Id})){ dk_call dk_error "PLUGIN.Id is invalid"; }
	dk_call dk_debug "PLUGIN.Id = '${PLUGIN.Id}'";
}	
	
	
	
#############################
function Global:PRINTVARS() {
	Write-Host "PRINTVARS()";
	dk_call dk_echo;
	dk_call dk_echo "################## PLUGIN.variables ##################";
	dk_call dk_echo "PLUGIN                             = '${PLUGIN}'";
	dk_call dk_echo "${PLUGIN}                          = '$($PLUGIN)'";
	dk_call dk_echo "PLUGIN.ARGS                        = '${PLUGIN.ARGS}";
	dk_call dk_echo "PLUGIN.Id                          = '${PLUGIN.Id}'";
	dk_call dk_echo "PLUGIN.Version                     = '${PLUGIN.Version}'";
	dk_call dk_echo "PLUGIN.Url                         = '${PLUGIN.Url}'";
	dk_call dk_echo "PLUGIN.Url.Basename                = '${PLUGIN.Url.Basename}'";
	dk_call dk_echo "PLUGIN.Url.Name                    = '${PLUGIN.Url.Name}'";
	dk_call dk_echo "PLUGIN.Url.Extension               = '${PLUGIN.Url.Extension}'";
	dk_call dk_echo "PLUGIN.Import.Dirname              = '${PLUGIN.Import.Dirname}'";
	dk_call dk_echo "PLUGIN.Import.Name                 = '${PLUGIN.Import.Name}'";
	dk_call dk_echo "PLUGIN.Import.Path                 = '${PLUGIN.Import.Path}'";
	dk_call dk_echo "PLUGIN.Install.Dirname             = '${PLUGIN.Install.Dirname}'";
	dk_call dk_echo "PLUGIN.Install.Name                = '${PLUGIN.Install.Name}'";
	dk_call dk_echo "PLUGIN.Install.Path                = '${PLUGIN.Install.Path}'";
	dk_call dk_echo "PLUGIN.Tuple_Dir                   = '${PLUGIN.Tuple_Dir}'";
	dk_call dk_echo "PLUGIN.Build_Dir                   = '${PLUGIN.Build_Dir}'";
	dk_call dk_echo "PLUGIN.Config_Dir                  = '${PLUGIN.Config_Dir}'";
	dk_call dk_echo "PLUGIN.Debug_Dir                   = '${PLUGIN.Debug_Dir}'";
	dk_call dk_echo "PLUGIN.Release_Dir                 = '${PLUGIN.Release_Dir}'";
	dk_call dk_echo;
	dk_call dk_echo;

	dk_call dk_echo "################## ${PLUGIN}.variables ##################"
	dk_call dk_echo "${PLUGIN}.Id                       = '${$(PLUGIN).Id}'";
#	dk_call dk_echo "${PLUGIN}.Args                     = '${${PLUGIN}.Args}'";
#	dk_call dk_echo "${PLUGIN}.Id                       = '${${PLUGIN}.Id}'";
#	dk_call dk_echo "${PLUGIN}.Version                  = '${${PLUGIN}.Version}'";
#	dk_call dk_echo "${PLUGIN}.Url                      = '${${PLUGIN}.Url}'";
#	dk_call dk_echo "${PLUGIN}.Url.Basename             = '${${PLUGIN}.Url.Basename}'";
#	dk_call dk_echo "${PLUGIN}.Url.Name                 = '${${PLUGIN}.Url.Name}'";
#	dk_call dk_echo "${PLUGIN}.Url.Extension            = '${${PLUGIN}.Url.Extension}'";
#	dk_call dk_echo "${PLUGIN}.Import.Dirname           = '${${PLUGIN}.Import.Dirname}'";
#	dk_call dk_echo "${PLUGIN}.Import.Name              = '${${PLUGIN}.Import.Name}'";
#	dk_call dk_echo "${PLUGIN}.Import.Path              = '${${PLUGIN}.Import.Path}'";
#	dk_call dk_echo "${PLUGIN}.Install.Dirname          = '${${PLUGIN}.Install.Dirname}'";
#	dk_call dk_echo "${PLUGIN}.Install.Name             = '${${PLUGIN}.Install.Name}'";
#	dk_call dk_echo "${PLUGIN}.Install.Path             = '${${PLUGIN}.Install.Path}'";
#	dk_call dk_echo "${PLUGIN}.Tuple_Dir                = '${${PLUGIN}.Tuple_Dir}'";
#	dk_call dk_echo "${PLUGIN}.Build_Dir                = '${${PLUGIN}.Build_Dir}'";
#	dk_call dk_echo "${PLUGIN}.Config_Dir               = '${${PLUGIN}.Config_Dir}'";
#	dk_call dk_echo "${PLUGIN}.Debug_Dir                = '${${PLUGIN}.Debug_Dir}'";
#	dk_call dk_echo "${PLUGIN}.Release_Dir              = '${${PLUGIN}.Release_Dir}'";
#	dk_call dk_echo
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


