# dk_includeGuard

##################################################################################
# dk_convertToLowercase()
#
#
dk_convertToLowercase() {
	dk_debugFunc
	[ -z "$2" ] && dk_error "dk_convertToCIdentifier <input> <output> requires 2 parameters"

	input=$1
	echo "convert_to_lowercase($1, $2)"
	echo "$input" | tr '[:upper:]' '[:lower:]'
	echo "input = $input"
	eval "$2=$input"
	#[[ $input == "" ]]
}