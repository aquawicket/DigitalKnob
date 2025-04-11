if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_move){ $dk_move = 1 } else{ return } #include guard

##################################################################################
# dk_move(from to)
#
#	Move/Rename a file or directory to another location/name
#
#	@from		- The source path to move or rename
#	@to			- The destination path to move or rename to
#	OVERWRITE	- if any of the parameters equals OVERWRITE, overwritting existing file or folder is enabled
#
function Global:dk_move($_from_, $_to_) {
	dk_debugFunc 2 3
	
	if($args[2] -eq "OVERWRITE"){ $OVERWRITE = 1 }
	
	dk_call dk_info "Moving $_from_ to $_to_"
	
	if(!(dk_call dk_pathExists "$_from_")){
		dk_call dk_error "dk_move: $_from_ not found"
	}
	
	if(dk_call dk_pathExists "$_to_"){
		if($OVERWRITE -ne 1){
			dk_call dk_error "Cannot move file. Destiantion exists and OVERWRITE is not set"
		}
		#dk_call dk_delete $_to_
	}
	
	# the base directory of the $_to_ path must exist.    
	$_parent_dir_ = dk_call dk_dirname "${_to_}"
	dk_call dk_printVar _parent_dir_
	dk_call dk_mkdir ${_parent_dir_}
	
	mv "$_from_" "$_to_"
}


###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function Global:DKTEST(){
	dk_debugFunc 0
	
	dk_call dk_validate DIGITALKNOB_DIR "dk_call dk_DIGITALKNOB_DIR"
	
	dk_call dk_fileWrite $DKDOWNLOAD_DIR/moveMe.file "dk_move test"
	dk_call dk_move $DKDOWNLOAD_DIR/moveMe.file $DIGITALKNOB_DIR/iWasMoved.txt OVERWRITE
	
	dk_call dk_fileWrite moveMe.file "dk_move test"
	dk_call dk_move moveMe.file iWasMoved.txt OVERWRITE
	
	dk_call dk_mkdir $DKDOWNLOAD_DIR/moveMe
	dk_call dk_move $DKDOWNLOAD_DIR/moveMe $DIGITALKNOB_DIR/iWasMoved OVERWRITE
	
	dk_call dk_mkdir moveMe
	dk_call dk_move moveMe iWasMoved OVERWRITE
}