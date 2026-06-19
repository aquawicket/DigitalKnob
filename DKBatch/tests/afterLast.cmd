@echo off
set "str=Content-Disposition: attachment; filename=PortableGit-2.46.2-64-bit.7z.exe"
set "result=%str:filename=" & set "result=%"
echo %result%


for /f "tokens=1* delims==" %%A in ("%str%") do echo %%B



pause