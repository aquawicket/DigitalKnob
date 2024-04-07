# dk_include_guard()

##################################################################################
# dk_download()
#
#
dk_download() {
	dk_debug "dk_download($@)"
	if [ -z "$2" ]; then
		dk_error "dk_convert_to_c_identifier <input> <output> requires 2 parameters"
		return $false
	fi
	
	if dk_file_exists $2; then
		echo "dk_download(): $2 already exists"
		return 0
	fi
	#echo "dk_download($1, $2)"
	echo "Downloading $1 . . ."
	parentdir="$(dirname "$2")"
	#filename="$(basename "$2")"
	echo "parentdir = $parentdir"
	#echo "filename = $filename"
	olddir=$pwd
	echo "cd $parentdir"
	cd $parentdir
	echo "wget -P $parentdir $1"
	wget -P $parentdir $1 
	cd $oldpwd
	#[[ $input == "" ]]
}