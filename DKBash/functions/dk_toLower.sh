#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


##################################################################################
# dk_toLower(<input> <rtn_var:OPTIONAL>)
#
#
dk_toLower() {
	dk_debugFunc 1 2
	
	local _toLower=$(builtin echo "${1}" | tr '[:upper:]' '[:lower:]')
	#local _toLower=${1,,}  # bash 4.0+
	
	### return value ###
	eval "dk_toLower=\"${_toLower}\""				# return value in FUNCTION_NAME
	[ ${#} -gt 1 ] && eval "${2}=\"${_toLower}\""	# return value in RETURN_VAR
	dk_return "${_toLower}"							# return value in COMMAND_SUBSTITUTION
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
DKTEST() {
	dk_debugFunc 0
	
	### Special Characters ###
	#     ALL:  ! " # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~
	#   VALID:  !   # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _   { | } ~
	# INVALID:    "                                                   `        
	dk_call dk_echo
	myVar="a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z 1 2 3 4 5 6 7 8 9 0 ! # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ { | } ~"
	dk_call dk_printVar myVar
	
	# return value in FUNCTION_NAME
	dk_call dk_echo
	dk_call dk_toLower "${myVar}"					
	dk_call dk_printVar dk_toLower
	
	# return value in RETURN_VAR
	dk_call dk_echo
	dk_call dk_toLower "${myVar}" rv_toLower		
	dk_call dk_printVar rv_toLower
	
	# return value in COMMAND_SUBSTITUTION
	dk_call dk_echo
	cs_toLower=$(dk_call dk_toLower "${myVar}")		
	dk_call dk_printVar cs_toLower
}
