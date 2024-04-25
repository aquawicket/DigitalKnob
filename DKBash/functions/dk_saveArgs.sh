dk_includeGuard

##################################################################################
# dk_saveArgs(<args..>)
#
# reference: https://www.etalabs.net/sh_tricks.html
#
# usage:
#   set -- One Two Three Four
#   myarrayA=$(dk_saveArgs "$@")
#   eval "set -- $myarrayA"
#	echo "$1 $2 $3 $4"
#
dk_saveArgs () {
	dk_debugFunc

	for i do 
		printf %s\\n "$i" | sed "s/'/'\\\\''/g;1s/^/'/;\$s/\$/' \\\\/"
	done
	echo " "
}