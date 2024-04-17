# dk_include_guard()

CMAKE_DL_WIN_X86=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-windows-i386.zip
CMAKE_DL_WIN_X86_64=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-windows-x86_64.zip
CMAKE_DL_WIN_ARM64=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-windows-arm64.zip
CMAKE_DL_MAC=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-macos-universal.tar.gz
#CMAKE_DL_MAC=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-macos10.10-universal.tar.gz
CMAKE_DL_LINUX_X86_64=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-linux-x86_64.tar.gz
CMAKE_DL_LINUX_ARM64=https://github.com/Kitware/CMake/releases/download/v3.29.0/cmake-3.29.0-linux-aarch64.tar.gz


##################################################################################
# dk_validate_cmake()
#
#
dk_validate_cmake () {
	dk_verbose "dk_validate_cmake($*)"
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
	
	######################################################################################################
	if [ "${HOST_OS}" 		= "android" ]; 			then CMAKE_IMPORT=cmake;							fi
	if [ "${HOST_TRIPLE}" 	= "win_arm32" ];		then CMAKE_IMPORT=$CMAKE_DL_WIN_ARM32;				fi
	if [ "${HOST_TRIPLE}" 	= "win_arm64" ];		then CMAKE_IMPORT=$CMAKE_DL_WIN_ARM64;				fi
	if [ "${HOST_TRIPLE}" 	= "win_x86" ];			then CMAKE_IMPORT=$CMAKE_DL_WIN_X86;				fi
	if [ "${HOST_TRIPLE}"	= "win_x86_64" ];		then CMAKE_IMPORT=$CMAKE_DL_WIN_X86_64;				fi
	if [ "${HOST_OS}" 		= "mac" ];				then CMAKE_IMPORT=$CMAKE_DL_MAC;					fi
	if [ "${HOST_TRIPLE}" 	= "linux_x86_64" ];		then CMAKE_IMPORT=$CMAKE_DL_LINUX_X86_64;			fi
	if [ "${HOST_TRIPLE}" 	= "linux_arm64" ];		then CMAKE_IMPORT=$CMAKE_DL_LINUX_ARM64;			fi
	if [ "${HOST_TRIPLE}" 	= "raspberry_arm64" ];	then CMAKE_IMPORT=$CMAKE_DL_LINUX_ARM64;			fi
	if [ "${TARGET_OS}" 	= "android_arm32" ]; 	then CMAKE_IMPORT=cmake;							fi
	if [ "${TARGET_OS}" 	= "win_arm64_clang" ]; 	then CMAKE_IMPORT=mingw-w64-clang-aarch64-cmake;	fi
	if [ "${TARGET_OS}" 	= "win_x86_clang" ];	then CMAKE_IMPORT=mingw-w64-clang-i686-cmake;		fi
	if [ "${TARGET_OS}" 	= "win_x86_mingw" ]; 	then CMAKE_IMPORT=mingw-w64-i686-cmake;				fi
	if [ "${TARGET_OS}"		= "win_x86_64_clang" ];	then CMAKE_IMPORT=mingw-w64-clang-x86_64-cmake;		fi
	if [ "${TARGET_OS}" 	= "win_x86_64_mingw" ];	then CMAKE_IMPORT=mingw-w64-x86_64-cmake;			fi
	if [ "${TARGET_OS}" 	= "win_x86_64_ucrt" ]; 	then CMAKE_IMPORT=mingw-w64-ucrt-x86_64-cmake;		fi
	
	dk_debug CMAKE_IMPORT
	if dk_url ${CMAKE_IMPORT}; then
		dk_info "Installing CMake from dl files"
		dk_debug CMAKE_IMPORT
		
		dk_get_filename "$CMAKE_IMPORT" CMAKE_DL_FILE
		dk_debug CMAKE_DL_FILE
		
		CMAKE_FOLDER="${CMAKE_DL_FILE%.*}"		# remove everything past last dot
		dk_debug CMAKE_FOLDER
		dk_debug "CMAKE_DL_FILE extension = ${CMAKE_FOLDER##*.}"
		if [ "${CMAKE_FOLDER##*.}" = "tar" ]; then
			CMAKE_FOLDER="${CMAKE_FOLDER%.*}"	# .tar.?? files remove past the last TWO dots
		fi
		
		dk_convert_to_c_identifier "$CMAKE_FOLDER" CMAKE_FOLDER
		dk_to_lower CMAKE_FOLDER
		dk_debug CMAKE_FOLDER
		
		if [ "${HOST_OS}" = "win" ]; then
			CMAKE_EXE=$DKTOOLS_DIR/$CMAKE_FOLDER/bin/cmake.exe
		elif [ "${HOST_OS}" = "mac" ]; then
			CMAKE_EXE=$DKTOOLS_DIR/$CMAKE_FOLDER/CMake.app/Contents/bin/cmake
		elif [ "${HOST_OS}" = "linux" ]; then
			CMAKE_EXE=$DKTOOLS_DIR/$CMAKE_FOLDER/bin/cmake
		elif [ "${HOST_OS}" = "raspberry" ]; then
			CMAKE_EXE=$DKTOOLS_DIR/$CMAKE_FOLDER/bin/cmake
		else
			dk_error "no cmake for this OS"
		fi
		dk_debug CMAKE_EXE
		
		if dk_file_exists "$CMAKE_EXE"; then 
			return $true;
		fi

		dk_echo 
		dk_info "Installing cmake . . ."
		dk_download "$CMAKE_DL" "$DKDOWNLOAD_DIR"/"$CMAKE_DL_FILE"
		dk_extract "$DKDOWNLOAD_DIR"/"$CMAKE_DL_FILE" "$DKTOOLS_DIR"
		
		#if ! dk_file_exists $CMAKE_EXE; then error "cannot find cmake"; fi

	else	# linux package
		dk_info "Installing CMake from package managers"
		
		CMAKE_EXE=$(command -v cmake)
		dk_debug CMAKE_EXE
		if ! dk_command_exists cmake; then
			dk_install ${CMAKE_IMPORT}
		fi	
		CMAKE_EXE=$(command -v cmake)
		dk_debug CMAKE_EXE
	fi
}