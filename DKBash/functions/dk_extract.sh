# dk_include_guard()

##################################################################################
# dk_extract(<file> <destination>)
#
#
dk_extract () {
	dk_verbose "dk_extract($*)"
	[ $# -ne 2 ] && dk_error "Incorrect number of parameters"

	filename="$(basename "$1")"
	destFolder="${filename%.*}"
	destFolder="${destFolder%.*}"
	fulldest="$2/$destFolder"
	dk_debug fulldest
		
	#if dk_file_exists $fulldest; then
	#	dk_warning "dk_extract(): $fulldest already exists"
	#	return 0
	#fi
	dk_info "Extracting $1 . . ."
	parentdir="$(dirname "$1")"
	parentdest="$(dirname "$2")"
	dk_debug "parentdir = $parentdir"
	dk_debug "filename = $filename"
	#need to cd into parent directory of $1 and send tar the file name of $1
	olddir=$PWD
	cd "$parentdir" #|| dk_error "cd $$parentdir failed!"
	tar -xf "$filename" -C "$2"
	cd "$oldpwd" #|| dk_error "cd $$oldpwd failed!"
	dk_convert_to_c_identifier "$destFolder" destFolder_
	dk_debug destFolder_
	mv "$2"/"$destFolder" "$2"/"$destFolder_"

	#echo echo "$CMAKE_FOLDER">"$2"/"$destFolder_"/dk_installed

	#TODO
	#[ "$input" = "" ]
}