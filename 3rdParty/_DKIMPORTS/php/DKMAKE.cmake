# https://github.com/php/php-src
# https://www.php.net
#
# https://www.php.net/distributions/php-8.0.9.tar.gz
# https://github.com/php/php-src/archive/refs/tags/php-8.0.14.zip

DKGITCLONE(https://github.com/php/php-src.git)

#DKIMPORT(https://github.com/php/php-src)

#DKSET(PHP_VERSION 8.0.14)
#DKSET(PHP_DL https://github.com/php/php-src/archive/refs/tags/php-8.0.14.zip)
#DKSET(PHP_NAME php-${PHP_VERSION})
#DKSET(PHP ${3RDPARTY}/${PHP_NAME})
#DKINSTALL(${PHP_DL} php ${PHP})
