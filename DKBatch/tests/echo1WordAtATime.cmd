@echo off
setlocal enableDelayedExpansion
set "sentence=The small brown fox runs quickly through the woods"
set "delim= "
for %%G in ("!sentence:%delim%=" "!") do @echo '%%~G'
pause