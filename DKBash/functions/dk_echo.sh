#!/bin/sh
[ -z "$DKINIT" ] && . ./DK.sh
#dk_includeGuard


# https://linuxcommand.org/lc3_man_pages/echoh.html

[ -z ${ESCAPES-} ]    && ESCAPES=1
[ -z ${NO_NEWLINE-} ] && NO_NEWLINE=0
[ "$ESCAPES" = "1" ]    && [ "$(builtin echo -e)" = "" ] && escapes="-e "
[ "$NO_NEWLINE" = "1" ] && [ "$(builtin echo -n)" = "" ] && nonewline="-n "
##################################################################################
# dk_echo(<message>)
#
#
dk_echo () {
	#dk_debugFunc

	echo ${escapes}${nonewline}"$1"
}






################################ DKTEST #########################################
[ -n "$DKTEST" ] && {

	echo "This is a normal echo commmand"
	dk_echo "This is a dk_echo line"
	dk_echo "${cyan} This is dk_echo with color ${clr}"

} && exec $SHELL
