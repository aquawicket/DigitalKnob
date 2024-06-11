if(!$DKINIT){ . $PWD\DK.ps1 }
if(!$dk_move){ $dk_move = 1 } else{ return }

dk_load dk_validate
dk_load dk_getDKPaths
dk_load dk_pathExists
dk_load dk_error
dk_load dk_remove
dk_load dk_getDirname
##################################################################################
# dk_move(<from> <to>)
#
#	Move/Rename a file or directory to another location/name
#
#	@from		- The source path to move or rename
#	@to			- The destination path to move or rename to
#	OVERWRITE	- if any of the parameters equals OVERWRITE, overwritting existing file or folder is enabled
#
function Global:dk_move($_from_, $_to_) {
	dk_debugFunc
	if($(__ARGC__) -lt 2){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	if($(__ARGC__) -gt 3){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	if($args[2] -eq "OVERWRITE"){ $OVERWRITE = 1 }
	$OVERWRITE = 1
	
	dk_info "Moving $_from_ to $_to_"
	
	if(!(dk_pathExists "$_from_")){
		dk_error "dk_move: $_from_ not found"
	}
	
	if(dk_pathExists "$_to_"){
		if($OVERWRITE -ne 1){
			dk_error "dk_rename Cannot move file. Destiantion exists and OVERWRITE is not set"
		}
		dk_remove $_to_
	}
	
	# the base directory of the $_to_ path must exist.    
	$_parent_dir_ = dk_getDirname "$_to_"
	dk_printVar _parent_dir_
	dk_makeDirectory "$_parent_dir_"
	
	mv "$_from_" "$_to_"
}



function Global:DKTEST(){ ###############################################################################
	
	dk_validate DIGITALKNOB_DIR dk_getDKPaths
	
	echo "dk_move test" > $DKDOWNLOAD_DIR/moveMe.file
	dk_move $DKDOWNLOAD_DIR/moveMe.file $DIGITALKNOB_DIR/iWasMoved.txt OVERWRITE
	
	echo "dk_move test" > moveMe.file
	dk_move moveMe.file iWasMoved.txt OVERWRITE
	
	dk_makeDirectory $DKDOWNLOAD_DIR/moveMe
	dk_move $DKDOWNLOAD_DIR/moveMe $DIGITALKNOB_DIR/iWasMoved OVERWRITE
	
	dk_makeDirectory moveMe
	dk_move moveMe iWasMoved OVERWRITE
}