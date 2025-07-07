#!/bin/sh
###### DK.sh #####################################################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


####################################################################
# dk_DKUSERNAME()
#
#
dk_DKUSERNAME() {
    dk_debugFunc 0 1;

	############ SET ############
	if [ -n "${1-}" ]; then  
		export DKUSERNAME="${1}" ;

	############ GET ############
	else
		[ -n "${DKUSERNAME-}" ] || export DKUSERNAME="${USER-}";
		[ -n "${DKUSERNAME-}" ] || export DKUSERNAME="${USERNAME-}";
		[ -n "${DKUSERNAME-}" ] || export DKUSERNAME="${LOGNAME-}";
		[ -n "${DKUSERNAME-}" ] || export DKUSERNAME="UNDEFINED";
	fi
	
	builtin echo "${DKUSERNAME}";
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
    dk_debugFunc 0;
 
	dk_call dk_echo;
	dk_call dk_echo "Test Getting DKUSERNAME . . .";
    dk_call dk_echo "DKUSERNAME = '$(dk_call dk_DKUSERNAME)'";
	
	dk_call dk_echo;
	dk_call dk_echo "Test Setting DKUSERNAME . . .";
	dk_call dk_echo "DKUSERNAME = '$(dk_call dk_DKUSERNAME 'MyUsername')'";
}
