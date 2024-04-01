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
	#cat -A $filename    $ line_endings = UNIX
	#echo "filename = $filename"
	
	#if file $filename | grep -q '^ASCII text.*with CRLF'
	
	#if file $filename | grep -q '^ASCII text.*with CRLF'
	#echo $(file $filename)
	#echo "str = $str"
	#if [ -e $filename ];then
		dos2unix $filename
	#fi
	
	#echo "$filename: has_crlf = $has_crlf"
	
	
	[ -f $filename ] && . $filename && $echo "loaded $filename"

	#dos2unix -ihp $filename
	#dos2unix < $filename|bash -s
	
	return 0 #true
}
