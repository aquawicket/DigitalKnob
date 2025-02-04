#!/bin/sh
[ -z "${DKINIT-}" ] && . "${DKBASH_FUNCTIONS_DIR_-./}DK.sh"

dk_run() {
	echo "TEST TEST" >&2
	return
	
	echo "$*" >&2
	"${@}"
}