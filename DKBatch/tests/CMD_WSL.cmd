::###### WSLENV flags ######
::# /p - translates the path between WSL/Linux style paths and Win32 paths.
::# /l - indicates the environment variable is a list of paths.
::# /u - indicates that this environment variable should only be included when running WSL from Win32.
::# /w - indicates that this environment variable should only be included when running Win32 from WSL.

::### CMD to WSL
::# set WSLENV=pathVar/p		# Translate pathVar to WSL
::# set WSLENV=pathList/l		# Translate pathList to WSL
::# set WSLENV=varA				# from CMD to WSL
::# set WSLENV=varB/u			# from CMD to WSL only
::# set WSLENV=varC/w			# from WSL to CMD only


::### WSL to CMD
::# export WSLENV=pathVar/p		# Translate pathVar to CMD
::# export WSLENV=pathList/l	# Translate pathList to CMD
::# export WSLENV=varA			# from WSL to CMD
::# export WSLENV=varB/u		# from CMD to WSL only
::# export WSLENV=varC/w		# from WSL to CMD only

@echo off
set "nooption=%USERPROFILE%"
set "option_u=%USERPROFILE%"
set "option_w=%USERPROFILE%"
set "option_p=%USERPROFILE%"
set "option_l=%USERPROFILE%"
set WSLENV=%WSLENV%:^
nooption:^
option_u/u:^
option_w/w:^
option_p/p:^
option_l/l

echo.
echo CMD_WSL.cmd(%*)
echo WSLENV   = %WSLENV%
echo nooption = %nooption%
echo option_u = %option_u%
echo option_w = %option_w%
echo option_p = %option_p%
echo option_l = %option_l%

 
::wsl /bin/bash -c "export nooption='%nooption%' && export option_u='%option_u%' && export option_w='%option_w%' &&  export option_p='%option_p%' && export option_l='%option_l%' && /mnt/c/Users/Administrator/Desktop/WSL_CMD.sh"
wsl /mnt/c/Users/Administrator/Desktop/WSL_CMD.sh


echo.
echo CMD_WSL.cmd(%*)
echo WSLENV   = %WSLENV%
echo nooption = %nooption%
echo option_u = %option_u%
echo option_w = %option_w%
echo option_p = %option_p%
echo option_l = %option_l%

pause