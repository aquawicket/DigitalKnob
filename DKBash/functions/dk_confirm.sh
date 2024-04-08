# dk_include_guard()

##################################################################################
# dk_confirm()
#
# reference: https://bash.cyberciti.biz/guide/Getting_User_Input_Via_Keyboard
#
dk_confirm() {
	dk_debug "dk_confirm($@)"
	echo -e "${yellow} Are you sure ? [Y/N] ${clr}"
	read -p " " -n 1 -r REPLY
	echo ""
	echo ""
	#result=$(echo $REPLY | grep "^[Yy]$")
	[ "$REPLY" = "y" ] && return $true
	[ "$REPLY" = "Y" ] && return $true
	return $false;
}