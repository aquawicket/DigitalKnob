#!/usr/bin/env sh
############################## DigitalKnob DKBash ################################
[ -z "${DK_SH-}" ] && $(find "${HOME}" -name "DK.sh" -print) "$0" $*
##################################################################################


##################################################################################
# dk_toUpper(<input> <rtn_var:OPTIONAL>)
#
#
dk_toUpper() {
	dk_debugFunc 1 2

	local _toUpper=$(builtin echo "${1}" | tr '[:lower:]' '[:upper:]')
	#local _toUpper=${1^^}  # bash 4.0+
	
	### return value ###
	eval "dk_toUpper=\"${_toUpper}\""				# return value in FUNCTION_NAME
	[ ${#} -gt 1 ] && eval "${2}=\"${_toUpper}\""	# return value in RETURN_VAR
	dk_return "${_toUpper}"							# return value in COMMAND_SUBSTITUTION
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
	dk_call dk_toUpper "${myVar}"					
	dk_call dk_printVar dk_toUpper
	
	# return value in RETURN_VAR
	dk_call dk_echo
	dk_call dk_toUpper "${myVar}" rv_toUpper		
	dk_call dk_printVar rv_toUpper
	
	# return value in COMMAND_SUBSTITUTION
	dk_call dk_echo
	cs_toUpper=$(dk_call dk_toUpper "${myVar}")		
	dk_call dk_printVar cs_toUpper
}