if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR/DK.ps1 } else { . '/DK.ps1' }
if(!$dk_installPackage){ $dk_installPackage = 1 } else{ return } #include guard

####################################################################
# dk_installPackage()
#
function Global:dk_installPackage() {
	dk_debugFunc 0

	dk_call dk_todo "dk_installPackage(${args[@]})"
	
	
#	if(!(dk_commandExists ${args[1]})){
#		return $(true)
#	}
#	#if(dk_packageInstalled ${}){
#	#	dk_call dk_warning "${args[1]} already installed"
#	#	return $(false);
#	#fi
#	
#	dk_call dk_info "installing ${args[1]}. . ."
#	# https://en.wikipedia.org/wiki/List_of_software_package_management_systems
#	# https://en.wikipedia.org/wiki/Package_manager
#	# https://www.digitalocean.com/community/tutorials/package-management-basics-apt-yum-dnf-pkg
#	
#	if(dk_call dk_commandExists apk){
#		dk_call apk add "${args[1]}"				# Alpine Package Keeper (alpine linux)
#	}
#	elseif(dk_call dk_commandExists apt-get){
#		dk_call apt-get -y install "${args[1]}"		# Apt-get (debian)
#	}
#	elseif(dk_call dk_commandExists apt){	
#		dk_call apt -y install "${args[1]}"			# Apt (debian)
#	}
#	elseif(dk_call dk_commandExists brew){	
#		dk_call brew install "${args[1]}"			# Homebrew (MacOS)
#	}
#	elseif(dk_call dk_commandExists dnf){
#		dk_call dnf install "${args[1]}"			# Dnf (yum)
#	}
#	elseif(dk_call dk_commandExists emerge){	
#		dk_call emerge "${args[1]}"					# Portage
#	}
#	elseif(dk_call dk_commandExists nix-env){	
#		dk_call nix-env -i "${args[1]}"				# Nix
#	}
#	elseif(dk_call dk_commandExists ohpm){	
#		dk_call ohpm install "${args[1]}"			# Ohpm
#	}
#	elseif(dk_call dk_commandExists pkg){
#		dk_call pkg install "${args[1]}"			# Termux
#	}
#	elseif(dk_call dk_commandExists pacman){
#		dk_call pacman -S "${args[1]}" --noconfirm	# Pacman
#	}
#	elseif(dk_call dk_commandExists swupd){
#		dk_call swupd bundle-add "${args[1]}"		# Swupd
#	}
#	elseif(dk_call dk_commandExists tce-load){
#		dk_call tce-load -wil "${args[1]}"     		# Tiny core linux
#	}
#	elseif(dk_call dk_commandExists winget){
#		dk_call dk_call winget install "${args[1]}"	# WinGet
#	}
#	elseif(dk_call dk_commandExists xbps-install){
#		dk_call xbps-install "${args[1]}"			# Xbps
#	}
#	elseif(dk_call dk_commandExists zypper){
#		dk_call zypper in "${args[1]}"				# Zypper
#	}
#	else{
#		dk_call dk_error "ERROR: no package managers found"
#	}
}



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_installPackage wget
}
