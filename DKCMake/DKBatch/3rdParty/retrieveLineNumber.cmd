:initRetrieveLineNumber
setlocal enableDelayedExpansion
set ^"LF=^

^" The empty line above is critical - DO NOT REMOVE
set "sp=="
for /l %%N in (1 1 13) do set "sp=!sp:~0,4000!!sp:~0,4000!"
setlocal disableDelayedExpansion
copy "%~f0" "%~f0.save" >nul
set /a offset=0
>"%~f0.#" (
  for /f "delims=" %%A in ('findstr /ironc:"\<call  *:retrieveLineNumber " "%~f0"') do (
    set "ln=%%A"
    for /f "tokens=1,2 delims=:" %%B in ("%%A") do (
      set "ln=%%A"
      setlocal enableDelayedExpansion
      set "ln=!ln:*:=!"
      set "ln=!ln:*:=!"
      set "label=%%B"
      call :strlen ln lnLen
      call :strlen label labelLen
      set /a "fill=%%C+lnLen-labelLen-6-offset, fillCnt=fill/8002, fill=fill%%8002, offset=%%C+lnLen+labelLen+10"
      for /l %%N in (1 1 !fillCnt!) do (echo !sp!)
      for %%N in (!fill!) do (echo(!sp:~-%%N!)
      (echo :%%B!LF!%%#%%!LF!%%#:?=%%B%%)
      for %%O in (!offset!) do endlocal&set "offset=%%O"
    )
  )
)
exit /b


:retrieveLineNumber  RtnVar
set ^"#=set ^^^"#=move /y "%~f0" "%~f0.#"^^^>nul^^^&move /y "%~f0.0" "%~f0"^^^>nul^^^&set #=^^^&set %1=?^^^"^&goto :?^"
move /y "%~f0" "%~f0.0" >nul & move /y "%~f0.#" "%~f0" >nul & exit /b


:quitRetrieveLineNumber
setlocal disableDelayedExpansion
del "%~f0.0" "%~f0.#"
exit /b


:strlen  StrVar  [RtnVar]
setlocal EnableDelayedExpansion
set "s=#!%~1!"
set "len=0"
for %%N in (4096 2048 1024 512 256 128 64 32 16 8 4 2 1) do (
  if "!s:~%%N,1!" neq "" (
    set /a "len+=%%N"
    set "s=!s:~%%N!"
  )
)
endlocal&if "%~2" neq "" (set %~2=%len%) else echo %len%
exit /b
