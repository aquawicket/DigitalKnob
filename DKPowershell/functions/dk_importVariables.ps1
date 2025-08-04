if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_importVariables_ps1){ $dk_importVariables_ps1 = 1; } else{ return; } #include guard


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
function Global:dk_importVariables() {
	#dk_debugFunc 1 9;
	
	${global:PLUGIN} = @{};
															###### EXAMPLE ######
	
	### IMPORT_Path											/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
	dk_call dk_unset IMPORT_Path;
	dk_call dk_getParameterValue IMPORT_Path @args;
	
	### IMPORT_Name											zlib
	dk_call dk_unset IMPORT_Name;
	dk_call dk_getParameterValue IMPORT_Name @args;
	
	### BRANCH												master
	dk_call dk_unset BRANCH;
	dk_call dk_getParameterValue BRANCH	@args;
	
	### FOLDER												zlib-master
	dk_call dk_unset FOLDER;
	dk_call dk_getParameterValue FOLDER @args;
	
	### DIR													C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	dk_call dk_unset DIR;
	dk_call dk_getParameterValue DIR @args;
	
	### ROOT												C:/Users/Administrator/DigitalKnob/Development/3rdParty
	dk_call dk_unset ROOT;
	dk_call dk_getParameterValue ROOT @args;
	
	### TAG													v1.3.1
	dk_call dk_unset TAG;
	dk_call dk_getParameterValue TAG @args;
	
	### VERSION												master
	dk_call dk_unset VERSION;
	dk_call dk_getParameterValue VERSION @args;


		
	############### <PLUGIN> ##################
	
	### <PLUGIN>_IMPORT_Path
	dk_call dk_getcwd;
	$PLUGIN['IMPORT_Path'] = ${DKPWD};
	
	### <PLUGIN>_IMPORT_Name								zlib
	dk_call dk_basename $PLUGIN['IMPORT_Path'] IMPORT_Name;
	$PLUGIN['IMPORT_Name'] = ${IMPORT_Name};
	
	### <PLUGIN>_Name
	dk_call dk_toUpper $PLUGIN['IMPORT_Name'] PLUGIN_IMPORT_Name_Upper;
	$PLUGIN['Name'] = "${PLUGIN_IMPORT_Name_Upper}";
	dk_call dk_convertToCIdentifier $PLUGIN['Name'] PLUGIN_IMPORT_C_Name;
	
	if( !($PLUGIN['Name'] -eq ${PLUGIN_IMPORT_C_Name})) {
		dk_call dk_notice "'$($PLUGIN['Name'])' contains non-alphanumeric characters and will be changed to '${PLUGIN_IMPORT_C_Name}'";
		$PLUGIN['Name'] = "${PLUGIN_IMPORT_C_Name}";
	}  


	### <PLUGIN>
	Set-Variable -Name $PLUGIN['Name'] -Value ${PLUGIN} -Scope Global;
	

	###########################################

	
	### <PLUGIN>_ARGS												"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	$PLUGIN['ARGS'] = ${args};
	
	### <PLUGIN>_URL												"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	$PLUGIN['URL'] = ${args}[0];
	
	### <PLUGIN>_IMPORT												1
	dk_call dk_validate env:DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR";
	if(dk_call dk_includes "${IMPORT_Path}" "${env:DKIMPORTS_DIR}"){ 
		$PLUGIN['IMPORT'] = "1";
	} else {
		$PLUGIN['IMPORT'] = "0";
	}
	
	### <PLUGIN>_URL_Filename													master.zip
	dk_call dk_basename $PLUGIN['URL'] PLUGIN_URL_Filename;				
	$PLUGIN['URL_Filename'] = ${PLUGIN_URL_Filename};
	
	### <PLUGIN>_URL_List														https:;github.com;madler;zlib;archive;refs;heads;master.zip
	dk_call dk_replaceAll $PLUGIN['URL'] "/" ";" PLUGIN_URL_List;
	$PLUGIN['URL_List'] = ${PLUGIN_URL_List};
	dk_call dk_replaceAll $PLUGIN['URL_List'] ";;" ";" PLUGIN_URL_List;
	$PLUGIN['URL_List'] = ${PLUGIN_URL_List};
	
	### <PLUGIN>_GIT																1
	if(dk_call dk_includes $PLUGIN['URL'] "https://github.com") {
		$PLUGIN['GIT'] = "1";
	} else {
		$PLUGIN['GIT'] = "0";
	}
	
	### <PLUGIN>_URL_Extension									.zip
	dk_call dk_getExtension $PLUGIN['URL_Filename'] PLUGIN_URL_Extension;
	$PLUGIN['URL_Extension'] = ${PLUGIN_URL_Extension};
		
	### <PLUGIN>_URL_File										master
	dk_call dk_removeExtension $PLUGIN['URL_Filename'] PLUGIN_URL_File;
	$PLUGIN['URL_File'] = ${PLUGIN_URL_File};
	
	### <PLUGIN>_URL_File_Lower									master
	dk_call dk_toLower $PLUGIN['URL_File'] PLUGIN_URL_File_Lower;
	$PLUGIN['URL_File_Lower'] = ${PLUGIN_URL_File_Lower};
	
	### <PLUGIN>_URL_Array										[0]https: [1]github.com [2]madler [3]zlib [4]archive [5]refs [6]heads [7]master.zip	
	dk_call dk_listToArray $PLUGIN['URL_List'] PLUGIN_URL_Array;
	$PLUGIN['URL_Array'] = ${PLUGIN_URL_Array};
	
	### <PLUGIN>_URL_Length										8
	dk_call dk_arrayLength PLUGIN_URL_Array PLUGIN_URL_Length;
	$PLUGIN['URL_Length'] = ${PLUGIN_URL_Length};
	
	### <PLUGIN>_IMPORT_Name_Lower												zlib
	dk_call dk_toLower $PLUGIN['IMPORT_Name'] PLUGIN_IMPORT_Name_Lower;
	$PLUGIN['IMPORT_Name_Lower'] = ${PLUGIN_IMPORT_Name_Lower};
	
	### <PLUGIN>_IMPORT_Name_Upper												ZLIB
	dk_call dk_toUpper $PLUGIN['IMPORT_Name'] PLUGIN_IMPORT_Name_Upper;
	$PLUGIN['IMPORT_Name_Upper'] = ${PLUGIN_IMPORT_Name_Upper};
	
	### PLUGIN_URL_Length														8	
	dk_call dk_arrayLength PLUGIN_URL_Array PLUGIN_URL_Length;
	$PLUGIN['URL_Array'] = ${PLUGIN_URL_Array};

	##############################################
	############ PLUGIN_GIT_Variables ############
	##############################################
	if($PLUGIN['GIT'] -eq 1){
		
		### PLUGIN_GIT_Filename													zlib
		dk_call dk_basename $PLUGIN['URL'];
		$PLUGIN['GIT_Filename'] = "${dk_basename}";
		
		### PLUGIN_GIT_Name														zlib
		dk_call dk_arrayAt $PLUGIN['URL_Array'] 3;
		$PLUGIN['GIT_Name'] = ${dk_arrayAt};
		
		### PLUGIN_GIT_Name_Lower												zlib
		dk_call dk_toLower $PLUGIN['GIT_Name'] PLUGIN_GIT_Name_Lower;
		$PLUGIN['GIT_Name_Lower'] = ${PLUGIN_GIT_Name_Lower};
		
		### PLUGIN_GIT_Branch													master
		if(${BRANCH}) {
			$PLUGIN['GIT_Branch'] = ${BRANCH};
		} else {
			#dk_call dk_getGitBranchName ${PLUGIN_URL} PLUGIN_GIT_Branch 					
			$PLUGIN['GIT_Branch'] = "master";
		}  
		
		### PLUGIN_GIT_Tag														TODO
		if(${TAG}) {
			$PLUGIN['GIT_Tag'] = ${TAG};
		} else {
			$PLUGIN['GIT_Tag'] = "";
		}
	}

	##################################################
	############ PLUGIN_INSTALL_Variables ############
	##################################################
	
	### PLUGIN_INSTALL_Name														zlib
	if( ${IMPORT_Name} ) {
		$PLUGIN['INSTALL_Name'] = ${IMPORT_Name};
	} elseif( $PLUGIN['IMPORT_Name'] ) {
		$PLUGIN['INSTALL_Name'] = $PLUGIN['IMPORT_Name'];
	} elseif( $PLUGIN['GIT_Name'] ) {
		$PLUGIN['INSTALL_Name'] = $PLUGIN['GIT_Name'];
	} elseif( $PLUGIN['URL_Name'] ) { 
		$PLUGIN['INSTALL_Name'] = $PLUGIN['URL_Name'];
	} else {
		dk_call dk_error "ERROR: setting PLUGIN['INSTALL_Name']";
	}
	# dk_call dk_convertToCIdentifier $PLUGIN['INSTALL_Name'] PLUGIN_INSTALL_Name;

	### PLUGIN_INSTALL_Version													master
	if(${VERSION}) { 
		$PLUGIN['INSTALL_Version'] = ${VERSION};
	} elseif( $PLUGIN['URL_File_Lower'] -AND $PLUGIN['IMPORT_Name_Lower'] ) {
		# deduce the plugin version		
		dk_call dk_replaceAll $PLUGIN['URL_File_Lower'] $PLUGIN['IMPORT_Name_Lower'] "" PLUGIN_INSTALL_Version;
		$PLUGIN['INSTALL_Version'] = ${PLUGIN_INSTALL_Version};
		if( $PLUGIN['URL_File_Lower'] -eq $PLUGIN['IMPORT_Name_Lower'] ){
			if( $PLUGIN['GIT_Tag'] ) {
				$PLUGIN['INSTALL_Version'] = $PLUGIN['GIT_Tag'];
			} elseif( $PLUGIN['GIT_Branch'] ){
				$PLUGIN['INSTALL_Version'] = $PLUGIN['GIT_Branch'];
			} else {
				$PLUGIN['INSTALL_Version'] = "master";
			}
		}  
	} else {
		dk_call dk_error "ERROR: setting PLUGIN['INSTALL_Version']";
	}

#		dk_call dk_validate PLUGIN_INSTALL_Version "dk_call dk_PLUGIN_INSTALL_Version";
#		string FIND ${PLUGIN_INSTALL_Version} - index;
#		if [ ${index} -eq 0 ]; then
#			string SUBSTRING ${PLUGIN_INSTALL_Version} 1 -1 PLUGIN_INSTALL_Version;
#		fi  
#		string FIND ${PLUGIN_INSTALL_Version} _ index;
#		if [ ${index} -eq 0 ]; then
#			string SUBSTRING ${PLUGIN_INSTALL_Version} 1 -1 PLUGIN_INSTALL_Version;
#		fi  
#	} 

	### PLUGIN_INSTALL_Folder													zlib-master
	if(${FOLDER}) {
		$PLUGIN['INSTALL_Folder'] = ${FOLDER};
	} elseif( $PLUGIN['INSTALL_Name'] -AND $PLUGIN['INSTALL_Version'] ) {
		$PLUGIN['INSTALL_Folder'] = "$($PLUGIN['INSTALL_Name'])-$($PLUGIN['INSTALL_Version'])";
	} elseif( $PLUGIN['INSTALL_Name'] ) {	
		$PLUGIN['INSTALL_Folder'] = $PLUGIN['INSTALL_Name'];
	} else {
		dk_call dk_error "ERROR: setting PLUGIN['INSTALL_Folder']";
	}

	### PLUGIN_INSTALL_Root														C:/Users/Administrator/DigitalKnob/Development/3rdParty
	if(${ROOT}) { 
		$PLUGIN['INSTALL_Root'] = ${ROOT};
	} else {
		dk_call dk_validate env:DK3RDPARTY_DIR "dk_call dk_DK3RDPARTY_DIR";
		$PLUGIN['INSTALL_Root'] = ${env:DK3RDPARTY_DIR};
	}

	### PLUGIN_INSTALL_Path														C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	if(${DIR}) { 
		$PLUGIN['INSTALL_Path'] = ${DIR};
	} else {
		$PLUGIN['INSTALL_Path'] = "$($PLUGIN['INSTALL_Root'])/$($PLUGIN['INSTALL_Folder'])";
	} 


	##############################################
	############# <PLUGIN>_Variables #############
	##############################################

	if($PLUGIN['IMPORT_Name_Lower'] -AND $PLUGIN['GIT_Name_Lower']) {
		if(!($PLUGIN['IMPORT_Name_Lower'] -eq $PLUGIN['GIT_Name_Lower'])) {
			dk_call dk_warning "PLUGIN['IMPORT_Name_Lower']:$($PLUGIN['IMPORT_Name_Lower']) and PLUGIN['GIT_Name_Lower']:$($PLUGIN['GIT_Name_Lower']) do not match";
		}
	}	
	
	### <PLUGIN>_Dir												C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	if(!("${PLUGIN}" -eq "GIT")) {	### DO NOT USE GIT_DIR ###
		$PLUGIN['Dir'] = $PLUGIN['INSTALL_Path'];
	}
	
	### <PLUGIN>_Url												https://github.com/madler/zlib/archive/refs/heads/master.zip
	$PLUGIN['Url'] = $PLUGIN['URL'];
	
	### <PLUGIN>_Import_File										master.zip
	$PLUGIN['Import_File'] = $PLUGIN['URL_Filename'];

	### <PLUGIN>_Version											master
	$PLUGIN['Version'] = $PLUGIN['INSTALL_Version'];

	### <PLUGIN>_Folder												zlib-master
	$PLUGIN['Folder'] = $PLUGIN['INSTALL_Folder'];

	### <PLUGIN>_Import_Name										zlib
	$PLUGIN['Import_Name'] = $PLUGIN['IMPORT_Name_Lower'];
		
	### <PLUGIN>_Branch												master
	$PLUGIN['Branch'] = $PLUGIN['GIT_Branch'];
	
	### <PLUGIN>_Tag												v1.2
	$PLUGIN['Tag'] = $PLUGIN['GIT_Tag'];

		
	#####################################################
	############# TARGET <PLUGIN>_Variables #############
	#####################################################

	### <PLUGIN>_Tuple_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang
	$PLUGIN['Tuple_Dir'] = "$($PLUGIN['INSTALL_Path'])/${Target_Tuple}";
	
	### <PLUGIN>_Config_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	$PLUGIN['Config_Dir'] = "$($PLUGIN['INSTALL_Path'])/${Config_Path}";
	
	### <PLUGIN>_Build_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	$PLUGIN['Build_Dir'] = "$($PLUGIN['INSTALL_Path'])/${Build_Path}";
	
	### <PLUGIN>_Debug_Dir											C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	$PLUGIN['Debug_Dir'] = "$($PLUGIN['INSTALL_Path'])/${Target_Tuple}/${Debug_Dir}";
	
	### <PLUGIN>_Release_Dir										C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Release
	$PLUGIN['Release_Dir'] = "$($PLUGIN['INSTALL_Path'])/${Target_Tuple}/${Release_Dir}";

}











