if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_importVariables_ps1){ $dk_importVariables_ps1 = 1; } else{ return; } #include guard


#########################################################################
# dk_import() LIBRARY APP
#
#	This is a flexable super function for importing just about anything into DigitalKnob
#	The idea is to provide a url or path and dk_import will do the rest. 
#
#	@url	- The online path of the .git or file to import
#
#	github GIT:	https://github.com/orginization/library.git		dkimportGit(url) #branch/tag #PATCH
#	 github DL:	https://github.com/orginization/library			dkimportGit(url) #branch/tag #PATCH
#	lib url DL:	https://website.com/library.zip					dkimportDownload(url) #PATCH
#	exe url DL:	https://website.com/executable.exe 				dkimportDownload(url) #PATCH
#
#	TODO: https://cmake.org/cmake/help/latest/module/FetchContent.html 
#
function Global:dk_import() {
	dk_debugFunc 0 99
	
	if(dk_call dk_isUrl $args[0]){
		dk_call dk_echo "args[0]:$($args[0]) is a url";
	}
	
	if(!(${CURRENT_IMPORT})){
		dk_call dk_validate env:DKIMPORTS_DIR "dk_call dk_DKIMPORTS_DIR";
		$CallStack = Get-PSCallStack;
		$frame=0;
		while($CallStack.Count -gt $frame) {	
			$callingScript = $CallStack[$frame].ScriptName -replace "\\", "/";
			if(dk_call dk_includes "${callingScript}" "${env:DKIMPORTS_DIR}"){
				dk_call dk_dirname "${callingScript}" CURRENT_IMPORT;
				${global:CURRENT_IMPORT}="${CURRENT_IMPORT}" -replace "\\", "/";
				break;
			}
			$frame++;
		}
	}	
	
	dk_call dk_assertPath "${CURRENT_IMPORT}/dkconfig.txt";
	dk_call dk_getFileParams "${CURRENT_IMPORT}/dkconfig.txt";
	dk_call dk_validate Host_Tuple "dk_call dk_Host_Tuple";
	dk_call dk_basename "${CURRENT_IMPORT}" Import_Name;
	dk_call dk_assertVar "Import_Name";
	Write-Host "Import_Name = ${Import_Name}";
	
	dk_call dk_getParameterValue APP @args;
	Write-Host "APP = ${APP}";
	if(${APP}) {
		dk_call dk_validate env:DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR";
		${INSTALL_ROOT}="${env:DKTOOLS_DIR}";
	} 
	else {
		dk_call dk_validate env:DK3RDPARTY_DIR "dk_call dk_DK3RDPARTY_DIR";
		${INSTALL_ROOT}="${env:DK3RDPARTY_DIR}";
	}
	dk_call dk_assertVar "INSTALL_ROOT";

	dk_call dk_assertVar "${Import_Name}_${Host_Tuple}_Import";
	${PLUGIN_IMPORT}=$(gv -Name ${Import_Name}_${Host_Tuple}_Import -ValueOnly);
	dk_call dk_assertVar "PLUGIN_IMPORT";
	
	dk_call dk_importVariables "${PLUGIN_IMPORT}" INSTALL_ROOT ${INSTALL_ROOT};
	dk_call dk_assertVar "PLUGIN.Url";
	dk_call dk_assertVar "PLUGIN.Install.Path";
	
	dk_call dk_download "${PLUGIN.Url}";
	dk_call dk_assertVar "dk_download";
	
	dk_call dk_getExtension "${PLUGIN.Url}" PLUGIN.Url.Extension;
	dk_call dk_assertVar "PLUGIN.Url.Extension";
	if("${PLUGIN.Url.Extension}" -eq ".7z"){ 		$FileType = "Archive"; }
	if("${PLUGIN.Url.Extension}" -eq ".bz"){		$FileType = "Archive"; }	
	if("${PLUGIN.Url.Extension}" -eq ".bz2"){		$FileType = "Archive"; }
	if("${PLUGIN.Url.Extension}" -eq ".gz"){		$FileType = "Archive"; }
	if("${PLUGIN.Url.Extension}" -eq ".rar"){		$FileType = "Archive"; }
	if("${PLUGIN.Url.Extension}" -eq ".sfx.exe"){	$FileType = "Archive"; }
	if("${PLUGIN.Url.Extension}" -eq ".tar"){		$FileType = "Archive"; }
	if("${PLUGIN.Url.Extension}" -eq ".tar.gz"){	$FileType = "Archive"; }
	if("${PLUGIN.Url.Extension}" -eq ".tgz"){		$FileType = "Archive"; }
	if("${PLUGIN.Url.Extension}" -eq ".xz"){		$FileType = "Archive"; }
	if("${PLUGIN.Url.Extension}" -eq ".zip"){		$FileType = "Archive"; }
	
	if("${FileType}" -eq "Archive"){
		dk_call dk_smartExtract "${dk_download}" "${PLUGIN.Install.Path}";
	}
}















###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST() {
	#dk_debugFunc 0;
	
	dk_call dk_import git;
	#dk_call dk_import "https://github.com/madler/zlib/archive/d4768283.zip";
	#dk_call dk_import https://www.dependencywalker.com/depends22_x64.zip;
}