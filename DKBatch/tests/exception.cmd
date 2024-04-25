::EXCEPTION.BAT Version 1.4
::
:: Provides exception handling for Windows batch scripts.
::
:: Designed and written by Dave Benham, with important contributions from
:: DosTips users jeb and siberia-man
::
:: Full documentation is at the bottom of this script
::
:: History:
::   v1.4 2016-08-16  Improved detection of command line delayed expansion
::                    using an original idea by jeb
::   v1.3 2015-12-12  Added paged help option via MORE
::   v1.2 2015-07-16  Use COMSPEC instead of OS to detect delayed expansion
::   v1.1 2015-07-03  Preserve ! in exception attributes when delayed expansion enabled
::   v1.0 2015-06-26  Initial versioned release with embedded documentation
::
@echo off
if "%~1" equ "/??" goto pagedHelp
if "%~1" equ "/?" goto help
if "%~1" equ "" goto help
shift /1 & goto %1


:throw  errCode  errMsg  errLoc
set "exception.Stack="
:: Fall through to :rethrow


:rethrow  errCode  errMsg  errLoc
setlocal disableDelayedExpansion
if not defined exception.Restart set "exception.Stack=[%~1:%~2] %exception.Stack%"
for /f "delims=" %%1 in ("%~1") do for /f "delims=" %%2 in ("%~2") do for /f "delims=" %%3 in ("%~3") do (
  setlocal enableDelayedExpansion
  for /l %%# in (1 1 10) do for /f "delims=" %%S in (" !exception.Stack!") do (
    (goto) 2>NUL
    setlocal enableDelayedExpansion
    if "!!" equ "" (
      endlocal
      setlocal disableDelayedExpansion
      call set "funcName=%%~0"
      call set "batName=%%~f0"
      if defined exception.Restart (set "exception.Restart=") else call set "exception.Stack=%%funcName%%%%S"
      setlocal EnableDelayedExpansion
      if !exception.Try! == !batName!:!funcName! (
        endlocal
        endlocal
        set "exception.Code=%%1"
        if "!!" equ "" (
          call "%~f0" setDelayed
        ) else (
          set "exception.Msg=%%2"
          set "exception.Loc=%%3"
          set "exception.Stack=%%S"
        )
        set "exception.Try="
        (CALL )
        goto :@Catch
      )
    ) else (
      for %%V in (Code Msg Loc Stack Try Restart) do set "exception.%%V="
      if "^!^" equ "^!" (
        call "%~f0" showDelayed
      ) else (
        echo(
        echo Unhandled batch exception:
        echo   Code = %%1
        echo   Msg  = %%2
        echo   Loc  = %%3
        echo   Stack=%%S
      )
      echo on
      call "%~f0" Kill
    )>&2
  )
  set exception.Restart=1
  setlocal disableDelayedExpansion
  call "%~f0" rethrow %1 %2 %3
)
:: Never reaches here


:init
set "@Try=call set exception.Try=%%~f0:%%~0"
set "@EndTry=set "exception.Try=" & goto :@endCatch"
:: Fall through to :clear


:clear
for %%V in (Code Msg Loc Stack Restart Try) do set "exception.%%V="
exit /b


:Kill - Cease all processing, ignoring any remaining cached commands
setlocal disableDelayedExpansion
if not exist "%temp%\Kill.Yes" call :buildYes
call :CtrlC <"%temp%\Kill.Yes" 1>nul 2>&1
:CtrlC
@cmd /c exit -1073741510

:buildYes - Establish a Yes file for the language used by the OS
pushd "%temp%"
set "yes="
copy nul Kill.Yes >nul
for /f "delims=(/ tokens=2" %%Y in (
  '"copy /-y nul Kill.Yes <nul"'
) do if not defined yes set "yes=%%Y"
echo %yes%>Kill.Yes
popd
exit /b


:setDelayed
setLocal disableDelayedExpansion
for %%. in (.) do (
  set "v2=%%2"
  set "v3=%%3"
  set "vS=%%S"
)
(
  endlocal
  set "exception.Msg=%v2:!=^!%"
  set "exception.Loc=%v3:!=^!%"
  set "exception.Stack=%vS:!=^!%"
)
exit /b


