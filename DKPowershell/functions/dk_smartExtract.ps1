if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_smartExtract){ $dk_smartExtract = 1 } else{ return }

dk_load dk_realpath
dk_load dk_getDirname
dk_load dk_remove
dk_load dk_extract
dk_load dk_getDirectories
dk_load dk_getBasename
dk_load dk_warning
##################################################################################
# dk_smartExtract(src, dest)
#
#
function Global:dk_smartExtract($src, $dest) {
	dk_debugFunc
	if($(__ARGC__) -lt 2){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }

	$src_fullpath = dk_realpath $src
	$src_directory = dk_getDirname $src_fullpath
	$src_filename = dk_getBasename $src_fullpath
	$src_folder = "${src_filename%.*}"
	#dk_realpath "${dest}" dest_fullpath
	$dest_fullpath="${dest}"
	$dest_folder = dk_getBasename $dest_fullpath
	
	if(!(dk_pathExists $dest_fullpath)){
		dk_makeDirectory $dest_fullpath
	}
	
	
	dk_remove $src_directory/UNZIPPED
	dk_makeDirectory $src_directory/UNZIPPED
	dk_info "Extracting $src_filename . . ."
	dk_extract $src_fullpath $src_directory/UNZIPPED
	
	$directories = dk_getDirectories $src_directory/UNZIPPED 
	$dir_count = dk_arrayLength $directories
	
	$files = dk_getFiles "$src_directory/UNZIPPED"
	$file_count = dk_arrayLength $files
	
	if($dir_count -eq 1){
		if($file_count -eq 0){
			dk_move $directories[0] $dest_fullpath OVERWRITE    #rename/move UNZIPPED/root folder to dest path"
		}
	}

	dk_move $src_directory/UNZIPPED $dest_fullpath OVERWRITE    # rename/move UNZIPPED folder to dest path
}



function Global:DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_smartExtract
}