@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

set "DIGITALKNOB=C:\Users\%USERNAME%\digitalknob"
set "DKPATH=%DIGITALKNOB%\DK"
set "EXECUTABLE=%DKPATH%\DKApps\DKBuilder\win32\Release\DKBuilder.exe"
set "EXECUTABLE=C:\program files (x86)\git\mingw32\libexec\git-core\git-remote-https.exe"

:: netsh advfirewall firewall add rule name="RULENAME" dir=[in/out] action=[allow/block/bypass] protocol=[tcp/udp] localip=[any] remoteip=[any]
netsh advfirewall firewall add rule name="DKBuilder" dir=out action=allow program="%EXECUTABLE%" profile=any 