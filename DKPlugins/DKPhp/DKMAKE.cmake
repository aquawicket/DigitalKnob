DKDEPEND(php_binary)

dk_copy(${PHP_BINARY}/php.exe ${DKPLUGINS}/DKPhp/php.exe TRUE)
dk_copy(${PHP_BINARY}/php8ts.dll ${DKPLUGINS}/DKPhp/php8ts.dll TRUE)

DKASSETS(DKPhp)