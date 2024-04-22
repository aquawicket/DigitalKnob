# dk_include_guard()

##################################################################################
# dk_save_args(<args..>)
#
# reference: https://www.etalabs.net/sh_tricks.html
#
# usage:
#   set -- One Two Three Four
#   myarrayA=$(dk_save_args "$@")
#   eval "set -- $myarrayA"
#	echo "$1 $2 $3 $4"
#
dk_save_args () {
	dk_verbose "dk_save_args($*)"

	for i do 
		printf %s\\n "$i" | sed "s/'/'\\\\''/g;1s/^/'/;\$s/\$/' \\\\/"
	done
	echo " "
}