dk_includeGuard

CMAKE_DL_WIN_X86=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-windows-i386.zip
CMAKE_DL_WIN_X86_64=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-windows-x86_64.zip
CMAKE_DL_WIN_ARM64=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-windows-arm64.zip
CMAKE_DL_MAC=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-macos-universal.tar.gz
#CMAKE_DL_MAC=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-macos10.10-universal.tar.gz
CMAKE_DL_LINUX_X86_64=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-linux-x86_64.tar.gz
CMAKE_DL_LINUX_ARM64=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-linux-aarch64.tar.gz


##################################################################################
# dk_validateCmake()
#
#
dk_validateCmake () {
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
	
	dk_validate HOST_OS dk_getHostTriple
	######################################################################################################
	[ "${HOST_OS}" = "android" ]                 && CMAKE_IMPORT=cmake;						
	[ "${HOST_TRIPLE}" = "win_arm32" ]           && CMAKE_IMPORT=$CMAKE_DL_WIN_ARM32
	[ "${HOST_TRIPLE}" = "win_arm64" ]           && CMAKE_IMPORT=$CMAKE_DL_WIN_ARM64
	[ "${HOST_TRIPLE}" = "win_x86" ]             && CMAKE_IMPORT=$CMAKE_DL_WIN_X86
	[ "${HOST_OS}_${HOST_ARCH}" = "win_x86_64" ] && CMAKE_IMPORT=$CMAKE_DL_WIN_X86_64
	[ "${HOST_OS}" = "mac" ]                     && CMAKE_IMPORT=$CMAKE_DL_MAC
	[ "${HOST_TRIPLE}" = "linux_x86_64" ]        && CMAKE_IMPORT=$CMAKE_DL_LINUX_X86_64
	[ "${HOST_TRIPLE}" = "linux_arm64" ]         && CMAKE_IMPORT=$CMAKE_DL_LINUX_ARM64
	[ "${HOST_TRIPLE}" = "raspberry_arm64" ]     && CMAKE_IMPORT=$CMAKE_DL_LINUX_ARM64
	#[ "${TARGET_OS}" = "android_arm32" ]        && CMAKE_IMPORT=cmake
	[ "${TARGET_OS}" = "win_arm64_clang" ]       && CMAKE_IMPORT=mingw-w64-clang-aarch64-cmake
	[ "${TARGET_OS}" = "win_x86_clang" ]         && CMAKE_IMPORT=mingw-w64-clang-i686-cmake
	[ "${TARGET_OS}" = "win_x86_mingw" ]         && CMAKE_IMPORT=mingw-w64-i686-cmake
	[ "${TARGET_OS}" = "win_x86_64_clang" ]      && CMAKE_IMPORT=mingw-w64-clang-x86_64-cmake
	[ "${TARGET_OS}" = "win_x86_64_mingw" ]      && CMAKE_IMPORT=mingw-w64-x86_64-cmake
	[ "${TARGET_OS}" = "win_x86_64_ucrt" ]       && CMAKE_IMPORT=mingw-w64-ucrt-x86_64-cmake
	
	dk_debug CMAKE_IMPORT
	if dk_url ${CMAKE_IMPORT}; then
		dk_info "Installing CMake from dl files"
		dk_debug CMAKE_IMPORT
		
		CMAKE_DL=${CMAKE_IMPORT}
		
		dk_getFilename "$CMAKE_DL" CMAKE_DL_FILE
		dk_debug CMAKE_DL_FILE
		
		CMAKE_FOLDER="${CMAKE_DL_FILE%.*}"		# remove everything past last dot
		dk_debug CMAKE_FOLDER
		dk_debug "CMAKE_DL_FILE extension = ${CMAKE_FOLDER##*.}"
		[ "${CMAKE_FOLDER##*.}" = "tar" ] && CMAKE_FOLDER="${CMAKE_FOLDER%.*}"	# .tar.?? files remove past the last TWO dots
		
		dk_convertToCIdentifier "$CMAKE_FOLDER" CMAKE_FOLDER
		dk_toLower CMAKE_FOLDER
		dk_debug CMAKE_FOLDER
		
		[ -z $DKTOOLS_DIR ] && dk_getDKPaths
		[ "${HOST_OS}" = "win" ]       && CMAKE_EXE=$DKTOOLS_DIR/$CMAKE_FOLDER/bin/cmake.exe
		[ "${HOST_OS}" = "mac" ]       && CMAKE_EXE=$DKTOOLS_DIR/$CMAKE_FOLDER/CMake.app/Contents/bin/cmake
		[ "${HOST_OS}" = "linux" ]     && CMAKE_EXE=$DKTOOLS_DIR/$CMAKE_FOLDER/bin/cmake
		[ "${HOST_OS}" = "raspberry" ] && CMAKE_EXE=$DKTOOLS_DIR/$CMAKE_FOLDER/bin/cmake
		[ -z $CMAKE_EXE ]              && dk_error "no cmake for this OS"
		dk_debug CMAKE_EXE
		
		if dk_fileExists "$CMAKE_EXE"; then 
			return $true;
		fi

		dk_echo
		dk_info "Installing cmake . . ."
		dk_download "$CMAKE_DL" "$DKDOWNLOAD_DIR"/"$CMAKE_DL_FILE"
		dk_extract "$DKDOWNLOAD_DIR"/"$CMAKE_DL_FILE" "$DKTOOLS_DIR"
		
		#if ! dk_fileExists $CMAKE_EXE; then error "cannot find cmake"; fi

	else	# linux package
		dk_info "Installing CMake from package managers"
		
		CMAKE_EXE=$(command -v cmake)
		CMAKE_EXE=$(realpath ${CMAKE_EXE})
		dk_debug CMAKE_EXE
		if ! dk_commandExists cmake; then
			dk_install ${CMAKE_IMPORT}
		fi	
		CMAKE_EXE=$(command -v cmake)
		CMAKE_EXE=$(realpath ${CMAKE_EXE})
		dk_debug CMAKE_EXE
	fi
}