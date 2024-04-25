# dk_includeGuard()

##################################################################################
# dk_url()
#
#
dk_url () {
	dk_debugFunc
	
	dk_stringContains $1 "://" && return $true
	return $false
}