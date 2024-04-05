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
function dk_validate_cmake() {
	dk_debug "dk_validate_cmake($@)"
	
	if [[ $HOST_OS == "android" ]]; then
		CMAKE_SYSTEM_INSTALL=1
	fi
	if [[ $CMAKE_SYSTEM_INSTALL == 1 ]]; then
		echo "Installing CMake System packages"
		CMAKE_EXE=$(command -v cmake)
		dk_print_var CMAKE_EXE
		if ! dk_command_exists cmake; then
			if [[ "$MSYSTEM" == "CLANG32" ]]; then
				dk_install mingw-w64-clang-i686-cmake
			elif [[ "$MSYSTEM" == "CLANG64" ]]; then
				dk_install mingw-w64-clang-x86_64-cmake
			elif [[ "$MSYSTEM" == "CLANGARM64" ]]; then
				dk_install mingw-w64-clang-aarch64-cmake
			elif [[ "$MSYSTEM" == "MINGW32" ]]; then
				dk_install mingw-w64-i686-cmake
			elif [[ "$MSYSTEM" == "MINGW64" ]]; then
				dk_install mingw-w64-x86_64-cmake
			elif [[ "$MSYSTEM" == "UCRT64" ]]; then
				dk_install mingw-w64-ucrt-x86_64-cmake
			else
				dk_install cmake
			fi
		fi	
		CMAKE_EXE=$(command -v cmake)
		dk_print_var CMAKE_EXE
	else
		echo "Installing DK CMake packages"
		## New method of obtaining cmake
		######################################################################################################
		if [[ "${HOST_OS}_${HOST_ARCH}" == "win_arm32" ]];		then CMAKE_DL=$CMAKE_DL_WIN_ARM32;		fi
		if [[ "${HOST_OS}_${HOST_ARCH}" == "win_arm64" ]];		then CMAKE_DL=$CMAKE_DL_WIN_ARM64;		fi
		if [[ "${HOST_OS}_${HOST_ARCH}" == "win_x86" ]];		then CMAKE_DL=$CMAKE_DL_WIN_X86;		fi
		if [[ "${HOST_OS}_${HOST_ARCH}" == "win_x86_64" ]];		then CMAKE_DL=$CMAKE_DL_WIN_X86_64;		fi
		if [[ "${HOST_OS}" == "mac" ]];							then CMAKE_DL=$CMAKE_DL_MAC;			fi
		if [[ "${HOST_OS}_${HOST_ARCH}" == "linux_x86_64" ]];	then CMAKE_DL=$CMAKE_DL_LINUX_X86_64;	fi
		if [[ "${HOST_OS}_${HOST_ARCH}" == "linux_arm64" ]];	then CMAKE_DL=$CMAKE_DL_LINUX_ARM64;	fi
		dk_print_var CMAKE_DL
		
		dk_get_filename $CMAKE_DL CMAKE_DL_FILE
		dk_print_var CMAKE_DL_FILE
		
		CMAKE_FOLDER="${CMAKE_DL_FILE%.*}"		# remove everything past last dot
		dk_print_var CMAKE_FOLDER
		echo "CMAKE_DL_FILE extension = ${CMAKE_FOLDER##*.}"
		if [ "${CMAKE_FOLDER##*.}" == "tar" ]; then
			CMAKE_FOLDER="${CMAKE_FOLDER%.*}"	# .tar.?? files remove past the last TWO dots
		fi
		#dk_print_var CMAKE_FOLDER
		
		dk_convert_to_c_identifier $CMAKE_FOLDER CMAKE_FOLDER
		dk_convert_to_lowercase $CMAKE_FOLDER CMAKE_FOLDER
		dk_print_var CMAKE_FOLDER
		
		if [[ "${HOST_OS}" == "win" ]]; then
			CMAKE_EXE=$DKTOOLS_DIR/$CMAKE_FOLDER/bin/cmake.exe
		elif [[ "${HOST_OS}" == "mac" ]]; then
			CMAKE_EXE=$DKTOOLS_DIR/$CMAKE_FOLDER/CMake.app/Contents/bin/cmake
		elif [[ "${HOST_OS}" == "linux" ]]; then
			CMAKE_EXE=$DKTOOLS_DIR/$CMAKE_FOLDER/bin/cmake
		fi
		dk_print_var CMAKE_EXE
		
		if dk_file_exists $CMAKE_EXE; then return $true; fi

		echo ""   
		echo "Installing cmake . . ."
		dk_download $CMAKE_DL $DKDOWNLOAD_DIR/$CMAKE_DL_FILE
		echo "extract $CMAKE_DL_FILE $DKTOOLS_DIR"
		dk_extract $DKDOWNLOAD_DIR/$CMAKE_DL_FILE $DKTOOLS_DIR
		
		#if ! dk_file_exists $CMAKE_EXE; then error "cannot find cmake"; fi
	fi
}