# https://www.php.net/distributions/php-8.0.9.tar.gz

### VERSION ###
DKSET(PHP_VERSION 8.0.9)
DKSET(PHP_NAME php-${PHP_VERSION})
DKSET(PHP_DL https://www.php.net/distributions/${PHP_VERSION}.tar.gz)
DKSET(PHP ${3RDPARTY}/${PHP_NAME})

### INSTALL ###
DKINSTALL(${PHP_DL} php ${PHP})