###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
	#dk_call dk_validate DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR"
	dk_call dk_DKIMPORTS_DIR;
	dk_call dk_DKTOOLS_DIR;
	dk_call dk_chdir "${env:DKIMPORTS_DIR}/git";
	dk_call dk_importVariables "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe" IMPORT_Name git ROOT "${env:DKTOOLS_DIR}";
	dk_call dk_echo;
	dk_call dk_echo "BRANCH                      = '${BRANCH}'";
	dk_call dk_echo "DIR                         = '${DIR}'";
	dk_call dk_echo "FOLDER                      = '${FOLDER}'";
	dk_call dk_echo "ROOT                        = '${ROOT}'";
	dk_call dk_echo "TAG                         = '${TAG}'";
	dk_call dk_echo "VERSION                     = '${VERSION}'";
	dk_call dk_echo "IMPORT_Name                 = '${IMPORT_Name}'";
	dk_call dk_echo "IMPORT_Path                 = '${IMPORT_Path}'";
	dk_call dk_echo "";
	dk_call dk_echo "PLUGIN['NAME']              = '$($PLUGIN['NAME'])'";
	dk_call dk_echo "PLUGIN['ARGS']              = '$($PLUGIN['ARGS'])'";
	dk_call dk_echo "PLUGIN['GIT']               = '$($PLUGIN['GIT'])'";
	dk_call dk_echo "PLUGIN['GIT_Branch']        = '$($PLUGIN['GIT_Branch'])'";
	dk_call dk_echo "PLUGIN['GIT_Filename']      = '$($PLUGIN['GIT_Filename'])'";
	dk_call dk_echo "PLUGIN['GIT_Name']          = '$($PLUGIN['GIT_Name'])'";
	dk_call dk_echo "PLUGIN['GIT_Lower']         = '$($PLUGIN['GIT_Lower'])'";
	dk_call dk_echo "PLUGIN['GIT_Tag']           = '$($PLUGIN['GIT_Tag'])'";
	dk_call dk_echo "PLUGIN['IMPORT']            = '$($PLUGIN['IMPORT'])'";
	dk_call dk_echo "PLUGIN['IMPORT_Name']       = '$($PLUGIN['IMPORT_Name'])'";
	dk_call dk_echo "PLUGIN['IMPORT_Name_Lower'] = '$($PLUGIN['IMPORT_Name_Lower'])'";
	dk_call dk_echo "PLUGIN['IMPORT_Name_Upper'] = '$($PLUGIN['IMPORT_Name_Upper'])'";
	dk_call dk_echo "PLUGIN['IMPORT_Path']       = '$($PLUGIN['IMPORT_Path'])'";
	dk_call dk_echo "PLUGIN['INSTALL_Folder']    = '$($PLUGIN['INSTALL_Folder'])'";
	dk_call dk_echo "PLUGIN['INSTALL_Name']      = '$($PLUGIN['INSTALL_Name'])'";
	dk_call dk_echo "PLUGIN['INSTALL_Path']      = '$($PLUGIN['INSTALL_Path'])'";
	dk_call dk_echo "PLUGIN['INSTALL_Root']      = '$($PLUGIN['INSTALL_Root'])'";
	dk_call dk_echo "PLUGIN['INSTALL_Version']   = '$($PLUGIN['INSTALL_Version'])'";
	dk_call dk_echo "PLUGIN['URL']               = '$($PLUGIN['URL'])'";
	dk_call dk_echo "PLUGIN['URL_Array']         = '$($PLUGIN['URL_Array'])'";
	dk_call dk_echo "PLUGIN['URL_Extension']     = '$($PLUGIN['URL_Extension'])'";
	dk_call dk_echo "PLUGIN['URL_File']          = '$($PLUGIN['URL_File'])'";
	dk_call dk_echo "PLUGIN['URL_Filename']      = '$($PLUGIN['URL_Filename'])'";
	dk_call dk_echo "PLUGIN['URL_Length']        = '$($PLUGIN['URL_Length'])'";
	dk_call dk_echo "PLUGIN['URL_List']          = '$($PLUGIN['URL_List'])'";
	dk_call dk_echo "PLUGIN['Branch']            = '$($PLUGIN['Branch'])'";
	dk_call dk_echo "PLUGIN['Build_Dir']         = '$($PLUGIN['Build_Dir'])'";
	dk_call dk_echo "PLUGIN['Config_Dir']        = '$($PLUGIN['Config_Dir'])'";
	dk_call dk_echo "PLUGIN['Debug_Dir']         = '$($PLUGIN['Debug_Dir'])'";
	dk_call dk_echo "PLUGIN['Dir']               = '$($PLUGIN['Dir'])'";
	dk_call dk_echo "PLUGIN['Folder']            = '$($PLUGIN['Folder'])'";
	dk_call dk_echo "PLUGIN['Import_File']       = '$($PLUGIN['Import_File'])'";
	dk_call dk_echo "PLUGIN['Import_Name']       = '$($PLUGIN['Import_Name'])'";
	dk_call dk_echo "PLUGIN['Release_Dir']       = '$($PLUGIN['Release_Dir'])'";
	dk_call dk_echo "PLUGIN['Tag']               = '$($PLUGIN['Tag'])'";
	dk_call dk_echo "PLUGIN['Tuple_Dir']         = '$($PLUGIN['Tuple_Dir'])'";
	dk_call dk_echo "PLUGIN['Url']               = '$($PLUGIN['Url'])'";
	dk_call dk_echo "PLUGIN['Version']           = '$($PLUGIN['Version'])'";
	dk_call dk_echo "GIT['ARGS']                 = '$($GIT['ARGS'])'";
	
	dk_call dk_chdir "${env:DKIMPORTS_DIR}/php-src";
	dk_call dk_importVariables "https://windows.php.net/downloads/releases/php-8.4.11-Win32-vs17-x64.zip";
	dk_call dk_echo;
	dk_call dk_echo "BRANCH                      = '${BRANCH}'";
	dk_call dk_echo "DIR                         = '${DIR}'";
	dk_call dk_echo "FOLDER                      = '${FOLDER}'";
	dk_call dk_echo "ROOT                        = '${ROOT}'";
	dk_call dk_echo "TAG                         = '${TAG}'";
	dk_call dk_echo "VERSION                     = '${VERSION}'";
	dk_call dk_echo "IMPORT_Name                 = '${IMPORT_Name}'";
	dk_call dk_echo "IMPORT_Path                 = '${IMPORT_Path}'";
	dk_call dk_echo "";
	dk_call dk_echo "PLUGIN['NAME']              = '$($PLUGIN['NAME'])'";
	dk_call dk_echo "PLUGIN['ARGS']              = '$($PLUGIN['ARGS'])'";
	dk_call dk_echo "PLUGIN['GIT']               = '$($PLUGIN['GIT'])'";
	dk_call dk_echo "PLUGIN['GIT_Branch']        = '$($PLUGIN['GIT_Branch'])'";
	dk_call dk_echo "PLUGIN['GIT_Filename']      = '$($PLUGIN['GIT_Filename'])'";
	dk_call dk_echo "PLUGIN['GIT_Name']          = '$($PLUGIN['GIT_Name'])'";
	dk_call dk_echo "PLUGIN['GIT_Lower']         = '$($PLUGIN['GIT_Lower'])'";
	dk_call dk_echo "PLUGIN['GIT_Tag']           = '$($PLUGIN['GIT_Tag'])'";
	dk_call dk_echo "PLUGIN['IMPORT']            = '$($PLUGIN['IMPORT'])'";
	dk_call dk_echo "PLUGIN['IMPORT_Name']       = '$($PLUGIN['IMPORT_Name'])'";
	dk_call dk_echo "PLUGIN['IMPORT_Name_Lower'] = '$($PLUGIN['IMPORT_Name_Lower'])'";
	dk_call dk_echo "PLUGIN['IMPORT_Name_Upper'] = '$($PLUGIN['IMPORT_Name_Upper'])'";
	dk_call dk_echo "PLUGIN['IMPORT_Path']       = '$($PLUGIN['IMPORT_Path'])'";
	dk_call dk_echo "PLUGIN['INSTALL_Folder']    = '$($PLUGIN['INSTALL_Folder'])'";
	dk_call dk_echo "PLUGIN['INSTALL_Name']      = '$($PLUGIN['INSTALL_Name'])'";
	dk_call dk_echo "PLUGIN['INSTALL_Path']      = '$($PLUGIN['INSTALL_Path'])'";
	dk_call dk_echo "PLUGIN['INSTALL_Root']      = '$($PLUGIN['INSTALL_Root'])'";
	dk_call dk_echo "PLUGIN['INSTALL_Version']   = '$($PLUGIN['INSTALL_Version'])'";
	dk_call dk_echo "PLUGIN['URL']               = '$($PLUGIN['URL'])'";
	dk_call dk_echo "PLUGIN['URL_Array']         = '$($PLUGIN['URL_Array'])'";
	dk_call dk_echo "PLUGIN['URL_Extension']     = '$($PLUGIN['URL_Extension'])'";
	dk_call dk_echo "PLUGIN['URL_File']          = '$($PLUGIN['URL_File'])'";
	dk_call dk_echo "PLUGIN['URL_Filename']      = '$($PLUGIN['URL_Filename'])'";
	dk_call dk_echo "PLUGIN['URL_Length']        = '$($PLUGIN['URL_Length'])'";
	dk_call dk_echo "PLUGIN['URL_List']          = '$($PLUGIN['URL_List'])'";
	dk_call dk_echo "PLUGIN['Branch']            = '$($PLUGIN['Branch'])'";
	dk_call dk_echo "PLUGIN['Build_Dir']         = '$($PLUGIN['Build_Dir'])'";
	dk_call dk_echo "PLUGIN['Config_Dir']        = '$($PLUGIN['Config_Dir'])'";
	dk_call dk_echo "PLUGIN['Debug_Dir']         = '$($PLUGIN['Debug_Dir'])'";
	dk_call dk_echo "PLUGIN['Dir']               = '$($PLUGIN['Dir'])'";
	dk_call dk_echo "PLUGIN['Folder']            = '$($PLUGIN['Folder'])'";
	dk_call dk_echo "PLUGIN['Import_File']       = '$($PLUGIN['Import_File'])'";
	dk_call dk_echo "PLUGIN['Import_Name']       = '$($PLUGIN['Import_Name'])'";
	dk_call dk_echo "PLUGIN['Release_Dir']       = '$($PLUGIN['Release_Dir'])'";
	dk_call dk_echo "PLUGIN['Tag']               = '$($PLUGIN['Tag'])'";
	dk_call dk_echo "PLUGIN['Tuple_Dir']         = '$($PLUGIN['Tuple_Dir'])'";
	dk_call dk_echo "PLUGIN['Url']               = '$($PLUGIN['Url'])'";
	dk_call dk_echo "PLUGIN['Version']           = '$($PLUGIN['Version'])'";
}
