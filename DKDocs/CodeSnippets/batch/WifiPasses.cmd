
@echo off
%dkbatch%

  :: Programmed by hXR16F
:: hXR16F.ar@gmail.com

@echo off & setlocal enabledelayedexpansion & (set "tempfile=temp_%random%" & set "dumpname=dump.txt")
(if exist "!tempfile!" (del /f /q "!tempfile!" >nul 2>&1)) & (netsh wlan show profile | findstr All>> "!tempfile!")
(for /f "tokens=2 delims=:" %%i in (!tempfile!) do (set /a count+=1 & set "list_!count!=%%i")) && (for /l %%i in (1,1,!count!) do (set list_%%i=!list_%%i:~1!))
for /l %%i in (1,1,!count!) do ((echo      Wi-Fi Name            : !list_%%i!>> "!dumpname!") & (netsh wlan show profile name="!list_%%i!" key=clear | findstr Content>> "!dumpname!") & (echo. >> "!dumpname!"))
del /f /q !tempfile! >nul 2>&1