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

	if(dk_commandExists ${package})
		return()
	endif()
#	if(dk_packageInstalled ${package})
#		dk_warning "${package} already installed"
#		return(${false});
#	endif()
#	
	dk_info("installing ${package}. . .")
#
	execute_process(COMMAND command -v apk OUTPUT_VARIABLE APK_EXE)
	if(APK_EXE)
		execute_process(COMMAND ${APK_EXE} add ${package})				# Alpine Package Keeper (alpine linux)
		return()
	endif()
	
	execute_process(COMMAND command -v apt-get OUTPUT_VARIABLE APTGET_EXE)
	if(APTGET_EXE)
		execute_process(COMMAND ${APTGET_EXE} -y install ${package})	# Apt-get (debian)
		return()
	endif()
	
#		execute_process(COMMAND apt -y install ${package})				# Apt (debian)
#		execute_process(COMMAND brew install ${package})				# Homebrew (MacOS)
#		execute_process(COMMAND dnf install ${package})					# Dnf (yum)
#		execute_process(COMMAND emerge ${package})						# Portage
#		execute_process(COMMAND nix-env -i ${package})					# Nix
#		execute_process(COMMAND ohpm install ${package})				# Ohpm
#		execute_process(COMMAND pkg install ${package} -y)				# Termux
#		execute_process(COMMAND pacman -S ${package} --noconfirm)		# Pacman
#		execute_process(COMMAND swupd bundle-add ${package})			# Swupd
#		execute_process(COMMAND tce-load -wil ${package})     			# Tiny core linux
#		execute_process(COMMAND winget install ${package})				# WinGet
#		execute_process(COMMAND xbps-install ${package})				# Xbps
#		execute_process(COMMAND zypper in ${package})					# Zypper

#		dk_error("ERROR: no package managers found")

endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_installPackage(zlib)
endfunction()