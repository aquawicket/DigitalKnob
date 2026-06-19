@echo off
:top
setlocal disableDelayedExpansion
for /l %%n in (0,1,255) do (
  call :chr %1 %%n char
  if not errorlevel 1 (
    call :asc %1 char 0 n
    call echo "%%n:%%char%%:%%n%%"
  ) else echo chr %%n produced above error
)
echo:
call :asciiMap %1 map
call :strLen map len
set map
echo len=%len%
echo:
call :str2hex %1 map hex
set hex
echo:
call :hex2str %1 hex str
set str
echo:
setlocal enableDelayedExpansion
if "!map!"=="!str!" (echo map matches str) else (echo map does not match str)
if "%1"=="" call :top /X
exit /b

:str2hex    [/X] StrVar [RtnVar]
::
::  Converts the string contained within variable StrVar into a string of
::  ASCII codes, with each code represented as a pair of hexadecimal digits.
::  The length of the result will always be exactly twice the length of
::  the original string.
::
::  Sets RtnVar=result
::  or displays result if RtnVar not specified
::
::  If one of the following problematic characters appears within StrVar
::  then the corresponding hex pair is set to 00 and errorlevel is set to 1.
::
::     C H A R A C T E R                      S U P P O R T E D ?
::    Dec   Hex   Oct  Char                    Normal  /X Option
::    ---  ----  ----  ----                    ------  ---------
::      0  0x00    00  NUL  (null)               No      No
::     10  0x0A   012  LF   (line feed)          No      No
::     13  0x0D   015  CR   (carriage return)    No      Yes
::     26  0x1A   032  SUB  (substitute)         No      Yes
::
::  If the case insensitive /X option is specified then CR (0x0D) and
::  SUB (0x1A) are supported properly as input.
::
::  Note: The /X option requires writing and reading a small temporary file.
:::
::: Dependencies - :asciiMap, :strLen, :Unique
:::
  setlocal disableDelayedExpansion
  if /i "%~1"=="/X" (
    set option=%1
    shift /1
  ) else set option=
  call :asciiMap %option% asciiMap
  set "hexMap=0123456789ABCDEF"
  call :strLen %~1 len
  set /a len-=1
  set rtn=
  set err=
  setlocal enableDelayedExpansion
  for /l %%n in (0,1,%len%) do (
    set c=!%~1:~%%n,1!
    set d=0
    for /l %%n in (0,1,255) do if "!asciiMap:~%%n,1!"=="!c!" set d=%%n
    set /a h1=d/16, h2=d%%16
    for %%a in (!h1!) do for %%b in (!h2!) do set rtn=!rtn!!hexMap:~%%a,1!!hexMap:~%%b,1!
  )
  ( endlocal
    endlocal
    if "%~2" neq "" (set %~2=%rtn%) else echo:%rtn%
    exit /b %err%
  )
exit /b


:hex2str    [/X] HexVar RtnVar
::
::  Converts a string of hexadecimal digits contained within variable HexVar
::  into a string, where each pair of hex digits in the input represents the
::  ASCII code of a character in the result.
::
::  Stores the result in the variable RtnVar.
::
::  If one of the following problematic characters is specified within the Hex
::  string then a space is substituted and errorlevel is set to 1:
::
::     C H A R A C T E R                      S U P P O R T E D ?
::    Dec   Hex   Oct  Char                    Normal  /X Option
::    ---  ----  ----  ----                    ------  ---------
::      0  0x00    00  NUL  (null)               No      No
::     10  0x0A   012  LF   (line feed)          No      No
::     13  0x0D   015  CR   (carriage return)    No      Yes
::     26  0x1A   032  SUB  (substitute)         No      Yes
::
::  If the case insensitive /X option is specified then CR (0x0D) and
::  SUB (0x1A) may appear in the output. If the result contains CR (0x0D)
::  then RtnVar should only be accessed via delayed expansion.
::
::  Note: The /X option requires writing and reading a small temporary file.
::
::  If an invalid hexadecimal digit is detected within the Hex string then the
::  corresponding result character is set to a space and errorlevel is set
::  to 2.
::
::  Aborts with an error message to stderr and errorlevel 3 if the Hex string
::  length is not divisible by 2.
:::
::: Dependencies - :asciiMap, :strLen, :Unique
:::
  setlocal disableDelayedExpansion
  if /i "%~1"=="/X" (
    set option=%1
    shift /1
  ) else set option=
  call :asciiMap %option% map
  call :strLen %1 len
  set /a mod=len%%2
  if %mod%==1 1>&2 echo "ERROR: Hex string length not a multiple of 2" & exit /b 3
  set rtn=
  set /a len-=1
  setlocal enableDelayedExpansion
  set err=0
  for /l %%n in (0,2,%len%) do (
    2>nul set /a d=0x!%~1:~%%n,2! || (set d=32&set err=2)
    for %%d in (!d!) do set c=^!map:~%%d,1!
    if "!c!"==" " if not !d!==32 if !err!==0 set err=1
    set "rtn=!rtn!!c!"
  )
  if defined option if "!rtn:~-1!"=="!map:~13,1!" set "rtn=!rtn!!map:~13,1!"
  for /f "delims=" %%s in ("!rtn!") do (
    endlocal
    endlocal
    if "%~2" neq "" set %~2=%%s
    exit /b %err%
  )
