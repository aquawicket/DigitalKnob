include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
# perl
# https://packages.msys2.org/package/mingw-w64-x86_64-perl

if(ANDROID_HOST)
	dk_command(pkg install perl -y)
	
	find_program(PERL_EXE perl)
	if(NOT PERL_EXE)
		dk_warning("perl not found!")
	else()
		dk_debug(PERL_EXE)
		dk_command(${PERL_EXE} --version)
	endif()
	
endif()


if(MSYSTEM)
	dk_depend(msys2)
	
	dk_delete(${MSYS2}/var/lib/pacman/db.lck NO_HALT)
	dk_command(bash -c "command -v perl" OUTPUT_VARIABLE PERL_EXE NO_HALT) # BASH_ENV)
	if(PERL_EXE)
		dk_command(${CYGPATH_EXE} -m ${PERL_EXE} OUTPUT_VARIABLE PERL_EXE)
	endif()
	
	#if(win_x86_clang)
	#	dk_command(${PACMAN_EXE} -S mingw-w64-clang-i686-perl --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# CLANG32
	#elseif(win_x86_64_clang)
	#	dk_command(${PACMAN_EXE} -S mingw-w64-clang-x86_64-perl --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# CLANG64
	#	#dk_download(https://mirror.msys2.org/mingw/clang64/mingw-w64-clang-x86_64-perl-5.38.2-1-any.pkg.tar.zst)
	#	#dk_command(${PACMAN_EXE} -U ${DKDOWNLOAD_DIR}/mingw-w64-clang-x86_64-perl-5.38.2-1-any.pkg.tar.zst --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})
	#elseif(win_arm64_clang)
	#	dk_command(${PACMAN_EXE} -S mingw-w64-clang-aarch64-perl --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# CLANGARM64
	#elseif(win_x86_mingw)
	#	dk_command(${PACMAN_EXE} -S mingw-w64-i686-perl --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})				# MINGW32
	#elseif(win_x86_64_mingw)
	#	dk_command(${PACMAN_EXE} -S mingw-w64-x86_64-perl --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})			# MINGW32
	#	#dk_download(https://mirror.msys2.org/mingw/mingw64/mingw-w64-x86_64-perl-5.38.2-1-any.pkg.tar.zst)
	#	#dk_command(${PACMAN_EXE} -U ${DKDOWNLOAD_DIR}/mingw-w64-x86_64-perl-5.38.2-1-any.pkg.tar.zst --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})
	#elseif(win_x86_64_ucrt)
	#	dk_command(${PACMAN_EXE} -S mingw-w64-ucrt-x86_64-perl --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})		# UCRT64
	#endif()
	dk_command(${PACMAN_EXE} -S perl --needed --noconfirm --cachedir ${DKDOWNLOAD_DIR})									# MSYS2
	
	dk_command(bash -c "command -v perl" OUTPUT_VARIABLE PERL_EXE) # BASH_ENV)
	if(PERL_EXE)
		dk_command(cygpath -m ${PERL_EXE} OUTPUT_VARIABLE PERL_EXE)
	endif()

endif()