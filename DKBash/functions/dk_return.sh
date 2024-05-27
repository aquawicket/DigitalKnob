#!/bin/sh
[ -z "${DKINIT}" ] && . "$(dirname $0)/DK.sh"


##################################################################################
# dk_return()
#
#
if [ "$(builtin echo -e)" = "" ]; then
	alias echo='builtin echo -e '
	#alias echo='>&2 builtin echo -e '
	alias dk_return='builtin echo -e '
else
	alias echo='builtin echo '
	#alias echo='>&2 builtin echo '
	alias dk_return='builtin echo '
fi


DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_return "return string value"
}