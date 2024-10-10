#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
# https://en.wikipedia.org/wiki/List_of_software_package_management_systems
# https://en.wikipedia.org/wiki/Package_manager
# https://www.digitalocean.com/community/tutorials/package-management-basics-apt-yum-dnf-pkg

###############################################################################
# dk_installPackage(package)
#
function(dk_installPackage package)
	dk_debugFunc("\${ARGV}")

	execute_process(COMMAND command -v ${package} OUTPUT_VARIABLE PACKAGE_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(EXISTS ${PACKAGE_EXE})
		message("${package}_EXE already exists")
		return()
	endif()
#	if(dk_packageInstalled ${package})
#		dk_warning "${package} already installed"
#		return(${false});
#	endif()
#	
	dk_info("installing ${package}. . .")
#


	### Alpine Package Keeper (alpine linux) ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v apk" OUTPUT_VARIABLE APK_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(APK_EXE)
		message("${APK_EXE} add ${package}")
		execute_process(COMMAND ${SUDO_EXE} ${APK_EXE} add ${package})
	endif()
	
	### Apt-get (debian) ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v apt-get" OUTPUT_VARIABLE APTGET_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(APTGET_EXE)
		message("${APTGET_EXE} -y install ${package}")
		execute_process(COMMAND ${SUDO_EXE} ${APTGET_EXE} -y install ${package})
	endif()
	
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v apt" OUTPUT_VARIABLE APT_EXE)
	if(APT_EXE)
		execute_process(COMMAND ${SUDO_EXE} ${APT_EXE} -y install ${package})		# Apt (debian)
	endif()
	
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v brew" OUTPUT_VARIABLE BREW_EXE)
	if(BREW_EXE)
		execute_process(COMMAND ${SUDO_EXE} ${BREW_EXE} install ${package})			# Homebrew (MacOS)
	endif()

	execute_process(COMMAND $ENV{DKSHELL} -c "command -v dnf" OUTPUT_VARIABLE DNF_EXE)
	if(DNF_EXE)
		execute_process(COMMAND ${SUDO_EXE} ${DNF_EXE} install ${package})			# Dnf (yum)
	endif()
	
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v emerge" OUTPUT_VARIABLE EMERGE_EXE)
	if(EMERGE_EXE)
		execute_process(COMMAND ${SUDO_EXE} ${EMERGE_EXE} ${package})				# Portage
	endif()
	
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v nix-env" OUTPUT_VARIABLE NIX_ENV_EXE)
	if(NIX_ENV_EXE)
		execute_process(COMMAND ${SUDO_EXE} ${NIX_ENV_EXE} -i ${package})					# Nix
	endif()
	
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v ohpm" OUTPUT_VARIABLE OHPM_EXE)
	if(OHPM_EXE)
		execute_process(COMMAND ${OHPM_EXE} install ${package})				# Ohpm
	endif()
	
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v pkg" OUTPUT_VARIABLE PKG_EXE)
	if(PKG_EXE)
		execute_process(COMMAND ${PKG_EXE} install ${package} -y)				# Termux
	endif()

	execute_process(COMMAND $ENV{DKSHELL} -c "command -v pacman" OUTPUT_VARIABLE PACMAN_EXE)
	if(PACMAN_EXE)
		if(win_x86_clang)
			execute_process(COMMAND ${PACMAN_EXE} -S mingw-w64-clang-i686-${package} --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# CLANG32
		elseif(win_x86_64_clang)
			execute_process(COMMAND ${PACMAN_EXE} -S mingw-w64-clang-x86_64-${package} --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})	# CLANG64
		elseif(win_arm64_clang)
			execute_process(COMMAND ${PACMAN_EXE} -S mingw-w64-clang-aarch64-${package} --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})	# CLANGARM64
		elseif(win_x86_mingw)
			execute_process(COMMAND ${PACMAN_EXE} -S mingw-w64-i686-${package} --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})			# MINGW32
		elseif(win_x86_64_mingw)
			execute_process(COMMAND ${PACMAN_EXE} -S mingw-w64-x86_64-${package} --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})			# MINGW64
		elseif(win_x86_64_ucrt)
			execute_process(COMMAND ${PACMAN_EXE} -S mingw-w64-ucrt-x86_64-${package} --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})	# UCRT64
		else()
			execute_process(COMMAND ${PACMAN_EXE} -S ${package} --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})							# DEFAULT
		endif()
	endif()

	execute_process(COMMAND $ENV{DKSHELL} -c "command -v swupd" OUTPUT_VARIABLE SWUPD_EXE)
	if(SWUPD_EXE)
		execute_process(COMMAND ${SWUPD_EXE} bundle-add ${package})			# Swupd
	endif()
	
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v tce-load" OUTPUT_VARIABLE TCE_LOAD_EXE)
	if(TCE_LOAD_EXE)
		execute_process(COMMAND ${TCE_LOAD_EXE} -wil ${package})     			# Tiny core linux
	endif()
	
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v winget" OUTPUT_VARIABLE WINGET_EXE)
	if(WINGET_EXE)
		execute_process(COMMAND winget install ${package})				# WinGet
	endif()
	
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v xbps-install" OUTPUT_VARIABLE WINGET_EXE)
	if(XBPS_INSTALL_EXE)
		execute_process(COMMAND xbps-install ${package})				# Xbps
	endif()
	
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v zypper" OUTPUT_VARIABLE ZYPPER_EXE)
	if(ZYPPER_EXE)
		execute_process(COMMAND zypper in ${package})					# Zypper
	endif()
	
#	dk_error("ERROR: no package managers found")

	execute_process(COMMAND $ENV{DKSHELL} -c "command -v ${package}" OUTPUT_VARIABLE PACKAGE_EXE)
	if(EXISTS ${PACKAGE_EXE})
		message("${package}_EXE installed successfully")
		return()
	endif()
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_installPackage(zlib)
endfunction()