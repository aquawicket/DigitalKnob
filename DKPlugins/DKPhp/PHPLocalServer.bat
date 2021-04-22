@echo off
copy php.exe php_running.exe
cd ..
start /min DKPhp\php_running.exe -S 127.0.0.1:8000
start /min DKPhp\php_running.exe -S 192.168.1.78:8000

