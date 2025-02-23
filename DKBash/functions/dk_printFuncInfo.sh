#!/usr/bin/env sh
[ -z "${DK_SH-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"


##################################################################################
# dk_printFuncInfo()
#
#
alias dk_printFuncInfo='{
	echo "$(__FILE__ 0):$(__LINE__ 0):$(__CALLER__ 0)  $(__FUNCTION__ 0):$(__ARGC__ 0)($(__ARGV__ 0))"
	echo ""
	echo "$(__FILE__ 1):$(__LINE__ 1):$(__CALLER__ 1)  $(__FUNCTION__ 1):$(__ARGC__ 1)($(__ARGV__ 1))"
	echo ""
	echo "$(__FILE__ 2):$(__LINE__ 2):$(__CALLER__ 2)  $(__FUNCTION__ 2):$(__ARGC__ 2)($(__ARGV__ 2))"
	echo ""
	echo "$(__FILE__ 3):$(__LINE__ 3):$(__CALLER__ 3)  $(__FUNCTION__ 3):$(__ARGC__ 3)($(__ARGV__ 3))"
	echo ""
	echo "$(__FILE__ 4):$(__LINE__ 4):$(__CALLER__ 4)  $(__FUNCTION__ 4):$(__ARGC__ 4)($(__ARGV__ 4))"
}'


###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {

	dk_printFuncInfo

}