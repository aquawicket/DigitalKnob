#!/usr/bin/cmake -P
if(NOT DKCMAKE_FUNCTIONS_DIR_)
	set(DKCMAKE_FUNCTIONS_DIR_ ${CMAKE_SOURCE_DIR}/../../../DKCMake/functions/)
endif()
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)


############ php-src ############
# https://github.com/php/php-src.git
# https://www.php.net
# https://windows.php.net/downloads/releases
dk_load(dk_builder)

if(NOT WIN_HOST)
	dk_undepend(php-src)
	dk_return()
endif()


dk_validate		(DKIMPORTS_DIR "dk_DKIMPORTS_DIR()")
dk_getFileParam ("${DKIMPORTS_DIR}/php-src/php-src.txt" PHP_SRC_UNIX)
dk_getFileParam ("${DKIMPORTS_DIR}/php-src/php-src.txt" PHP_SRC_WIN_X86_DL)
dk_getFileParam ("${DKIMPORTS_DIR}/php-src/php-src.txt" PHP_SRC_WIN_X86_64_DL)


### DEPEND ###
dk_depend(vc_redist) #for VCRUNTIME140.dll

### IMPORT ###
#dk_import			(https://windows.php.net/downloads/releases/php-8.2.7-Win32-vs16-x86.zip)		# old
#dk_import			(https://windows.php.net/downloads/releases/php-8.0.30-Win32-vs16-x86.zip)		# old
#dk_import			(https://github.com/php/php-src.git)											# git
#dk_import			(https://github.com/php/php-src/archive/refs/heads/master.zip)					# zip
UNIX_dk_import		(${PHP_SRC_UNIX})				# unix binary
WIN_X86_dk_import   (${PHP_SRC_WIN_X86_DL})			# win_x86 binary
WIN_X86_64_dk_import(${PHP_SRC_WIN_X86_64_DL})		# win x86_64 binary
