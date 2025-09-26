if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_installCmake_ps1){ $dk_installCmake_ps1 = 1; } else{ return; } #include guard

####################################################################
# dk_installCmake()
#
function Global:dk_installCmake() {
	dk_debugFunc 0;

	dk_call dk_validate Host_Os "dk_call dk_Host_Os";
	
#   if("${Host_Os}_${Host_Arch}" -eq "Windows_Arm32"    { ${cmake_Import} = "https://todo"; }
    if("${Host_Os}_${Host_Arch}" -eq "Windows_Arm64")   { ${cmake_Import} = "https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-arm64.zip"; }
    if("${Host_Os}_${Host_Arch}" -eq "Windows_X86")     { ${cmake_Import} = "https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-i386.zip"; }
    if("${Host_Os}_${Host_Arch}" -eq "Windows_X86_64")  { ${cmake_Import} = "https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-x86_64.zip"; }
    if("$Host_Os" -eq "Mac")                        	{ ${cmake_Import} = "https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-macos-universal.tar.gz"; }
#	if("$Host_Os" -eq "Mac")                        	{ ${cmake_Import} = "https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-macos10.10-universal.tar.gz"; }
    if("${Host_Os}_${Host_Arch}" -eq "Linux_X86_64")	{ ${cmake_Import} = "https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-linux-x86_64.tar.gz"; }
    if("${Host_Os}_${Host_Arch}" -eq "Linux_Arm64") 	{ ${cmake_Import} = "https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-linux-aarch64.tar.gz"; }
    
    ${cmake_Import_File} = dk_call dk_basename ${cmake_Import};
	${cmake_Install_Name} = dk_call dk_removeExtension ${cmake_Import_File};
    #${cmake_Install_Name} = dk_call dk_convertToCIdentifier ${cmake_Install_Name}; 
    #${cmake_Install_Name} = dk_call dk_toLower ${cmake_Install_Name};
	dk_call dk_validate DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR";
	$global:cmake = "$DKTOOLS_DIR/$cmake_Install_Name";
    $global:cmake_exe = "$cmake/bin/cmake.exe";
        
    if(dk_call dk_pathExists ${cmake_exe}){ return; }
       
    dk_call dk_echo "\n";
    dk_call dk_info "Installing CMake . . .\n";
    dk_call dk_download "${cmake_Import}" "${DKDOWNLOAD_DIR}/${cmake_Import_File}";
	dk_call dk_smartExtract "${DKDOWNLOAD_DIR}/${cmake_Import_File}" "${cmake}";
    
    if(!(dk_call dk_pathExists "${cmake_exe}")){ dk_call dk_error "cannot find cmake\n"; }
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0;
	
	dk_call dk_installCmake;
}
