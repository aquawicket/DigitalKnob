if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_generate){ $dk_generate = 1 } else{ return }


##################################################################################
# dk_generate()
#
#
function Global:dk_generate() {
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	dk_echo
	dk_echo "##################################################################"
	dk_echo "     Generating $APP - $TARGET_OS - $TYPE - $DKLEVEL"
	dk_echo "##################################################################"
	dk_echo

	dk_clearCmakeCache
	dk_deleteTempFiles

	$TARGET_PATH = "$DKAPPS_DIR\$APP"
	dk_printVar TARGET_PATH
	dk_makeDirectory "$TARGET_PATH\$TARGET_OS"
	cd "$TARGET_PATH\$TARGET_OS"
	$CMAKE_SOURCE_DIR = $DKCMAKE_DIR
	dk_printVar CMAKE_SOURCE_DIR
	if(! dk_fileExists "$CMAKE_SOURCE_DIR"){
		dk_error "CMAKE_SOURCE_DIR does not exist"
	}
	dk_printVar CMAKE_SOURCE_DIR
	$CMAKE_TARGET_PATH = $TARGET_PATH
	dk_printVar CMAKE_TARGET_PATH
	
	###### BUILD CMAKE_ARGS ARRAY ######
	$DKLEVEL = "RebuildAll"
	$DKLINK = "Static"
	
	#declare -a CMAKE_ARGS
	set --											#clear the positional parameters
	if($TYPE -eq "Debug"){
		#set -- "-DDEBUG=ON" )
		set -- "$@" "-DDEBUG=ON"
		set -- "$@" "-DRELEASE=OFF"
	}
	if($TYPE -eq "Release"){ 
		set -- "$@" "-DDEBUG=OFF"
		set -- "$@" "-DRELEASE=ON"
	}
	if($TYPE -eq "All"){ 
		set -- "$@" "-DDEBUG=ON"
		set -- "$@" "-DRELEASE=ON"
	}
	if($DKLEVEL -eq "Build"){ 
		set -- "$@" "-DBUILD=ON"
	}
	if($DKLEVEL -eq "Rebuild"){ 
		set -- "$@" "-DREBUILD=ON"
	}
	if($DKLEVEL -eq "RebuildAll"){ 
		set -- "$@" "-DREBUILDALL=ON"
	}
	if($DKLINK -eq "Static"){ 
		set -- "$@" "-DSTATIC=ON"
	}
	if($DKLINK -eq "Shared"){ 
		set -- "$@" "-DSHARED=ON"
	}
	
	CMAKE_BINARY_DIR=$CMAKE_TARGET_PATH\$TARGET_OS\$TYPE
	dk_printVar CMAKE_BINARY_DIR
	
	if ! dk_defined WSLENV; then 
		set -- "$@" "-S=$CMAKE_SOURCE_DIR"
	}
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
	
	if($TARGET_OS -eq "android_arm32"){ 
		set -- "-G Unix Makefiles" "$@"
	}

	if($TARGET_OS -eq "android_arm64"){ 
		set -- "-G Unix Makefiles" "$@"
	}
	
	if($TARGET_OS -eq "emscripten"){ 
		set -- "-G Unix Makefiles" "$@"
	}
	
	if($TARGET_OS -eq "ios_arm32"){ 
		set -- "-G Xcode" "$@"
	}
	
	if($TARGET_OS -eq "ios_arm64"){ 
		set -- "-G Xcode" "$@"
	}
	
	if($TARGET_OS -eq "iossim_x86"){ 
		set -- "-G Xcode" "$@"
	}
	
	if($TARGET_OS -eq "iossim_x86_64"){ 
		set -- "-G Xcode" "$@"
	}
	
	if($TARGET_OS -eq "linux_x86"){ 
		set -- "-G Unix Makefiles" "$@"
	}
	
	if($TARGET_OS -eq "linux_x86_64"){ 
		set -- "-G Unix Makefiles" "$@"
	}
	
	if($TARGET_OS -eq "mac_x86"){ 
		set -- "-G Xcode" "$@"
	}
	
	if($TARGET_OS -eq "mac_x86_64"){ 
		set -- "-G Xcode" "$@"
	}
	
	if($TARGET_OS -eq "raspberry_arm32"){ 
		set -- "-G Unix Makefiles" "$@"
	}
	
	if($TARGET_OS -eq "raspberry_arm64"){ 
		set -- "-G Unix Makefiles" "$@"
	}
	
	if($TARGET_OS -eq "win_arm64_clang"){ 
		export PATH=${DK3RDPARTY_DIR}\msys2-x86_64-20231026\clangarm64\bin:$PATH
		set -- "-G MSYS Makefiles" "$@"
	}
	
	if($TARGET_OS -eq "win_x86_clang"){ 
		export PATH=${DK3RDPARTY_DIR}\msys2-x86_64-20231026\clang32\bin:$PATH
		set -- "-G MSYS Makefiles" "$@"
	}
	
	if($TARGET_OS -eq "win_x86_mingw"){ 
		export PATH=${DK3RDPARTY_DIR}\msys2-x86_64-20231026\mingw32\bin:$PATH
		set -- "-G MSYS Makefiles" "$@"
	}
	
	if($TARGET_OS -eq "win_x86_64_clang"){ 
		export PATH=${DK3RDPARTY_DIR}\msys2-x86_64-20231026\clang64\bin:$PATH
		#set -- "-DCMAKE_EXE_LINKER_FLAGS=-static -mconsole"
		set -- "-G MSYS Makefiles" "$@"
		set -- "$@" "-DMSYSTEM=CLANG64"
	}
	
	if($TARGET_OS -eq "win_x86_64_mingw"){ 
		export PATH=${DK3RDPARTY_DIR}\msys2-x86_64-20231026\mingw64\bin:$PATH
		set -- "-G MSYS Makefiles" "$@"
	}
	
	if($TARGET_OS -eq "win_x86_64_ucrt"){ 
		export PATH=${DK3RDPARTY_DIR}\msys2-x86_64-20231026\ucrt64\bin:$PATH
		set -- "-G MSYS Makefiles" "$@"
		set -- "$@" "-DMSYSTEM=UCRT64"
	}

	###### CMAKE_TOOLCHAIN_FILE ######
#	TOOLCHAIN="${DKCMAKE_DIR}\toolchains\${TARGET_OS}_toolchain.cmake"
#	dk_echo "TOOLCHAIN = $TOOLCHAIN"
#	if dk_fileExists "$TOOLCHAIN"; then
#		set -- "$@" "-DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN"
#	}
	
	###### WSL CMake Fix ######
	if dk_defined WSLENV; then 
		cd "$DKCMAKE_DIR"
		set -- "$@" "."
	}
	
	###### CMake Configure ######
	dk_validateCmake
	
	dk_echo
	dk_echo "****** CMAKE COMMAND ******"
	dk_echo "CMAKE_ARGS = $@"	
	dk_call "$CMAKE_EXE" "$@"
	dk_echo
}






function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_generate
}