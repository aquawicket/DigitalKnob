#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname ${0})/DK.sh"

# The reason we are overwriting echo is to try and keep junk echo's out of command substitution returns.
#   result=$(myFunction thing) <- if anything writes to stdout durring this, it will junk up the result value.
#   for that reason, we've overwritten echo and we point it to stderr since command substitions use stdout. 
export OVERWRITE_echo=1
if [ "${OVERWRITE_echo-}" = "1" ]; then
	echo (){
		#[ -z ${ESCAPES-} ]      && export ESCAPES=1
		#[ -z ${NO_NEWLINE-} ]    && export NO_NEWLINE=0
		#[ "$ESCAPES" = "1" ]    && [ "$(builtin echo -e)" = "" ] && export escapes="-e "
		#[ "$NO_NEWLINE" = "1" ] && [ "$(builtin echo -n)" = "" ] && export nonewline="-n "
		
		#args=${@:1:$#-1}
		if [ "${@:$#}" = "-e" ]; then
			true
		elif [ "$(builtin echo -e)" = "" ]; then
			>&2 builtin echo -e "${@:$#}"
		else
			>&2 builtin echo "${@:$#}"
		fi
	}
fi

##################################################################################
# dk_echo(<message>)
#
#
dk_echo (){
	dk_debugFunc
	[ ${#} -eq 0 ] && echo "" && return
	[ ${#} -ne 1 ] && dk_error "${FUNCNAME}(${#}): incorrect number of arguments"
	
#	# https://linuxcommand.org/lc3_man_pages/echoh.html
	[ -z ${ESCAPES-} ]      && export ESCAPES=1
	[ -z ${NO_NEWLINE-} ]   && export NO_NEWLINE=0
	[ "$ESCAPES" = "1" ]    && [ "$(echo -e)" = "" ] && export escapes="-e "
	[ "$NO_NEWLINE" = "1" ] && [ "$(echo -n)" = "" ] && export nonewline="-n "

	msg=${1-}
	msg=${msg//\\/\\\\}    # replace all exscapes
	msg=${msg//\\\\x/\\x}  # put back all \x escapes for color
	
	[ -z ${echo_fileline-} ] && export echo_fileline="$(__FILE__ 1):$(__LINE__ 1)   "
	echo ${escapes-}${nonewline-}"${echo_fileline}  ${msg}"
	dk_unset echo_fileline
}


DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	echo "This is a normal echo commmand"
	dk_echo
	dk_echo ""
	dk_echo "This is a dk_echo line"
	dk_echo "${red}This is ${white}dk_echo ${blue}with color ${clr}"
}