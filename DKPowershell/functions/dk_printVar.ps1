#!/bin/sh
#[ -z "${DKINIT}" ] && . "$(dirname $0)/DK"

#[ -z ${USE_LOCAL_N_dk_printVar-} ] && export USE_LOCAL_N_dk_printVar=0
if (! (Get-Variable 'USE_LOCAL_N_dk_printVar' -Scope 'Global' -ErrorAction 'Ignore')) {
	$global:USE_LOCAL_N_dk_printVar = 0
}



