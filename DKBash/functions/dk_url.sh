# dk_include_guard()

##################################################################################
# dk_url()
#
#
dk_url () {
	dk_stringContains $1 "://" && return $true
	return $false
}