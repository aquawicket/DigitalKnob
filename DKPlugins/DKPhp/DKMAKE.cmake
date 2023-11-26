#dk_depend(php_binary)
#dk_copy(${PHP_BINARY}/php.exe ${DKPLUGINS}/DKPhp/php.exe OVERWRITE)
#dk_copy(${PHP_BINARY}/php8ts.dll ${DKPLUGINS}/DKPhp/php8ts.dll OVERWRITE)

dk_depend(php-src)
dk_copy(${PHP-SRC}/php.exe ${DKPLUGINS}/DKPhp/php.exe OVERWRITE)
dk_copy(${PHP-SRC}/php8ts.dll ${DKPLUGINS}/DKPhp/php8ts.dll OVERWRITE)

dk_assets(DKPhp)