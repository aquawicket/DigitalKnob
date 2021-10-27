# https://windows.php.net/downloads/releases
#
# https://phpdev.toolsforresearch.com/php-8.0.3-Win32-vs16-x64.zip
# https://windows.php.net/downloads/releases/php-8.0.12-Win32-vs16-x86.zip

DKDEPEND(vs16-redistributable)

### VERSION ###
DKSET(PHP_VERSION 8.0.12-Win32-vs16-x86)
DKSET(PHP_NAME php-${PHP_VERSION})
DKSET(PHP_DL https://windows.php.net/downloads/releases/${PHP_NAME}.zip)
DKSET(PHP ${3RDPARTY}/${PHP_NAME})


### INSTALL ###
DKINSTALL(${PHP_DL} php-win32-vs16-x64 ${PHP})
