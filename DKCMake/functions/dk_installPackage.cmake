#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development
# https://en.wikipedia.org/wiki/List_of_software_package_management_systems
# https://en.wikipedia.org/wiki/Package_manager
# https://www.digitalocean.com/community/tutorials/package-management-basics-apt-yum-dnf-pkg

###############################################################################
# dk_installPackage(package)
#
<<<<<<< HEAD
function(dk_installPackage package)
	dk_debugFunc()
=======
function(dk_installPackage)
	dk_debugFunc(1)
	set(package ${ARGV0})
>>>>>>> Development

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
<<<<<<< HEAD
	dk_if(WIN_HOST [[ dk_validate(MSYS2 "dk_depend(msys2)") ]])
	set(ENV{DKSHELL} sh) # HACK

	### Alpine Package Keeper (alpine linux) ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v apk" OUTPUT_VARIABLE APK_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(APK_EXE)
		execute_process(COMMAND ${SUDO_EXE} ${APK_EXE} add ${package})
=======
	dk_if(WIN_HOST "dk_depend(msys2)")
	set(ENV{DKSHELL} sh) # HACK

	### Termux ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v pkg" OUTPUT_VARIABLE PKG_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(PKG_EXE)
		set(comand ${PKG_EXE} install ${package} -y)
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
		return()
	endif()
	
	### Alpine Package Keeper (alpine linux) ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v apk" OUTPUT_VARIABLE APK_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(APK_EXE)
		set(comand ${SUDO_EXE} ${APK_EXE} add ${package})
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
>>>>>>> Development
		return()
	endif()
	
	### Apt-get (debian) ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v apt-get" OUTPUT_VARIABLE APTGET_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(APTGET_EXE)
<<<<<<< HEAD
		execute_process(COMMAND ${SUDO_EXE} ${APTGET_EXE} -y install ${package})
=======
		set(comand ${SUDO_EXE} ${APTGET_EXE} -y install ${package})
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
>>>>>>> Development
		return()
	endif()
	
	### Apt (debian) ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v apt" OUTPUT_VARIABLE APT_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(APT_EXE)
<<<<<<< HEAD
		execute_process(COMMAND ${SUDO_EXE} ${APT_EXE} -y install ${package})
=======
		set(comand ${SUDO_EXE} ${APT_EXE} -y install ${package})
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
>>>>>>> Development
		return()
	endif()
	
	### Homebrew (MacOS) ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v brew" OUTPUT_VARIABLE BREW_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(BREW_EXE)
<<<<<<< HEAD
		execute_process(COMMAND ${SUDO_EXE} ${BREW_EXE} install ${package})
=======
		set(comand ${SUDO_EXE} ${BREW_EXE} install ${package})
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
>>>>>>> Development
		return()
	endif()

	### Dnf (yum) ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v dnf" OUTPUT_VARIABLE DNF_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(DNF_EXE)
<<<<<<< HEAD
		execute_process(COMMAND ${SUDO_EXE} ${DNF_EXE} install ${package})
=======
		set(comand ${SUDO_EXE} ${DNF_EXE} install ${package})
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
>>>>>>> Development
		return()
	endif()
	
	### Portage ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v emerge" OUTPUT_VARIABLE EMERGE_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(EMERGE_EXE)
<<<<<<< HEAD
		execute_process(COMMAND ${SUDO_EXE} ${EMERGE_EXE} ${package})
=======
		set(comand ${SUDO_EXE} ${EMERGE_EXE} ${package})
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
>>>>>>> Development
		return()
	endif()
	
	### Nix ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v nix-env" OUTPUT_VARIABLE NIX_ENV_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(NIX_ENV_EXE)
<<<<<<< HEAD
		execute_process(COMMAND ${SUDO_EXE} ${NIX_ENV_EXE} -i ${package})
=======
		set(comand ${SUDO_EXE} ${NIX_ENV_EXE} -i ${package})
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
>>>>>>> Development
		return()
	endif()
	
	### Ohpm ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v ohpm" OUTPUT_VARIABLE OHPM_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(OHPM_EXE)
<<<<<<< HEAD
		execute_process(COMMAND ${OHPM_EXE} install ${package})
		return()
	endif()
	
	### Termux ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v pkg" OUTPUT_VARIABLE PKG_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(PKG_EXE)
		execute_process(COMMAND ${PKG_EXE} install ${package} -y)
=======
		set(comand ${OHPM_EXE} install ${package})
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
		return()
	endif()
	
	### Cygwin ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v setup-x86_64.exe" OUTPUT_VARIABLE CYGPKG_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(CYGPKG_EXE)
		set(comand ${CYGPKG_EXE} -q -P ${package})
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
>>>>>>> Development
		return()
	endif()

	### Msys2 ###
