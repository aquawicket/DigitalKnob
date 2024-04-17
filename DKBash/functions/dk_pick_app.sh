# dk_include_guard()

##################################################################################
# dk_pick_app()
#
#
dk_pick_app() {
	dk_verbose "dk_pick_app($*)"
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"

	dk_echo
	dk_echo "${APP-}  ${TARGET_OS-} ${TYPE-}"
	
	dk_echo
    dk_echo " 1) HelloWorld"
    dk_echo " 2) DKCore"
    dk_echo " 3) DKJavascript"
    dk_echo " 4) DKSDL"
    dk_echo " 5) DKSDLRml"
    dk_echo " 6) DKDomTest"
    dk_echo " 7) DKTestAll"
    dk_echo " 8) Enter Manually"
    dk_echo " 9) Clear Screen"
    dk_echo "10) Go Back"
    dk_echo "11) Reload"
	dk_echo "12) Exit"
    dk_echo 
	
	read input
	if [ "$input" = "1" ]; then
		APP="HelloWorld"
	elif [ "$input" = "2" ]; then
		APP="DKCore"
	elif [ "$input" = "3" ]; then
		APP="DKJavascript"
	elif [ "$input" = "4" ]; then
		APP="DKSDL"
	elif [ "$input" = "5" ]; then
		APP="DKSDLRml"
	elif [ "$input" = "6" ]; then
		APP="DKDomTest"
	elif [ "$input" = "7" ]; then
		APP="DKTestAll"
	elif [ "$input" = "8" ]; then
		dk_enter_manually
	elif [ "$input" = "9" ]; then
		clear
	elif [ "$input" = "10" ]; then
		UPDATE=
	elif [ "$input" = "11" ]; then
		dk_call dk_reload
	elif [ "$input" = "12" ]; then
		exit 0
	else
		dk_warning "invalid selection"
	fi
}