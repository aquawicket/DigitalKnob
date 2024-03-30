#include_guard()

export DKBASH_DIR=$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )
##################################################################################
# dk_load()
#
#
#
dk_load () {
	#echo "dk_load($@)"
	[ -z $@ ] && return 0 #true
	#echo "DKBASH_DIR = $DKBASH_DIR"
	filename=$DKBASH_DIR/$1.sh
	#echo "filename = $filename"
	[ -f $filename ] && . "$filename" && $echo "loaded $filename"
	return 0 #true
}
