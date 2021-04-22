@echo off
cd ..
mkdir DKPhp_running
copy DKPhp\php.exe DKPhp_running\php.exe
copy DKPhp\php8ts.dll DKPhp_running\php8ts.dll
start /min DKPhp_running\php.exe -S 127.0.0.1:8000
start /min DKPhp_running\php.exe -S 192.168.1.78:8000