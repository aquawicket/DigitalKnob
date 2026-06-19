@echo off
rem https://stackoverflow.com/a/79686604

::The following command writes one null ASCII character (0x00) to the file 0.bin:

echo.|(pause>nul & findstr "^")>0.bin & cmd /D /U /C "type 0.bin">A0.tmp & findstr /R . A0.tmp>0.bin

::For use where the paths are ambiguous and with A0.tmp cleanup, use:
::echo.|(pause>nul & %SystemRoot%\System32\findstr.exe "^")>0.bin & %SystemRoot%\System32\cmd.exe /D /U /C "type 0.bin">A0.tmp & (%SystemRoot%\System32\findstr.exe /R . A0.tmp & del A0.tmp)>0.bin