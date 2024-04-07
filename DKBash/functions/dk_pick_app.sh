# dk_include_guard()

##################################################################################
# dk_pick_app()
#
#
dk_pick_app() {
	dk_debug "dk_pick_app($@)"
	echo ""
	echo "${APP}  ${TARGET_OS} ${TYPE}"
	
	echo ""	
    echo " 1) HelloWorld"
    echo " 2) DKCore"
    echo " 3) DKJavascript"
    echo " 4) DKSDL"
    echo " 5) DKSDLRml"
    echo " 6) DKDomTest"
    echo " 7) DKTestAll"
    echo " 8) Enter Manually"
    echo " 9) Clear Screen"
    echo "10) Go Back"
    echo "11) Reload"
	echo "12) Exit"
    echo "" 
	
	read input
	if [ "$input" == "1" ]; then
		APP="HelloWorld"
	elif [ "$input" == "2" ]; then
		APP="DKCore"
	elif [ "$input" == "3" ]; then
		APP="DKJavascript"
	elif [ "$input" == "4" ]; then
		APP="DKSDL"
	elif [ "$input" == "5" ]; then
		APP="DKSDLRml"
	elif [ "$input" == "6" ]; then
		APP="DKDomTest"
	elif [ "$input" == "7" ]; then
		APP="DKTestAll"
	elif [ "$input" == "8" ]; then
		enter_manually
	elif [ "$input" == "9" ]; then
		clear
	elif [ "$input" == "10" ]; then
		UPDATE=
	elif [ "$input" == "11" ]; then
		dk_call dk_reload
	elif [ "$input" == "12" ]; then
		exit 0
	else
		echo "invalid selection"
	fi
}