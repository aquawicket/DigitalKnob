DKDEPEND(php_win32_vs16_x64)

DKCOPY(${PHP}/php.exe ${DKPLUGINS}/DKPhp/php.exe TRUE)
DKCOPY(${PHP}/php8ts.dll ${DKPLUGINS}/DKPhp/php8ts.dll TRUE)

DKASSETS(DKPhp)