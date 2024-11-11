#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


##################################
dk_load(dk_builder)


if(NOT WIN)
	dk_undepend(pdh)
	dk_return()
endif()



if(MSVC OR msvc)
	dk_findLibrary(pdh)
	
elseif(MSYSTEM OR msystem)
	message("ENV{MSYSTEM} = $ENV{MSYSTEM}")
	message("MSYSTEM      = ${MSYSTEM}")
	message("CLANGARM64   = ${CLANGARM64}")
	message("CLANG32      = ${CLANG32}")
	message("CLANG64      = ${CLANG64}")
	message("MINGW32      = ${MINGW32}")
	message("MINGW64      = ${MINGW64}")
	message("UCRT64       = ${UCRT64}")
	message("msystem      = ${msystem}")
	message("clangarm64   = ${clangarm64}")
	message("clang32      = ${clang32}")
	message("clang64      = ${clang64}")
	message("mingw32      = ${mingw32}")
	message("mingw64      = ${mingw64}")
	message("ucrt64       = ${ucrt64}")


	dk_validate(MSYS2 "dk_depend(msys2)")
	# mingw-w64-ucrt-x86_64-crt-git		ucrt64
	# mingw-w64-clang-x86_64-crt-git	clang64
	# mingw-w64-clang-aarch64-crt-git	clangarm64
	# mingw-w64-x86_64-crt-git			mingw64
	# mingw-w64-i686-crt-git			mingw32
	# mingw-w64-clang-i686-crt-git		clang32
	dk_installPackage(crt-git)

	#dk_findLibrary(libpdh.a)
	
	dk_findLibrary(pdh)
	dk_lib("${MSYS2}/${msystem}/lib/libpdh.a")
	dk_append(CMAKE_EXE_LINKER_FLAGS -lpdh)
	

endif()
