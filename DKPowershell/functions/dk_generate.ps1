if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_generate){ $dk_generate = 1 } else{ return }

dk_load dk_installCmake
dk_load dk_call
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
	$CMAKE_SOURCE_DIR = "$DKCMAKE_DIR"
	$CMAKE_SOURCE_DIR = $CMAKE_SOURCE_DIR -replace '\\', '/';
	dk_printVar CMAKE_SOURCE_DIR
	if(!(dk_pathExists "$CMAKE_SOURCE_DIR")){
		dk_error "CMAKE_SOURCE_DIR does not exist"
	}
	$CMAKE_TARGET_PATH = $TARGET_PATH
	dk_printVar CMAKE_TARGET_PATH
	$CMAKE_TARGET_PATH = $CMAKE_TARGET_PATH -replace '\\', '/';
	
	###### BUILD CMAKE_ARGS ARRAY ######
	$DKLEVEL = "RebuildAll"
	$DKLINK = "Static"
	
	$CMAKE_ARGS = @()
	if($TARGET_OS -eq "android_arm32")  { $CMAKE_ARGS += "-G Unix Makefiles" }
	if($TARGET_OS -eq "android_arm64")  { $CMAKE_ARGS += "-G Unix Makefiles" }
	if($TARGET_OS -eq "emscripten")     { $CMAKE_ARGS += "-G Unix Makefiles" }
	if($TARGET_OS -eq "ios_arm32")      { $CMAKE_ARGS += "-G Xcode" }
	if($TARGET_OS -eq "ios_arm64")      { $CMAKE_ARGS += "-G Xcode" }
	if($TARGET_OS -eq "iossim_x86")     { $CMAKE_ARGS += "-G Xcode" }
	if($TARGET_OS -eq "iossim_x86_64")  { $CMAKE_ARGS += "-G Xcode" }
	if($TARGET_OS -eq "linux_x86")      { $CMAKE_ARGS += "-G Unix Makefiles" }
	if($TARGET_OS -eq "linux_x86_64")   { $CMAKE_ARGS += "-G Unix Makefiles" }
	if($TARGET_OS -eq "mac_x86")        { $CMAKE_ARGS += "-G Xcode" }
	if($TARGET_OS -eq "mac_x86_64")     { $CMAKE_ARGS += "-G Xcode" }
	if($TARGET_OS -eq "raspberry_arm32"){ $CMAKE_ARGS += "-G Unix Makefiles" }
	if($TARGET_OS -eq "raspberry_arm64"){ $CMAKE_ARGS += "-G Unix Makefiles" }
	if($TARGET_OS -eq "win_arm64_clang"){ 
	    $env:PATH = "${DK3RDPARTY_DIR}\msys2-x86_64-20231026\clangarm64\bin;$env:PATH"
		$CMAKE_ARGS += "-G MinGW Makefiles "
	}
	if($TARGET_OS -eq "win_x86_clang"){ 
		$env:PATH = "${DK3RDPARTY_DIR}\msys2-x86_64-20231026\clang32\bin;$env:PATH"
		$CMAKE_ARGS += "-G MinGW Makefiles "
	}
	if($TARGET_OS -eq "win_x86_mingw"){ 
		$env:PATH = "${DK3RDPARTY_DIR}\msys2-x86_64-20231026\mingw32\bin;$env:PATH"
		$CMAKE_ARGS += "-G MinGW Makefiles "
	}
	if($TARGET_OS -eq "win_x86_64_clang"){ 
		$env:PATH = "${DK3RDPARTY_DIR}\msys2-x86_64-20231026\clang64\bin;$env:PATH"
		#$CMAKE_ARGS += "-DCMAKE_EXE_LINKER_FLAGS=-static -mconsole"
		$CMAKE_ARGS += "-G MinGW Makefiles"
		$CMAKE_ARGS += "-DMSYSTEM=CLANG64"
	}
	if($TARGET_OS -eq "win_x86_64_mingw"){ 
		$env:PATH = "${DK3RDPARTY_DIR}\msys2-x86_64-20231026\mingw64\bin;$env:PATH"
		$CMAKE_ARGS += "-G MinGW Makefiles "
	}
	if($TARGET_OS -eq "win_x86_64_ucrt"){ 
		$env:PATH = "${DK3RDPARTY_DIR}\msys2-x86_64-20231026\ucrt64\bin;$env:PATH"
		$CMAKE_ARGS += "-G MinGW Makefiles "
		$CMAKE_ARGS += "-DMSYSTEM=UCRT64"
	}

	
	if($TYPE -eq "Debug"){
		$CMAKE_ARGS += "-DDEBUG=ON"
		$CMAKE_ARGS += "-DRELEASE=ON"
	}
	if($TYPE -eq "Release"){ 
		$CMAKE_ARGS += "-DDEBUG=OFF"
		$CMAKE_ARGS += "-DRELEASE=ON"
	}
	if($TYPE -eq "All"){ 
		$CMAKE_ARGS += "-DDEBUG=ON"
		$CMAKE_ARGS += "-DRELEASE=ON"
	}
	if($DKLEVEL -eq "Build"){ 
		$CMAKE_ARGS += "-DBUILD=ON"
	}
	if($DKLEVEL -eq "Rebuild"){ 
		$CMAKE_ARGS += "-DREBUILD=ON"
	}
	if($DKLEVEL -eq "RebuildAll"){ 
		$CMAKE_ARGS += "-DREBUILDALL=ON"
	}
	if($DKLINK -eq "Static"){ 
		$CMAKE_ARGS += "-DSTATIC=ON"
	}
	if($DKLINK -eq "Shared"){ 
		$CMAKE_ARGS += "-DSHARED=ON"
	}
	
	$CMAKE_BINARY_DIR = "$CMAKE_TARGET_PATH\$TARGET_OS\$TYPE"
	dk_printVar CMAKE_BINARY_DIR
	
	#if(!($WSLENV)){ 
		$CMAKE_ARGS += "-S=$CMAKE_SOURCE_DIR"
	#}
	$CMAKE_ARGS += "-B=$CMAKE_BINARY_DIR"
	
	############ CMake Options ############
    #$CMAKE_ARGS += "-DCMAKE_VERBOSE_MAKEFILE=1"
	#$CMAKE_ARGS += "-DCMAKE_COLOR_DIAGNOSTICS=ON"
	#$CMAKE_ARGS += "-Wdev"
	#$CMAKE_ARGS += "-Werror=dev"
	#$CMAKE_ARGS += "-Wdeprecated"
	#$CMAKE_ARGS += "-Werror=deprecated"
	#$CMAKE_ARGS += "--graphviz=graphviz.txt"
	#$CMAKE_ARGS += "--system-information system_information.txt"
	#$CMAKE_ARGS += "--debug-trycompile"
	#$CMAKE_ARGS += "--debug-output"
	#$CMAKE_ARGS += "--trace"
	#$CMAKE_ARGS += "--trace-expand"
	#$CMAKE_ARGS += "--warn-uninitialized"
	#$CMAKE_ARGS += "--warn-unused-vars"
	#$CMAKE_ARGS += "--check-system-vars"
	
	###### CMAKE_TOOLCHAIN_FILE ######
#	TOOLCHAIN="${DKCMAKE_DIR}\toolchains\${TARGET_OS}_toolchain.cmake"
#	dk_echo "TOOLCHAIN = $TOOLCHAIN"
#	if dk_pathExists "$TOOLCHAIN"; then
#		$CMAKE_ARGS += "-DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN"
#	}
	
	###### WSL CMake Fix ######
	if($WSLENV){ 
		cd "$DKCMAKE_DIR"
		$CMAKE_ARGS += "."
	}
	
	###### CMake Configure ######
	dk_installCmake
	
	dk_echo
	dk_echo "****** CMAKE COMMAND ******"
	dk_echo "$CMAKE_EXE $CMAKE_ARGS"
	dk_call "$CMAKE_EXE" @CMAKE_ARGS
	dk_echo
}






function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_generate
}