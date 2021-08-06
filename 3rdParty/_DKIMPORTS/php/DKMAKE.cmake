### VERSION ###
DKSET(PHP_VERSION php-8.0.2)

### INSTALL ###
DKINSTALL(https://www.php.net/distributions/${PHP_VERSION}.tar.gz php ${PHP})
DKSET(PHP ${3RDPARTY}/${PHP_VERSION})