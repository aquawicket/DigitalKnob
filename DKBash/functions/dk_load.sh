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
	filename=$DKBASH_DIR/functions/$1.sh
	
	[[ $(file myfile.txt) =~ CRLF ]] && echo dos1
	[[ $(file -b - < $filename) =~ CRLF ]] && echo dos2
	
	# Convert to unix line endings if CRLF found
	if [[ $(file -b - < $filename) =~ CRLF ]]; then
		echo Converting file to Unix line endings
		sed -i -e 's/\r$//' $filename
	fi
	
	[ -f $filename ] && . $filename && $echo "loaded $filename"
	
	return 0 #true
}
