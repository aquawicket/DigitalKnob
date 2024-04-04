#include_guard()

##################################################################################
# dk_extract()
#
#
function dk_extract() {
	dk_debug "dk_extract($@)"
	if [ -z "$2" ]; then
		dk_error "extract <input> <output> requires 2 parameters"
		return $false
	fi

	filename="$(basename "$1")"
	destFolder="${filename%.*}"
	destFolder="${destFolder%.*}"
	fulldest="$2/$destFolder"
	print_var fulldest
		
	#if dk_file_exists $fulldest; then
	#	echo "extract(): $fulldest already exists"
	#	return 0
	#fi
	echo "Extracting $1 . . ."
	parentdir="$(dirname "$1")"
	parentdest="$(dirname "$2")"
	echo "parentdir = $parentdir"
	echo "filename = $filename"
	#need to cd into parent directory of $1 and send tar the file name of $1
	olddir=$pwd
	echo "cd $parentdir"
	cd $parentdir
	echo "tar -xf $filename -C $2"
	tar -xf $filename -C $2
	cd $oldpwd
	dk_convert_to_c_identifier $destFolder destFolder_
	print_var destFolder_
	echo "mv $2/$destFolder $2/$destFolder_"
	mv $2/$destFolder $2/$destFolder_
	echo $CMAKE_FOLDER>$2/$destFolder_/installed
	
	#TODO
	#[[ $input == "" ]]
}