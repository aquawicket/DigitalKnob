# dk_includeGuard()

##################################################################################
# dk_convertToLowercase()
#
#
dk_convertToLowercase() {
	dk_debug "dk_convertToLowercase($@)"
	if [ -z "$2" ]; then
		dk_error "dk_convertToCIdentifier <input> <output> requires 2 parameters"
		return $false
	fi
	input=$1
	echo "convert_to_lowercase($1, $2)"
	echo "$input" | tr '[:upper:]' '[:lower:]'
	echo "input = $input"
	eval "$2=$input"
	#[[ $input == "" ]]
}