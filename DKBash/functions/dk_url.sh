# dk_include_guard()

##################################################################################
# dk_url()
#
#
dk_url () {
	dk_string_contains $1 "://" && return $true
	return $false
}