:showDelayed -
setLocal disableDelayedExpansion
for %%. in (.) do (
  set "v2=%%2"
  set "v3=%%3"
  set "vS=%%S"
)
for /f "delims=" %%2 in ("%v2:!=^!%") do for /f "delims=" %%3 in ("%v3:!=^!%") do for /f "delims=" %%S in ("%vS:!=^!%") do (
  endlocal
  echo(
  echo Unhandled batch exception:
  echo   Code = %%1
  echo   Msg  = %%2
  echo   Loc  = %%3
  echo   Stack=%%S
)
exit /b


:-?
:help
setlocal disableDelayedExpansion
for /f "delims=:" %%N in ('findstr /rbn ":::DOCUMENTATION:::" "%~f0"') do set "skip=%%N"
for /f "skip=%skip% tokens=1* delims=:" %%A in ('findstr /n "^" "%~f0"') do echo(%%B
exit /b


:-??
:pagedHelp
setlocal disableDelayedExpansion
for /f "delims=:" %%N in ('findstr /rbn ":::DOCUMENTATION:::" "%~f0"') do set "skip=%%N"
((for /f "skip=%skip% tokens=1* delims=:" %%A in ('findstr /n "^" "%~f0"') do @echo(%%B)|more /e) 2>nul
exit /b


:-v
:/v
:version
echo(
for /f "delims=:" %%A in ('findstr "^::EXCEPTION.BAT" "%~f0"') do echo %%A
exit /b


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::DOCUMENTATION:::

EXCEPTION.BAT is a pure batch script utility that provides robust exception
handling within batch scripts. It enables code to be placed in TRY/CATCH blocks.
If no exception is thrown, then only code within the TRY block is executed.
If an exception is thrown, the batch CALL stack is popped repeatedly until it
reaches an active TRY block, at which point control is passed to the associated
CATCH block and normal processing resumes from that point. Code within a CATCH
block is ignored unless an exception is thrown.

An exception may be caught in a different script from where it was thrown.

If no active TRY is found after throwing an exception, then an unhandled
exception message is printed to stderr, all processing is terminated within the
current CMD shell, and control is returned to the shell command line.

TRY blocks are specified using macros. Obviously the macros must be defined
before they can be used. The TRY macros are defined using the following CALL

    call exception init

Besides defining @Try and @EndTry, the init routine also explicitly clears any
residual exception that may have been left by prior processing.

A TRY/CATCH block is structured as follows:

    %@Try%
      REM any normal code goes here
    %@EndTry%
    :@Catch
      REM exception handling code goes here
    :@EndCatch

- Every TRY must have an associated CATCH.

- TRY/CATCH blocks cannot be nested.

- Any script or :labeled routine that uses TRY/CATCH must have at least one
  SETLOCAL prior to the appearance of the first TRY.

- TRY/CATCH blocks use labels, so they should not be placed within parentheses.
  It can be done, but the parentheses block is broken when control is passed to
  the :@Catch or :@EndCatch label, and the code becomes difficult to interpret
  and maintain.

- Any valid code can be used within a TRY or CATCH block, including CALL, GOTO,
  :labels, and balanced parentheses. However, GOTO cannot be used to leave a
  TRY block. GOTO can only be used within a TRY block if the label appears
  within the same TRY block.

- GOTO must never transfer control from outside TRY/CATCH to within a TRY or
  CATCH block.

- CALL should not be used to call a label within a TRY or CATCH block.

- CALLed routines containing TRY/CATCH must have labels that are unique within
  the script. This is generally good batch programming practice anyway.
  It is OK for different scripts to share :label names.

- If a script or routine recursively CALLs itself and contains TRY/CATCH, then
  it must not throw an exception until after execution of the first %@Try%

Exceptions are thrown by using

    call exception throw  Code  Message  Location

where

    Code = The numeric code value for the exception.

    Message = A description of the exception.

    Location = A string that helps identify where the exception occurred.
               Any value may be used. A good generic value is "%~f0[%~0]",
               which expands to the full path of the currently executing
               script, followed by the currently executing routine name
               within square brackets.

The Message and Location values must be quoted if they contain spaces or poison
characters like & | < >. The values must not contain additional internal quotes,
and they must not contain a caret ^.

The following variables will be defined for use by the CATCH block:

  exception.Code  = the Code value
  exception.Msg   = the Message value
  exception.Loc   = the Location value
  exception.Stack = traces the call stack from the CATCH block (or command line
                    if not caught), all the way to the exception.

If the exception is not caught, then all four values are printed as part of the
"unhandled exception" message, and the exception variables are not defined.

A CATCH block should always do ONE of the following at the end:

- If the exception has been handled and processing can continue, then clear the
  exception definition by using

    call exception clear

  Clear should never be used within a Try block.

- If the exception has not been fully handled, then a new exception should be
  thrown which can be caught by a higher level CATCH. You can throw a new
  exception using the normal THROW, which will clear exception.Stack and any
  higher CATCH will have no awareness of the original exception.

  Alternatively, you may rethrow an exception and preserve the exeption stack
  all the way to the original exception:

    call exception rethrow  Code  Message  Location

  It is your choice as to whether you want to pass the original Code and/or
  Message and/or Location. Either way, the stack will preserve all exceptions
  if rethrow is used.

  Rethrow should only be used within a CATCH block.


One last restriction - the full path to EXCEPTION.BAT must not include ! or ^.


This documentation can be accessed via the following commands

    constant stream:   exception /?   OR  exception help
    paged via MORE:    exception /??  OR  exception pagedHelp

The version of this utility can be accessed via

    exception /v  OR  exception version


EXCEPTION.BAT was designed and written by Dave Benham, with important
contributions from DosTips users jeb and siberia-man.

Development history can be traced at:
  http://www.dostips.com/forum/viewtopic.php?f=3&t=6497