# dk_include_guard()

##################################################################################
# dk_confirm()
#
#
dk_confirm() {
	dk_debug "dk_confirm($@)"
	echo -e "${yellow} Are you sure ? [Y/N] ${clr}"
	read -p " " -n 1 -r
	echo ""
	echo ""
	[[ $REPLY =~ ^[Yy]$ ]]
}