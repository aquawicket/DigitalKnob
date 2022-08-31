# https://github.com/php/php-src
# https://www.php.net
#
# https://www.php.net/distributions/php-8.0.9.tar.gz
# https://github.com/php/php-src/archive/refs/tags/php-8.0.14.zip

# dk_import(https://github.com/php/php-src.git)







##############################################################################################
# https://windows.php.net/downloads/releases
# https://phpdev.toolsforresearch.com/php-8.0.23-Win32-vs16-x64.zip
# https://windows.php.net/downloads/releases/php-8.0.23-Win32-vs16-x86.zip
if(NOT WIN_HOST)
	return()
endif()
### DEPENDS ###
dk_depend(vc_redist) #for VCRUNTIME140.dll
dk_import(https://windows.php.net/downloads/releases/php-8.0.23-Win32-vs16-x86.zip)

### INSTALL ###
#dk_set(PHP-SRC_VERSION 8.0.23-Win32-vs16-x86)
#dk_set(PHP-SRC_DL https://windows.php.net/downloads/releases/php-${PHP-SRC_VERSION}.zip)
#dk_set(PHP-SRC_NAME php-src-${PHP-SRC_VERSION})
#dk_set(PHP-SRC ${3RDPARTY}/${PHP-SRC_NAME})
#dk_import(${PHP-SRC_DL} ${PHP-SRC})
###############################################################################################