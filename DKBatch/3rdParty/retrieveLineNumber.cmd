:: This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
::
:: For the latest information, see https://github.com/aquawicket/DigitalKnob
::
:: Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
::
:: Permission is hereby granted, free of charge, to any person obtaining a copy
:: of this software and associated documentation files(the "Software"), to deal
:: in the Software without restriction, including without limitation the rights
:: to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
:: copies of the Software, and to permit persons to whom the Software is
:: furnished to do so, subject to the following conditions :
::
:: The above copyright notice and this permission notice shall be included in all
:: copies or substantial portions of the Software.
::
:: THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
:: IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
:: FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
:: AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
:: LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
:: OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
:: SOFTWARE.

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
