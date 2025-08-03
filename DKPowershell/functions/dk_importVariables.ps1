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
	
	#														###### EXAMPLE ######
	### PLUGIN_ARGS											"https://github.com/madler/zlib/archive/refs/heads/master.zip"
	dk_call dk_unset PLUGIN_ARGS;
	${global:PLUGIN_ARGS} = ${args};
	# dk_call dk_printVar PLUGIN_ARGS;
	
	### PLUGIN_URL											https://github.com/madler/zlib/archive/refs/heads/master.zip
	dk_call dk_unset PLUGIN_URL;
	${global:PLUGIN_URL} = ${args}[0];
	# dk_call dk_printVar PLUGIN_URL;

	### IMPORT_Path											/c/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
	dk_call dk_unset IMPORT_Path;
	dk_call dk_getParameterValue IMPORT_Path @args;
	if(!(${IMPORT_Path})){
		dk_call dk_getcwd;
		${global:IMPORT_Path} = ${DKPWD}; 
	}
	# dk_call dk_printVar IMPORT_Path;
	
	### BRANCH											master
	dk_call dk_unset BRANCH;
	dk_call dk_getParameterValue BRANCH	@args;
	# dk_call dk_printVar BRANCH;
	
	### FOLDER												zlib-master
	dk_call dk_unset FOLDER;
	dk_call dk_getParameterValue FOLDER @args;
	# dk_call dk_printVar FOLDER;
	
	### IMPORT_Name												zlib
	dk_call dk_unset IMPORT_Name;
	dk_call dk_getParameterValue IMPORT_Name @args;
	# dk_call dk_printVar IMPORT_Name;
	
	### DIR													C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	dk_call dk_unset DIR;
	dk_call dk_getParameterValue DIR @args;
	# dk_call dk_printVar DIR;
	
	### ROOT												C:/Users/Administrator/DigitalKnob/Development/3rdParty
	dk_call dk_unset ROOT;
	dk_call dk_getParameterValue ROOT @args;
	# dk_call dk_printVar ROOT;
	
	### TAG													v1.3.1
	dk_call dk_unset TAG;
	dk_call dk_getParameterValue TAG @args;
	# dk_call dk_printVar TAG;
	
	### VERSION												master
	dk_call dk_unset VERSION;
	dk_call dk_getParameterValue VERSION @args;
	# dk_call dk_printVar VERSION;

	###### POPULATE VARIABLES ######
	# PLUGIN_URL				- from arg:url														: https://github.com/madler/zlib/archive/refs/heads/master.zip
	# PLUGIN_URL_List			- from PLUGIN_URL													: https:;github.com;madler;zlib;archive;refs;heads;master.zip
	# PLUGIN_URL_Length			- from PLUGIN_URL_List												: 8
	# PLUGIN_URL_Array n 		- from PLUGIN_URL_List												: [0]https: [1]github.com [2]madler [3]zlib [4]archive [5]refs [6]heads [7]master.zip
	# PLUGIN_URL_Filename   	- from PLUGIN_URL													: master.zip
	# PLUGIN_URL_Extension  	- from PLUGIN_URL_Filename											: .zip
	# PLUGIN_URL_File      		- from PLUGIN_URL_Filename											: master
	
	# PLUGIN_IMPORT				- from CMAKE_CURRENT_LIST_DIR										: 1
	# PLUGIN_IMPORT_Path		- from CMAKE_CURRENT_LIST_DIR										: C:/Users/Administrator/DigitalKnob/Development/3rdParty/_DKIMPORTS/zlib
	# PLUGIN_IMPORT_Name		- from PLUGIN_IMPORT_Path											: zlib
	
	# PLUGIN_GIT				- from PLUGIN_URL													: 1
	# PLUGIN_GIT_Filename		- from PLUGIN_URL													: zlib
	# PLUGIN_GIT_Name			- from PLUGIN_GIT_Filename											: zlib
	# PLUGIN_GIT_Branch			- from default:master OR arg:BRANCH									: master
	# PLUGIN_GIT_Tag			- from default: OR arg:TAG
	
	# PLUGIN_INSTALL_Name		- from PLUGIN_IMPORT_Name, 	PLUGIN_GIT_Name 		OR PLUGIN_URL_Name	: zlib
	# PLUGIN_INSTALL_Version	- from PLUGIN_URL_File,		PLUGIN_IMPORT_Name							: master
	# PLUGIN_INSTALL_Folder    	- from PLUGIN_INSTALL_Name,	PLUGIN_INSTALL_Version						: zlib-master
	# PLUGIN_INSTALL_Root		- from default:DK3RDPARTY 							OR arg:ROOT			: C:/Users/Administrator/DigitalKnob/Development/3rdParty
	# PLUGIN_INSTALL_Path		- from PLUGIN_INSTALL_Root and PLUGIN_INSTALL_Folder					: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	
	# PLUGIN					- from PLUGIN_IMPORT_Name						:ZLIB   				: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	# <PLUGIN>					- from <PLUGIN>									:ZLIB					: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	# <PLUGIN>_Dir				- from PLUGIN_INSTALL_Path						:ZLIB_Dir				: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	# <PLUGIN>_Url				- from PLUGIN_URL								:ZLIB_Url				: https://github.com/madler/zlib/archive/refs/heads/master.zip
	# <PLUGIN>_Import_File		- from PLUGIN_URL_Filename						:ZLIB_Import_File		: master.zip
	# <PLUGIN>_Version        	- from PLUGIN_INSTALL_Version					:ZLIB_Version			: master
	# <PLUGIN>_Folder			- from PLUGIN_INSTALL_Folder					:ZLIB_Folder			: zlib-master
	# <PLUGIN>_Import_Name		- from PLUGIN_IMPORT_Name						:ZLIB_Import_Name		: zlib
	# <PLUGIN>_Branch			- from PLUGIN_GIT_Branch						:ZLIB_Branch			: master
	# <PLUGIN>_Tag				- from PLUGIN_GIT_Tag							:ZLIB_Tag				: 
	# <PLUGIN>_Tuple_Dir		- from PLUGIN_INSTALL_Path and Target_Tuple		:ZLIB_Tuple_Dir			: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang
	# <PLUGIN>_Config_Dir		- from PLUGIN_INSTALL_Path and Config_Dir		:ZLIB_Config_Dir		: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	# <PLUGIN>_Build_Dir		- from PLUGIN_INSTALL_Path and Build_Dir		:ZLIB_Build_Dir			: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	# <PLUGIN>_Debug_Dir		- from PLUGIN_INSTALL_Path and Debug_Dir		:ZLIB_Debug_Dir			: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
	# <PLUGIN>_Release_Dir		- from PLUGIN_INSTALL_Path and Release_Dir		:ZLIB_Release_Dir		: C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Release
		
		
	##############################################
	############ PLUGIN_URL_Variables ############
	##############################################
	
	### PLUGIN_URL_Filename														master.zip
