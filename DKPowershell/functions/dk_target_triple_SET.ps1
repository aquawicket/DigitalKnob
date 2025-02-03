if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_target_triple_SET){ $dk_target_triple_SET = 1 } else{ return } #include guard

##################################################################################
# dk_target_triple_SET()
#
#
function Global:dk_target_triple_SET() {
	dk_debugFunc 0

	dk_call dk_echo
	dk_call dk_echo "${target_app} ${target_triple} ${target_type}"
	dk_call dk_echo	
    dk_call dk_echo " 1) ${host_triple}"
	dk_call dk_echo
	dk_call dk_echo " 2) cosmopolitan"
	dk_call dk_echo " 3) android_arm32_clang"
	dk_call dk_echo " 4) android_arm64_clang"
	dk_call dk_echo " 5) android_x86_clang"
	dk_call dk_echo " 6) android_x86_64_clang"
	dk_call dk_echo " 7) emscripten_clang"
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
	    if(${input} -eq  "1"){ $global:target_triple = "${host_triple}" }
	elseif(${input} -eq  "2"){ $global:target_triple = "cosmopolitan" }
	elseif(${input} -eq  "3"){ $global:target_triple = "android_arm32_clang" }
	elseif(${input} -eq  "4"){ $global:target_triple = "android_arm64_clang" }
	elseif(${input} -eq  "5"){ $global:target_triple = "android_x86_clang" }
	elseif(${input} -eq  "6"){ $global:target_triple = "android_x86_64_clang" }
	elseif(${input} -eq  "7"){ $global:target_triple = "emscripten_clang" }
	elseif(${input} -eq  "8"){ $global:target_triple = "ios_arm32_clang" }
	elseif(${input} -eq  "9"){ $global:target_triple = "ios_arm64_clang" }
	elseif(${input} -eq "10"){ $global:target_triple = "ios_x86_clang" }
	elseif(${input} -eq "11"){ $global:target_triple = "ios_x86_64_clang" }
	elseif(${input} -eq "12"){ $global:target_triple = "iossim_arm32_clang" }
	elseif(${input} -eq "13"){ $global:target_triple = "iossim_arm64_clang" }
	elseif(${input} -eq "14"){ $global:target_triple = "iossim_x86_clang" }
	elseif(${input} -eq "15"){ $global:target_triple = "iossim_x86_64_clang" }
	elseif(${input} -eq "16"){ $global:target_triple = "linux_arm32_clang" }
	elseif(${input} -eq "17"){ $global:target_triple = "linux_arm64_clang" }
	elseif(${input} -eq "18"){ $global:target_triple = "linux_x86_clang" }
	elseif(${input} -eq "19"){ $global:target_triple = "linux_x86_64_clang" }
	elseif(${input} -eq "20"){ $global:target_triple = "mac_arm32_clang" }
	elseif(${input} -eq "21"){ $global:target_triple = "mac_arm64_clang" }
	elseif(${input} -eq "22"){ $global:target_triple = "mac_x86_clang" }
	elseif(${input} -eq "23"){ $global:target_triple = "mac_x86_64_clang" }
	elseif(${input} -eq "24"){ $global:target_triple = "raspberry_arm32_clang" }
	elseif(${input} -eq "25"){ $global:target_triple = "raspberry_arm64_clang" }
	elseif(${input} -eq "26"){ $global:target_triple = "raspberry_x86_clang" }
	elseif(${input} -eq "27"){ $global:target_triple = "raspberry_x64_clang" }
	elseif(${input} -eq "28"){ $global:target_triple = "win_arm32_clang" }
	elseif(${input} -eq "29"){ $global:target_triple = "win_arm64_clang" }
	elseif(${input} -eq "30"){ $global:target_triple = "win_x86_clang" }
	elseif(${input} -eq "31"){ $global:target_triple = "win_x86_mingw" }
	elseif(${input} -eq "32"){ $global:target_triple = "win_x86_msvc" }
	elseif(${input} -eq "33"){ $global:target_triple = "win_x86_64_clang" }
	elseif(${input} -eq "34"){ $global:target_triple = "win_x86_64_mingw" }
	elseif(${input} -eq "35"){ $global:target_triple = "win_x86_64_msvc" }
	elseif(${input} -eq "36"){ $global:target_triple = "win_x86_64_ucrt" }
	elseif(${input} -eq "37"){ dk_call dk_clearScreen }
	elseif(${input} -eq "38"){ dk_call dk_unset target_app }
	elseif(${input} -eq "39"){ dk_call dk_exit 0 }
	else{ dk_call dk_warning "invalid selection" }
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_target_triple_SET
}
