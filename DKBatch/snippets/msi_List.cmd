@echo off
setlocal ENABLEDELAYEDEXPANSION

set x86GUID=HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall
for /f "tokens=2*" %%A in (
  'reg query "%x86GUID%" /V /F DisplayName /S /E 2^>nul ^| findstr "DisplayName"'
) do (
  for /f "delims=" %%P in ('reg query "%x86GUID%" /s /f "%%B" 2^>nul ^| findstr "HKEY_LOCAL_MACHINE"') do (
    for /f "tokens=2*" %%X in (
      'reg query "%%P" /v "UninstallString" 2^>nul ^|findstr "UninstallString" ^|findstr "MsiExec.exe"'
    ) do (
      set MsiStr=%%Y
      set MsiStr=!MsiStr:/I=/X!
      echo !MsiStr! %%B
    )
  )
)