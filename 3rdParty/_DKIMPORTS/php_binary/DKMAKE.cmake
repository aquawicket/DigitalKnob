# https://windows.php.net/downloads/releases
#
# https://phpdev.toolsforresearch.com/php-8.0.3-Win32-vs16-x64.zip
# https://windows.php.net/downloads/releases/php-8.0.14-Win32-vs16-x86.zip
if(NOT WIN_HOST)
	return()
endif()


### DEPENDS ###
DKDEPEND(vs16-redistributable)


### VERSION ###
DKSET(PHP_VERSION 8.0.14-Win32-vs16-x86)
DKSET(PHP_DL https://windows.php.net/downloads/releases/php-8.0.14-Win32-vs16-x86.zip)



### INSTALL ###
DKSET(PHP_NAME php_binary-${PHP_VERSION})
DKSET(PHP ${3RDPARTY}/${PHP_NAME})
DKINSTALL(${PHP_DL} php_binary ${PHP})
