dk_includeGuard

##################################################################################
# dk_realpath()
#
#    reference: https://stackoverflow.com/a/18443300/688352
#
dk_realpath() (
	dk_debugFunc

	OURPWD=$PWD
	cd "$(dirname "$1")"
	LINK=$(readlink "$(basename "$1")")
	while [ "$LINK" ]; do
		cd "$(dirname "$LINK")"
		LINK=$(readlink "$(basename "$1")")
	done
	REALPATH="$PWD/$(basename "$1")"
	cd "$OURPWD"
	echo "$REALPATH"
)