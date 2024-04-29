#!/bin/sh
#. ./DK.sh
dk_includeGuard
##################################################################################
# dk_assert(expression)
#
#
dk_assert() {
	dk_debugFunc
	#echo "dk_assert($*)"
	[ -z $1 ] && dk_error "Assertion failed: $1"
	return $true	
}