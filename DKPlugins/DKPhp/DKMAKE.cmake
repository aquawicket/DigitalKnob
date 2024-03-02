#dk_depend(php_binary)
#dk_copy(${PHP_BINARY}/php.exe ${DKPLUGINS_DIR}/DKPhp/php.exe OVERWRITE)
#dk_copy(${PHP_BINARY}/php8ts.dll ${DKPLUGINS_DIR}/DKPhp/php8ts.dll OVERWRITE)

dk_depend(php-src)
dk_copy(${PHP_SRC}/php.exe ${DKPLUGINS_DIR}/DKPhp/php.exe OVERWRITE)
dk_copy(${PHP_SRC}/php8ts.dll ${DKPLUGINS_DIR}/DKPhp/php8ts.dll OVERWRITE)

dk_assets(DKPhp)