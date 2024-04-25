# dk_includeGuard()


[ -z $ENABLE_dk_debugFunc ] && ENABLE_dk_debugFunc=1
##################################################################################
# dk_debugFunc()
#
#
alias dk_debugFunc='{
	[ $ENABLE_dk_debug -eq 1 ] && dk_debug "$(basename ${BASH_SOURCE[0]}:${BASH_LINENO[0]}) ${FUNCNAME[0]}($*)"
}'

#alias DKDEBUGFUNC='{
#	dk_debugFunc
#}'