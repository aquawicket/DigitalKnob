# https://phpdev.toolsforresearch.com/php-8.0.3-Win32-vs16-x64

### VERSION ###
DKSET(PHP_VERSION 8.0.3-Win32-vs16-x64)
DKSET(PHP_NAME php-${PHP_VERSION})
DKSET(PHP_DL https://phpdev.toolsforresearch.com/${PHP_NAME}.zip)
DKSET(PHP ${3RDPARTY}/${PHP_NAME})


### INSTALL ###
DKINSTALL(${PHP_DL} php-win32-vs16-x64 ${PHP})
