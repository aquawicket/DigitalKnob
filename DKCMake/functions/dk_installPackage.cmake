#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
# https://en.wikipedia.org/wiki/List_of_software_package_management_systems
# https://en.wikipedia.org/wiki/Package_manager
# https://www.digitalocean.com/community/tutorials/package-management-basics-apt-yum-dnf-pkg

###############################################################################
# dk_installPackage(package)
#
function(dk_installPackage)
	dk_debugFunc("\${ARGV}")

	dk_todo("dk_installPackage(${ARGV})")

#	if(dk_commandExists ${package})
#		return()
#	endif()
#	if(dk_packageInstalled ${package})
#		dk_warning "${package} already installed"
#		return(${false});
#	endif()
#	
#	dk_info("installing ${package}. . .")
#
#	if(dk_commandExists apk)
#		apk add "${package}"					# Alpine Package Keeper (alpine linux)
#	elseif(dk_commandExists apt-get)
#		apt-get -y install "${package}"			# Apt-get (debian)
#	elseif((dk_commandExists apt)
#		apt -y install "${package}"				# Apt (debian)
#	elseif(dk_commandExists brew)
#		brew install "${package}"				# Homebrew (MacOS)
#	elseif(dk_commandExists dnf)
#		dnf install "${package}"				# Dnf (yum)
#	elseif(dk_commandExists emerge)
#		emerge "${package}"						# Portage
#	elseif(dk_commandExists nix-env)
#		nix-env -i "${package}"					# Nix
#	elseif(dk_commandExists ohpm)
#		ohpm install "${package}"				# Ohpm
#	elseif(dk_commandExists pkg)
#		pkg install "${package}" -y				# Termux
#	elseif(dk_commandExists pacman)
#		pacman -S "${package}" --noconfirm		# Pacman
#	elseif(dk_commandExists swupd)
#		swupd bundle-add "${package}"			# Swupd
#	elseif(dk_commandExists tce-load)
#		tce-load -wil "${package}"     			# Tiny core linux
#	elseif(dk_commandExists winget)
#		winget install "${package}"				# WinGet
#	elseif(dk_commandExists xbps-install)
#		xbps-install "${package}"				# Xbps
#	elseif(dk_commandExists zypper)
#		zypper in "${package}"					# Zypper
#	else()
#		dk_error "ERROR: no package managers found"
#	endif()
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_installPackage(zlib)
endfunction()