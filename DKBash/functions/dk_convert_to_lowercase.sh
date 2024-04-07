# dk_include_guard()

##################################################################################
# dk_convert_to_lowercase()
#
#
dk_convert_to_lowercase() {
	dk_debug "dk_convert_to_lowercase($@)"
	if [ -z "$2" ]; then
		dk_error "dk_convert_to_c_identifier <input> <output> requires 2 parameters"
		return $false
	fi
	input=$1
	echo "convert_to_lowercase($1, $2)"
	echo "$input" | tr '[:upper:]' '[:lower:]'
	echo "input = $input"
	eval "$2=$input"
	#[[ $input == "" ]]
}