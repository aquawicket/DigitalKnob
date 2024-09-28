if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_copy){ $dk_copy = 1 } else{ return }

#################################################################################
# dk_copy(from to)
#
#	copy a file or directory to another location
#
#	@from		- The source path to copy
#	@to			- The destination path to copy to
#	OVERWRITE	- if any of the parameters equals OVERWRITE, overwritting existing file or folder is enabled
#
function Global:dk_copy($from, $to) {
	dk_debugFunc 2 3
	
	#$from = $args[0]
	#$to = $args[1]
	#$overwrite = $args[2]
	if("$args[2]" = "OVERWRITE"){
		$OVERWRITE = 1
	} else { 
		$OVERWRITE = 0 
	}
	
	dk_call dk_info "Copying ${from} to ${to}"
	
	if(!(dk_call dk_pathExists "${from}")){
		dk_call dk_error "dk_copy: ${from} not found"
		return $false
	}
	
	if(dk_call dk_pathExists "${to}")){
		if("${OVERWRITE}" -ne "1"){
			dk_call dk_error "dk_copy Cannot copy file. Destiantion exists and OVERWRITE is not set"
			return $false
		}
		dk_call dk_delete ${to}
	}
	
	# the base directory of the ${to} path must exist.    
	$_parent_dir_ = dk_call dk_dirname "${to}" _parent_dir_
	dk_call dk_makeDirectory "${_parent_dir_}"
	
	#cp -r "${from}" "${to}"
}


###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_validate DIGITALKNOB_DIR "dk_call dk_DIGITALKNOB_DIR"
	
	echo "dk_copy test" > ${DKDOWNLOAD_DIR}/copyMe.file
	dk_call dk_copy ${DKDOWNLOAD_DIR}/copyMe.file ${DIGITALKNOB_DIR}/iWasCopied.txt OVERWRITE
	
	echo "dk_copy test" > copyMe.file
	dk_call dk_copy copyMe.file iWasCopied.txt OVERWRITE
	
	dk_call dk_makeDirectory ${DKDOWNLOAD_DIR}/copyMe
	dk_call dk_copy ${DKDOWNLOAD_DIR}/copyMe ${DIGITALKNOB_DIR}/iWasCopied OVERWRITE
	
	dk_call dk_makeDirectory copyMe
	dk_call dk_copy copyMe iWasCopied OVERWRITE
}