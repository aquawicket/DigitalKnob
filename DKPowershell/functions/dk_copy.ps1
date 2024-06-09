if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_copy){ $dk_copy = 1 } else{ return }

#################################################################################
# dk_copy(<from> <to>)
#
#	copy a file or directory to another location
#
#	@from		- The source path to copy
#	@to			- The destination path to copy to
#	OVERWRITE	- if any of the parameters equals OVERWRITE, overwritting existing file or folder is enabled
#
function Global:dk_copy($from, $to) {
	dk_debugFunc
	if($(__ARGC__) -lt 2){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	#$from = $args[0]
	#$to = $args[1]
	#$overwrite = $args[2]
	if("$args[2]" = "OVERWRITE"){
		$OVERWRITE = 1
	} else { 
		$OVERWRITE = 0 
	}
	
	dk_info "Copying ${from} to ${to}"
	
	if(!(dk_pathExists "${from}")){
		dk_error "dk_copy: ${from} not found"
	}
	
	if(dk_pathExists "${to}")){
		if("${OVERWRITE}" -ne "1"){
			dk_error "dk_copy Cannot copy file. Destiantion exists and OVERWRITE is not set"
		}
		dk_remove ${to}
	}
	
	# the base directory of the %to% path must exist.    
	$_parent_dir_ = dk_getDirname "${to}" _parent_dir_
	dk_makeDirectory "${_parent_dir_}"
	
	#cp -r "${from}" "${to}"
}



DKTEST() { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###

	dk_validate DIGITALKNOB_DIR "dk_getDKPaths"
	
	echo "dk_copy test" > ${DKDOWNLOAD_DIR}/copyMe.file
	dk_copy ${DKDOWNLOAD_DIR}/copyMe.file ${DIGITALKNOB_DIR}/iWasCopied.txt OVERWRITE
	
	echo "dk_copy test" > copyMe.file
	dk_copy copyMe.file iWasCopied.txt OVERWRITE
	
	dk_makeDirectory ${DKDOWNLOAD_DIR}/copyMe
	dk_copy ${DKDOWNLOAD_DIR}/copyMe ${DIGITALKNOB_DIR}/iWasCopied OVERWRITE
	
	dk_makeDirectory copyMe
	dk_copy copyMe iWasCopied OVERWRITE
}