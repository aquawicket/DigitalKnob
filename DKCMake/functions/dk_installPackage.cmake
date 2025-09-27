#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()


####################################################################
# dk_installPackage(package)
#
#		Reference: https://en.wikipedia.org/wiki/List_of_software_package_management_systems
#		Reference: https://en.wikipedia.org/wiki/Package_manager
#		Reference: https://www.digitalocean.com/community/tutorials/package-management-basics-apt-yum-dnf-pkg
#
function(dk_installPackage)
	dk_debugFunc(1)
	
	# ${ARGV0} = package
	
	set(package ${ARGV0})
	dk_toUpper(${package} PACKAGE)
	execute_process(COMMAND command -v ${package} OUTPUT_VARIABLE ${PACKAGE}_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(EXISTS ${${PACKAGE}_exe})
		message("${PACKAGE}_exe:${${PACKAGE}_exe} already exists")
		return()
	endif()
#	if(dk_packageInstalled ${package})
#		dk_warning "${package} already installed"
#		return(${false});
#	endif()
#	
	dk_info("dk_installPackage(): installing ${package}. . .")
	dk_depend(msys2)
	set(ENV{DKSHELL} sh) # HACK

	### Termux ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v pkg" OUTPUT_VARIABLE pkg_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(pkg_exe)
		set(comand ${pkg_exe} install ${package} -y)
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
		return()
	endif()
	
	### Alpine Package Keeper (alpine linux) ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v apk" OUTPUT_VARIABLE apk_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(apk_exe)
		dk_validate(sudo_exe "dk_depend(sudo_exe)")
		set(comand ${sudo_exe} ${apk_exe} add ${package})
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
		return()
	endif()
	
	### Apt-get (debian) ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v apt-get" OUTPUT_VARIABLE apt-get_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(apt-get_exe)
		dk_validate(sudo_exe "dk_depend(sudo_exe)")
		set(comand ${sudo_exe} ${apt-get_exe} -y install ${package})
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
		return()
	endif()
	
	### Apt (debian) ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v apt" OUTPUT_VARIABLE apt_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(apt_exe)
		dk_validate(sudo_exe "dk_depend(sudo_exe)")
		set(comand ${sudo_exe} ${apt_exe} -y install ${package})
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
		return()
	endif()
	
	### Homebrew (MacOS) ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v brew" OUTPUT_VARIABLE brew_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(brew_exe)
		dk_validate(sudo_exe "dk_depend(sudo_exe)")
		set(comand ${sudo_exe} ${brew_exe} install ${package})
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
		return()
	endif()

	### Dnf (yum) ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v dnf" OUTPUT_VARIABLE dnf_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(dnf_exe)
		dk_validate(sudo_exe "dk_depend(sudo_exe)")
		set(comand ${sudo_exe} ${dnf_exe} install ${package})
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
		return()
	endif()
	
	### Portage ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v emerge" OUTPUT_VARIABLE emerge_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(emerge_exe)
		dk_validate(sudo_exe "dk_depend(sudo_exe)")
		set(comand ${sudo_exe} ${emerge_exe} ${package})
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
		return()
	endif()
	
	### Nix ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v nix-env" OUTPUT_VARIABLE nix-env_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(nix-env_exe)
		dk_validate(sudo_exe "dk_depend(sudo_exe)")
		set(comand ${sudo_exe} ${nix-env_exe} -i ${package})
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
		return()
	endif()
	
	### Ohpm ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v ohpm" OUTPUT_VARIABLE ohpm_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(ohpm_exe)
		set(comand ${ohpm_exe} install ${package})
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
		return()
	endif()
	
	### Cygwin ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v setup-x86_64.exe" OUTPUT_VARIABLE CYGpkg_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(CYGpkg_exe)
		set(comand ${CYGpkg_exe} -q -P ${package})
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
		return()
	endif()

	### Msys2 ###
	dk_depend(pacman_exe)
	if(pacman_exe)
		dk_assertPath(pacman_exe)
		if(EXISTS "${msys2_CacheDir}/db.lck")
			dk_delete("${msys2_CacheDir}/db.lck")
		endif()
		#dk_mkdir("${msys2_CacheDir}")
		dk_assertPath(msys2_CacheDir)
		
		if(Windows_X86_Clang)
			set(comand "${pacman_exe}" -S mingw-w64-clang-i686-${package} --needed --noconfirm --cachedir "${msys2_CacheDir}")		# CLANG32
			#set(comand "${pacman_exe}" -S mingw-w64-clang-i686-${package} --needed --noconfirm)									# CLANG32
		elseif(Windows_X86_64_Clang)
			set(comand "${pacman_exe}" -S mingw-w64-clang-x86_64-${package} --needed --noconfirm --cachedir "${msys2_CacheDir}")	# CLANG64
			#set(comand "${pacman_exe}" -S mingw-w64-clang-x86_64-${package} --needed --noconfirm)									# CLANG64
		elseif(Windows_Arm64_Clang)
			set(comand "${pacman_exe}" -S mingw-w64-clang-aarch64-${package} --needed --noconfirm --cachedir "${msys2_CacheDir}")	# CLANGARM64
			#set(comand "${pacman_exe}" -S mingw-w64-clang-aarch64-${package} --needed --noconfirm)									# CLANGARM64
		elseif(Windows_X86_Gcc)
			set(comand "${pacman_exe}" -S mingw-w64-i686-${package} --needed --noconfirm --cachedir "${msys2_CacheDir}")			# MINGW32
			#set(comand "${pacman_exe}" -S mingw-w64-i686-${package} --needed --noconfirm)											# MINGW32
		elseif(Windows_X86_64_Gcc)
			set(comand "${pacman_exe}" -S mingw-w64-x86_64-${package} --needed --noconfirm --cachedir "${msys2_CacheDir}")			# MINGW64
			#set(comand "${pacman_exe}" -S mingw-w64-x86_64-${package} --needed --noconfirm)										# MINGW64
		elseif(Windows_X86_64_Ucrt)
			set(comand "${pacman_exe}" -S mingw-w64-ucrt-x86_64-${package} --needed --noconfirm --cachedir "${msys2_CacheDir}")		# UCRT64
			#set(comand "${pacman_exe}" -S mingw-w64-ucrt-x86_64-${package} --needed --noconfirm)									# UCRT64
		else()
			set(comand "${pacman_exe}" -S ${package} --needed --noconfirm --cachedir "${msys2_CacheDir}")							# MSYS (DEFAULT)
			#set(comand "${pacman_exe}" -S ${package} --needed --noconfirm)															# MSYS (DEFAULT)
		endif()
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
		return()
	endif()
	
	### Swupd ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v swupd" OUTPUT_VARIABLE swupd_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(swupd_exe)
		set(comand ${swupd_exe} bundle-add ${package})
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
		return()
	endif()
	
	### Tiny core linux ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v tce-load" OUTPUT_VARIABLE tce-load_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(tce-load_exe)
		set(comand ${tce-load_exe} -wil ${package})
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
		return()
	endif()
	
	### WinGet ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v winget" OUTPUT_VARIABLE winget_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(winget_exe)
		set(comand winget install ${package})
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
		return()
	endif()
	
	### Xbps ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v xbps-install" OUTPUT_VARIABLE xbps-install_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(xbps-install_exe)
		set(comand xbps-install_exe ${package})
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
		return()
	endif()
	
	### Zypper ###
	execute_process(COMMAND $ENV{DKSHELL} -c "command -v zypper" OUTPUT_VARIABLE zypper_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(zypper_exe)
		set(comand zypper in ${package})
		dk_echo(${comand})
		execute_process(COMMAND ${comand})
		return()
	endif()
	
	dk_fatal("no package managers found")
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_installPackage(zlib)
endfunction()