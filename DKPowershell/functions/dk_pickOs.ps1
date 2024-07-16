if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_pickOs){ $dk_pickOs = 1 } else{ return }

##################################################################################
# dk_pickOs()
#
#
function Global:dk_pickOs() {
	dk_debugFunc
	if($(__ARGC__) -ne 0){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }


	dk_echo
	dk_echo "${APP} ${TARGET_OS} ${TYPE}"
	dk_echo	
    dk_echo " 1) ${HOST_TRIPLE}"
	dk_echo
	dk_echo " 2) Android arm32"
	dk_echo " 3) Android arm64"
	dk_echo " 4) Android x86"
	dk_echo " 5) Android x86_64"
	dk_echo " 6) Emscripten"
	dk_echo " 7) Ios arm32"
	dk_echo " 8) Ios arm64"
	dk_echo " 9) Ios x86"
	dk_echo "10) Ios x86_64"
	dk_echo "11) Iossim arm32"
	dk_echo "12) Iossim arm64"
	dk_echo "13) Iossim x86"
	dk_echo "14) Iossim x86_64"
	dk_echo "15) Linux arm32"
	dk_echo "16) Linux arm64"
	dk_echo "17) Linux x86"
	dk_echo "18) Linux x86_64"
	dk_echo "19) Mac arm32"
	dk_echo "20) Mac arm64"
	dk_echo "21) Mac x86"
	dk_echo "22) Mac x86_64"
	dk_echo "23) Raspberry arm32"
	dk_echo "24) Raspberry arm64"
	dk_echo "25) Raspberry x86"
	dk_echo "26) Raspberry x86_64"
	dk_echo "27) Windows arm32"
	dk_echo "28) Windows arm64 (clang)"
	dk_echo "29) Windows x86 (gcc)"
	dk_echo "30) Windows x86 (clang)"
	dk_echo "31) Windows x86 (msvc)"
	dk_echo "32) Windows x86_64 (gcc)"
    dk_echo "33) Windows x86_64 (clang)"
    dk_echo "34) Windows x86_64 (ucrt)"
    dk_echo "35) Windows x86_64 (msvc)"
	dk_echo "36) Clear Screen"
	dk_echo "37) Go Back"
	dk_echo "38) Exit"
	dk_echo
	
	$input = Read-Host
	    if(${input} -eq  "1"){ $global:TARGET_OS = "${HOST_TRIPLE}" }
	elseif(${input} -eq  "2"){ $global:TARGET_OS = "android_arm32" }
	elseif(${input} -eq  "3"){ $global:TARGET_OS = "android_arm64" }
	elseif(${input} -eq  "4"){ $global:TARGET_OS = "android_x86" }
	elseif(${input} -eq  "5"){ $global:TARGET_OS = "android_x86_64" }
	elseif(${input} -eq  "6"){ $global:TARGET_OS = "emscripten" }
	elseif(${input} -eq  "7"){ $global:TARGET_OS = "ios_arm32" }
	elseif(${input} -eq  "8"){ $global:TARGET_OS = "ios_arm64" }
	elseif(${input} -eq  "9"){ $global:TARGET_OS = "ios_x86" }
	elseif(${input} -eq "10"){ $global:TARGET_OS = "ios_x86_64" }
	elseif(${input} -eq "11"){ $global:TARGET_OS = "iossim_arm32" }
	elseif(${input} -eq "12"){ $global:TARGET_OS = "iossim_arm64" }
	elseif(${input} -eq "13"){ $global:TARGET_OS = "iossim_x86" }
	elseif(${input} -eq "14"){ $global:TARGET_OS = "iossim_x86_64" }
	elseif(${input} -eq "15"){ $global:TARGET_OS = "linux_arm32" }
	elseif(${input} -eq "16"){ $global:TARGET_OS = "linux_arm64" }
	elseif(${input} -eq "17"){ $global:TARGET_OS = "linux_x86" }
	elseif(${input} -eq "18"){ $global:TARGET_OS = "linux_x86_64" }
	elseif(${input} -eq "19"){ $global:TARGET_OS = "mac_arm32" }
	elseif(${input} -eq "20"){ $global:TARGET_OS = "mac_arm64" }
	elseif(${input} -eq "21"){ $global:TARGET_OS = "mac_x86" }
	elseif(${input} -eq "22"){ $global:TARGET_OS = "mac_x86_64" }
	elseif(${input} -eq "23"){ $global:TARGET_OS = "raspberry_arm32" }
	elseif(${input} -eq "24"){ $global:TARGET_OS = "raspberry_arm64" }
	elseif(${input} -eq "25"){ $global:TARGET_OS = "raspberry_x86" }
	elseif(${input} -eq "26"){ $global:TARGET_OS = "raspberry_x64" }
	elseif(${input} -eq "27"){ $global:TARGET_OS = "win_arm32" }
	elseif(${input} -eq "28"){ $global:TARGET_OS = "win_arm64_clang" }
	elseif(${input} -eq "29"){ $global:TARGET_OS = "win_x86_mingw" }
	elseif(${input} -eq "30"){ $global:TARGET_OS = "win_x86_clang" }
	elseif(${input} -eq "31"){ $global:TARGET_OS = "win_x86_msvc" }
	elseif(${input} -eq "32"){ $global:TARGET_OS = "win_x86_64_mingw" }
	elseif(${input} -eq "33"){ $global:TARGET_OS = "win_x86_64_clang" }
	elseif(${input} -eq "34"){ $global:TARGET_OS = "win_x86_64_ucrt" }
	elseif(${input} -eq "35"){ $global:TARGET_OS = "win_x86_64_msvc" }
	elseif(${input} -eq "36"){ dk_clearScreen }
	elseif(${input} -eq "37"){ dk_unset APP }
	elseif(${input} -eq "38"){ dk_exit 0 }
	else{ dk_warning "invalid selection" }
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	dk_pickOs
}