@ECHO OFF
set "drlist="
for /f "tokens=*" %%A in ('fsutil fsinfo drives^|find "\"') do (
    set "dr=%%A"
    call set "drlist=%%drlist%% %%dr:~-3%%"
)
for %%A in (%drlist%) do fsutil fsinfo drivetype %%A