#	dk_call dk_validate PLUGIN_URL "dk_call dk_PLUGIN_URL";
	dk_call dk_basename "${PLUGIN_URL}" PLUGIN_URL_Filename;					
	# dk_call dk_printVar PLUGIN_URL_Filename;

	### PLUGIN_URL_List															https:;github.com;madler;zlib;archive;refs;heads;master.zip
#	dk_call dk_validate PLUGIN_URL "dk_call dk_PLUGIN_URL";
	dk_call dk_replaceAll "${PLUGIN_URL}" "/" ";" PLUGIN_URL_List;
	dk_call dk_replaceAll "${PLUGIN_URL_List}" ";;" ";" PLUGIN_URL_List;
	# dk_call dk_printVar PLUGIN_URL_List;

	### PLUGIN_GIT																1
#	dk_call dk_validate PLUGIN_URL "dk_call dk_PLUGIN_URL";
	if(dk_call dk_includes "${PLUGIN_URL}" "https://github.com") {
		${global:PLUGIN_GIT}="1";
	} else {
		${global:PLUGIN_GIT}="0";
	}
	# dk_call dk_printVar PLUGIN_GIT;
		
	### PLUGIN_URL_Extension													.zip
#	dk_call dk_validate PLUGIN_URL_Filename "dk_call dk_PLUGIN_URL_Filename";
	dk_call dk_getExtension "${PLUGIN_URL_Filename}" PLUGIN_URL_Extension;		
	# dk_call dk_printVar PLUGIN_URL_Extension;

	### PLUGIN_URL_File															master
#	dk_call dk_validate PLUGIN_URL_Filename "dk_call dk_PLUGIN_URL_Filename";	
	dk_call dk_removeExtension "${PLUGIN_URL_Filename}" PLUGIN_URL_File			
	# dk_call dk_printVar PLUGIN_URL_File;
	
	### PLUGIN_URL_File_LOWER															master
#	dk_call dk_validate PLUGIN_URL_File "dk_call dk_PLUGIN_URL_File";	
	dk_call dk_toLower "${PLUGIN_URL_File}" PLUGIN_URL_File_LOWER			
	# dk_call dk_printVar PLUGIN_URL_File_LOWER;

	### PLUGIN_URL_Array														[0]https: [1]github.com [2]madler [3]zlib [4]archive [5]refs [6]heads [7]master.zip
#	dk_call dk_validate PLUGIN_URL_List "dk_call dk_PLUGIN_URL_List";		
	dk_call dk_listToArray "${PLUGIN_URL_List}" PLUGIN_URL_Array
	# dk_call dk_printVar PLUGIN_URL_Array;
	
	### PLUGIN_URL_Length														8
