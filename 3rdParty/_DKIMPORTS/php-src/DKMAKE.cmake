# https://github.com/php/php-src.git
# https://www.php.net
# https://www.php.net/distributions/php-8.0.9.tar.gz
# https://github.com/php/php-src/archive/refs/tags/php-8.0.14.zip
# https://windows.php.net/downloads/releases
# https://phpdev.toolsforresearch.com/php-8.0.23-Win32-vs16-x64.zip
# https://windows.php.net/downloads/releases/php-8.0.26-Win32-vs16-x86.zip
if(NOT WIN_HOST)
	dk_undepend(php-src)
	dk_return()
endif()


### DEPEND ###
dk_depend(vc_redist) #for VCRUNTIME140.dll


### IMPORT ###
dk_import(https://windows.php.net/downloads/releases/php-8.2.7-Win32-vs16-x86.zip)
#dk_import(https://github.com/php/php-src.git)
