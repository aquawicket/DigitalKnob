if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_pickOs){ $dk_pickOs = 1 } else{ return }

##################################################################################
# dk_pickOs()
#
#
function Global:dk_pickOs() {
	dk_debugFunc 0

	dk_call dk_echo
	dk_call dk_echo "${APP} ${triple} ${TYPE}"
	dk_call dk_echo	
    dk_call dk_echo " 1) ${HOST_TRIPLE}"
	dk_call dk_echo
	dk_call dk_echo " 2) Android arm32"
	dk_call dk_echo " 3) Android arm64"
	dk_call dk_echo " 4) Android x86"
	dk_call dk_echo " 5) Android x86_64"
	dk_call dk_echo " 6) Emscripten"
	dk_call dk_echo " 7) Ios arm32"
	dk_call dk_echo " 8) Ios arm64"
	dk_call dk_echo " 9) Ios x86"
	dk_call dk_echo "10) Ios x86_64"
	dk_call dk_echo "11) Iossim arm32"
	dk_call dk_echo "12) Iossim arm64"
	dk_call dk_echo "13) Iossim x86"
	dk_call dk_echo "14) Iossim x86_64"
	dk_call dk_echo "15) Linux arm32"
	dk_call dk_echo "16) Linux arm64"
	dk_call dk_echo "17) Linux x86"
	dk_call dk_echo "18) Linux x86_64"
	dk_call dk_echo "19) Mac arm32"
	dk_call dk_echo "20) Mac arm64"
	dk_call dk_echo "21) Mac x86"
	dk_call dk_echo "22) Mac x86_64"
	dk_call dk_echo "23) Raspberry arm32"
	dk_call dk_echo "24) Raspberry arm64"
	dk_call dk_echo "25) Raspberry x86"
	dk_call dk_echo "26) Raspberry x86_64"
	dk_call dk_echo "27) Windows arm32"
	dk_call dk_echo "28) Windows arm64 (clang)"
	dk_call dk_echo "29) Windows x86 (gcc)"
	dk_call dk_echo "30) Windows x86 (clang)"
	dk_call dk_echo "31) Windows x86 (msvc)"
	dk_call dk_echo "32) Windows x86_64 (gcc)"
    dk_call dk_echo "33) Windows x86_64 (clang)"
    dk_call dk_echo "34) Windows x86_64 (ucrt)"
    dk_call dk_echo "35) Windows x86_64 (msvc)"
	dk_call dk_echo "36) Clear Screen"
	dk_call dk_echo "37) Go Back"
	dk_call dk_echo "38) Exit"
	dk_call dk_echo
	
	$input = Read-Host
	    if(${input} -eq  "1"){ $global:triple = "${HOST_TRIPLE}" }
	elseif(${input} -eq  "2"){ $global:triple = "android_arm32" }
	elseif(${input} -eq  "3"){ $global:triple = "android_arm64" }
	elseif(${input} -eq  "4"){ $global:triple = "android_x86" }
	elseif(${input} -eq  "5"){ $global:triple = "android_x86_64" }
	elseif(${input} -eq  "6"){ $global:triple = "emscripten" }
	elseif(${input} -eq  "7"){ $global:triple = "ios_arm32" }
	elseif(${input} -eq  "8"){ $global:triple = "ios_arm64" }
	elseif(${input} -eq  "9"){ $global:triple = "ios_x86" }
	elseif(${input} -eq "10"){ $global:triple = "ios_x86_64" }
	elseif(${input} -eq "11"){ $global:triple = "iossim_arm32" }
	elseif(${input} -eq "12"){ $global:triple = "iossim_arm64" }
	elseif(${input} -eq "13"){ $global:triple = "iossim_x86" }
	elseif(${input} -eq "14"){ $global:triple = "iossim_x86_64" }
	elseif(${input} -eq "15"){ $global:triple = "linux_arm32" }
	elseif(${input} -eq "16"){ $global:triple = "linux_arm64" }
	elseif(${input} -eq "17"){ $global:triple = "linux_x86" }
	elseif(${input} -eq "18"){ $global:triple = "linux_x86_64" }
	elseif(${input} -eq "19"){ $global:triple = "mac_arm32" }
	elseif(${input} -eq "20"){ $global:triple = "mac_arm64" }
	elseif(${input} -eq "21"){ $global:triple = "mac_x86" }
	elseif(${input} -eq "22"){ $global:triple = "mac_x86_64" }
	elseif(${input} -eq "23"){ $global:triple = "raspberry_arm32" }
	elseif(${input} -eq "24"){ $global:triple = "raspberry_arm64" }
	elseif(${input} -eq "25"){ $global:triple = "raspberry_x86" }
	elseif(${input} -eq "26"){ $global:triple = "raspberry_x64" }
	elseif(${input} -eq "27"){ $global:triple = "win_arm32" }
	elseif(${input} -eq "28"){ $global:triple = "win_arm64_clang" }
	elseif(${input} -eq "29"){ $global:triple = "win_x86_mingw" }
	elseif(${input} -eq "30"){ $global:triple = "win_x86_clang" }
	elseif(${input} -eq "31"){ $global:triple = "win_x86_msvc" }
	elseif(${input} -eq "32"){ $global:triple = "win_x86_64_mingw" }
	elseif(${input} -eq "33"){ $global:triple = "win_x86_64_clang" }
	elseif(${input} -eq "34"){ $global:triple = "win_x86_64_ucrt" }
	elseif(${input} -eq "35"){ $global:triple = "win_x86_64_msvc" }
	elseif(${input} -eq "36"){ dk_call dk_clearScreen }
	elseif(${input} -eq "37"){ dk_call dk_unset APP }
	elseif(${input} -eq "38"){ dk_call dk_exit 0 }
	else{ dk_call dk_warning "invalid selection" }
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_pickOs
}
