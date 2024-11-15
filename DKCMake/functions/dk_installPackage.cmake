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
	dk_debugFunc()

	dk_toUpper(${package} PACKAGE)
	execute_process(COMMAND command -v ${package} OUTPUT_VARIABLE ${PACKAGE}_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(EXISTS ${${PACKAGE}_EXE})
		message("${PACKAGE}_EXE:${${PACKAGE}_EXE} already exists")
		return()
	endif()
#	if(dk_packageInstalled ${package})
#		dk_warning "${package} already installed"
#		return(${false});
#	endif()
#	
	dk_info("dk_installPackage(): installing ${package}. . .")
	dk_if(WIN_HOST [[ dk_validate(MSYS2 "dk_depend(msys2)") ]])
	set(ENV{DKSHELL} sh) # HACK

	### Alpine Package Keeper (alpine linux) ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v apk" OUTPUT_VARIABLE APK_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(APK_EXE)
		execute_process(COMMAND ${SUDO_EXE} ${APK_EXE} add ${package})
		return()
	endif()
	
	### Apt-get (debian) ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v apt-get" OUTPUT_VARIABLE APTGET_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(APTGET_EXE)
		execute_process(COMMAND ${SUDO_EXE} ${APTGET_EXE} -y install ${package})
		return()
	endif()
	
	### Apt (debian) ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v apt" OUTPUT_VARIABLE APT_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(APT_EXE)
		execute_process(COMMAND ${SUDO_EXE} ${APT_EXE} -y install ${package})
		return()
	endif()
	
	### Homebrew (MacOS) ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v brew" OUTPUT_VARIABLE BREW_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(BREW_EXE)
		execute_process(COMMAND ${SUDO_EXE} ${BREW_EXE} install ${package})
		return()
	endif()

	### Dnf (yum) ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v dnf" OUTPUT_VARIABLE DNF_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(DNF_EXE)
		execute_process(COMMAND ${SUDO_EXE} ${DNF_EXE} install ${package})
		return()
	endif()
	
	### Portage ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v emerge" OUTPUT_VARIABLE EMERGE_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(EMERGE_EXE)
		execute_process(COMMAND ${SUDO_EXE} ${EMERGE_EXE} ${package})
		return()
	endif()
	
	### Nix ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v nix-env" OUTPUT_VARIABLE NIX_ENV_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(NIX_ENV_EXE)
		execute_process(COMMAND ${SUDO_EXE} ${NIX_ENV_EXE} -i ${package})
		return()
	endif()
	
	### Ohpm ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v ohpm" OUTPUT_VARIABLE OHPM_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(OHPM_EXE)
		execute_process(COMMAND ${OHPM_EXE} install ${package})
		return()
	endif()
	
	### Termux ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v pkg" OUTPUT_VARIABLE PKG_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(PKG_EXE)
		execute_process(COMMAND ${PKG_EXE} install ${package} -y)
		return()
	endif()

	### Cygwin ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v setup-x86_64.exe" OUTPUT_VARIABLE CYGPKG_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(CYGPKG_EXE)
		execute_process(COMMAND ${CYGPKG_EXE} -q -P ${package})
		return()
	endif()

	### Msys2 ###
	if(NOT PACMAN_EXE)
		dk_validate(MSYS2 "dk_depend(msys2)")
		dk_findProgram(PACMAN_EXE pacman "${MSYS2_DIR}/usr/bin")
	endif()
	if(PACMAN_EXE)
		dk_assertPath(PACMAN_EXE)
		dk_validate(DKDONWLOAD_DIR "dk_DIGITALKNOB_DIR()")
		#dk_delete("${MSYS2_DIR}/var/lib/pacman/db.lck" NO_HALT)
		execute_process(COMMAND ${PACMAN_EXE} -Syu --noconfirm --cachedir ${DKDOWNLOAD_DIR})
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
		return()
	endif()
	
	### Swupd ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v swupd" OUTPUT_VARIABLE SWUPD_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(SWUPD_EXE)
		execute_process(COMMAND ${SWUPD_EXE} bundle-add ${package})
		return()
	endif()
	
	### Tiny core linux ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v tce-load" OUTPUT_VARIABLE TCE_LOAD_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(TCE_LOAD_EXE)
		execute_process(COMMAND ${TCE_LOAD_EXE} -wil ${package})
		return()
	endif()
	
	### WinGet ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v winget" OUTPUT_VARIABLE WINGET_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(WINGET_EXE)
		execute_process(COMMAND winget install ${package})
		return()
	endif()
	
	### Xbps ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v xbps-install" OUTPUT_VARIABLE WINGET_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(XBPS_INSTALL_EXE)
		execute_process(COMMAND xbps-install ${package})
		return()
	endif()
	
	### Zypper ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v zypper" OUTPUT_VARIABLE ZYPPER_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(ZYPPER_EXE)
		execute_process(COMMAND zypper in ${package})
		return()
	endif()
	
	dk_error("ERROR: no package managers found")
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_installPackage(zlib)
endfunction()