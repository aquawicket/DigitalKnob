@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


setlocal ENABLEDELAYEDEXPANSION

set x86GUID=HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall
for /f "tokens=2*" %%A in (
  'reg query "%x86GUID%" /V /F DisplayName /S /E 2^>nul ^| findstr "DisplayName"'
) do (
  for /f "delims=" %%P in ('reg query "%x86GUID%" /s /f "%%B" 2^>nul ^| findstr "HKLM"') do (
    for /f "tokens=2*" %%X in (
      'reg query "%%P" /v "UninstallString" 2^>nul ^|findstr "UninstallString" ^|findstr "MsiExec.exe"'
    ) do (
      set MsiStr=%%Y
      set MsiStr=!MsiStr:/I=/X!
      echo !MsiStr! %%B
    )
  )
)