@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

::set "DIGITALKNOB=C:\Users\%USERNAME%\digitalknob"
::set "DKPATH=%DIGITALKNOB%\DK"
::set "EXECUTABLE=%DKPATH%\DKApps\DKBuilder\win32\Release\DKBuilder.exe"


set "NAME=Git"
set "EXECUTABLE=C:\program files (x86)\git\mingw32\libexec\git-core\git-remote-https.exe"

:: netsh -> advfirewall -> firewall -> add -> rule
:: Usage: add rule
::		[name=<string>]
::      [dir=in|out]
::      [action=allow|block|bypass]
::      [program=<program path>]
::      [service=<service short name>|any]
::      [description=<string>]
::      [enable=yes|no (default=yes)]
::      [profile=public|private|domain|any[,...]]
::      [localip=any|<IPv4 address>|<IPv6 address>|<subnet>|<range>|<list>]
::      [remoteip=any|localsubnet|dns|dhcp|wins|defaultgateway|<IPv4 address>|<IPv6 address>|<subnet>|<range>|<list>]
::      [localport=0-65535|<port range>[,...]|RPC|RPC-EPMap|IPHTTPS|any (default=any)]
::      [remoteport=0-65535|<port range>[,...]|any (default=any)]
::      [protocol=0-255|icmpv4|icmpv6|icmpv4:type,code|icmpv6:type,code|tcp|udp|any (default=any)]
::      [interfacetype=wireless|lan|ras|any]
::      [rmtcomputergrp=<SDDL string>]
::      [rmtusrgrp=<SDDL string>]
::      [edge=yes|deferapp|deferuser|no (default=no)]
::      [security=authenticate|authenc|authdynenc|authnoencap|notrequired(default=notrequired)]


:: netsh advfirewall firewall add rule name="RULENAME" dir=[in/out] action=[allow/block/bypass] protocol=[tcp/udp] localip=[any] remoteip=[any]
netsh advfirewall firewall add rule name="%NAME%" dir=in action=allow program="%EXECUTABLE%" enable=yes profile=any
netsh advfirewall firewall add rule name="%NAME%" dir=out action=allow program="%EXECUTABLE%" enable=yes profile=any 