<<<<<<< HEAD
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
=======
	dk_validate(PACMAN "dk_depend(pacman)")
	if(PACMAN_EXE)
		dk_assertPath(PACMAN_EXE)
		if(EXISTS "${MSYS2_CacheDir}/db.lck")
			dk_delete("${MSYS2_CacheDir}/db.lck")
		endif()
		#dk_mkdir("${MSYS2_CacheDir}")
		dk_assertPath(MSYS2_CacheDir)
		
		if(win_x86_clang)
			set(comand "${PACMAN_EXE}" -S mingw-w64-clang-i686-${package} --needed --noconfirm --cachedir "${MSYS2_CacheDir}")		# CLANG32
			#set(comand "${PACMAN_EXE}" -S mingw-w64-clang-i686-${package} --needed --noconfirm)									# CLANG32
		elseif(win_x86_64_clang)
			set(comand "${PACMAN_EXE}" -S mingw-w64-clang-x86_64-${package} --needed --noconfirm --cachedir "${MSYS2_CacheDir}")	# CLANG64
			#set(comand "${PACMAN_EXE}" -S mingw-w64-clang-x86_64-${package} --needed --noconfirm)									# CLANG64
		elseif(win_arm64_clang)
			set(comand "${PACMAN_EXE}" -S mingw-w64-clang-aarch64-${package} --needed --noconfirm --cachedir "${MSYS2_CacheDir}")	# CLANGARM64
			#set(comand "${PACMAN_EXE}" -S mingw-w64-clang-aarch64-${package} --needed --noconfirm)									# CLANGARM64
		elseif(win_x86_gcc)
			set(comand "${PACMAN_EXE}" -S mingw-w64-i686-${package} --needed --noconfirm --cachedir "${MSYS2_CacheDir}")			# MINGW32
			#set(comand "${PACMAN_EXE}" -S mingw-w64-i686-${package} --needed --noconfirm)											# MINGW32
		elseif(win_x86_64_gcc)
			set(comand "${PACMAN_EXE}" -S mingw-w64-x86_64-${package} --needed --noconfirm --cachedir "${MSYS2_CacheDir}")			# MINGW64
			#set(comand "${PACMAN_EXE}" -S mingw-w64-x86_64-${package} --needed --noconfirm)										# MINGW64
		elseif(win_x86_64_ucrt)
			set(comand "${PACMAN_EXE}" -S mingw-w64-ucrt-x86_64-${package} --needed --noconfirm --cachedir "${MSYS2_CacheDir}")		# UCRT64
			#set(comand "${PACMAN_EXE}" -S mingw-w64-ucrt-x86_64-${package} --needed --noconfirm)									# UCRT64
		else()
			set(comand "${PACMAN_EXE}" -S ${package} --needed --noconfirm --cachedir "${MSYS2_CacheDir}")							# MSYS (DEFAULT)
			#set(comand "${PACMAN_EXE}" -S ${package} --needed --noconfirm)															# MSYS (DEFAULT)
		endif()
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
>>>>>>> Development
		return()
	endif()
	
	### Swupd ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v swupd" OUTPUT_VARIABLE SWUPD_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(SWUPD_EXE)
<<<<<<< HEAD
		execute_process(COMMAND ${SWUPD_EXE} bundle-add ${package})
=======
		set(comand ${SWUPD_EXE} bundle-add ${package})
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
>>>>>>> Development
		return()
	endif()
	
	### Tiny core linux ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v tce-load" OUTPUT_VARIABLE TCE_LOAD_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(TCE_LOAD_EXE)
<<<<<<< HEAD
		execute_process(COMMAND ${TCE_LOAD_EXE} -wil ${package})
=======
		set(comand ${TCE_LOAD_EXE} -wil ${package})
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
>>>>>>> Development
		return()
	endif()
	
	### WinGet ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v winget" OUTPUT_VARIABLE WINGET_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(WINGET_EXE)
<<<<<<< HEAD
		execute_process(COMMAND winget install ${package})
=======
		set(comand winget install ${package})
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
>>>>>>> Development
		return()
	endif()
	
	### Xbps ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v xbps-install" OUTPUT_VARIABLE WINGET_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(XBPS_INSTALL_EXE)
<<<<<<< HEAD
		execute_process(COMMAND xbps-install ${package})
=======
		set(comand xbps-install ${package})
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
>>>>>>> Development
		return()
	endif()
	
	### Zypper ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v zypper" OUTPUT_VARIABLE ZYPPER_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(ZYPPER_EXE)
<<<<<<< HEAD
		execute_process(COMMAND zypper in ${package})
		return()
	endif()
	
	dk_error("ERROR: no package managers found")
=======
		set(comand zypper in ${package})
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
		return()
	endif()
	
	dk_fatal("no package managers found")
>>>>>>> Development
endfunction()



<<<<<<< HEAD
###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
=======




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_installPackage(zlib)
endfunction()