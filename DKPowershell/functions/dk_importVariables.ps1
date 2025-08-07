if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_importVariables_ps1){ $dk_importVariables_ps1 = 1; } else{ return; } #include guard


#################################################################################
# dk_importVariables(PLUGIN_URL rtn_var) BRANCH FOLDER IMPORT_NAME PATH ROOT TAG VERSION
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
function Global:dk_importVariables() {
	#dk_debugFunc 1 99;
	
	### PLUGIN(hashtable) 
	${global:PLUGIN}=@{};
															###### EXAMPLE ######
	
	### IMPORT_ROOT											/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS
	dk_call dk_unset IMPORT_ROOT;
	dk_call dk_getParameterValue IMPORT_ROOT @args;
	$PLUGIN.IMPORT_ROOT=${IMPORT_ROOT};
	
	### IMPORT_NAME											zlib
	dk_call dk_unset IMPORT_NAME;
	dk_call dk_getParameterValue IMPORT_NAME @args;
	$PLUGIN.IMPORT_NAME=${IMPORT_NAME};
	
	### IMPORT_PATH											/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
	dk_call dk_unset IMPORT_PATH;
	dk_call dk_getParameterValue IMPORT_PATH @args;
	$PLUGIN.IMPORT_PATH=${IMPORT_PATH};
	
	### INSTALL_ROOT										/c/Users/Administrator/DigitalKnob/Development/3rdParty
	dk_call dk_unset INSTALL_ROOT;
	dk_call dk_getParameterValue INSTALL_ROOT @args;
	$PLUGIN.INSTALL_ROOT=${INSTALL_ROOT};
	
	### INSTALL_NAME										zlib-master
	dk_call dk_unset INSTALL_NAME;
	dk_call dk_getParameterValue INSTALL_NAME @args;
	$PLUGIN.INSTALL_NAME=${INSTALL_NAME};

	### INSTALL_PATH										/c/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	dk_call dk_unset INSTALL_PATH;
	dk_call dk_getParameterValue INSTALL_PATH @args;
	$PLUGIN.INSTALL_PATH=${INSTALL_PATH};
	
	### VERSION												master
	dk_call dk_unset VERSION;
	dk_call dk_getParameterValue VERSION @args;
	$PLUGIN.VERSION=${VERSION};
	
	### BRANCH												master
	dk_call dk_unset BRANCH;
	dk_call dk_getParameterValue BRANCH	@args;
	$PLUGIN.BRANCH=${BRANCH};
	
	### TAG													v1.3.1
	dk_call dk_unset TAG;
	dk_call dk_getParameterValue TAG @args;
	$PLUGIN.TAG=${TAG};
	
	


		
	############### $PLUGIN ##################
	
	### $PLUGIN.IMPORT_PATH										/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
	if(!($PLUGIN.IMPORT_PATH)){	
		dk_call dk_getcwd;
		$PLUGIN.IMPORT_PATH=${DKPWD};
	}
	
	### $PLUGIN.IMPORT_ROOT										/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS
	if(!($PLUGIN.IMPORT_ROOT)){	
		dk_call dk_dirname			$PLUGIN.IMPORT_PATH			PLUGIN.IMPORT_ROOT;
	}
	
	### $PLUGIN.IMPORT_NAME										zlib
	if(!($PLUGIN.IMPORT_NAME)){	
		dk_call dk_basename			$PLUGIN.IMPORT_PATH			PLUGIN.IMPORT_NAME;
	}
	
	### $PLUGIN.IMPORT_NAME_Upper
	dk_call dk_toUpper				$PLUGIN.IMPORT_NAME			PLUGIN.IMPORT_NAME_Upper;
	
	### $PLUGIN.IMPORT_C_Name
	dk_call dk_convertToCIdentifier $PLUGIN.IMPORT_NAME_Upper 	PLUGIN.IMPORT_NAME_Alphanumeric;
	
	### $PLUGIN.ID
	$PLUGIN.ID=$PLUGIN.IMPORT_NAME_Upper;
	if( !($PLUGIN.ID -eq $PLUGIN.IMPORT_NAME_Alphanumeric) ){
		dk_call dk_notice "$($PLUGIN.ID) contains non-alphanumeric characters and will be set to $($PLUGIN.IMPORT_NAME_Alphanumeric)";
		$PLUGIN.ID=$PLUGIN.IMPORT_NAME_Alphanumeric;
	}

	### $PLUGIN.ARGS															"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	$PLUGIN.ARGS=${args};
	
	### $PLUGIN.URL																"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	$PLUGIN.URL=${args}[0];
	
	### $PLUGIN.IMPORT												1
	dk_call dk_validate env:DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR";
	if(dk_call dk_includes $PLUGIN.IMPORT_PATH ${env:DKIMPORTS_DIR}){ $PLUGIN.IMPORT="1"; }
	
	### $PLUGIN.URL_Filename													master.zip
	dk_call dk_basename			$PLUGIN.URL							PLUGIN.URL_Filename;				
	
	### $PLUGIN.URL_List														https:;github.com;madler;zlib;archive;refs;heads;master.zip
	dk_call dk_replaceAll 		$PLUGIN.URL 		"/" 	";" 	PLUGIN.URL_List;
	dk_call dk_replaceAll 		$PLUGIN.URL_List 	";;" 	";" 	PLUGIN.URL_List;
	
	### $PLUGIN.GIT																1
	if(dk_call dk_includes 		$PLUGIN.URL 		"https://github.com") { $PLUGIN.GIT="1"; }
	
	### $PLUGIN.URL_Extension													.zip
	dk_call dk_getExtension		$PLUGIN.URL_Filename	PLUGIN.URL_Extension;
		
	### $PLUGIN.URL_File														master
	dk_call dk_removeExtension	$PLUGIN.URL_Filename	PLUGIN.URL_File;
	
	### $PLUGIN.URL_File_Lower													master
	dk_call dk_toLower 			$PLUGIN.URL_File 		PLUGIN.URL_File_Lower;
	
	### $PLUGIN.URL_Array														[0]https: [1]github.com [2]madler [3]zlib [4]archive [5]refs [6]heads [7]master.zip	
	dk_call dk_listToArray 		$PLUGIN.URL_List 		PLUGIN.URL_Array;
	
	### $PLUGIN.URL_Length														8
	dk_call dk_arrayLength 		$PLUGIN.URL_Array 		PLUGIN.URL_Length;
	
	### $PLUGIN.IMPORT_NAME_Lower												zlib
	dk_call dk_toLower 			$PLUGIN.IMPORT_NAME 	PLUGIN.IMPORT_NAME_Lower;
	

	###############################################
	############ $PLUGIN.GIT_Variables ############
	###############################################
	if($PLUGIN.GIT -eq 1){
		
		### $PLUGIN.GIT_NAME													zlib
		dk_call dk_arrayAt 		$PLUGIN.URL_Array 	3	PLUGIN.GIT_NAME;
		
		### $PLUGIN.GIT_NAME_Lower												zlib
		dk_call dk_toLower 		$PLUGIN.GIT_NAME 		PLUGIN.GIT_NAME_Lower;
		
		### $PLUGIN.GIT_BRANCH													master
		if( !($PLUGIN.BRANCH) ){
			#dk_call dk_getGitBRANCHName ${PLUGIN_URL} PLUGIN_BRANCH
			$PLUGIN.BRANCH="master";
		}  
		
		### $PLUGIN.GIT_TAG														TODO
		if( !($PLUGIN.TAG) ){
			### TODO ###
		}
	}

	###################################################
	############ $PLUGIN.INSTALL_Variables ############
	###################################################
	
	### $PLUGIN.NAME
	if(!($PLUGIN.NAME)) { $PLUGIN.NAME=$PLUGIN.IMPORT_NAME; } 
	if(!($PLUGIN.NAME)) { $PLUGIN.NAME=$PLUGIN.GIT_NAME; }
	if(!($PLUGIN.NAME)) { $PLUGIN.NAME=$PLUGIN.URL_NAME; }
	if(!($PLUGIN.NAME)) { dk_call dk_error "PLUGIN.NAME invalid"; }
	# dk_call dk_convertToCIdentifier	$PLUGIN.INSTALL_NAME	PLUGIN.INSTALL_NAME;

	### $PLUGIN.VERSION													master
	if(!($PLUGIN.VERSION)) { $PLUGIN.VERSION=${VERSION}; } 
	if(!($PLUGIN.VERSION) -AND $PLUGIN.URL_File_Lower -AND $PLUGIN.IMPORT_NAME_Lower) {
		dk_call dk_replaceAll $PLUGIN.URL_File_Lower 	$PLUGIN.IMPORT_NAME_Lower 	"" 	PLUGIN.VERSION;
		if(!($PLUGIN.VERSION)){ $PLUGIN.VERSION=$PLUGIN.TAG; } 
		if(!($PLUGIN.VERSION)){ $PLUGIN.VERSION=$PLUGIN.BRANCH; } 
	}
	if(!($PLUGIN.VERSION)) { $PLUGIN.VERSION="master"; }
	if(!($PLUGIN.VERSION)) { dk_call dk_error "PLUGIN.VERSION invalid"; }

#	string FIND $PLUGIN.VERSION - index;
#	if [ ${index} -eq 0 ]; then
#		string SUBSTRING $PLUGIN.VERSION} 1 -1 PLUGIN.VERSION;
#	fi  
#	string FIND $PLUGIN.VERSION _ index;
#	if [ ${index} -eq 0 ]; then
#		string SUBSTRING $PLUGIN.VERSION 1 -1 PLUGIN.VERSION;
#	fi 

	### $PLUGIN.INSTALL_NAME													zlib-master
	if(!($PLUGIN.INSTALL_NAME) -AND $PLUGIN.NAME -AND $PLUGIN.VERSION) {
		$PLUGIN.INSTALL_NAME="$($PLUGIN.NAME)-$($PLUGIN.VERSION)";
	}
	if(!($PLUGIN.INSTALL_NAME)) { $PLUGIN.INSTALL_NAME=$PLUGIN.NAME; }
	if(!($PLUGIN.INSTALL_NAME)) { dk_call dk_error "PLUGIN.INSTALL_NAME invalid"; }

	### $PLUGIN.INSTALL_ROOT														C:/Users/Administrator/DigitalKnob/Development/3rdParty
	if(!($PLUGIN.INSTALL_ROOT)) {
		dk_call dk_validate env:DK3RDPARTY_DIR "dk_call dk_DK3RDPARTY_DIR";
		$PLUGIN.INSTALL_ROOT=${env:DK3RDPARTY_DIR};
	}
	if(!($PLUGIN.INSTALL_ROOT)) { dk_call dk_error "PLUGIN.INSTALL_ROOT invalid"; }

	### $PLUGIN.INSTALL_PATH														C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	if(!($PLUGIN.INSTALL_PATH)) { $PLUGIN.INSTALL_PATH="$($PLUGIN.INSTALL_ROOT)/$($PLUGIN.INSTALL_NAME)"; }
	if(!($PLUGIN.INSTALL_PATH)) { dk_call dk_error "PLUGIN.INSTALL_PATH invalid"; }


	##############################################
	############# $PLUGIN.Variables ##############
	##############################################

	if($PLUGIN.IMPORT_NAME_Lower -AND $PLUGIN.GIT_NAME_Lower) {
		if(!($PLUGIN.IMPORT_NAME_Lower -eq $PLUGIN.GIT_NAME_Lower)) {
			dk_call dk_warning "PLUGIN.IMPORT_NAME_Lower:$($PLUGIN.IMPORT_NAME_Lower) and PLUGIN.GIT_NAME_Lower:$($PLUGIN.GIT_NAME_Lower) do not match";
		}
	}	
	
#	### $PLUGIN.DIR												C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
#	if(!("${PLUGIN}" -eq "GIT")) {	### DO NOT USE GIT_DIR ###
#		$PLUGIN.DIR=$PLUGIN.INSTALL_PATH;
#	}
	
		
	#####################################################
	############# TARGET $PLUGIN.Variables #############
	#####################################################

	### $PLUGIN.Tuple_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang
	$PLUGIN.Tuple_Dir="$($PLUGIN.INSTALL_PATH)/${Target_Tuple}";
	
	### $PLUGIN.Config_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	$PLUGIN.Config_Dir="$($PLUGIN.INSTALL_PATH)/${Config_Path}";
	
	### $PLUGIN.Build_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	$PLUGIN.Build_Dir="$($PLUGIN.INSTALL_PATH)/${Build_Path}";
	
	### $PLUGIN.Debug_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	$PLUGIN.Debug_Dir="$($PLUGIN.Tuple_Dir)/${Debug_Dir}";
	
	### $PLUGIN.Release_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Release
	$PLUGIN.Release_Dir="$($PLUGIN.Tuple_Dir)/${Release_Dir}";
	
	
	### Set the <PLUGIN.ID> variable to mirror $PLUGIN
	### All $PLUGIN.variables will be mirrored to the Plugin Import Name.  I.E.   $ZLIB.variables
	Set-Variable -Name $PLUGIN.ID -Value ${PLUGIN} -Scope Global;
	############### $PLUGIN ##################
}











