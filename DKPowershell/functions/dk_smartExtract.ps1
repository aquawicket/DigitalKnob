if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_smartExtract){ $dk_smartExtract = 1 } else{ return }

##################################################################################
# dk_smartExtract(src, dest)
#
#
function Global:dk_smartExtract($src, $dest) {
	dk_debugFunc 2

	$src_fullpath = dk_call dk_realpath $src
	$src_dirname = dk_call dk_dirname $src_fullpath
	$src_basename = dk_call dk_basename $src_fullpath
	$src_folder = "${src_basename%.*}"
	
	#$dest_fullpath = dk_call dk_realpath $dest
	$dest_fullpath="${dest}"
	$dest_dirname = dk_call dk_dirname $dest_fullpath
	$dest_basename = dk_call dk_basename $dest_fullpath
	
#	if(!(dk_call dk_pathExists $dest_fullpath)){
#		dk_call dk_makeDirectory $dest_fullpath
#	}
	
	dk_call dk_delete $src_dirname/UNZIPPED
	dk_call dk_info "Extracting $src_filename . . ."
	dk_call dk_extract $src_fullpath $src_dirname/UNZIPPED
	
	$directories = dk_call dk_getDirectories $src_dirname/UNZIPPED
	$dir_count = dk_call dk_arrayLength directories
	
	$files = dk_call dk_getFiles $src_dirname/UNZIPPED
	$file_count = dk_call dk_arrayLength files
	
	if($dir_count -eq 1){
		if($file_count -eq 0){
			dk_call dk_move $src_dirname/UNZIPPED/$directories $dest_fullpath OVERWRITE    #rename/move UNZIPPED/root folder to dest path"
			return
		}
	}

	dk_call dk_move $src_dirname/UNZIPPED $dest_fullpath OVERWRITE    # rename/move UNZIPPED folder to dest path
}









###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_smartExtract
}
