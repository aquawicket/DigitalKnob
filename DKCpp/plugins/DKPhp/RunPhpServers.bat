@echo off
cd ..
mkdir DKPhp_running
copy DKPhp\php.exe DKPhp_running\php_local.exe
copy DKPhp\php.exe DKPhp_running\php_web.exe
copy DKPhp\php8ts.dll DKPhp_running\php8ts.dll
TASKLIST | FINDSTR php_local.exe || START /min "" "DKPhp_running\php_local.exe" -S 127.0.0.1:2393
TASKLIST | FINDSTR php_web.exe || START /min "" "DKPhp_running\php_web.exe" -S 192.168.1.210:2393