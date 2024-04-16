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
	
	dk_remove(${MSYS2}/var/lib/pacman/db.lck NOERROR)
	dk_command(bash -c "command -v perl" OUTPUT_VARIABLE PERL_EXE NOASSERT) # BASH_ENV)
	if(PERL_EXE)
		dk_command(${CYGPATH_EXE} -m ${PERL_EXE} OUTPUT_VARIABLE PERL_EXE)
	endif()
	
	#if(CLANG32)
	#	dk_command(pacman -S mingw-w64-clang-i686-perl --needed --noconfirm)		# CLANG32
	#elseif(CLANG64)
	#	dk_command(pacman -S mingw-w64-clang-x86_64-perl --needed --noconfirm)		# CLANG64
	#	#dk_download(https://mirror.msys2.org/mingw/clang64/mingw-w64-clang-x86_64-perl-5.38.2-1-any.pkg.tar.zst)
	#	#dk_command(pacman -U ${DKDOWNLOAD_DIR}/mingw-w64-clang-x86_64-perl-5.38.2-1-any.pkg.tar.zst --needed --noconfirm)
	#elseif(CLANGARM64)
	#	dk_command(pacman -S mingw-w64-clang-aarch64-perl --needed --noconfirm)		# CLANGARM64
	#elseif(MINGW32)
	#	dk_command(pacman -S mingw-w64-i686-perl --needed --noconfirm)				# MINGW32
	#elseif(MINGW64)
	#	dk_command(pacman -S mingw-w64-x86_64-perl --needed --noconfirm)			# MINGW32
	#	#dk_download(https://mirror.msys2.org/mingw/mingw64/mingw-w64-x86_64-perl-5.38.2-1-any.pkg.tar.zst)
	#	#dk_command(pacman -U ${DKDOWNLOAD_DIR}/mingw-w64-x86_64-perl-5.38.2-1-any.pkg.tar.zst --needed --noconfirm)
	#elseif(UCRT64)
	#	dk_command(pacman -S mingw-w64-ucrt-x86_64-perl --needed --noconfirm)		# UCRT64
	#endif()
	dk_command(pacman -S perl --needed --noconfirm)									# MSYS2
	
	dk_command(bash -c "command -v perl" OUTPUT_VARIABLE PERL_EXE) # BASH_ENV)
	if(PERL_EXE)
		dk_command(cygpath -m ${PERL_EXE} OUTPUT_VARIABLE PERL_EXE)
	endif()

endif()