#	dk_call dk_validate PLUGIN_URL_Array "dk_call dk_PLUGIN_URL_Array";		
	dk_call dk_arrayLength PLUGIN_URL_Array PLUGIN_URL_Length;
	# dk_call dk_printVar PLUGIN_URL_Length;


	
	#######################################################
	############### PLUGIN_IMPORT_Variables ###############
	#######################################################
	
	### PLUGIN_IMPORT															1
	dk_call dk_validate env:DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR";
	if(dk_call dk_includes "${IMPORT_Path}" "${DKIMPORTS_DIR}"){ 
		${global:PLUGIN_IMPORT}="1"; 
	} else {
		${global:PLUGIN_IMPORT}="0"; 
	}
	# dk_call dk_printVar PLUGIN_IMPORT;
	
	### PLUGIN_IMPORT_Path														C:\Users\Administrator\DigitalKnob\Development\3rdParty\_DKIMPORTS\zlib
	${global:PLUGIN_IMPORT_Path} = "${IMPORT_Path}";					
	# dk_call dk_printVar PLUGIN_IMPORT_Path;

	### PLUGIN_IMPORT_Name														zlib
	if(${IMPORT_Name}){
		${global:PLUGIN_IMPORT_Name}="${IMPORT_Name}";
	} else {
#		dk_call dk_validate PLUGIN_IMPORT_Path "dk_call dk_PLUGIN_IMPORT_Path";	
		dk_call dk_basename "${PLUGIN_IMPORT_Path}" PLUGIN_IMPORT_Name;
	}	
	# dk_call dk_printVar PLUGIN_IMPORT_Name;

	### PLUGIN_IMPORT_Name_Lower												zlib
#	dk_call dk_validate PLUGIN_IMPORT_Name "dk_call dk_PLUGIN_IMPORT_Name";	
	dk_call dk_toLower "${PLUGIN_IMPORT_Name}" PLUGIN_IMPORT_Name_Lower
	# dk_call dk_printVar PLUGIN_IMPORT_Name_Lower;			         	
	
	### PLUGIN_IMPORT_Name_Upper ###											ZLIB
#	dk_call dk_validate PLUGIN_IMPORT_Name "dk_call dk_PLUGIN_IMPORT_Name";	
	dk_call dk_toUpper "${PLUGIN_IMPORT_Name}" PLUGIN_IMPORT_Name_Upper
	# dk_call dk_printVar PLUGIN_IMPORT_Name_Upper;
	
	
	##############################################
	############# <PLUGIN>_Variables #############
	##############################################
	### PLUGIN																	ZLIB
#	dk_call dk_validate PLUGIN_IMPORT_Name_Upper "dk_call dk_PLUGIN_IMPORT_Name_Upper";
	${global:PLUGIN}="${PLUGIN_IMPORT_Name_Upper}";
#	dk_call dk_convertToCIdentifier ${PLUGIN} PLUGIN;
#	if(!("${PLUGIN}" -eq "${PLUGIN_IMPORT_Name_Upper}")) { 
#		dk_call dk_notice "'${PLUGIN_IMPORT_Name_Upper}' contains non-alphanumeric characters and was changed to '${PLUGIN}'";
#	}  
	# dk_call dk_printVar PLUGIN;		

	##############################################
	############ PLUGIN_GIT_Variables ############
	##############################################
	Set-Variable -Name ${PLUGIN}_GIT -Value ${PLUGIN_GIT} -Scope Global;
	Write-Host "${PLUGIN}_GIT = $(gv "${PLUGIN}_GIT" -ValueOnly)";
	
	if($(gv "${PLUGIN}_GIT" -ValueOnly) -eq 1){
#	if(${PLUGIN_GIT} -eq 1) { 
		### PLUGIN_GIT_Filename													zlib
#		dk_call dk_validate PLUGIN_URL_Array "dk_call dk_PLUGIN_URL_Array";		
		dk_call dk_arrayAt PLUGIN_URL_Array 3;		
		${global:PLUGIN_GIT_Filename}="${dk_arrayAt}";
		# dk_call dk_printVar PLUGIN_GIT_Filename;
		
		### PLUGIN_GIT_Name														zlib
#		dk_call dk_validate PLUGIN_GIT_Filename "dk_call dk_PLUGIN_GIT_Filename";
		dk_call dk_replaceAll "${PLUGIN_GIT_Filename}" ".git" "" PLUGIN_GIT_Name
		dk_call dk_replaceAll "$(gv "${PLUGIN}_GIT_Filename" -ValueOnly)" ".git" "" PLUGIN_GIT_Name		
		# dk_call dk_printVar PLUGIN_GIT_Name;
		
		### PLUGIN_GIT_Name_Lower												zlib
#		dk_call dk_validate PLUGIN_GIT_Name "dk_call dk_PLUGIN_GIT_Name";
		dk_call dk_toLower "${PLUGIN_GIT_Name}" PLUGIN_GIT_Name_Lower;
		dk_call dk_toLower "$(gv "${PLUGIN}_GIT_Name" -ValueOnly)" PLUGIN_GIT_Name_Lower;
		# dk_call dk_printVar PLUGIN_GIT_Name_Lower;
		
		### PLUGIN_GIT_Branch														master
		if(${BRANCH}) {
			${global:PLUGIN_GIT_Branch}="${BRANCH}";
		} else {
#			dk_call dk_validate PLUGIN_URL "dk_call dk_PLUGIN_URL";
			#dk_call dk_getGitBranchName ${PLUGIN_URL} PLUGIN_GIT_Branch 					
			${global:PLUGIN_GIT_Branch}="master";
		}  
		# dk_call dk_printVar PLUGIN_GIT_Branch;
		
		### PLUGIN_GIT_Tag														TODO
		if(${TAG}) {
			${global:PLUGIN_GIT_Tag}="${TAG}";
		} else {
			${global:PLUGIN_GIT_Tag}="";
		}
		# dk_call dk_printVar PLUGIN_GIT_Tag;
	}

	##################################################
	############ PLUGIN_INSTALL_Variables ############
	##################################################
	
	### PLUGIN_INSTALL_Name														zlib
	if(${IMPORT_Name}) {
		${global:PLUGIN_INSTALL_Name}="${IMPORT_Name}";
	} elseif(${PLUGIN_IMPORT_Name}) {
#		dk_call dk_validate PLUGIN_IMPORT_Name "dk_call dk_PLUGIN_IMPORT_Name";
		${global:PLUGIN_INSTALL_Name}="${PLUGIN_IMPORT_Name}";
	} elseif(${PLUGIN_GIT_Name}) {
#		dk_call dk_validate PLUGIN_GIT_Name "dk_call dk_PLUGIN_GIT_Name";
		${global:PLUGIN_INSTALL_Name}="${PLUGIN_GIT_Name}";
	} elseif(${PLUGIN_URL_Name}) { 
#		dk_call dk_validate PLUGIN_URL_Name "dk_call dk_PLUGIN_URL_Name";
		${global:PLUGIN_INSTALL_Name}="${PLUGIN_URL_Name}";					
	} else {
		dk_call dk_error "ERROR: setting PLUGIN_INSTALL_Name";
	}
