# dk_include_guard()

##################################################################################
# dk_verbose()
#
#
function dk_verbose() {
	#echo "dk_verbose($@)"
	if [ $LOG_VERBOSE == 1 ]; then 
		echo -e "${blue} VERBOSE: $1 ${clr}"
	fi
}