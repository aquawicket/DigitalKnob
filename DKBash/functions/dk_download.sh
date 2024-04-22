# dk_include_guard()

##################################################################################
# dk_download(<url> <destination>)
#
#
dk_download () {
	dk_verbose "dk_download($*)"
	[ $# -ne 2 ] && dk_error "Incorrect number of parameters"
	
	if dk_file_exists "$2"; then
		dk_warning "dk_download(): $2 already exists"
		return 0
	fi
	dk_info "Downloading $1 . . ."
	parentdir="$(dirname "$2")"
	dk_debug "parentdir = $parentdir"
	olddir=$PWD
	cd "$parentdir" #|| dk_error "cd $parentdir failed!"
	wget -P "$parentdir" "$1" 
	cd "$oldpwd" #|| dk_error "cd $oldpwd failed!"
	#[ "$input" = "" ]
}