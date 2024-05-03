echo "$0 $*"
#[ -n "$include_dk_test" ] && exit || export readonly include_dk_test=1
[ -z "$DKINIT" ] && . ./DK.sh #$0


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








################################ DKTEST #########################################
DKTEST_START

	reelpath() {
		[ $1 = /* ] && echo "$1" || echo "$PWD/${1#./}"
	}

	echo ""
	RP=$(reelpath "$0")
	echo "RP = $RP"


DKTEST_END