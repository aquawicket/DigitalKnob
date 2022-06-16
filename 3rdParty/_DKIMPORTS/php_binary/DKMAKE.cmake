# https://windows.php.net/downloads/releases
#
# https://phpdev.toolsforresearch.com/php-8.0.3-Win32-vs16-x64.zip
# https://windows.php.net/downloads/releases/php-8.0.18-Win32-vs16-x86.zip
if(NOT WIN_HOST)
	return()
endif()


### DEPENDS ###
DKDEPEND(vc_redist) #for VCRUNTIME140.dll

DKIMPORT(https://windows.php.net/downloads/releases/php-8.0.20-Win32-vs16-x86.zip)

### INSTALL ###
#DKSET(PHP_BINARY_VERSION 8.0.20-Win32-vs16-x86)
#DKSET(PHP_BINARY_DL https://windows.php.net/downloads/releases/php-${PHP_BINARY_VERSION}.zip)
#DKSET(PHP_BINARY_NAME php_binary-${PHP_BINARY_VERSION})
#DKSET(PHP_BINARY ${3RDPARTY}/${PHP_BINARY_NAME})
#DKINSTALL(${PHP_BINARY_DL} php_binary ${PHP_BINARY})
