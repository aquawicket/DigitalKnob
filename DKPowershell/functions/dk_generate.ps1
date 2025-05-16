if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_generate){ $dk_generate = 1 } else{ return } #include guard

##################################################################################
# dk_generate()
#
#
function Global:dk_generate() {
	dk_debugFunc 0
	
	dk_call dk_echo
	dk_call dk_echo "##################################################################"
	dk_call dk_echo "     Generating $Target_App - $Target_Tuple - $Target_Type - $Target_Level"
	dk_call dk_echo "##################################################################"
	dk_call dk_echo

	dk_call dk_clearCmakeCache
	dk_call dk_deleteTempFiles

	$TARGET_PATH = "$DKCPP_APPS_DIR/$Target_App"
	dk_call dk_printVar TARGET_PATH
	dk_call dk_mkdir "$TARGET_PATH/$Target_Tuple"
	cd "$TARGET_PATH/$Target_Tuple"
	$CMAKE_SOURCE_DIR = "$DKCMAKE_DIR"
	$CMAKE_SOURCE_DIR = $CMAKE_SOURCE_DIR -replace '\\', '/';
	dk_call dk_printVar CMAKE_SOURCE_DIR
	if(!(dk_call dk_pathExists "$CMAKE_SOURCE_DIR")){
		dk_call dk_error "CMAKE_SOURCE_DIR does not exist"
	}
	$CMAKE_TARGET_PATH = $TARGET_PATH
	dk_call dk_printVar CMAKE_TARGET_PATH
	$CMAKE_TARGET_PATH = $CMAKE_TARGET_PATH -replace '\\', '/';
	
	###### BUILD CMAKE_ARGS ARRAY ######
	$Target_Level = "RebuildAll"
	$DKLINK = "Static"
	
	$CMAKE_ARGS = @()
	if($Target_Tuple -eq "Android_Arm32")  	{ $CMAKE_ARGS += "-G Unix Makefiles" }
	elseif($Target_Tuple -eq "android_arm64")  { $CMAKE_ARGS += "-G Unix Makefiles" }
	elseif($Target_Tuple -eq "emscripten")     { $CMAKE_ARGS += "-G Unix Makefiles" }
	elseif($Target_Tuple -eq "ios_arm32")      { $CMAKE_ARGS += "-G Xcode" }
	elseif($Target_Tuple -eq "ios_arm64")      { $CMAKE_ARGS += "-G Xcode" }
	elseif($Target_Tuple -eq "Iossim_X86")     { $CMAKE_ARGS += "-G Xcode" }
	elseif($Target_Tuple -eq "iossim_x86_64")  { $CMAKE_ARGS += "-G Xcode" }
	elseif($Target_Tuple -eq "linux_x86")      { 
		$CMAKE_ARGS += "-G Unix Makefiles" 
		$DK_SHELL = "wsl"
	}
	elseif($Target_Tuple -eq "linux_x86_64")   { 
		$CMAKE_ARGS += "-G Unix Makefiles"
		$DK_SHELL = "wsl"
	}
	elseif($Target_Tuple -eq "mac_x86")        { $CMAKE_ARGS += "-G Xcode" }
	elseif($Target_Tuple -eq "mac_x86_64")     { $CMAKE_ARGS += "-G Xcode" }
	elseif($Target_Tuple -eq "raspberry_arm32"){ $CMAKE_ARGS += "-G Unix Makefiles" }
	elseif($Target_Tuple -eq "raspberry_arm64"){ $CMAKE_ARGS += "-G Unix Makefiles" }
	elseif($Target_Tuple -eq "Windows_Arm64_Clang"){ 
		dk_validate DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()"
	    $env:PATH = "${DK3RDPARTY_DIR}\msys2-x86_64-20231026\clangarm64\bin;$env:PATH"
		$CMAKE_ARGS += "-G MinGW Makefiles"
		$CMAKE_ARGS += "-DMSYSTEM=CLANGARM64"
	}
	elseif($Target_Tuple -eq "Windows_X86_Clang"){
		dk_validate DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()"
		$env:PATH = "${DK3RDPARTY_DIR}\msys2-x86_64-20231026\clang32\bin;$env:PATH"
		$CMAKE_ARGS += "-G MinGW Makefiles"
		$CMAKE_ARGS += "-DMSYSTEM=CLANG32"
	}
	elseif($Target_Tuple -eq "win_x86_mingw"){
		dk_validate DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()"
		$env:PATH = "${DK3RDPARTY_DIR}\msys2-x86_64-20231026\mingw32\bin;$env:PATH"
		$CMAKE_ARGS += "-G MinGW Makefiles"
		$CMAKE_ARGS += "-DMSYSTEM=MINGW32"
	}
	elseif($Target_Tuple -eq "Windows_X86_64_Clang"){
		dk_validate DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()"
		$env:PATH = "${DK3RDPARTY_DIR}\msys2-x86_64-20231026\clang64\bin;$env:PATH"
		#$CMAKE_ARGS += "-DCMAKE_EXE_LINKER_FLAGS=-static -mconsole"
		$CMAKE_ARGS += "-G MinGW Makefiles"
		$CMAKE_ARGS += "-DMSYSTEM=CLANG64"
	}
	elseif($Target_Tuple -eq "win_x86_64_mingw"){
		dk_validate DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()"
		$env:PATH = "${DK3RDPARTY_DIR}\msys2-x86_64-20231026\mingw64\bin;$env:PATH"
		$CMAKE_ARGS += "-G MinGW Makefiles"
		$CMAKE_ARGS += "-DMSYSTEM=MINGW64"
	}
	elseif($Target_Tuple -eq "Windows_X86_64_Ucrt"){
		dk_validate DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()"
		$env:PATH = "${DK3RDPARTY_DIR}\msys2-x86_64-20231026\ucrt64\bin;$env:PATH"
		$CMAKE_ARGS += "-G MinGW Makefiles"
		$CMAKE_ARGS += "-DMSYSTEM=UCRT64"
	}
	elseif($Target_Tuple -eq "Windows_X86_64_Msvc"){ 
		$CMAKE_ARGS += "-G Visual Studio 17 2022"
	}
	else{
		dk_call dk_error "Unrecognized Target_Tuple:${Target_Tuple}"	
	}

	
	if($Target_Type -eq "Debug"){
		$CMAKE_ARGS += "-DDEBUG=ON"
		$CMAKE_ARGS += "-DRELEASE=ON"
	}
	if($Target_Type -eq "Release"){ 
		$CMAKE_ARGS += "-DDEBUG=OFF"
		$CMAKE_ARGS += "-DRELEASE=ON"
	}
	if($Target_Type -eq "All"){ 
		$CMAKE_ARGS += "-DDEBUG=ON"
		$CMAKE_ARGS += "-DRELEASE=ON"
	}
	if($Target_Level -eq "Build"){ 
		$CMAKE_ARGS += "-DBUILD=ON"
	}
	if($Target_Level -eq "Rebuild"){ 
		$CMAKE_ARGS += "-DREBUILD=ON"
	}
	if($Target_Level -eq "RebuildAll"){ 
		$CMAKE_ARGS += "-DREBUILDALL=ON"
	}
	if($DKLINK -eq "Static"){ 
		$CMAKE_ARGS += "-DSTATIC=ON"
	}
	if($DKLINK -eq "Shared"){ 
		$CMAKE_ARGS += "-DSHARED=ON"
	}
	
	
	::###### linux (WSL) ######
	if($DK_SHELL){ $DKSCRIPT_DIR = $DKSCRIPT_DIR -replace "C:", "/mnt/c" }
	if($DK_SHELL){ $DKSCRIPT_DIR = $DKSCRIPT_DIR -replace '\\', '/' }
	if($DK_SHELL){ dk_call "C:\Windows\System32\wsl.exe" bash -c "export UPDATE=1 && export Target_App=${Target_App} && export Target_Tuple=${Target_Tuple} && export Target_Type=${Target_Type} && ${DKSCRIPT_DIR}/DKBuilder.sh && exit $(true)" }
	if($DK_SHELL){ return }
	
	
	$CMAKE_BINARY_DIR = "$CMAKE_TARGET_PATH\$Target_Tuple\$Target_Type"
	$CMAKE_BINARY_DIR = $CMAKE_BINARY_DIR -replace '\\', '/';
	dk_call dk_printVar CMAKE_BINARY_DIR
	
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
	
#	###### CMAKE_TOOLCHAIN_FILE ######
#	$TOOLCHAIN = "${DKCMAKE_DIR}\toolchains\${Target_Tuple}_toolchain.cmake"
#	$TOOLCHAIN = $TOOLCHAIN -replace '\\', '/';
#	dk_call dk_echo "TOOLCHAIN = $TOOLCHAIN"
#	if(dk_call dk_pathExists "$TOOLCHAIN"){ $CMAKE_ARGS += "-DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN" }
	
	###### WSL CMake Fix ######
	if($WSLENV){ 
		cd "$DKCMAKE_DIR"
		$CMAKE_ARGS += "."
	}
	
	###### CMake Configure ######
	dk_call dk_source $DKIMPORTS_DIR/cmake/dk_install.ps1
	dk_call dk_install
	
	dk_call dk_echo
	dk_call dk_echo "****** CMAKE COMMAND ******"
	dk_call dk_echo "$CMAKE_EXE $CMAKE_ARGS ${clr}"
	dk_call dk_call "$CMAKE_EXE" @CMAKE_ARGS
	dk_call dk_echo
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_generate
}