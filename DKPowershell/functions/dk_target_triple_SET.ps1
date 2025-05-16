if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_target_tuple_SET){ $dk_target_tuple_SET = 1 } else{ return } #include guard

##################################################################################
# dk_target_tuple_SET()
#
#
function Global:dk_target_tuple_SET() {
	dk_debugFunc 0

	dk_call dk_echo
	dk_call dk_echo "${target_app} ${Target_Tuple} ${target_type}"
	dk_call dk_echo	
    dk_call dk_echo " 1) ${Host_Tuple}"
	dk_call dk_echo
	dk_call dk_echo " 2) Cosmopolitan"
	dk_call dk_echo " 3) Android_Arm32_Clang"
	dk_call dk_echo " 4) Android_Arm64_Clang"
	dk_call dk_echo " 5) Android_X86_Clang"
	dk_call dk_echo " 6) Android_X86_64_Clang"
	dk_call dk_echo " 7) Emscripten_X86_Clang"
	dk_call dk_echo " 8) Ios_Arm32_Clang"
	dk_call dk_echo " 9) Ios_Arm64_Clang"
	dk_call dk_echo "10) Ios_X86_Clang"
	dk_call dk_echo "11) Ios_X86_64_Clang"
	dk_call dk_echo "12) Iossim_Arm32_Clang"
	dk_call dk_echo "13) Iossim_Arm64_Clang"
	dk_call dk_echo "14) Iossim_X86_Clang"
	dk_call dk_echo "15) Iossim_X86_Clang"
	dk_call dk_echo "16) Linux_Arm32_Clang"
	dk_call dk_echo "17) Linux_Arm64_Clang"
	dk_call dk_echo "18) Linux_X86_Clang"
	dk_call dk_echo "19) Linux_X86_64_Clang"
	dk_call dk_echo "20) Mac_Arm32_Clang"
	dk_call dk_echo "21) Mac_Arm64_Clang"
	dk_call dk_echo "22) Mac_X86_Clang"
	dk_call dk_echo "23) Mac_X86_64_Clang"
	dk_call dk_echo "24) Raspberry_Arm32_Clang"
	dk_call dk_echo "25) Raspberry_Arm64_Clang"
	dk_call dk_echo "26) raspberry_x86_clang"
	dk_call dk_echo "27) raspberry_x86_64_clang"
	dk_call dk_echo "28) windows_arm32_clang"
	dk_call dk_echo "29) windows_arm64_clang"
	dk_call dk_echo "30) windows_x86_clang"
	dk_call dk_echo "31) windows_x86_gcc"
	dk_call dk_echo "32) windows_x86_msvc"
	dk_call dk_echo "33) windows_x86_64_clang"
	dk_call dk_echo "34) windows_x86_64_gcc"
	dk_call dk_echo "35) windows_x86_64_msvc"
	dk_call dk_echo "36) windows_x86_64_ucrt"
	dk_call dk_echo "37) Clear Screen"
	dk_call dk_echo "38) Go Back"
	dk_call dk_echo "39) Exit"
	dk_call dk_echo
	
	$input = Read-Host
	    if(${input} -eq  "1"){ $global:Target_Tuple = "${Host_Tuple}" }
	elseif(${input} -eq  "2"){ $global:Target_Tuple = "Cosmopolitan" }
	elseif(${input} -eq  "3"){ $global:Target_Tuple = "Android_Arm32_Clang" }
	elseif(${input} -eq  "4"){ $global:Target_Tuple = "Android_Arm64_Clang" }
	elseif(${input} -eq  "5"){ $global:Target_Tuple = "Android_X86_Clang" }
	elseif(${input} -eq  "6"){ $global:Target_Tuple = "Android_X86_64_Clang" }
	elseif(${input} -eq  "7"){ $global:Target_Tuple = "emscripten_clang" }
	elseif(${input} -eq  "8"){ $global:Target_Tuple = "Ios_Arm32_Clang" }
	elseif(${input} -eq  "9"){ $global:Target_Tuple = "Ios_Arm64_Clang" }
	elseif(${input} -eq "10"){ $global:Target_Tuple = "Ios_X86_Clang" }
	elseif(${input} -eq "11"){ $global:Target_Tuple = "Ios_X86_64_Clang" }
	elseif(${input} -eq "12"){ $global:Target_Tuple = "Iossim_Arm32_Clang" }
	elseif(${input} -eq "13"){ $global:Target_Tuple = "Iossim_Arm64_Clang" }
	elseif(${input} -eq "14"){ $global:Target_Tuple = "Iossim_X86_Clang" }
	elseif(${input} -eq "15"){ $global:Target_Tuple = "Iossim_X86_Clang" }
	elseif(${input} -eq "16"){ $global:Target_Tuple = "Linux_Arm32_Clang" }
	elseif(${input} -eq "17"){ $global:Target_Tuple = "Linux_Arm64_Clang" }
	elseif(${input} -eq "18"){ $global:Target_Tuple = "Linux_X86_Clang" }
	elseif(${input} -eq "19"){ $global:Target_Tuple = "Linux_X86_64_Clang" }
	elseif(${input} -eq "20"){ $global:Target_Tuple = "Mac_Arm32_Clang" }
	elseif(${input} -eq "21"){ $global:Target_Tuple = "Mac_Arm64_Clang" }
	elseif(${input} -eq "22"){ $global:Target_Tuple = "Mac_X86_Clang" }
	elseif(${input} -eq "23"){ $global:Target_Tuple = "Mac_X86_64_Clang" }
	elseif(${input} -eq "24"){ $global:Target_Tuple = "Raspberry_Arm32_Clang" }
	elseif(${input} -eq "25"){ $global:Target_Tuple = "Raspberry_Arm64_Clang" }
	elseif(${input} -eq "26"){ $global:Target_Tuple = "raspberry_x86_clang" }
	elseif(${input} -eq "27"){ $global:Target_Tuple = "raspberry_x64_clang" }
	elseif(${input} -eq "28"){ $global:Target_Tuple = "Win_Arm32_Clang" }
	elseif(${input} -eq "29"){ $global:Target_Tuple = "Win_Arm64_Clang" }
	elseif(${input} -eq "30"){ $global:Target_Tuple = "Win_X86_Clang" }
	elseif(${input} -eq "31"){ $global:Target_Tuple = "Win_X86_Gcc" }
	elseif(${input} -eq "32"){ $global:Target_Tuple = "Win_X86_Msvc" }
	elseif(${input} -eq "33"){ $global:Target_Tuple = "Win_X86_64_Clang" }
	elseif(${input} -eq "34"){ $global:Target_Tuple = "Win_X86_64_Gcc" }
	elseif(${input} -eq "35"){ $global:Target_Tuple = "Win_X86_64_Msvc" }
	elseif(${input} -eq "36"){ $global:Target_Tuple = "Win_X86_64_Ucrt" }
	elseif(${input} -eq "37"){ dk_call dk_clearScreen }
	elseif(${input} -eq "38"){ dk_call dk_unset target_app }
	elseif(${input} -eq "39"){ dk_call dk_exit 0 }
	else{ dk_call dk_warning "invalid selection" }
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_target_tuple_SET
}
