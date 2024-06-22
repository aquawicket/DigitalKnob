#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


[ -z ${OVERWRITE_echo-} ]      && export OVERWRITE_echo=1

if [ "$OVERWRITE_echo" = "1" ]; then
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
#	echo "${1-}"
	
#	# https://linuxcommand.org/lc3_man_pages/echoh.html
	[ -z ${ESCAPES-} ]      && export ESCAPES=1
	[ -z ${NO_NEWLINE-} ]   && export NO_NEWLINE=0
	[ "$ESCAPES" = "1" ]    && [ "$(echo -e)" = "" ] && export escapes="-e "
	[ "$NO_NEWLINE" = "1" ] && [ "$(echo -n)" = "" ] && export nonewline="-n "

	msg=${1-}
	msg=${msg//\\/\\\\}    # replace all exscapes
	msg=${msg//\\\\x/\\x}  # put back all \x escapes for color
	echo ${escapes-}${nonewline-}"${msg}"
}


DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	echo "This is a normal echo commmand"
	dk_echo "This is a dk_echo line"
	dk_echo "${cyan} This is dk_echo with color ${clr}"
}