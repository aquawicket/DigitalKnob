# dk_include_guard()

##################################################################################
# dk_generate()
#
#
dk_generate() {
	dk_verbose "dk_generate($*)"
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"
	
	dk_echo
	dk_echo "##################################################################"
	dk_echo "     Generating $APP - $TARGET_OS - $TYPE - ${DKLEVEL-}"
	dk_echo "##################################################################"
	dk_echo

	dk_clear_cmake_cache
	dk_delete_temp_files

	TARGET_PATH="$DKAPPS_DIR"/"$APP"
	dk_debug TARGET_PATH
	mkdir -p "$TARGET_PATH"/"$TARGET_OS"
	cd "$TARGET_PATH"/"$TARGET_OS"
	CMAKE_SOURCE_DIR="$DKCMAKE_DIR"
	dk_debug CMAKE_SOURCE_DIR
	if ! dk_file_exists "$CMAKE_SOURCE_DIR"; then
		dk_error "CMAKE_SOURCE_DIR does not exist"
	fi
	dk_debug CMAKE_SOURCE_DIR
	CMAKE_TARGET_PATH=$TARGET_PATH
	dk_debug CMAKE_TARGET_PATH
	
	###### BUILD CMAKE_ARGS ARRAY ######
	DKLEVEL="RebuildAll"
	DKLINK="Static"
	
	#declare -a CMAKE_ARGS
	set --											#clear the positional parameters
	if [ "$TYPE" = "Debug" ]; then
		#set -- "-DDEBUG=ON" )
		set -- "$@" "-DDEBUG=ON"
		set -- "$@" "-DRELEASE=OFF"
	fi
	if [ "$TYPE" = "Release" ]; then
		set -- "$@" "-DDEBUG=OFF"
		set -- "$@" "-DRELEASE=ON"
	fi
	if [ "$TYPE" = "All" ]; then
		set -- "$@" "-DDEBUG=ON"
		set -- "$@" "-DRELEASE=ON"
	fi
	if [ "$DKLEVEL" = "Build" ]; then
		set -- "$@" "-DBUILD=ON"
	fi
	if [ "$DKLEVEL" = "Rebuild" ]; then
		set -- "$@" "-DREBUILD=ON"
	fi
	if [ "$DKLEVEL" = "RebuildAll" ]; then
		set -- "$@" "-DREBUILDALL=ON"
	fi
	if [ "$DKLINK" = "Static" ]; then
		set -- "$@" "-DSTATIC=ON"
	fi
	if [ "$DKLINK" = "Shared" ]; then
		set -- "$@" "-DSHARED=ON"
	fi
	
	CMAKE_BINARY_DIR=$CMAKE_TARGET_PATH/$TARGET_OS/$TYPE
	dk_debug CMAKE_BINARY_DIR
	
	if ! dk_defined WSLENV; then 
		set -- "$@" "-S=$CMAKE_SOURCE_DIR"
	fi
	set -- "$@" "-B=$CMAKE_BINARY_DIR"
	
	############ CMake Options ############
    #set -- "$@" "-DCMAKE_VERBOSE_MAKEFILE=1"
	#set -- "$@" "-DCMAKE_COLOR_DIAGNOSTICS=ON"
	#set -- "$@" "-Wdev"
	#set -- "$@" "-Werror=dev"
	#set -- "$@" "-Wdeprecated"
	#set -- "$@" "-Werror=deprecated"
	#set -- "$@" "--graphviz=graphviz.txt"
	#set -- "$@" "--system-information system_information.txt"
	#set -- "$@" "--debug-trycompile"
	#set -- "$@" "--debug-output"
	#set -- "$@" "--trace"
	#set -- "$@" "--trace-expand"
	#set -- "$@" "--warn-uninitialized"
	#set -- "$@" "--warn-unused-vars"
	#set -- "$@" "--check-system-vars"
	
	if [ "$TARGET_OS" = "android_arm32" ]; then
		set -- "-G Unix Makefiles" "$@"
	fi

	if [ "$TARGET_OS" = "android_arm64" ]; then
		set -- "-G Unix Makefiles" "$@"
	fi
	
	if [ "$TARGET_OS" = "emscripten" ]; then
		set -- "-G Unix Makefiles" "$@"
	fi
	
	if [ "$TARGET_OS" = "ios_arm32" ]; then
		set -- "-G Xcode" "$@"
	fi
	
	if [ "$TARGET_OS" = "ios_arm64" ]; then
		set -- "-G Xcode" "$@"
	fi
	
	if [ "$TARGET_OS" = "iossim_x86" ]; then
		set -- "-G Xcode" "$@"
	fi
	
	if [ "$TARGET_OS" = "iossim_x86_64" ]; then
		set -- "-G Xcode" "$@"
	fi
	
	if [ "$TARGET_OS" = "linux_x86" ]; then
		set -- "-G Unix Makefiles" "$@"
	fi
	
	if [ "$TARGET_OS" = "linux_x86_64" ]; then
		set -- "-G Unix Makefiles" "$@"
	fi
	
	if [ "$TARGET_OS" = "mac_x86" ]; then
		set -- "-G Xcode" "$@"
	fi
	
	if [ "$TARGET_OS" = "mac_x86_64" ]; then
		set -- "-G Xcode" "$@"
	fi
	
	if [ "$TARGET_OS" = "raspberry_arm32" ]; then
		set -- "-G Unix Makefiles" "$@"
	fi
	
	if [ "$TARGET_OS" = "raspberry_arm64" ]; then
		set -- "-G Unix Makefiles" "$@"
	fi
	
	if [ "$TARGET_OS" = "win_arm64_clang" ]; then
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/clangarm64/bin:$PATH
		set -- "-G MSYS Makefiles" "$@"
	fi
	
	if [ "$TARGET_OS" = "win_x86_clang" ]; then
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/clang32/bin:$PATH
		set -- "-G MSYS Makefiles" "$@"
	fi
	
	if [ "$TARGET_OS" = "win_x86_mingw" ]; then
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/mingw32/bin:$PATH
		set -- "-G MSYS Makefiles" "$@"
	fi
	
	if [ "$TARGET_OS" = "win_x86_64_clang" ]; then
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/clang64/bin:$PATH
		#set -- "-DCMAKE_EXE_LINKER_FLAGS=-static -mconsole"
		set -- "-G MSYS Makefiles" "$@"
	fi
	
	if [ "$TARGET_OS" = "win_x86_64_mingw" ]; then
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/mingw64/bin:$PATH
		set -- "-G MSYS Makefiles" "$@"
	fi
	
	if [ "$TARGET_OS" = "win_x86_64_ucrt" ]; then
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/ucrt64/bin:$PATH
		set -- "-G MSYS Makefiles" "$@"
	fi

	###### CMAKE_TOOLCHAIN_FILE ######
#	TOOLCHAIN="${DKCMAKE_DIR}/toolchains/${TARGET_OS}_toolchain.cmake"
#	dk_echo "TOOLCHAIN = $TOOLCHAIN"
#	if dk_file_exists "$TOOLCHAIN"; then
#		set -- "$@" "-DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN"
#	fi
	
	###### WSL CMake Fix ######
	if dk_defined WSLENV; then 
		cd "$DKCMAKE_DIR"
		set -- "$@" "."
	fi
	
	###### CMake Configure ######
	dk_validate_cmake
	
	dk_echo
	dk_echo "****** CMAKE COMMAND ******"
	dk_echo "CMAKE_ARGS = $@"	
	dk_call "$CMAKE_EXE" "$@"
	dk_echo
}