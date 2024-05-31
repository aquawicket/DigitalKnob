if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_validateCmake){ $dk_validateCmake = 1 } else{ return }


$CMAKE_DL_WIN_X86      = "https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-windows-i386.zip"
$CMAKE_DL_WIN_X86_64   = "https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-windows-x86_64.zip"
$CMAKE_DL_WIN_ARM64    = "https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-windows-arm64.zip"
$CMAKE_DL_MAC          = "https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-macos-universal.tar.gz"
#$CMAKE_DL_MAC         = "https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-macos10.10-universal.tar.gz"
$CMAKE_DL_LINUX_X86_64 = "https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-linux-x86_64.tar.gz"
$CMAKE_DL_LINUX_ARM64  = "https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-linux-aarch64.tar.gz"


##################################################################################
# dk_validateCmake()
#
#
function Global:dk_validateCmake () {
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	dk_validate HOST_OS dk_getHostTriple	
	######################################################################################################
	if(${HOST_OS} -eq "android")                 { $CMAKE_IMPORT = "cmake" }				
	if(${HOST_TRIPLE} -eq "win_arm32")           { $CMAKE_IMPORT = ${CMAKE_DL_WIN_ARM32} }
	if(${HOST_TRIPLE} -eq "win_arm64")           { $CMAKE_IMPORT = ${CMAKE_DL_WIN_ARM64} }
	if(${HOST_TRIPLE} -eq "win_x86")             { $CMAKE_IMPORT = ${CMAKE_DL_WIN_X86} }
	if(${HOST_OS}_${HOST_ARCH} -eq "win_x86_64") { $CMAKE_IMPORT = ${CMAKE_DL_WIN_X86_64} }
	if(${HOST_OS} -eq "mac")                     { $CMAKE_IMPORT = ${CMAKE_DL_MAC} }
	if(${HOST_TRIPLE} -eq "linux_x86_64")        { $CMAKE_IMPORT = ${CMAKE_DL_LINUX_X86_64} }
	if(${HOST_TRIPLE} -eq "linux_arm64")         { $CMAKE_IMPORT = ${CMAKE_DL_LINUX_ARM64} }
	if(${HOST_TRIPLE} -eq "raspberry_arm64")     { $CMAKE_IMPORT = ${CMAKE_DL_LINUX_ARM64} }
	#if(${TARGET_OS} -eq "android_arm32")        { $CMAKE_IMPORT = "cmake" }
	if(${TARGET_OS} -eq "win_arm64_clang")       { $CMAKE_IMPORT = "mingw-w64-clang-aarch64-cmake" }
	if(${TARGET_OS} -eq "win_x86_clang")         { $CMAKE_IMPORT = "mingw-w64-clang-i686-cmake" }
	if(${TARGET_OS} -eq "win_x86_mingw")         { $CMAKE_IMPORT = "mingw-w64-i686-cmake" }
	if(${TARGET_OS} -eq "win_x86_64_clang")      { $CMAKE_IMPORT = "mingw-w64-clang-x86_64-cmake" }
	if(${TARGET_OS} -eq "win_x86_64_mingw")      { $CMAKE_IMPORT = "mingw-w64-x86_64-cmake" }
	if(${TARGET_OS} -eq "win_x86_64_ucrt")       { $CMAKE_IMPORT = "mingw-w64-ucrt-x86_64-cmake" }
	dk_printVar CMAKE_IMPORT
	
	if(dk_isUrl "${CMAKE_IMPORT}"){
		dk_info "Installing CMake from dl files"
		dk_printVar CMAKE_IMPORT
		
		$CMAKE_DL = ${CMAKE_IMPORT}
		
		$CMAKE_DL_FILE = dk_getFilename "${CMAKE_DL}" 
		dk_printVar CMAKE_DL_FILE
		
		$CMAKE_FOLDER = dk_removeExtension "${CMAKE_DL_FILE}"
		dk_printVar CMAKE_FOLDER
		
		$CMAKE_FOLDER = dk_convertToCIdentifier "${CMAKE_FOLDER}"
		$CMAKE_FOLDER = dk_toLower ${CMAKE_FOLDER}
		dk_printVar CMAKE_FOLDER
		
		#[ -z ${DKTOOLS_DIR}) && dk_getDKPaths
		dk_validate DKTOOLS_DIR dk_getDKPaths
		if(${HOST_OS} -eq "win")       { $CMAKE_EXE = "${DKTOOLS_DIR}\${CMAKE_FOLDER}\bin\cmake.exe" }
		if(${HOST_OS} -eq "mac")       { $CMAKE_EXE = "${DKTOOLS_DIR}\${CMAKE_FOLDER}\CMake.app\Contents\bin\cmake" }
		if(${HOST_OS} -eq "linux")     { $CMAKE_EXE = "${DKTOOLS_DIR}\${CMAKE_FOLDER}\bin\cmake" }
		if(${HOST_OS} -eq "raspberry") { $CMAKE_EXE = "${DKTOOLS_DIR}\${CMAKE_FOLDER}\bin\cmake" }
		if(!(${CMAKE_EXE}))            { dk_error "no cmake for this OS" }
		dk_printVar CMAKE_EXE
		
		if dk_fileExists "${CMAKE_EXE}"; then 
			return ${true};
		fi

		dk_echo
		dk_info "Installing cmake . . ."
		dk_download "${CMAKE_DL}" "${DKDOWNLOAD_DIR}\${CMAKE_DL_FILE}"
		dk_extract "${DKDOWNLOAD_DIR}\${CMAKE_DL_FILE}" "${DKTOOLS_DIR}"
		
		$CMAKE_DL_NAME = dk_removeExtension ${CMAKE_DL_FILE}
		dk_rename "${DKTOOLS_DIR}\${CMAKE_DL_NAME}" "${DKTOOLS_DIR}\${CMAKE_FOLDER}"
		
		dk_echo ${CMAKE_FOLDER}>"${DKTOOLS_DIR}\${CMAKE_FOLDER}\installed"
        
		if(!(dk_fileExists ${CMAKE_EXE}){ dk_error "cannot find cmake" }
	}
	else{	# linux package
		dk_info "Installing CMake from package managers"
		
		$CMAKE_EXE = $(command -v cmake)
		$CMAKE_EXE = dk_realpath ${CMAKE_EXE}
		dk_printVar CMAKE_EXE
		if(!(dk_commandExists cmake)){
			dk_install ${CMAKE_IMPORT}
		}
		$CMAKE_EXE = $(command -v cmake)
		$CMAKE_EXE = dk_realpath ${CMAKE_EXE}
		dk_printVar CMAKE_EXE
	}
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_validateCmake
}