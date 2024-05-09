rem Description:
rem   Script for string lines extraction from a text/binary file by findstr
rem   utility pattern and/or line number.

rem Command arguments:
rem %1 - Optional flags:
rem      -n - prints line number prefix "<N>:" for each found string from file.
rem           By default, the line number prefix does not print.
rem      -f1 - filter by line numbers for strings after %4..%N filter pattern.
rem           By default, filters by line numbers from the file.
rem      -pe - treats input file as a Portable Executable file
rem           (the strings.exe must exist).
rem           By default, the file treated as a text file.
rem %1 - Path to a directory with a file to extract.
rem %2 - Relative path to a text/binary file with strings.
rem %3 - Set of line numbers separated by : character to print strings of.
rem      These line numbers by default are line numbers of strings from the
rem      file, not from filtered output. If you want to point line numbers
rem      after %4..%N filter pattern, then you must use -f1 flag.
rem      If empty, then treated as "all strings".
rem %4..%N - Arguments for findstr command line in first filter.
rem      If empty, then treated as /R /C:".*", which means "any string".

rem CAUTION:
rem   DO NOT use /N flag in %4..%N arguments, instead use script -n flag to
rem   print strings w/ line number prefix.

rem Examples:
rem 1. call print_file_string.bat -n . example.txt 1:20:10:30 /R /C:".*"
rem Prints 1, 10, 20, 30 lines of the example.txt file sorted by line number
rem and prints them w/ line number prefix:
rem
rem 2. call print_file_string.bat . example.txt 100 /R /C:".*"
rem Prints 100'th string of example.txt file and prints it w/o line number
rem prefix.
rem
rem 3. call print_file_string.bat -pe c:\Application res.dll "" /B /C:"VERSION="
rem Prints all strings from the c:\Application\res.dll binary file, where
rem strings beginning by the "VERSION=" string and prints them w/o line number
rem prefix.
rem
rem 4. call print_file_string.bat -pe c:\Application res.dll 1:20:10:30 /R /C:".*"
rem Prints 1, 10, 20, 30 lines of string resources from the
rem c:\Application\res.dll binary file, where strings beginning by the
rem "VERSION=" string and prints them w/o line number prefix.

setlocal EnableDelayedExpansion

set "?~dp0=%~dp0"
set "?~nx0=%~nx0"

rem script flags
set FLAG_PRINT_LINE_NUMBER_PREFIX=0
set FLAG_F1_LINE_NUMBER_FILTER=0
set FLAG_FILE_FORMAT_PE=0

rem flags
set "FLAGS="

:FLAGS_LOOP

rem flags always at first
set "FLAG=%~1"

if not "%FLAG%" == "" ^
if not "%FLAG:~0,1%" == "-" set "FLAG="

if not "%FLAG%" == "" (
  if "%FLAG%" == "-n" set FLAG_PRINT_LINE_NUMBER_PREFIX=1
  if "%FLAG%" == "-f1" set FLAG_F1_LINE_NUMBER_FILTER=1
  if "%FLAG%" == "-pe" set FLAG_FILE_FORMAT_PE=1
  shift

  rem read until no flags
  goto FLAGS_LOOP
)

set "DIR_PATH=%~dpf1"
set "FILE_PATH=%~2"

set "FILE_PATH_PREFIX="
if not "%DIR_PATH%" == "" set "FILE_PATH_PREFIX=%DIR_PATH%\"

if not "%FILE_PATH_PREFIX%" == "" ^
if not exist "%FILE_PATH_PREFIX%" (
  echo.%?~nx0%: error: Directory path does not exist: "%FILE_PATH_PREFIX%"
  exit /b 1
) >&2

if "%FILE_PATH%" == "" (
  echo.%?~nx0%: error: File path does not set.
  exit /b 2
) >&2

if not exist "%FILE_PATH_PREFIX%%FILE_PATH%" (
  echo.%?~nx0%: error: File path does not exist: "%FILE_PATH_PREFIX%%FILE_PATH%"
  exit /b 3
) >&2

set "LINE_NUMBERS=%~3"

set "FINDSTR_LINES_FILTER_CMD_LINE="
if "%LINE_NUMBERS%" == "" goto FINDSTR_LINES_FILTER_END

set LINE_NUMBER_INDEX=1
:FINDSTR_LINES_FILTER_LOOP
set "LINE_NUMBER="
for /F "tokens=%LINE_NUMBER_INDEX% delims=:" %%i in ("%LINE_NUMBERS%") do set "LINE_NUMBER=%%i"
if "%LINE_NUMBER%" == "" goto FINDSTR_LINES_FILTER_END

set FINDSTR_LINES_FILTER_CMD_LINE=!FINDSTR_LINES_FILTER_CMD_LINE! /C:"!LINE_NUMBER!:"
set /A LINE_NUMBER_INDEX+=1
goto FINDSTR_LINES_FILTER_LOOP

:FINDSTR_LINES_FILTER_END

shift
shift
shift

set "FINDSTR_FIRST_FILTER_CMD_LINE="

:FINDSTR_FIRST_FILTER_LOOP
set ARG=%1