###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
	#dk_call dk_validate DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR"
	dk_call dk_DKIMPORTS_DIR;
	dk_call dk_DKTOOLS_DIR;
	dk_call dk_chdir "${env:DKIMPORTS_DIR}/git";
	dk_call dk_importVariables "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe" INSTALL_ROOT "${env:DKTOOLS_DIR}";
	dk_call dk_echo;
	dk_call dk_echo "`$IMPORT_ROOT              = ${IMPORT_ROOT}";
	dk_call dk_echo "`$IMPORT_NAME              = ${IMPORT_NAME}";
	dk_call dk_echo "`$IMPORT_PATH              = ${IMPORT_PATH}";
	dk_call dk_echo "`$INSTALL_ROOT             = ${INSTALL_ROOT}";
	dk_call dk_echo "`$INSTALL_NAME             = ${INSTALL_NAME}";
	dk_call dk_echo "`$INSTALL_PATH             = ${INSTALL_PATH}";
	dk_call dk_echo "`$VERSION                  = ${VERSION}";
	dk_call dk_echo "`$BRANCH                   = ${BRANCH}";
	dk_call dk_echo "`$TAG                      = ${TAG}";
	dk_call dk_echo "";
	dk_call dk_echo "`$PLUGIN.ARGS              = $($PLUGIN.ARGS)";
	dk_call dk_echo "`$PLUGIN.ID                = $($PLUGIN.ID)";
	dk_call dk_echo "`$PLUGIN.IMPORT_ROOT       = $($PLUGIN.IMPORT_ROOT)";
	dk_call dk_echo "`$PLUGIN.IMPORT_NAME       = $($PLUGIN.IMPORT_NAME)";
	dk_call dk_echo "`$PLUGIN.IMPORT_PATH       = $($PLUGIN.IMPORT_PATH)";
	dk_call dk_echo "`$PLUGIN.INSTALL_ROOT      = $($PLUGIN.INSTALL_ROOT)";
	dk_call dk_echo "`$PLUGIN.INSTALL_NAME      = $($PLUGIN.INSTALL_NAME)";
	dk_call dk_echo "`$PLUGIN.INSTALL_PATH      = $($PLUGIN.INSTALL_PATH)";
	dk_call dk_echo "`$PLUGIN.VERSION           = $($PLUGIN.VERSION)";
	dk_call dk_echo "`$PLUGIN.BRANCH            = $($PLUGIN.BRANCH)";
	dk_call dk_echo "`$PLUGIN.TAG               = $($PLUGIN.TAG)";
	dk_call dk_echo "";
	dk_call dk_echo "`$PLUGIN.URL               = $($PLUGIN.URL)";
	dk_call dk_echo "`$PLUGIN.URL_Filename      = $($PLUGIN.URL_Filename)";
	dk_call dk_echo "`$PLUGIN.URL_File          = $($PLUGIN.URL_File)";
	dk_call dk_echo "`$PLUGIN.URL_Extension     = $($PLUGIN.URL_Extension)";
	dk_call dk_echo "`$PLUGIN.URL_List          = $($PLUGIN.URL_List)";
	dk_call dk_echo "`$PLUGIN.URL_Array         = $($PLUGIN.URL_Array)";
	dk_call dk_echo "`$PLUGIN.URL_Length        = $($PLUGIN.URL_Length)";
	dk_call dk_echo "";
	dk_call dk_echo "`$PLUGIN.GIT               = $($PLUGIN.GIT)";
	dk_call dk_echo "`$PLUGIN.GIT_NAME          = $($PLUGIN.GIT_NAME)";
	dk_call dk_echo "";
	dk_call dk_echo "`$PLUGIN.IMPORT            = $($PLUGIN.IMPORT)";
	dk_call dk_echo "`$PLUGIN.IMPORT_NAME_Lower = $($PLUGIN.IMPORT_NAME_Lower)";
	dk_call dk_echo "`$PLUGIN.IMPORT_NAME_Upper = $($PLUGIN.IMPORT_NAME_Upper)";	
	dk_call dk_echo "";
	dk_call dk_echo "`$PLUGIN.Build_Dir         = $($PLUGIN.Build_Dir)";
	dk_call dk_echo "`$PLUGIN.Config_Dir        = $($PLUGIN.Config_Dir)";
	dk_call dk_echo "`$PLUGIN.Debug_Dir         = $($PLUGIN.Debug_Dir)";
	dk_call dk_echo "`$PLUGIN.Release_Dir       = $($PLUGIN.Release_Dir)";
	dk_call dk_echo "`$PLUGIN.Tuple_Dir         = $($PLUGIN.Tuple_Dir)";
	#dk_call dk_echo "`$GIT.ARGS                = $($GIT.ARGS)";
	
	dk_call dk_chdir "${env:DKIMPORTS_DIR}/php-src";
	dk_call dk_importVariables "https://windows.php.net/downloads/releases/php-8.4.11-Win32-vs17-x64.zip";
	dk_call dk_echo;
	dk_call dk_echo "`$IMPORT_ROOT              = ${IMPORT_ROOT}";
	dk_call dk_echo "`$IMPORT_NAME              = ${IMPORT_NAME}";
	dk_call dk_echo "`$IMPORT_PATH              = ${IMPORT_PATH}";
	dk_call dk_echo "`$INSTALL_ROOT             = ${INSTALL_ROOT}";
	dk_call dk_echo "`$INSTALL_NAME             = ${INSTALL_NAME}";
	dk_call dk_echo "`$INSTALL_PATH             = ${INSTALL_PATH}";
	dk_call dk_echo "`$VERSION                  = ${VERSION}";
	dk_call dk_echo "`$BRANCH                   = ${BRANCH}";
	dk_call dk_echo "`$TAG                      = ${TAG}";
	dk_call dk_echo "";
	dk_call dk_echo "`$PLUGIN.ARGS              = $($PLUGIN.ARGS)";
	dk_call dk_echo "`$PLUGIN.ID                = $($PLUGIN.ID)";
	dk_call dk_echo "`$PLUGIN.IMPORT_ROOT       = $($PLUGIN.IMPORT_ROOT)";
	dk_call dk_echo "`$PLUGIN.IMPORT_NAME       = $($PLUGIN.IMPORT_NAME)";
	dk_call dk_echo "`$PLUGIN.IMPORT_PATH       = $($PLUGIN.IMPORT_PATH)";
	dk_call dk_echo "`$PLUGIN.INSTALL_ROOT      = $($PLUGIN.INSTALL_ROOT)";
	dk_call dk_echo "`$PLUGIN.INSTALL_NAME      = $($PLUGIN.INSTALL_NAME)";
	dk_call dk_echo "`$PLUGIN.INSTALL_PATH      = $($PLUGIN.INSTALL_PATH)";
	dk_call dk_echo "`$PLUGIN.VERSION           = $($PLUGIN.VERSION)";
	dk_call dk_echo "`$PLUGIN.BRANCH            = $($PLUGIN.BRANCH)";
	dk_call dk_echo "`$PLUGIN.TAG               = $($PLUGIN.TAG)";
	dk_call dk_echo "";
	dk_call dk_echo "`$PLUGIN.URL               = $($PLUGIN.URL)";
	dk_call dk_echo "`$PLUGIN.URL_Filename      = $($PLUGIN.URL_Filename)";
	dk_call dk_echo "`$PLUGIN.URL_File          = $($PLUGIN.URL_File)";
	dk_call dk_echo "`$PLUGIN.URL_Extension     = $($PLUGIN.URL_Extension)";
	dk_call dk_echo "`$PLUGIN.URL_List          = $($PLUGIN.URL_List)";
	dk_call dk_echo "`$PLUGIN.URL_Array         = $($PLUGIN.URL_Array)";
	dk_call dk_echo "`$PLUGIN.URL_Length        = $($PLUGIN.URL_Length)";
	dk_call dk_echo "";
	dk_call dk_echo "`$PLUGIN.GIT               = $($PLUGIN.GIT)";
	dk_call dk_echo "`$PLUGIN.GIT_NAME          = $($PLUGIN.GIT_NAME)";
	dk_call dk_echo "";
	dk_call dk_echo "`$PLUGIN.IMPORT            = $($PLUGIN.IMPORT)";
	dk_call dk_echo "`$PLUGIN.IMPORT_NAME_Lower = $($PLUGIN.IMPORT_NAME_Lower)";
	dk_call dk_echo "`$PLUGIN.IMPORT_NAME_Upper = $($PLUGIN.IMPORT_NAME_Upper)";	
	dk_call dk_echo "";
	dk_call dk_echo "`$PLUGIN.Build_Dir         = $($PLUGIN.Build_Dir)";
	dk_call dk_echo "`$PLUGIN.Config_Dir        = $($PLUGIN.Config_Dir)";
	dk_call dk_echo "`$PLUGIN.Debug_Dir         = $($PLUGIN.Debug_Dir)";
	dk_call dk_echo "`$PLUGIN.Release_Dir       = $($PLUGIN.Release_Dir)";
	dk_call dk_echo "`$PLUGIN.Tuple_Dir         = $($PLUGIN.Tuple_Dir)";
	#dk_call dk_echo "`$GIT.ARGS                = $($GIT.ARGS)";
}
