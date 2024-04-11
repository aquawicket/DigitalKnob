# dk_include_guard()

##################################################################################
# dk_string_contains(<string> <substring>)
#
#
dk_string_contains () {
	dk_verbose "dk_string_contains($*)"
	
	if [ -z "$2" ]; then
		dk_error "dk_string_contains <string> <substring> requires 2 parameters"
		return $false
	fi
	#[ $1 = *"$2"* ]						
	#if echo "$1" | grep -q '*"$2"*'; then
	#	return $true
	#fi
	#return $false
	
	# https://stackoverflow.com/a/8811800/688352
	string=$1
	substring=$2
	[ "${string#*"$substring"}" != "$string" ]
	#[ "${string#*"$substring"}" != "$string" ] && echo "${string} contains ${substring}" && return $true
	#echo "${string} does not contain ${substring}"
	#return $false;
	
	#[[ ${string} == *"${substring}"* ]]		# bash version
}