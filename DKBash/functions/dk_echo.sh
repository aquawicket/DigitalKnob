dk_includeGuard

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