exit /b


:asc        [/X] StrVar IntVal [RtnVar]
::
::  Computes the ASCII code for a specified character within the string
::  contained by variable StrVar. The position within the string is specified
::  by the IntVal argument. A non-negative value is relative to the beginning
::  of the string, with 0 specifiying the first character. A negative value is
::  relative to the end of the string, with -1 specifying the last character.
::
::  Sets RtnVar=result
::  or displays result if RtnVar not specified
::
::  IntVal may be passed as a variable without enclosing the name in percent
::  symbols.
::
::  If one of the following problematic characters is specified then RtnVar
::  will be undefined and errorlevel will be set to 1.
::
::     C H A R A C T E R                      S U P P O R T E D ?
::    Dec   Hex   Oct  Char                    Normal  /X Option
::    ---  ----  ----  ----                    ------  ---------
::      0  0x00    00  NUL  (null)               No      No
::     10  0x0A   012  LF   (line feed)          No      No
::     13  0x0D   015  CR   (carriage return)    No      Yes
::     26  0x1A   032  SUB  (substitute)         No      Yes
::
::  If the case insensitive /X option is specified then CR (0x0D) and
::  SUB (0x1A) may successfully be specified as input.
::
::  Note: The /X option requires writing and reading a small temporary file.
::
::  If StrVar is not defined then aborts with an error message to stderr and
::  errorlevel 2.
::
::  If IntVal is greater than or equal to the length of the string then aborts
::  with an error message to stderr and errorlevel 3.
::
::  Negative IntVal values will never result in errorlevel 2: Positions earlier
::  than the 1st character are treated as the 1st character.
:::
::: Dependencies - :asciiMap, :Unique
:::
  setlocal disableDelayedExpansion
  if /i "%~1"=="/X" (
    set option=%1
    shift /1
  ) else set option=
  set /a n=%~2 2>nul
  if errorlevel 1 1>&2 echo "ERROR: Invalid numeric value"&exit /b 11
  if not defined %~1 1>&2 echo "ERROR: Variable not defined"&exit /b 2
  call :asciiMap %option% ascii
  setlocal enableDelayedExpansion
  set "chr=!%~1:~%n%,1!"
  if not defined chr 1>&2 echo "ERROR: String position not found"&exit /b 3
  if "!chr!"==" " (set /a rtn=32) else (
    if defined rtn set rtn=
    for /l %%n in (0,1,255) do if "!ascii:~%%n,1!"=="!chr!" set rtn=%%n
  )
  if defined rtn (set err=0) else set err=1
  (endlocal & rem -- return values
    endlocal
    if "%~3" neq "" (set %~3=%rtn%) else (echo:%rtn%)
    exit /b %err%
  )
exit /b


:chr        [/X] IntVal [RtnVar]
::
::  Converts ASCII code IntVal into the corresponding character.
::
::  Sets RtnVar=result
::  or displays result if RtnVar not specified
::
::  IntVal must be a value between 0 and 255.
::
::  Aborts with an error message to stderr and errorlevel 11 if IntVal is not
::  a valid ASCII code.
::
::  Aborts with an error message to stderr and errorlevel 1 if IntVal
::  corresponds to one of the following problematic characters:
::
::     C H A R A C T E R                      S U P P O R T E D ?
::    Dec   Hex   Oct  Char                    Normal  /X Option
::    ---  ----  ----  ----                    ------  ---------
::      0  0x00    00  NUL  (null)               No      No
::     10  0x0A   012  LF   (line feed)          No      No
::     13  0x0D   015  CR   (carriage return)    No      Yes
::     26  0x1A   032  SUB  (substitute)         No      Yes
::
::  If the case insensitive /X option is specified then CR (0x0D) and
::  SUB (0x1A) are supported. If the result is CR (0x0D) then RtnVar should
::  only be accessed via delayed expansion.
::
::  Note: The /X option requires writing and reading a small temporary file.
::
::  IntVal may be passed as a variable without enclosing the name in percent
::  symbols.
:::
::: Dependencies - :asciiMap, :Unique
:::
  setlocal disableDelayedExpansion
  if /i "%~1"=="/X" (
    set option=%1
    shift /1
  ) else set option=
  set /a n=%~1 2>nul
  if errorlevel 1 1>&2 echo "ERROR: Invalid ASCII Code"&exit /b 11
  if %n%==32 set "c= "&setlocal enableDelayedExpansion&goto :chr.end
  if %n% lss 0 1>&2 echo "ERROR: Invalid ASCII Code"&exit /b 11
  if %n% gtr 255 1>&2 echo "ERROR: Invalid ASCII Code"&exit /b 11
  call :asciiMap %option% ascii
  setlocal EnableDelayedExpansion
  set "c=!ascii:~%n%,1!"
  if "!c!"==" " (
    1>&2 echo "ERROR: Problematic ASCII Code"&exit /b 1
  )
  if %n%==13 set "c=!c!!c!"
  :chr.end
  for /f "delims=" %%c in ("!c!") do (
    endlocal
    endlocal
    if "%~2" neq "" (set %~2=%%c) else (echo:%%c)
  )