#	dk_call dk_validate PLUGIN_INSTALL_Name "dk_call dk_PLUGIN_INSTALL_Name";	
	#dk_call dk_convertToCIdentifier "${PLUGIN_INSTALL_Name}" PLUGIN_INSTALL_Name
	# dk_call dk_printVar PLUGIN_INSTALL_Name;

	### PLUGIN_INSTALL_Version													master
	if(${VERSION}) { 
		${global:PLUGIN_INSTALL_Version}="${VERSION}";
	} elseif(${PLUGIN_URL_File_LOWER} -AND ${PLUGIN_IMPORT_Name_Lower}) {
		# deduce the plugin version		
#		dk_call dk_validate PLUGIN_URL_File_LOWER "dk_call dk_PLUGIN_URL_File_LOWER";
#		dk_call dk_validate PLUGIN_IMPORT_Name_Lower "dk_call dk_PLUGIN_IMPORT_Name_Lower";
		dk_call dk_replaceAll "${PLUGIN_URL_File_LOWER}" "${PLUGIN_IMPORT_Name_Lower}" "" PLUGIN_INSTALL_Version; 	
		if("${PLUGIN_URL_File_LOWER}" -eq "${PLUGIN_IMPORT_Name_Lower}"){
			if(${PLUGIN_GIT_Tag}) {
#				dk_call dk_validate PLUGIN_GIT_Tag "dk_call dk_PLUGIN_GIT_Tag";
				#${global:PLUGIN_INSTALL_Version}="${PLUGIN_GIT_Tag}";
				Set-Variable -Name ${PLUGIN}_INSTALL_Version -Value "${PLUGIN_GIT_Tag}" -Scope Global;
			} elseif(${PLUGIN_GIT_Branch}){
#				dk_call dk_validate PLUGIN_GIT_Branch "dk_call dk_PLUGIN_GIT_Branch";
				#${global:PLUGIN_INSTALL_Version}="${PLUGIN_GIT_Branch}";
				Set-Variable -Name ${PLUGIN}_INSTALL_Version -Value "${PLUGIN_GIT_Branch}" -Scope Global;
			} else {
				#${global:PLUGIN_INSTALL_Version}="master";
				Set-Variable -Name ${PLUGIN}_INSTALL_Version -Value "master" -Scope Global;
			}
		}  
	} else {
		dk_call dk_error "ERROR: setting PLUGIN_INSTALL_Version";
	}
	
