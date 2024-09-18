include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
dk_load(dk_builder)
# https://github.com/php/php-src.git
# https://www.php.net
# https://windows.php.net/downloads/releases

dk_validate(HOST_TRIPLE   		"dk_HOST_TRIPLE()")
dk_validate(TARGET_TRIPLE 		"dk_TARGET_TRIPLE()")
dk_validate(DKBUILD_TYPE		"dk_BUILD_TYPE()")
dk_validate(CONFIG_PATH   		"dk_MULTI_CONFIG()")
if(NOT WIN_HOST)
	dk_undepend(php-src)
	dk_return()
endif()


### DEPEND ###
dk_depend(vc_redist) #for VCRUNTIME140.dll

### IMPORT ###
#dk_import(https://windows.php.net/downloads/releases/php-8.2.7-Win32-vs16-x86.zip)					# old
#dk_import(https://windows.php.net/downloads/releases/php-8.0.30-Win32-vs16-x86.zip)				# old
#dk_import			(https://github.com/php/php-src.git)											# git
#dk_import			(https://github.com/php/php-src/archive/refs/heads/master.zip)					# zip
UNIX_dk_import		(https://www.php.net/distributions/php-8.3.11.tar.gz)							# unix binary
WIN_X86_dk_import   (https://windows.php.net/downloads/releases/php-8.3.11-Win32-vs16-x86.zip)		# win_x86 binary
WIN_X86_64_dk_import(https://windows.php.net/downloads/releases/php-8.3.11-Win32-vs16-x64.zip)		# win x86_64 binary