exit /b


:asciiMap   [/X] rtnVar
::
::  Sets variable rtnVar to a 256 character string containing the complete
::  extended ASCII character set except a space has been substituted for each
::  of the following problematic characters:
::
::     C H A R A C T E R                      S U P P O R T E D ?
::    Dec   Hex   Oct  Char                    Normal  /X Option
::    ---  ----  ----  ----                    ------  ---------
::      0  0x00    00  NUL  (null)               No      No
::     10  0x0A   012  LF   (line feed)          No      No
::     13  0x0D   015  CR   (carriage return)    No      Yes
::     26  0x1A   032  SUB  (substitute)         No      Yes
::
::  If the case insensitive /X option is specified then CR (0x0D) and
::  SUB (0x1A) characters are included in the map. However, a map with
::  these characters can only be accessed via delayed expansion.
::
::  Note: The /X option requires writing and reading a small temporary file.
:::
::: Dependencies - :Unique
:::
  setlocal disableDelayedExpansion
  if /i "%~1"=="/X" shift /1 & goto :asciiMap.extend
  (endlocal
    call :asciiMap.setMap %~1
    exit /b
  )
  :asciiMap.extend
  call :Unique file
  if defined temp (set filePath=%temp%) else if defined tmp (set filePath=%tmp%) else set filePath=.
  set file="%filePath%\_asciiMap_%file%_%random%.tmp"
  for /f %%a in ('copy /Z "%~dpf0" nul') do set "cr=%%a"
  copy /a nul+nul %file% > nul
  for /f "usebackq" %%a in (%file%) do set "sub=%%a"
  del %file%
  call :asciiMap.setMap map
  setlocal enableDelayedExpansion
  set "map=!map:~0,13!!cr!!map:~14,12!!sub!!map:~27!"
  for /f "delims=" %%a in ("!map!") do (
    endlocal
    endlocal
    set %~1=%%a
    exit /b
  )
  :asciiMap.setMap
:: WARNING - THE 10th character after the = should be a single TAB character. I believe the web site is converting the TAB into 4 spaces
  set %~1= 	   !^"#$%%^&'^(^)*+,-./0123456789:;^<=^>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^^_`abcdefghijklmnopqrstuvwxyz{^|}~€‚ƒ„…†‡ˆ‰Š‹Œ‘’“”•–—˜™š›œŸ ¡¢£¤¥¦§¨©ª«¬­®¯°±²³´µ¶·¸¹º»¼½¾¿ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏĞÑÒÓÔÕÖ×ØÙÚÛÜİŞßàáâãäåæçèéêëìíîïğñòóôõö÷øùúûüışÿ
exit /b


::-----------------------------------------------------------------------------
:: The following are existing dostips functions
::-----------------------------------------------------------------------------

:strLen string len -- returns the length of a string
::                 -- string [in]  - variable name containing the string being measured for length
::                 -- len    [out] - variable to be used to return the string length
:: Many thanks to 'sowgtsoi', but also 'jeb' and 'amel27' dostips forum users helped making this short and efficient
:$created 20081122 :$changed 20101116 :$categories StringOperation
:$source http://www.dostips.com
(   SETLOCAL ENABLEDELAYEDEXPANSION
    set "str=A!%~1!"&rem keep the A up front to ensure we get the length and not the upper bound
                     rem it also avoids trouble in case of empty string
    set "len=0"
    for /L %%A in (12,-1,0) do (
        set /a "len|=1<<%%A"
        for %%B in (!len!) do if "!str:~%%B,1!"=="" set /a "len&=~1<<%%A"
    )
)
( ENDLOCAL & REM RETURN VALUES
    IF "%~2" NEQ "" SET /a %~2=%len%
)
EXIT /b

:Unique ret -- returns a unique string based on a date-time-stamp, YYYYMMDDhhmmsscc
::          -- ret    [out,opt] - unique string
:$created 20060101 :$changed 20080219 :$categories StringOperation,DateAndTime
:$source http://www.dostips.com
SETLOCAL
for /f "skip=1 tokens=2-4 delims=(-)" %%a in ('"echo.|date"') do (
    for /f "tokens=1-3 delims=/.- " %%A in ("%date:* =%") do (
        set %%a=%%A&set %%b=%%B&set %%c=%%C))
set /a "yy=10000%yy% %%10000,mm=100%mm% %% 100,dd=100%dd% %% 100"
for /f "tokens=1-4 delims=:. " %%A in ("%time: =0%") do @set UNIQUE=%yy%%mm%%dd%%%A%%B%%C%%D
ENDLOCAL & IF "%~1" NEQ "" (SET %~1=%UNIQUE%) ELSE echo.%UNIQUE%
EXIT /b