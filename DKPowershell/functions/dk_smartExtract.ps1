if(!$DKINIT){ . $PWD/DK.ps1 }
if(!$dk_smartExtract){ $dk_smartExtract = 1 } else{ return }

##################################################################################
# dk_smartExtract(src, dest)
#
#
function Global:dk_smartExtract($src, $dest) {
	dk_debugFunc
	if($(__ARGC__) -lt 2){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }


	$src_fullpath = dk_realpath $src
	$src_dirname = dk_getDirname $src_fullpath
	$src_basename = dk_getBasename $src_fullpath
	$src_folder = "${src_basename%.*}"
	
	#$dest_fullpath = dk_realpath $dest
	$dest_fullpath="${dest}"
	$dest_dirname = dk_getDirname $dest_fullpath
	$dest_basename = dk_getBasename $dest_fullpath
	
#	if(!(dk_pathExists $dest_fullpath)){
#		dk_makeDirectory $dest_fullpath
#	}
	
	dk_remove $src_dirname/UNZIPPED
	dk_info "Extracting $src_filename . . ."
	dk_extract $src_fullpath $src_dirname/UNZIPPED
	
	$directories = dk_getDirectories $src_dirname/UNZIPPED
	$dir_count = dk_arrayLength directories
	
	$files = dk_getFiles $src_dirname/UNZIPPED
	$file_count = dk_arrayLength files
	
	if($dir_count -eq 1){
		if($file_count -eq 0){
			dk_move $src_dirname/UNZIPPED/$directories $dest_fullpath OVERWRITE    #rename/move UNZIPPED/root folder to dest path"
			return
		}
	}

	dk_move $src_dirname/UNZIPPED $dest_fullpath OVERWRITE    # rename/move UNZIPPED folder to dest path
}



function Global:DKTEST (){ ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc
	
	
	dk_smartExtract
}