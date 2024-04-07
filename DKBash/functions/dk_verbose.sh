# dk_include_guard()

##################################################################################
# dk_verbose()
#
#
dk_verbose() {
	#echo "dk_verbose($@)"
	if [ $LOG_VERBOSE = 1 ]; then 
		$echo "${cyan} VERBOSE: $1 ${clr}"
	fi
}