if not "!ARG!" == "" (
  set FINDSTR_FIRST_FILTER_CMD_LINE=!FINDSTR_FIRST_FILTER_CMD_LINE! !ARG!
  shift
  goto FINDSTR_FIRST_FILTER_LOOP
)

if "!FINDSTR_FIRST_FILTER_CMD_LINE!" == "" set FINDSTR_FIRST_FILTER_CMD_LINE=/R /C:".*"

set OUTPUT_HAS_NUMBER_PREFIX=0

rem in case if /N at the end
set "FINDSTR_FIRST_FILTER_CMD_LINE=!FINDSTR_FIRST_FILTER_CMD_LINE! "

rem 1. add /N parameter to first filter if must print line prefixes and -f1 flag is not set.
rem 2. flags prefixed output if must print line prefixes.
if %FLAG_PRINT_LINE_NUMBER_PREFIX% neq 0 (
  if %FLAG_F1_LINE_NUMBER_FILTER% equ 0 (
    if "!FINDSTR_FIRST_FILTER_CMD_LINE:/N =!" == "!FINDSTR_FIRST_FILTER_CMD_LINE!" (
      set "FINDSTR_FIRST_FILTER_CMD_LINE=/N !FINDSTR_FIRST_FILTER_CMD_LINE!"
    )
  )
  set OUTPUT_HAS_NUMBER_PREFIX=1
)

rem 1. add /N parameter to first filter and flags prefixed output if lines filter is not empty and -f1 flag is not set.
rem 2. add /B parameter to lines filter if lines filter is not empty
if not "!FINDSTR_LINES_FILTER_CMD_LINE!" == "" (
  if %FLAG_F1_LINE_NUMBER_FILTER% equ 0 (
    if "!FINDSTR_FIRST_FILTER_CMD_LINE:/N =!" == "!FINDSTR_FIRST_FILTER_CMD_LINE!" (
      set "FINDSTR_FIRST_FILTER_CMD_LINE=/N !FINDSTR_FIRST_FILTER_CMD_LINE!"
      set OUTPUT_HAS_NUMBER_PREFIX=1
    )
  )
  if "!FINDSTR_LINES_FILTER_CMD_LINE:/B =!" == "!FINDSTR_LINES_FILTER_CMD_LINE!" (
    set "FINDSTR_LINES_FILTER_CMD_LINE=/B !FINDSTR_LINES_FILTER_CMD_LINE!"
  )
)

rem 1. remove /N parameter from first filter if -f1 flag is set.
rem 2. flags prefixed output if -f1 flag is set.
if %FLAG_F1_LINE_NUMBER_FILTER% neq 0 (
  if not "!FINDSTR_FIRST_FILTER_CMD_LINE:/N =!" == "!FINDSTR_FIRST_FILTER_CMD_LINE!" (
    set "FINDSTR_FIRST_FILTER_CMD_LINE=!FINDSTR_FIRST_FILTER_CMD_LINE:/N =!"
  )
  set OUTPUT_HAS_NUMBER_PREFIX=1
)

if "%TOOLS_PATH%" == "" set "TOOLS_PATH=%?~dp0%"
rem set "TOOLS_PATH=%TOOLS_PATH:\=/%"
if "%TOOLS_PATH:~-1%" == "\" set "TOOLS_PATH=%TOOLS_PATH:~0,-1%"

if %FLAG_FILE_FORMAT_PE% equ 0 (
  set CMD_LINE=type "%FILE_PATH_PREFIX%%FILE_PATH%" ^| findstr !FINDSTR_FIRST_FILTER_CMD_LINE!
) else (
  rem add EULA acception into registry to avoid EULA acception GUI dialog
  reg add HKCU\Software\Sysinternals\Strings /v EulaAccepted /t REG_DWORD /d 0x00000001 /f >nul 2>nul

  rem @ for bug case workaround
  set CMD_LINE=@"%TOOLS_PATH%\strings.exe" -q "%FILE_PATH_PREFIX%%FILE_PATH%" ^| findstr !FINDSTR_FIRST_FILTER_CMD_LINE!
)

if %FLAG_F1_LINE_NUMBER_FILTER% neq 0 set CMD_LINE=!CMD_LINE! ^| findstr /N /R /C:".*"
if not "!FINDSTR_LINES_FILTER_CMD_LINE!" == "" set CMD_LINE=!CMD_LINE! ^| findstr !FINDSTR_LINES_FILTER_CMD_LINE!

rem echo !CMD_LINE! >&2
(
  endlocal
  rem to avoid ! character truncation
  setlocal DisableDelayedExpansion
  if %OUTPUT_HAS_NUMBER_PREFIX% neq 0 (
    if %FLAG_PRINT_LINE_NUMBER_PREFIX% neq 0 (
      %CMD_LINE% 2>nul
    ) else ( 
      for /F "usebackq eol= tokens=1,* delims=:" %%i in (`^(%CMD_LINE: | findstr = ^| findstr %^) 2^>nul`) do echo.%%j
    )
  ) else (
    %CMD_LINE% 2>nul
  )
)

exit /b 0