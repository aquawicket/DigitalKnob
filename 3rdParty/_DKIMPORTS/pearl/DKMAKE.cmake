# pearl
# https://packages.msys2.org/package/mingw-w64-x86_64-perl

if(ANDROID_HOST)
	dk_command(pkg install perl)
	
	find_program(PEARL_EXE pearl)
	if(NOT PEARL_EXE)
		dk_warn("pearl not found!")
	else()
		dk_debug(PEARL_EXE		PRINTVAR)
		dk_command(${PEARL_EXE} --version)
	endif()
	
endif()


if(MINGW)
	dk_depend(msys2)
	
	dk_remove(${MSYS2}/var/lib/pacman/db.lck NOERROR)
	
	if(CLANG32)
		dk_command(pacman -S mingw-w64-clang-i686-pearl --needed --noconfirm)		# CLANG32
	elseif(CLANG64)
		dk_command(pacman -S mingw-w64-clang-x86_64-pearl --needed --noconfirm)		# CLANG64
	elseif(CLANGARM64)
		dk_command(pacman -S mingw-w64-clang-aarch64-pearl --needed --noconfirm)	# CLANGARM64
	elseif(MINGW32)
		dk_command(pacman -S mingw-w64-i686-perl --needed --noconfirm)				# MINGW32
	elseif(MINGW64)
		#dk_command(pacman -S mingw-w64-x86_64-perl --needed --noconfirm)			# MINGW32
		dk_download(https://mirror.msys2.org/mingw/mingw64/mingw-w64-x86_64-perl-5.38.2-1-any.pkg.tar.zst)
		dk_command(pacman -U ${DKDOWNLOAD_DIR}/mingw-w64-x86_64-perl-5.38.2-1-any.pkg.tar.zst --needed --noconfirm)
	elseif(UCRT64)
		dk_command(pacman -S mingw-w64-ucrt-x86_64-pearl --needed --noconfirm)		# UCRT64
	endif()
	
	dk_set(PEARL_EXE pearl)
	dk_debug(PEARL_EXE	PRINTVAR)
	#dk_command(${PEARL_EXE} --version)

endif()