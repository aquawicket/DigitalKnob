if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$DKINSTALL){ $DKINSTALL = 1 } else{ return }

####################################################################
# DKINSTALL()
#
function Global:DKINSTALL() {
	dk_debugFunc 0

	dk_call dk_validate Host_Tuple "dk_call dk_Host_Tuple"
	
#   if("${Host_Os}_${Host_Arch}" -eq "Win_Arm32"    { ${CMAKE_DL} = "https://todo" }
    if("${Host_Os}_${Host_Arch}" -eq "Win_Arm64")   { ${CMAKE_DL} = "https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-arm64.zip" }
    if("${Host_Os}_${Host_Arch}" -eq "Win_X86")     { ${CMAKE_DL} = "https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-i386.zip" }
    if("${Host_Os}_${Host_Arch}" -eq "Win_X86_64")  { ${CMAKE_DL} = "https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-x86_64.zip" }
    if("$Host_Os" -eq "Mac")                        { ${CMAKE_DL} = "https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-macos-universal.tar.gz" }
#	if("$Host_Os" -eq "Mac")                        { ${CMAKE_DL} = "https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-macos10.10-universal.tar.gz" }
    if("${Host_Os}_${Host_Arch}" -eq "Linux_X86_64"){ ${CMAKE_DL} = "https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-linux-x86_64.tar.gz" }
    if("${Host_Os}_${Host_Arch}" -eq "Linux_Arm64") { ${CMAKE_DL} = "https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-linux-aarch64.tar.gz" }
    
    ${CMAKE_DL_FILE} = dk_call dk_basename ${CMAKE_DL}
	${CMAKE_FOLDER} = dk_call dk_removeExtension ${CMAKE_DL_FILE}
    #${CMAKE_FOLDER} = dk_call dk_convertToCIdentifier ${CMAKE_FOLDER} 
    #${CMAKE_FOLDER} = dk_call dk_toLower ${CMAKE_FOLDER}
	dk_call dk_validate DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR"
	$global:CMAKE_DIR = "$DKTOOLS_DIR/$CMAKE_FOLDER"
    $global:CMAKE_EXE = "$CMAKE_DIR/bin/cmake.exe"
        
    if(dk_call dk_pathExists ${CMAKE_EXE}){ return }
       
    dk_call dk_echo
    dk_call dk_info "Installing CMake . . ."
    dk_call dk_download "${CMAKE_DL}" "${DKDOWNLOAD_DIR}/${CMAKE_DL_FILE}"
	dk_call dk_smartExtract "${DKDOWNLOAD_DIR}/${CMAKE_DL_FILE}" "${CMAKE_DIR}"
    
    if(!(dk_call dk_pathExists "${CMAKE_EXE}")){ dk_call dk_error "cannot find cmake" }
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
function Global:DKTEST() { 
	dk_debugFunc 0
	
	dk_call DKINSTALL
}