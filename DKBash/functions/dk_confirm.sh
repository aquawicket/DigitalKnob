# dk_include_guard()

##################################################################################
# dk_confirm()
#
#
dk_confirm() {
	dk_verbose "dk_confirm($*)"
	[ $# -ne 0 ] && dk_error "Incorrect number of parameters"

	dk_echo "${yellow} Are you sure ? [Y/N] ${clr}"
	read -rp $" " REPLY
	dk_echo
	dk_echo
	#result=$(echo $REPLY | grep "^[Yy]$")
	[ "$REPLY" = "y" ] && return $true
	[ "$REPLY" = "Y" ] && return $true
	return $false;
}