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
	dk_call dk_echo " 2) cosmopolitan"
	dk_call dk_echo " 3) android_arm32_clang"
	dk_call dk_echo " 4) android_arm64_clang"
	dk_call dk_echo " 5) android_x86_clang"
	dk_call dk_echo " 6) android_x86_64_clang"
	dk_call dk_echo " 7) emscripten_x86_clang"
	dk_call dk_echo " 8) ios_arm32_clang"
	dk_call dk_echo " 9) ios_arm64_clang"
	dk_call dk_echo "10) ios_x86_clang"
	dk_call dk_echo "11) ios_x86_64_clang"
	dk_call dk_echo "12) iossim_arm32_clang"
	dk_call dk_echo "13) iossim_arm64_clang"
	dk_call dk_echo "14) iossim_x86_clang"
	dk_call dk_echo "15) iossim_x86_64_clang"
	dk_call dk_echo "16) linux_arm32_clang"
	dk_call dk_echo "17) linux_arm64_clang"
	dk_call dk_echo "18) linux_x86_clang"
	dk_call dk_echo "19) linux_x86_64_clang"
	dk_call dk_echo "20) mac_arm32_clang"
	dk_call dk_echo "21) mac_arm64_clang"
	dk_call dk_echo "22) mac_x86_clang"
	dk_call dk_echo "23) mac_x86_64_clang"
	dk_call dk_echo "24) raspberry_arm32_clang"
	dk_call dk_echo "25) raspberry_arm64_clang"
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
	elseif(${input} -eq  "2"){ $global:Target_Tuple = "cosmopolitan" }
	elseif(${input} -eq  "3"){ $global:Target_Tuple = "android_arm32_clang" }
	elseif(${input} -eq  "4"){ $global:Target_Tuple = "android_arm64_clang" }
	elseif(${input} -eq  "5"){ $global:Target_Tuple = "android_x86_clang" }
	elseif(${input} -eq  "6"){ $global:Target_Tuple = "android_x86_64_clang" }
	elseif(${input} -eq  "7"){ $global:Target_Tuple = "emscripten_clang" }
	elseif(${input} -eq  "8"){ $global:Target_Tuple = "ios_arm32_clang" }
	elseif(${input} -eq  "9"){ $global:Target_Tuple = "ios_arm64_clang" }
	elseif(${input} -eq "10"){ $global:Target_Tuple = "ios_x86_clang" }
	elseif(${input} -eq "11"){ $global:Target_Tuple = "ios_x86_64_clang" }
	elseif(${input} -eq "12"){ $global:Target_Tuple = "iossim_arm32_clang" }
	elseif(${input} -eq "13"){ $global:Target_Tuple = "iossim_arm64_clang" }
	elseif(${input} -eq "14"){ $global:Target_Tuple = "iossim_x86_clang" }
	elseif(${input} -eq "15"){ $global:Target_Tuple = "iossim_x86_64_clang" }
	elseif(${input} -eq "16"){ $global:Target_Tuple = "linux_arm32_clang" }
	elseif(${input} -eq "17"){ $global:Target_Tuple = "linux_arm64_clang" }
	elseif(${input} -eq "18"){ $global:Target_Tuple = "linux_x86_clang" }
	elseif(${input} -eq "19"){ $global:Target_Tuple = "linux_x86_64_clang" }
	elseif(${input} -eq "20"){ $global:Target_Tuple = "mac_arm32_clang" }
	elseif(${input} -eq "21"){ $global:Target_Tuple = "mac_arm64_clang" }
	elseif(${input} -eq "22"){ $global:Target_Tuple = "mac_x86_clang" }
	elseif(${input} -eq "23"){ $global:Target_Tuple = "mac_x86_64_clang" }
	elseif(${input} -eq "24"){ $global:Target_Tuple = "raspberry_arm32_clang" }
	elseif(${input} -eq "25"){ $global:Target_Tuple = "raspberry_arm64_clang" }
	elseif(${input} -eq "26"){ $global:Target_Tuple = "raspberry_x86_clang" }
	elseif(${input} -eq "27"){ $global:Target_Tuple = "raspberry_x64_clang" }
	elseif(${input} -eq "28"){ $global:Target_Tuple = "win_arm32_clang" }
	elseif(${input} -eq "29"){ $global:Target_Tuple = "win_arm64_clang" }
	elseif(${input} -eq "30"){ $global:Target_Tuple = "win_x86_clang" }
	elseif(${input} -eq "31"){ $global:Target_Tuple = "win_x86_gcc" }
	elseif(${input} -eq "32"){ $global:Target_Tuple = "win_x86_msvc" }
	elseif(${input} -eq "33"){ $global:Target_Tuple = "Win_X86_64_Clang" }
	elseif(${input} -eq "34"){ $global:Target_Tuple = "win_x86_64_gcc" }
	elseif(${input} -eq "35"){ $global:Target_Tuple = "win_x86_64_msvc" }
	elseif(${input} -eq "36"){ $global:Target_Tuple = "win_x86_64_ucrt" }
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
