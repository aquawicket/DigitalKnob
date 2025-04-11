if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_smartExtract){ $dk_smartExtract = 1 } else{ return } #include guard

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
	$src_extractPath = "${src_dirname}/${src_basename}_EXTRACTED"
	
	#$dest_fullpath = dk_call dk_realpath $dest
	$dest_fullpath = "${dest}"
	$dest_dirname = dk_call dk_dirname $dest_fullpath
	$dest_basename = dk_call dk_basename $dest_fullpath
	
#	if(!(dk_call dk_pathExists $dest_fullpath)){
#		dk_call dk_mkdir $dest_fullpath
#	}
	
	if(dk_call dk_pathExists "$src_extractPath"){ dk_call dk_delete "$src_extractPath" }
	
	dk_call dk_extract "$src_fullpath" "$src_extractPath"
	
	$directories = dk_call dk_getDirectories $src_extractPath
	
	$dir_count = dk_call dk_arrayLength directories
	
	$files = dk_call dk_getFiles $src_extractPath
	
	$file_count = dk_call dk_arrayLength files
	
	if($dir_count -eq 1){
		if($file_count -eq 0){
			dk_call dk_move $src_extractPath/$directories $dest_fullpath OVERWRITE    				#rename/move UNZIPPED/root folder to dest path"
			if(dk_call dk_pathExists "$src_extractPath"){ dk_call dk_delete "$src_extractPath" }
			return
		}
	}

	dk_call dk_move $src_extractPath $dest_fullpath OVERWRITE    	   # rename/move UNZIPPED folder to dest path
	if(dk_call dk_pathExists "$src_extractPath"){ dk_call dk_delete "$src_extractPath" }
}









###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	#dk_call dk_validate DKDOWNLOAD_DIR "dk_call dk_DKDOWNLOAD_DIR"
	#dk_call dk_download "https://newcontinuum.dl.sourceforge.net/project/lzmautils/xz-5.4.6.tar.gz" "${DKDOWNLOAD_DIR}/xz-5.4.6.tar.gz"
	#dk_call dk_smartExtract "${DKDOWNLOAD_DIR}/xz-5.4.6.tar.gz" "${DKDOWNLOAD_DIR}/xz-5.4.6"
	
	dk_call dk_validate DKDOWNLOAD_DIR "dk_call dk_DKDOWNLOAD_DIR"
	dk_call dk_download "https://github.com/libsdl-org/SDL/archive/refs/tags/release-2.26.1.zip" "${DKDOWNLOAD_DIR}/sdl-release-2.26.1.zip"
	dk_call dk_smartExtract "${DKDOWNLOAD_DIR}/sdl-release-2.26.1.zip" "${DKDOWNLOAD_DIR}/sdl-release-2.26.1"
}
