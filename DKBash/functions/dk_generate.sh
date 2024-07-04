#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"


##################################################################################
# dk_generate()
#
#
dk_generate (){
	dk_debugFunc
	[ $# -ne 0 ] && dk_error "${FUNCNAME}($#): incorrect number of arguments"
	
	dk_echo
	dk_echo "##################################################################"
	dk_echo "     Generating $APP - $TARGET_OS - $TYPE - ${DKLEVEL-}"
	dk_echo "##################################################################"
	dk_echo

	dk_clearCmakeCache
	dk_deleteTempFiles

	TARGET_PATH="$DKAPPS_DIR"/"$APP"
	dk_printVar TARGET_PATH
	dk_makeDirectory "$TARGET_PATH"/"$TARGET_OS"
	cd "$TARGET_PATH"/"$TARGET_OS"
	CMAKE_SOURCE_DIR="$DKCMAKE_DIR"
	dk_printVar CMAKE_SOURCE_DIR
	$(dk_pathExists "$CMAKE_SOURCE_DIR") || dk_error "CMAKE_SOURCE_DIR does not exist"
	dk_printVar CMAKE_SOURCE_DIR
	CMAKE_TARGET_PATH=$TARGET_PATH
	dk_printVar CMAKE_TARGET_PATH
	
	###### BUILD CMAKE_ARGS ARRAY ######
	DKLEVEL="RebuildAll"
	DKLINK="Static"
	
	#declare -a CMAKE_ARGS
	set --											#clear the positional parameters
	if [ "$TYPE" = "Debug" ]; then
		#set -- "-DDEBUG=ON" )
		#set -- "$@" "-DDEBUG=ON"
		dk_appendArgs CMAKE_ARGS "-DDEBUG=ON"
		dk_appendArgs CMAKE_ARGS "-DRELEASE=OFF"
	fi
	if [ "$TYPE" = "Release" ]; then
		dk_appendArgs CMAKE_ARGS "-DDEBUG=OFF"
		dk_appendArgs CMAKE_ARGS "-DRELEASE=ON"
	fi
	if [ "$TYPE" = "All" ]; then
		dk_appendArgs CMAKE_ARGS "-DDEBUG=ON"
		dk_appendArgs CMAKE_ARGS "-DRELEASE=ON"
	fi
	if [ "$DKLEVEL" = "Build" ]; then
		dk_appendArgs CMAKE_ARGS "-DBUILD=ON"
	fi
	if [ "$DKLEVEL" = "Rebuild" ]; then
		dk_appendArgs CMAKE_ARGS "-DREBUILD=ON"
	fi
	if [ "$DKLEVEL" = "RebuildAll" ]; then
		dk_appendArgs CMAKE_ARGS "-DREBUILDALL=ON"
	fi
	if [ "$DKLINK" = "Static" ]; then
		dk_appendArgs CMAKE_ARGS "-DSTATIC=ON"
	fi
	if [ "$DKLINK" = "Shared" ]; then
		dk_appendArgs CMAKE_ARGS "-DSHARED=ON"
	fi
	
	CMAKE_BINARY_DIR=$CMAKE_TARGET_PATH/$TARGET_OS/$TYPE
	dk_printVar CMAKE_BINARY_DIR
	
	if ! dk_defined WSLENV; then 
		dk_appendArgs CMAKE_ARGS "-S=$CMAKE_SOURCE_DIR"
	fi
	dk_appendArgs CMAKE_ARGS "-B=$CMAKE_BINARY_DIR"
	
	############ CMake Options ############
    #dk_appendArgs CMAKE_ARGS "-DCMAKE_VERBOSE_MAKEFILE=1"
	#dk_appendArgs CMAKE_ARGS "-DCMAKE_COLOR_DIAGNOSTICS=ON"
	#dk_appendArgs CMAKE_ARGS "-Wdev"
	#dk_appendArgs CMAKE_ARGS "-Werror=dev"
	#dk_appendArgs CMAKE_ARGS "-Wdeprecated"
	#dk_appendArgs CMAKE_ARGS "-Werror=deprecated"
	#dk_appendArgs CMAKE_ARGS "--graphviz=graphviz.txt"
	#dk_appendArgs CMAKE_ARGS "--system-information system_information.txt"
	#dk_appendArgs CMAKE_ARGS "--debug-trycompile"
	#dk_appendArgs CMAKE_ARGS "--debug-output"
	#dk_appendArgs CMAKE_ARGS "--trace"
	#dk_appendArgs CMAKE_ARGS "--trace-expand"
	#dk_appendArgs CMAKE_ARGS "--warn-uninitialized"
	#dk_appendArgs CMAKE_ARGS "--warn-unused-vars"
	#dk_appendArgs CMAKE_ARGS "--check-system-vars"
	
	if [ "$TARGET_OS" = "android_arm32" ]; then
		#set -- "-G Unix Makefiles" "$@"
		dk_prependArgs CMAKE_ARGS "-G Unix Makefiles" 
	fi

	if [ "$TARGET_OS" = "android_arm64" ]; then
		#set -- "-G Unix Makefiles" "$@"
		dk_prependArgs CMAKE_ARGS -G "Unix Makefiles"
	fi
	
	if [ "$TARGET_OS" = "emscripten" ]; then
		#set -- "-G Unix Makefiles" "$@"
		dk_prependArgs CMAKE_ARGS "-G Unix Makefiles" 
	fi
	
	if [ "$TARGET_OS" = "ios_arm32" ]; then
		#set -- "-G Xcode" "$@"
		dk_prependArgs CMAKE_ARGS "-G Xcode"
	fi
	
	if [ "$TARGET_OS" = "ios_arm64" ]; then
		#set -- "-G Xcode" "$@"
		dk_prependArgs CMAKE_ARGS "-G Xcode"
	fi
	
	if [ "$TARGET_OS" = "iossim_x86" ]; then
		#set -- "-G Xcode" "$@"
		dk_prependArgs CMAKE_ARGS "-G Xcode"
	fi
	
	if [ "$TARGET_OS" = "iossim_x86_64" ]; then
		#set -- "-G Xcode" "$@"
		dk_prependArgs CMAKE_ARGS "-G Xcode"
	fi
	
	if [ "$TARGET_OS" = "linux_x86" ]; then
		#set -- "-G Unix Makefiles" "$@"
		dk_prependArgs CMAKE_ARGS "-G Unix Makefiles" 
	fi
	
	if [ "$TARGET_OS" = "linux_x86_64" ]; then
		#set -- "-G Unix Makefiles" "$@"
		dk_prependArgs CMAKE_ARGS "-G Unix Makefiles" 
	fi
	
	if [ "$TARGET_OS" = "mac_x86" ]; then
		#set -- "-G Xcode" "$@"
		dk_prependArgs CMAKE_ARGS "-G Xcode"
	fi
	
	if [ "$TARGET_OS" = "mac_x86_64" ]; then
		#set -- "-G Xcode" "$@"
		dk_prependArgs CMAKE_ARGS "-G Xcode"
	fi
	
	if [ "$TARGET_OS" = "raspberry_arm32" ]; then
		#set -- "-G Unix Makefiles" "$@"
		dk_prependArgs CMAKE_ARGS "-G Unix Makefiles" 
	fi
	
	if [ "$TARGET_OS" = "raspberry_arm64" ]; then
		#set -- "-G Unix Makefiles" "$@"
		dk_prependArgs CMAKE_ARGS "-G Unix Makefiles" 
	fi
	
	if [ "$TARGET_OS" = "win_arm64_clang" ]; then
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/clangarm64/bin:$PATH
		#set -- "-G MSYS Makefiles" "$@"
		dk_prependArgs CMAKE_ARGS "-G MSYS Makefiles" 
	fi
	
	if [ "$TARGET_OS" = "win_x86_clang" ]; then
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/clang32/bin:$PATH
		#set -- "-G MSYS Makefiles" "$@"
		dk_prependArgs CMAKE_ARGS "-G MSYS Makefiles"
	fi
	
	if [ "$TARGET_OS" = "win_x86_mingw" ]; then
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/mingw32/bin:$PATH
		#set -- "-G MSYS Makefiles" "$@"
		dk_prependArgs CMAKE_ARGS "-G MSYS Makefiles"
	fi
	
	if [ "$TARGET_OS" = "win_x86_64_clang" ]; then
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/clang64/bin:$PATH
		#set -- "-DCMAKE_EXE_LINKER_FLAGS=-static -mconsole"
		#set -- "-G MSYS Makefiles" "$@"
		dk_appendArgs CMAKE_ARGS "-DMSYSTEM=CLANG64"
		dk_prependArgs CMAKE_ARGS "-G "MSYS Makefiles""
	fi
	
	if [ "$TARGET_OS" = "win_x86_64_mingw" ]; then
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/mingw64/bin:$PATH
		#set -- "-G MSYS Makefiles" "$@"
		dk_prependArgs CMAKE_ARGS "-G MSYS Makefiles"
	fi
	
	if [ "$TARGET_OS" = "win_x86_64_ucrt" ]; then
		export PATH=${DK3RDPARTY_DIR}/msys2-x86_64-20231026/ucrt64/bin:$PATH
		#set -- "-G MSYS Makefiles" "$@"
		dk_appendArgs CMAKE_ARGS "-DMSYSTEM=UCRT64"
		dk_prependArgs CMAKE_ARGS "-G MSYS Makefiles"
	fi

	###### CMAKE_TOOLCHAIN_FILE ######
#	TOOLCHAIN="${DKCMAKE_DIR}/toolchains/${TARGET_OS}_toolchain.cmake"
#	dk_echo "TOOLCHAIN = $TOOLCHAIN"
#	if dk_pathExists "$TOOLCHAIN"; then
#		dk_appendArgs CMAKE_ARGS "-DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN"
#	fi
	
	###### WSL CMake Fix ######
	if dk_defined WSLENV; then 
		cd "$DKCMAKE_DIR"
		dk_appendArgs CMAKE_ARGS "."
	fi
	
	###### CMake Configure ######
	dk_installCmake
	
	dk_echo
	dk_echo "****** CMAKE COMMAND ******"
	#dk_echo "CMAKE_ARGS = $*"
	dk_echo "CMAKE_ARGS = $CMAKE_ARGS"
	#dk_call "$CMAKE_EXE" "$@" #&& echo "CMake Generation Successful" || dk_error "CMake Generation Failed"
	dk_call "$CMAKE_EXE" $CMAKE_ARGS
	dk_echo
}






DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_generate
}