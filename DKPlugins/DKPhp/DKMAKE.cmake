DKDEPEND(php_binary)

DKCOPY(${PHP_BINARY}/php.exe ${DKPLUGINS}/DKPhp/php.exe TRUE)
DKCOPY(${PHP_BINARY}/php8ts.dll ${DKPLUGINS}/DKPhp/php8ts.dll TRUE)

DKASSETS(DKPhp)