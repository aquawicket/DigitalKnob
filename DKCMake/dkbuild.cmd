:: Let's ask the use to type in what they want to build
:: could be an app, library or anything with a DKMAKE.cmake file
:: We whould also give the option to list targets as well

@echo off
echo Please type the name of the library, tool or app to build. Then press enter.
set /p input=
echo %input%


CMAKE -G "VS_GENERATOR" -A Win32 -DDEBUG -DRELEASE -DSTATIC


pause