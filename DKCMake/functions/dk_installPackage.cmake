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

	execute_process(COMMAND command -v ${package} OUTPUT_VARIABLE PACKAGE_EXE)
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
	execute_process(COMMAND command -v apk OUTPUT_VARIABLE APK_EXE)
	if(APK_EXE)
		execute_process(COMMAND ${APK_EXE} add ${package})				# Alpine Package Keeper (alpine linux)
	endif()
	
	execute_process(COMMAND command -v apt-get OUTPUT_VARIABLE APTGET_EXE)
	if(APTGET_EXE)
		execute_process(COMMAND ${APTGET_EXE} -y install ${package})	# Apt-get (debian)
	endif()
	
	execute_process(COMMAND command -v apt OUTPUT_VARIABLE APT_EXE)
	if(APT_EXE)
		execute_process(COMMAND ${APT_EXE} -y install ${package})		# Apt (debian)
	endif()
	
#		execute_process(COMMAND brew install ${package})				# Homebrew (MacOS)
#		execute_process(COMMAND dnf install ${package})					# Dnf (yum)
#		execute_process(COMMAND emerge ${package})						# Portage
#		execute_process(COMMAND nix-env -i ${package})					# Nix
#		execute_process(COMMAND ohpm install ${package})				# Ohpm
#		execute_process(COMMAND pkg install ${package} -y)				# Termux
#		execute_process(COMMAND pacman -S ${package} --noconfirm)		# Pacman

	execute_process(COMMAND command -v pacman OUTPUT_VARIABLE PACMAN_EXE)
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
		endif()
	endif()


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