#		dk_call dk_validate PLUGIN_INSTALL_Version "dk_call dk_PLUGIN_INSTALL_Version";
#		string FIND ${PLUGIN_INSTALL_Version} - index 
#		if [ ${index} -eq 0 ]; then
#			string SUBSTRING ${PLUGIN_INSTALL_Version} 1 -1 PLUGIN_INSTALL_Version 
#		fi  
#		string FIND ${PLUGIN_INSTALL_Version} _ index 
#		if [ ${index} -eq 0 ]; then
#			string SUBSTRING ${PLUGIN_INSTALL_Version} 1 -1 PLUGIN_INSTALL_Version 
#		fi  
#	} 
	# dk_call dk_printVar PLUGIN_INSTALL_Version;

	### PLUGIN_INSTALL_Folder													zlib-master
	if(${FOLDER}) {
#		${global:PLUGIN_INSTALL_Folder}="${FOLDER}";
		Set-Variable -Name ${PLUGIN}_INSTALL_Folder -Value "${FOLDER}" -Scope Global;
	} elseif(${PLUGIN_INSTALL_Name} -AND ${PLUGIN_INSTALL_Version}) {
#		dk_call dk_validate PLUGIN_INSTALL_Name "dk_call dk_PLUGIN_INSTALL_Name";
#		dk_call dk_validate PLUGIN_INSTALL_Version "dk_call dk_PLUGIN_INSTALL_Version";
#		${global:PLUGIN_INSTALL_Folder}="${PLUGIN_INSTALL_Name}-${PLUGIN_INSTALL_Version}";
		Set-Variable -Name ${PLUGIN}_INSTALL_Folder -Value "$(gv ${PLUGIN}_INSTALL_Name -ValueOnly)-$(gv ${PLUGIN}_INSTALL_Version -ValueOnly)" -Scope Global;
	} elseif(${PLUGIN_INSTALL_Name}) {
#		dk_call dk_validate PLUGIN_INSTALL_Name "dk_call dk_PLUGIN_INSTALL_Name";
#		${global:PLUGIN_INSTALL_Folder}="${PLUGIN_INSTALL_Name}";
#		Set-Variable -Name ${PLUGIN}_INSTALL_Folder -Value "${PLUGIN_INSTALL_Name}" -Scope Global;
		Set-Variable -Name ${PLUGIN}_INSTALL_Folder -Value $(gv "${PLUGIN}_INSTALL_Name" -ValueOnly) -Scope Global;
	} else {
#		dk_call dk_validate PLUGIN_INSTALL_Folder "dk_call dk_PLUGIN_INSTALL_Folder";
		dk_call dk_error "ERROR: setting PLUGIN_INSTALL_Folder";
	}
	# dk_call dk_printVar PLUGIN_INSTALL_Folder;

	# PLUGIN_INSTALL_Root														C:/Users/Administrator/DigitalKnob/Development/3rdParty
	if(${ROOT}) { 
		#${global:PLUGIN_INSTALL_Root}="${ROOT}";
		Set-Variable -Name ${PLUGIN}_INSTALL_Root -Value "${ROOT}" -Scope Global;
	} else {
		dk_call dk_validate env:DK3RDPARTY_DIR "dk_call dk_DK3RDPARTY_DIR"; 
		#${global:PLUGIN_INSTALL_Root}="${env:DK3RDPARTY_DIR}";
		Set-Variable -Name ${PLUGIN}_INSTALL_Root -Value "${env:DK3RDPARTY_DIR}" -Scope Global;
	}
	# dk_call dk_printVar PLUGIN_INSTALL_Root;

	# PLUGIN_INSTALL_Path														C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	if(${DIR}) { 
		#${global:PLUGIN_INSTALL_Path}="${DIR}";
		Set-Variable -Name ${PLUGIN}_INSTALL_Path -Value ${DIR} -Scope Global;
	} else {
#		dk_call dk_validate PLUGIN_INSTALL_Root "dk_call dk_PLUGIN_INSTALL_Root";
#		dk_call dk_validate PLUGIN_INSTALL_Folder "dk_call dk_PLUGIN_INSTALL_Folder";
#		${global:PLUGIN_INSTALL_Path}="${PLUGIN_INSTALL_Root}/${PLUGIN_INSTALL_Folder}";	
#		Set-Variable -Name ${PLUGIN}_INSTALL_Path -Value "${PLUGIN_INSTALL_Root}/${PLUGIN_INSTALL_Folder}" -Scope Global;
		Set-Variable -Name ${PLUGIN}_INSTALL_Path -Value "$(gv ${PLUGIN}_INSTALL_Root -ValueOnly)/$(gv ${PLUGIN}_INSTALL_Folder -ValueOnly)" -Scope Global;
	} 
	# dk_call dk_printVar PLUGIN_INSTALL_Path;

	
	

	##############################################
	############# <PLUGIN>_Variables #############
	##############################################

#	dk_call dk_validate PLUGIN_IMPORT_Name_Lower "dk_call dk_PLUGIN_IMPORT_Name_Lower";
#	dk_call dk_validate PLUGIN_GIT_Name_Lower "dk_call dk_PLUGIN_GIT_Name_Lower";
	#if(${PLUGIN_IMPORT_Name_Lower} -AND ${PLUGIN_GIT_Name_Lower}) {
	if($(gv "${PLUGIN}_IMPORT_Name_Lower" -ValueOnly) -AND $(gv "${PLUGIN}_GIT_Name_Lower" -ValueOnly)) {
		#if(!(${PLUGIN_IMPORT_Name_Lower} -eq ${PLUGIN_GIT_Name_Lower})) {
		if(!($(gv "${PLUGIN}_IMPORT_Name_Lower" -ValueOnly) -eq $(gv "${PLUGIN}_GIT_Name_Lower" -ValueOnly))) {
			dk_call dk_warning "${PLUGIN}_IMPORT_Name_Lower:$(gv "${PLUGIN}_IMPORT_Name_Lower" -ValueOnly) and ${PLUGIN}_GIT_Name_Lower:$(gv "${PLUGIN}_GIT_Name_Lower" -ValueOnly) do not match"; 
		}
	}										
	
	### <PLUGIN>																C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
