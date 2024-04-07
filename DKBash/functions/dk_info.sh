# dk_include_guard()

##################################################################################
# dk_info()
#
#
dk_info() {
	#echo "dk_info($@)"
	dk_require dk_info $1
	echo -e "${white} INFO: $1 ${white}"
}