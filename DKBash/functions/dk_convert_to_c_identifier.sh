# dk_include_guard()

##################################################################################
# dk_convert_to_c_identifier(<input> <output>)
#
#
function dk_convert_to_c_identifier() {
	dk_debug "dk_convert_to_c_identifier($@)"
	if [ -z "$2" ]; then
		dk_error "dk_convert_to_c_identifier <input> <output> requires 2 parameters"
		return $false
	fi
	input=$1
	echo "dk_convert_to_c_identifier($1, $2)"
	input="${input//[^[:alnum:]]/_}"
	echo "input = $input"
	eval "$2=$input"
	#[[ $input == "" ]]
}