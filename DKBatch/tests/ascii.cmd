@if (@CodeSection == @Batch) @then

@echo off
setlocal

for /L %%a in (0,1,128) do (
    cmd /C exit %%a
    call echo Batch: %%a = %%^=ExitCodeAscii%%
)
echo/

rem for /F "tokens=1,2" %%a in ('powershell "0..128 | %%{ [char]$_ }"') do echo PS: %%a = '%%b'
for /F "tokens=1,2" %%a in ('powershell "0..128 | %%{ [char]$_ }"') do echo PS: %%a = '%%b'
echo/

for /F "tokens=1,2" %%a in ('cscript //nologo //E:JScript "%~F0"') do (
	echo JSCRIPT: %%a = '%%b'
)


pause
goto :EOF

@end

for (var i=0; i<=128; i++){
	WSH.Echo(i+" "+String.fromCharCode(i));
}