#	dk_call dk_validate PLUGIN_INSTALL_Path "dk_call dk_PLUGIN_INSTALL_Path";
#	Set-Variable -Name ${PLUGIN} -Value ${PLUGIN_INSTALL_Path} -Scope Global;
	Set-Variable -Name ${PLUGIN} -Value $(gv "${PLUGIN}_INSTALL_Path" -ValueOnly) -Scope Global;
	# dk_call dk_printVar ${PLUGIN};	

	### <PLUGIN>_Dir															C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master
	if(!("${PLUGIN}" -eq "GIT")) {	### DO NOT USE GIT_DIR ###
#		dk_call dk_validate PLUGIN_INSTALL_Path "dk_call dk_PLUGIN_INSTALL_Path";
		#Set-Variable -Name ${PLUGIN}_Dir -Value ${PLUGIN_INSTALL_Path} -Scope Global;
		Set-Variable -Name ${PLUGIN}_Dir -Value $(gv "${PLUGIN}_INSTALL_Path" -ValueOnly) -Scope Global;
		# dk_call dk_printVar ${PLUGIN}_Dir;
	}
	
	### <PLUGIN>_Url															https://github.com/madler/zlib/archive/refs/heads/master.zip
#	dk_call dk_validate PLUGIN_URL "dk_call dk_PLUGIN_URL";
#	Set-Variable -Name ${PLUGIN}_Url -Value ${PLUGIN_URL} -Scope Global;
	Set-Variable -Name ${PLUGIN}_Url -Value $(gv "${PLUGIN}_URL" -ValueOnly) -Scope Global;
	# dk_call dk_printVar ${PLUGIN}_Url;
	
	### <PLUGIN>_Import_File													master.zip
#	dk_call dk_validate PLUGIN_URL_Filename "dk_call dk_PLUGIN_URL_Filename";
#	Set-Variable -Name ${PLUGIN}_Import_File -Value ${PLUGIN_URL_Filename} -Scope Global;
	Set-Variable -Name ${PLUGIN}_Import_File -Value $(gv "${PLUGIN}_URL_Filename" -ValueOnly) -Scope Global;
	# dk_call dk_printVar ${PLUGIN}_Import_File;

	### <PLUGIN>_Version														master
#	dk_call dk_validate PLUGIN_INSTALL_Version "dk_call dk_PLUGIN_INSTALL_Version";
#	Set-Variable -Name ${PLUGIN}_Version -Value ${PLUGIN_INSTALL_Version} -Scope Global;
	Set-Variable -Name ${PLUGIN}_Version -Value $(gv "${PLUGIN}_INSTALL_Version" -ValueOnly) -Scope Global;
	# dk_call dk_printVar ${PLUGIN}_Version;

	### <PLUGIN>_Folder															zlib-master
#	dk_call dk_validate PLUGIN_INSTALL_Folder "dk_call dk_PLUGIN_INSTALL_Folder";
#	Set-Variable -Name ${PLUGIN}_Folder -Value ${PLUGIN_INSTALL_Folder} -Scope Global;
	Set-Variable -Name ${PLUGIN}_Folder -Value $(gv "${PLUGIN}_INSTALL_Folder" -ValueOnly) -Scope Global;
	# dk_call dk_printVar ${PLUGIN}_Folder;

	### <PLUGIN>_Import_Name													zlib
#	dk_call dk_validate PLUGIN_IMPORT_Name_Lower "dk_call dk_PLUGIN_IMPORT_Name_Lower";
#	Set-Variable -Name ${PLUGIN}_Import_Name -Value ${PLUGIN_IMPORT_Name_Lower} -Scope Global;
	Set-Variable -Name ${PLUGIN}_Import_Name -Value $(gv "${PLUGIN}_IMPORT_Name_Lower" -ValueOnly) -Scope Global;
	# dk_call dk_printVar ${PLUGIN}_Import_Name;
		
	### <PLUGIN>_Branch															master
#	dk_call dk_validate PLUGIN_GIT_Branch "dk_call dk_PLUGIN_GIT_Branch";
#	Set-Variable -Name ${PLUGIN}_Branch -Value ${PLUGIN_GIT_Branch} -Scope Global;
	Set-Variable -Name ${PLUGIN}_Branch -Value $(gv "${PLUGIN}_GIT_Branch" -ValueOnly) -Scope Global;
	# dk_call dk_printVar ${PLUGIN}_Branch;
	
	### <PLUGIN>_Tag															v1.2
#	dk_call dk_validate PLUGIN_GIT_Tag "dk_call dk_PLUGIN_GIT_Tag";
#	Set-Variable -Name ${PLUGIN}_Tag -Value ${PLUGIN_GIT_Tag} -Scope Global;
	Set-Variable -Name ${PLUGIN}_Tag -Value $(gv "${PLUGIN}_GIT_Tag" -ValueOnly) -Scope Global;
	# dk_call dk_printVar ${PLUGIN}_Tag;

		

	#####################################################
	############# TARGET <PLUGIN>_Variables #############
	#####################################################

	### <PLUGIN>_Tuple_Dir														C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang
