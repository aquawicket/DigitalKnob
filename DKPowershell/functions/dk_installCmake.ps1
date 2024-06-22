if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_installCmake){ $dk_installCmake = 1 } else{ return }

####################################################################
# dk_installCmake()
#
function Global:dk_installCmake () {
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	dk_validate HOST_OS "dk_getHostTriple"
	
#   if("${HOST_OS}_${HOST_ARCH}" -eq "win_arm32"    { $CMAKE_DL = "https://todo" }
    if("${HOST_OS}_${HOST_ARCH}" -eq "win_arm64")   { $CMAKE_DL = "https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-arm64.zip" }
    if("${HOST_OS}_${HOST_ARCH}" -eq "win_x86")     { $CMAKE_DL = "https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-i386.zip" }
    if("${HOST_OS}_${HOST_ARCH}" -eq "win_x86_64")  { $CMAKE_DL = "https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-windows-x86_64.zip" }
    if("$HOST_OS" -eq "mac")                        { $CMAKE_DL = "https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-macos-universal.tar.gz" }
#	if("$HOST_OS" -eq "mac")                        { $CMAKE_DL = "https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-macos10.10-universal.tar.gz" }
    if("${HOST_OS}_${HOST_ARCH}" -eq "linux_x86_64"){ $CMAKE_DL = "https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-linux-x86_64.tar.gz" }
    if("${HOST_OS}_${HOST_ARCH}" -eq "linux_arm64") { $CMAKE_DL = "https://github.com/Kitware/CMake/releases/download/v3.29.5/cmake-3.29.5-linux-aarch64.tar.gz" }
    
    $CMAKE_DL_FILE = dk_getBasename $CMAKE_DL 
	$CMAKE_DL_NAME = dk_removeExtension $CMAKE_DL_FILE 
    $CMAKE_FOLDER = dk_convertToCIdentifier $CMAKE_DL_NAME 
    $CMAKE_FOLDER = dk_toLower $CMAKE_FOLDER
	dk_validate DKTOOLS_DIR "dk_getDKPaths"
	$global:CMAKE = "$DKTOOLS_DIR/$CMAKE_FOLDER"
    $global:CMAKE_EXE = "$CMAKE/bin/cmake.exe"
        
    if(dk_pathExists $CMAKE_EXE){ return }
       
    dk_info " "
    dk_info "Installing CMake . . ."
    dk_download "$CMAKE_DL" "$DKDOWNLOAD_DIR/$CMAKE_DL_FILE"
	dk_smartExtract "$DKDOWNLOAD_DIR/$CMAKE_DL_FILE" "$CMAKE"

    
    if(!(dk_pathExists "$CMAKE_EXE")){ dk_error "cannot find cmake" }
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	dk_installCmake
}