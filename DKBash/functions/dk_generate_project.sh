#include_guard()

##################################################################################
# dk_generate_project()
#
#
function dk_generate_project() {
	dk_debug "dk_generate_project("$@")"
	echo ""
	echo "##################################################################"
	echo "     Generating $APP - $TARGET_OS - $TYPE - $DKLEVEL"
	echo "##################################################################"
	echo ""

	clear_cmake_cache
	delete_temp_files

	TARGET_PATH=$DKAPPS_DIR/$APP
	print_var TARGET_PATH
	mkdir -p $TARGET_PATH/$TARGET_OS
	cd $TARGET_PATH/$TARGET_OS
	CMAKE_SOURCE_DIR="$DKCMAKE_DIR"
	print_var CMAKE_SOURCE_DIR
	if ! dk_file_exists $CMAKE_SOURCE_DIR; then
		dk_error "CMAKE_SOURCE_DIR does not exist"
	fi
	print_var CMAKE_SOURCE_DIR
	CMAKE_TARGET_PATH=$TARGET_PATH
	print_var CMAKE_TARGET_PATH
	
	###### BUILD CMAKE_ARGS ARRAY ######
	DKLEVEL="RebuildAll"
	DKLINK="Static"
	
	declare -a CMAKE_ARGS
	if [[ $TYPE == "Debug" ]]; then
		CMAKE_ARGS+=( "-DDEBUG=ON" )
		CMAKE_ARGS+=( "-DRELEASE=OFF" )
	fi
	if [[ $TYPE == "Release" ]]; then
		CMAKE_ARGS+=( "-DDEBUG=OFF" )
		CMAKE_ARGS+=( "-DRELEASE=ON" )
	fi
	if [[ $TYPE == "All" ]]; then
		CMAKE_ARGS+=( "-DDEBUG=ON" )
		CMAKE_ARGS+=( "-DRELEASE=ON" )
	fi
	if [[ $DKLEVEL == "Build" ]]; then
		CMAKE_ARGS+=( "-DBUILD=ON" )
	fi
	if [[ $DKLEVEL == "Rebuild" ]]; then
		CMAKE_ARGS+=( "-DREBUILD=ON" )
	fi
	if [[ $DKLEVEL == "RebuildAll" ]]; then
		CMAKE_ARGS+=( "-DREBUILDALL=ON" )
	fi
	if [[ $DKLINK == "Static" ]]; then
		CMAKE_ARGS+=( "-DSTATIC=ON" )
	fi
	if [[ $DKLINK == "Shared" ]]; then
		CMAKE_ARGS+=( "-DSHARED=ON" )
	fi
	
	CMAKE_BINARY_DIR=$CMAKE_TARGET_PATH/$TARGET_OS/$TYPE
	print_var CMAKE_BINARY_DIR
	
	if ! [[ $WSL == 1 ]]; then
		CMAKE_ARGS+=( "-S=$CMAKE_SOURCE_DIR" )
	fi
	CMAKE_ARGS+=( "-B=$CMAKE_BINARY_DIR" )
	
	############ CMake Options ############
    #CMAKE_ARGS+=( "-DCMAKE_VERBOSE_MAKEFILE=1" ) 
    #CMAKE_ARGS+=( "--debug-output" )
	#CMAKE_ARGS+=( "--trace" )
	#CMAKE_ARGS+=( "--warn-unused-vars" )
	
	if [[ "$TARGET_OS" == "android_arm32" ]]; then
		CMAKE_ARGS+=( -G "Unix Makefiles" )
	fi

	if [[ "$TARGET_OS" == "android_arm64" ]]; then
		CMAKE_ARGS+=( "-G Unix Makefiles" )
	fi
	
	if [[ "$TARGET_OS" == "emscripten" ]]; then
		CMAKE_ARGS+=( "-G Unix Makefiles" )
	fi
	
	if [[ "$TARGET_OS" == "ios_arm32" ]]; then
		CMAKE_ARGS+=( "-G Xcode" )
	fi
	
	if [[ "$TARGET_OS" == "ios_arm64" ]]; then
		CMAKE_ARGS+=( "-G Xcode" )
	fi
	
	if [[ "$TARGET_OS" == "iossim_x86" ]]; then
		CMAKE_ARGS+=( "-G Xcode" )
	fi
	
	if [[ "$TARGET_OS" == "iossim_x86_64" ]]; then
		CMAKE_ARGS+=( "-G Xcode" )
	fi
	
	if [[ "$TARGET_OS" == "linux_x86" ]]; then
		CMAKE_ARGS+=( "-G Unix Makefiles" )
	fi
	
	if [[ "$TARGET_OS" == "linux_x86_64" ]]; then
		CMAKE_ARGS+=(-G)
		CMAKE_ARGS+=("Unix Makefiles")
	fi
	
	if [[ "$TARGET_OS" == "mac_x86" ]]; then
		CMAKE_ARGS+=( "-G Xcode" )
	fi
	
	if [[ "$TARGET_OS" == "mac_x86_64" ]]; then
		CMAKE_ARGS+=( "-G Xcode" )
	fi
	
	if [[ "$TARGET_OS" == "raspberry_arm32" ]]; then
		CMAKE_ARGS+=( "-G Unix Makefiles" )
	fi
	
	if [[ "$TARGET_OS" == "raspberry_arm64" ]]; then
		CMAKE_ARGS+=( "-G Unix Makefiles" )
	fi
	
	if [[ "$TARGET_OS" == "win_x86" ]]; then
		CMAKE_ARGS+=( "-G MSYS Makefiles" )
		#CMAKE_ARGS+=( "-DCMAKE_EXE_LINKER_FLAGS=-static -mconsole" )
	fi
	
	if [[ "$TARGET_OS" == "win_x86_64" ]]; then
		CMAKE_ARGS+=( "-G MSYS Makefiles" )
		#CMAKE_ARGS+=( "-DCMAKE_EXE_LINKER_FLAGS=-static -mconsole" )
	fi
	
	#### CMAKE CALL ####
	validate_cmake
	TOOLCHAIN="${DKCMAKE_DIR}/toolchains/${TARGET_OS}_toolchain.cmake"
	echo "TOOLCHAIN = $TOOLCHAIN"
	if dk_file_exists $TOOLCHAIN; then
		CMAKE_ARGS+=( "-DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN" )
	fi
	
	if [[ $WSL == 1 ]]; then
		cd $DKCMAKE_DIR
		CMAKE_ARGS+=( .)
	fi
	
	#echo CMAKE_ARGS = "${CMAKE_ARGS[@]}
	dk_call $CMAKE_EXE "${CMAKE_ARGS[@]}" 
}