#	dk_call dk_validate PLUGIN_INSTALL_Path "dk_call dk_PLUGIN_INSTALL_Path";
#	dk_call dk_validate Target_Tuple "dk_call dk_Target_Tuple";
#	Set-Variable -Name ${PLUGIN}_Tuple_Dir -Value "${PLUGIN_INSTALL_Path}/${Target_Tuple}" -Scope Global;
	Set-Variable -Name ${PLUGIN}_Tuple_Dir -Value "$(gv "${PLUGIN}_INSTALL_Path" -ValueOnly)/${Target_Tuple}" -Scope Global;
	# dk_call dk_printVar ${PLUGIN}_Tuple_Dir;
	
	### <PLUGIN>_Config_Dir														C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
#	dk_call dk_validate PLUGIN_INSTALL_Path "dk_call dk_PLUGIN_INSTALL_Path";
#	dk_call dk_validate Config_Path "dk_call dk_Config_Path";
#	Set-Variable -Name ${PLUGIN}_Config_Dir -Value "${PLUGIN_INSTALL_Path}/${Config_Path}" -Scope Global;
	Set-Variable -Name ${PLUGIN}_Config_Dir -Value "$(gv "${PLUGIN}_INSTALL_Path" -ValueOnly)/${Config_Path}" -Scope Global;
	# dk_call dk_printVar ${PLUGIN}_Config_Dir;
	
	### <PLUGIN>_Build_Dir														C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
#	dk_call dk_validate PLUGIN_INSTALL_Path "dk_call dk_PLUGIN_INSTALL_Path";
#	dk_call dk_validate Build_Path "dk_call dk_Build_Path";
#	Set-Variable -Name ${PLUGIN}_Build_Dir -Value "${PLUGIN_INSTALL_Path}/${Build_Path}" -Scope Global;
	Set-Variable -Name ${PLUGIN}_Build_Dir -Value "$(gv "${PLUGIN}_INSTALL_Path" -ValueOnly)/${Build_Path}" -Scope Global;
	# dk_call dk_printVar ${PLUGIN}_Build_Dir;
	
	### <PLUGIN>_Debug_Dir														C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Debug
#	dk_call dk_validate PLUGIN_INSTALL_Path "dk_call dk_PLUGIN_INSTALL_Path";
#	dk_call dk_validate Target_Tuple "dk_call dk_Target_Tuple";
#	dk_call dk_validate Debug_Dir "dk_call dk_Debug_Dir";
#	Set-Variable -Name ${PLUGIN}_Debug_Dir -Value "${PLUGIN_INSTALL_Path}/${Target_Tuple}/${Debug_Dir}" -Scope Global;
	Set-Variable -Name ${PLUGIN}_Debug_Dir -Value "$(gv "${PLUGIN}_INSTALL_Path" -ValueOnly)/${Target_Tuple}/${Debug_Dir}" -Scope Global;
	# dk_call dk_printVar ${PLUGIN}_Debug_Dir;
	
	### <PLUGIN>_Release_Dir													C:/Users/Administrator/DigitalKnob/Development/3rdParty/zlib-master/Windows_X86_64_Clang/Release
#	dk_call dk_validate PLUGIN_INSTALL_Path "dk_call dk_PLUGIN_INSTALL_Path";
#	dk_call dk_validate Target_Tuple "dk_call dk_Target_Tuple";
#	dk_call dk_validate Release_Dir "dk_call dk_Release_Dir";
#	Set-Variable -Name ${PLUGIN}_Release_Dir -Value "${PLUGIN_INSTALL_Path}/${Target_Tuple}/${Release_Dir}" -Scope Global;
	Set-Variable -Name ${PLUGIN}_Release_Dir -Value "$(gv "${PLUGIN}_INSTALL_Path" -ValueOnly)/${Target_Tuple}/${Release_Dir}" -Scope Global;
	# dk_call dk_printVar ${PLUGIN}_Release_Dir;
}


