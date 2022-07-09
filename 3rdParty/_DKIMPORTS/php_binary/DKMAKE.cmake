# https://windows.php.net/downloads/releases
#
# https://phpdev.toolsforresearch.com/php-8.0.21-Win32-vs16-x64.zip
# https://windows.php.net/downloads/releases/php-8.0.21-Win32-vs16-x86.zip
if(NOT WIN_HOST)
	return()
endif()


### DEPENDS ###
dk_depend(vc_redist) #for VCRUNTIME140.dll

dk_import(https://windows.php.net/downloads/releases/php-8.0.21-Win32-vs16-x86.zip)

### INSTALL ###
#dk_set(PHP_BINARY_VERSION 8.0.20-Win32-vs16-x86)
#dk_set(PHP_BINARY_DL https://windows.php.net/downloads/releases/php-${PHP_BINARY_VERSION}.zip)
#dk_set(PHP_BINARY_NAME php_binary-${PHP_BINARY_VERSION})
#dk_set(PHP_BINARY ${3RDPARTY}/${PHP_BINARY_NAME})
#dk_import(${PHP_BINARY_DL} ${PHP_BINARY})
