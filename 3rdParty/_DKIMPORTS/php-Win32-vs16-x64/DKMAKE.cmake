if(NOT WIN)
	return()
endif()

### VERSION ###
DKSET(PHP_VERSION 8.0.3-Win32-vs16-x64)
DKSET(PHP ${3RDPARTY}/php-${PHP_VERSION})


### INSTALL ###
DKINSTALL(https://phpdev.toolsforresearch.com/php-${PHP_VERSION}.zip php-Win32-vs16-x64 ${PHP})