$(gv "${PLUGIN}_GIT" -ValueOnly)



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
	#dk_call dk_validate DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR"
	dk_call dk_DKIMPORTS_DIR;
	dk_call dk_DKTOOLS_DIR;
	dk_call dk_chdir "${env:DKIMPORTS_DIR}/git";
	dk_call dk_importVariables "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe" IMPORT_Name git ROOT "${env:DKTOOLS_DIR}";
	dk_call dk_echo;
	dk_call dk_printVar BRANCH;
	dk_call dk_printVar DIR;
	dk_call dk_printVar FOLDER;
	dk_call dk_printVar ROOT;
	dk_call dk_printVar TAG;
	dk_call dk_printVar VERSION;
	dk_call dk_printVar IMPORT_Name;
	dk_call dk_printVar IMPORT_Path;
	dk_call dk_printVar PLUGIN;
	dk_call dk_printVar PLUGIN_ARGS;
	dk_call dk_printVar PLUGIN_GIT;
	dk_call dk_printVar PLUGIN_GIT_Branch;
	dk_call dk_printVar PLUGIN_GIT_Filename;
	dk_call dk_printVar PLUGIN_GIT_Name;
	dk_call dk_printVar PLUGIN_GIT_Name_Lower;
	dk_call dk_printVar PLUGIN_GIT_Tag;
	dk_call dk_printVar PLUGIN_IMPORT;
	dk_call dk_printVar PLUGIN_IMPORT_Name;
	dk_call dk_printVar PLUGIN_IMPORT_Name_Lower;
	dk_call dk_printVar PLUGIN_IMPORT_Name_Upper;
	dk_call dk_printVar PLUGIN_IMPORT_Path;
	dk_call dk_printVar PLUGIN_INSTALL_Folder;
	dk_call dk_printVar PLUGIN_INSTALL_Name;
	dk_call dk_printVar PLUGIN_INSTALL_Path;
	dk_call dk_printVar PLUGIN_INSTALL_Root;
	dk_call dk_printVar PLUGIN_INSTALL_Version;
	dk_call dk_printVar PLUGIN_URL;
	dk_call dk_printVar PLUGIN_URL_Array;
	dk_call dk_printVar PLUGIN_URL_Extension;
	dk_call dk_printVar PLUGIN_URL_File;
	dk_call dk_printVar PLUGIN_URL_Filename;
	dk_call dk_printVar PLUGIN_URL_Length;
	dk_call dk_printVar PLUGIN_URL_List;
	dk_call dk_printVar ${PLUGIN};
	dk_call dk_printVar ${PLUGIN}_Branch;
	dk_call dk_printVar ${PLUGIN}_Build_Dir;
	dk_call dk_printVar ${PLUGIN}_Config_Dir;
	dk_call dk_printVar ${PLUGIN}_Debug_Dir;
	dk_call dk_printVar ${PLUGIN}_Dir;
	dk_call dk_printVar ${PLUGIN}_Folder;
	dk_call dk_printVar ${PLUGIN}_Import_File;
	dk_call dk_printVar ${PLUGIN}_Import_Name;
	dk_call dk_printVar ${PLUGIN}_Release_Dir;
	dk_call dk_printVar ${PLUGIN}_Tag;
	dk_call dk_printVar ${PLUGIN}_Tuple_Dir;
	dk_call dk_printVar ${PLUGIN}_Url;
	dk_call dk_printVar ${PLUGIN}_Version;
	
	
	dk_call dk_chdir "${env:DKIMPORTS_DIR}/zlib";
	dk_call dk_importVariables "https://github.com/madler/zlib/archive/refs/heads/master.zip";
	dk_call dk_echo;
	dk_call dk_printVar BRANCH;
	dk_call dk_printVar DIR;
	dk_call dk_printVar FOLDER;
	dk_call dk_printVar ROOT;
	dk_call dk_printVar TAG;
	dk_call dk_printVar VERSION;
	dk_call dk_printVar IMPORT_Name;
	dk_call dk_printVar IMPORT_Path;
	dk_call dk_printVar ${PLUGIN};
	dk_call dk_printVar ${PLUGIN}_ARGS;
	dk_call dk_printVar ${PLUGIN}_GIT;
	dk_call dk_printVar ${PLUGIN}_GIT_Branch;
	dk_call dk_printVar ${PLUGIN}_GIT_Filename;
	dk_call dk_printVar ${PLUGIN}_GIT_Name;
	dk_call dk_printVar ${PLUGIN}_GIT_Name_Lower;
	dk_call dk_printVar ${PLUGIN}_GIT_Tag;
	dk_call dk_printVar ${PLUGIN}_IMPORT;
	dk_call dk_printVar ${PLUGIN}_IMPORT_Name;
	dk_call dk_printVar ${PLUGIN}_IMPORT_Name_Lower;
	dk_call dk_printVar ${PLUGIN}_IMPORT_Name_Upper;
	dk_call dk_printVar ${PLUGIN}_IMPORT_Path;
	dk_call dk_printVar ${PLUGIN}_INSTALL_Folder;
	dk_call dk_printVar ${PLUGIN}_INSTALL_Name;
	dk_call dk_printVar ${PLUGIN}_INSTALL_Path;
	dk_call dk_printVar ${PLUGIN}_INSTALL_Root;
	dk_call dk_printVar ${PLUGIN}_INSTALL_Version;
	dk_call dk_printVar ${PLUGIN}_URL;
	dk_call dk_printVar ${PLUGIN}_URL_Array;
	dk_call dk_printVar ${PLUGIN}_URL_Extension;
	dk_call dk_printVar ${PLUGIN}_URL_File;
	dk_call dk_printVar ${PLUGIN}_URL_Filename;
	dk_call dk_printVar ${PLUGIN}_URL_Length;
	dk_call dk_printVar ${PLUGIN}_URL_List;
	dk_call dk_printVar ${PLUGIN}_Branch;
	dk_call dk_printVar ${PLUGIN}_Build_Dir;
	dk_call dk_printVar ${PLUGIN}_Config_Dir;
	dk_call dk_printVar ${PLUGIN}_Debug_Dir;
	dk_call dk_printVar ${PLUGIN}_Dir;
	dk_call dk_printVar ${PLUGIN}_Folder;
	dk_call dk_printVar ${PLUGIN}_Import_File;
	dk_call dk_printVar ${PLUGIN}_Import_Name;
	dk_call dk_printVar ${PLUGIN}_Release_Dir;
	dk_call dk_printVar ${PLUGIN}_Tag;
	dk_call dk_printVar ${PLUGIN}_Tuple_Dir;
	dk_call dk_printVar ${PLUGIN}_Url;
	dk_call dk_printVar ${PLUGIN}_Version;
}
