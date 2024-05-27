#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"

##################################################################################
# dk_echo(<message>)
#
#
dk_echo () {
	dk_debugFunc
	
	# https://linuxcommand.org/lc3_man_pages/echoh.html

	[ -z ${ESCAPES-} ]      && export ESCAPES=1
	[ -z ${NO_NEWLINE-} ]    && export NO_NEWLINE=0
	[ "$ESCAPES" = "1" ]    && [ "$(echo -e)" = "" ] && export escapes="-e "
	[ "$NO_NEWLINE" = "1" ] && [ "$(echo -n)" = "" ] && export nonewline="-n "

    echo ${escapes-}${nonewline-}"${1-}"
}




DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	echo "This is a normal echo commmand"
	dk_echo "This is a dk_echo line"
	dk_echo "${cyan} This is dk_echo with color ${clr}"
}