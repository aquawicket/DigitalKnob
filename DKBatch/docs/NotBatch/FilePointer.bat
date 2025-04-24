@echo off
setlocal EnableDelayedExpansion

echo Extracting FilePointer.exe, please wait...
call :ExtractBinaryFile FilePointer.exe
echo FilePointer.exe file created
goto :EOF


rem Extract Binary File from hexadecimal digits placed in a "resource" in this .bat file

:ExtractBinaryFile filename.ext
setlocal EnableDelayedExpansion
set "start="
set "end="
for /F "tokens=1,3 delims=:=>" %%a in ('findstr /N /B "</*resource" "%~F0"') do (
   if not defined start (
      if "%%~b" equ "%~1" set start=%%a
   ) else if not defined end set end=%%a
)
(for /F "skip=%start% tokens=1* delims=:" %%a in ('findstr /N "^" "%~F0"') do (
   if "%%a" == "%end%" goto decodeHexFile
   echo %%b
)) > "%~1.hex"
:decodeHexFile

rem Modified code based on :genchr subroutine
type nul > t.tmp
(for /F "usebackq" %%a in ("%~1.hex") do (
   set input=%%a
   set i=0
   for /L %%I in (0,2,120) do for %%i in (!i!) do if "!input:~%%i,1!" neq "" (
      set hex=!input:~%%i,2!
      set /A i+=2
      if "!hex:~0,1!" neq "[" (
         set /A chr=0x!hex!
         if not exist !chr!.chr call :genchr !chr!
         type !chr!.chr
      ) else (
         for /L %%J in (1,1,5) do for %%i in (!i!) do if "!input:~%%i,1!" neq "]" (
            set "hex=!hex!!input:~%%i,1!"
            set /A i+=1
         )
         if not exist 0.chr call :genchr 0
         for /L %%J in (1,1,!hex:~1!) do type 0.chr
         set /A i+=1
      )
   )
)) > "%~1"
del *.chr
del t.tmp temp.tmp
del "%~1.hex"

exit /B


:genchr
REM This code creates one single byte. Parameter: int
REM Teamwork of carlos, penpen, aGerman, dbenham
REM Tested under Win2000, XP, Win7, Win8
set "options=/d compress=off /d reserveperdatablocksize=26"
if %~1 neq 26 (
   makecab %options% /d reserveperfoldersize=%~1 t.tmp %~1.chr > nul
   type %~1.chr | ( (for /l %%N in (1,1,38) do pause)>nul & findstr "^" > temp.tmp )
   >nul copy /y temp.tmp /a %~1.chr /b
) else (
   copy /y nul + nul /a 26.chr /a >nul
)
exit /B


<resource id="FilePointer.exe">
4d5a900003[3]04[3]ffff[2]b8[7]40[35]b0[3]0e1fba0e00b409cd21b8014ccd21546869732070726f6772616d2063616e6e6f74206265207275
6e20696e20444f53206d6f64652e0d0d0a24[7]551e49c1117f2792117f2792117f27929f603492167f2792ed5f3592137f279252696368117f2792
[8]5045[2]4c01020022e75a53[8]e0000f010b01050c0002[3]02[7]10[3]10[3]20[4]40[2]10[3]02[2]04[7]04[8]30[3]02[6]03[5]10[2]10
[4]10[2]10[6]10[11]1420[2]28[84]20[2]14[27]2e74657874[3]f6[4]10[3]02[3]02[14]20[2]602e7264617461[2]a0[4]20[3]02[3]04[14]
40[2]40[8]e806[3]50e8d3[3]558bec83c4f8e89a[3]e8b9[3]0fb606460ac00f8484[3]2c30040af7d850e8b1[3]8945fce899[3]0fb606460ac0
746833db33ffb90a[3]3c2d7505470fb606463c30720d3c3977092c3093f7e103d8ebeb0bff7402f7dbba[4]e85e[3]8a06460ac074223c2f751e8a
063c4374043c637507ba01[3]eb0d3c4574043c657505ba02[3]526a0053ff75fce83f[3]c9c3cccccce83b[3]8bf08a06463c2275098a06463c2275
f9eb0c8a06463c20740484c075f54ec38a06463c2074f94ec3ccff250c204000ff2500204000ff2504204000ff25082040[267]5e20[2]6e20[2]80
20[2]5020[6]3c20[10]9220[3]20[22]5e20[2]6e20[2]8020[2]5020[6]9b004578697450726f63657373006a0147657453746448616e646c65[2]
850253657446696c65506f696e746572[2]e600476574436f6d6d616e644c696e6541006b65726e656c33322e646c6c[354]
</resource>