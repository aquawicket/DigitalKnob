:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: SNAKE.BAT - A pure native Windows batch implementation of the classic game
:: ------------------------------------------------------------------------------
:: Written by Dave Benham with some debugging help and technique pointers from
:: DosTips users - See http://www.dostips.com/forum/viewtopic.php?f=3&t=4741
::
:: The game should work on any Windows machine from XP onward using only batch
:: and native external commands. However, the default configuration will most
:: likely have some screen flicker due to the CLS command issued upon every 
:: screen refresh. There are two ways to eliminate screen flicker:
::
:: 1 - "Pure batch" via VT100 escape sequences:
:: You can eliminate flicker by enabling the VT100 mode within the game's
:: Graphic options menu. However, this mode requires a console that supports
:: VT100 escape sequences. This comes standard with Windows 10 (and beyond).
:: The Windows 10 console must be configured properly for this to work - the
:: "Legacy Console" option must be OFF. Prior to Windows 10, there was no
:: standard Windows console that supported VT100 escape sequences, though you
:: may find a utility that provides that support.
::
:: 2 - CursorPos.exe cheat from Aacini:
:: You can eliminate screen flicker on any Windows version by placing Aacini's
:: CursorPos.exe in the same folder that contains SNAKE.BAT. This method of
:: eliminating flicker is "cheating" in that it is not pure native batch since
:: it relies on a 3rd party tool. A script to create CursorPos.exe is available
:: at http://goo.gl/hr6Kkn.
::
:: Note that user preferences and high scores are stored in %USERPROFILE%\Snake
:: User saved games have an implicit .snake.txt "extension", and are saved and
:: loaded from the current directory.
::
:: Version History
::
:: 4.1  2018-09-08
::   - Fixed bug in Playfield too large error handling that aborted but hung.
::
:: 4.0  2017-04-10
::   - New Field size options, ranging from tiny to large. Original = Medium.
::   - Reconfigured menu
::   - Added support for VT100 mode to eliminate screen flicker by using
::     with "pure" batch VT100 escape sequences.
::
:: 3.8  2015-02-16
::   - Improve performance of Replay abort
::   - Eliminate flicker at game start when using CursorPos.exe
::   - Use symbols (variables) for lock, key and cmd streams.
::
:: 3.7  2014-08-03
::   - Reduced screen flicker when playing without CursorPos.exe by building
::     entire screen in one variable before CLS and ECHOing the screen.
::
:: 3.6  2014-04-09
::   - Pause after displaying CursorPos.exe message at end if game was launced
::     via double click or START menu.
::
:: 3.5  2014-02-03
::   - Made growth rate user configurable. High scores are now stored for each
::     growth rate played.
::   - Added optional support for Aacini's CursorPos.exe to eliminate screen
::     flicker.
::   - Redesigned storage of configuration options within saved games to make
::     it easier to extend in the future. Existing saved games are automatically
::     converted to the new format.
::   - Simplified replay abort mechanics.
::
:: 3.4  2013-12-26
::   - Added ability to abort a game replay.
::
:: 3.3  2013-12-24
::   - Added Pause functionality.
::
:: 3.2  2013-12-08
::   - Fixed a replay bug. Note that attempting to delete a non-existent file
::     does not raise an error!
::   - Added ability to save a previous game or a High score game to a user
::     named file in the current directory.
::   - Added ability to load and replay a user saved game from the current
::     directory.
::
:: 3.1  2013-12-08
::   - Fixed a bug with the game logs. Must include key mappings in log.
::     High scores from version 3.0 should be deleted from %USERPROFILE%\Snake.
::
:: 3.0  2013-12-07
::   - Made control keys user configurable, including option for 2 key
::     (left/right) or 4 key (left/right/up/down) input.
::   - Made graphics user configurable.
::   - Added ability to display replay of previous game.
::   - Added High Score list, with ability to display replay of High Score games.
::
:: 2.3  2013-12-01
::   - Added elapsed game time to the display.
::
:: 2.2  2013-08-06
::   - Improved comments / internal documentation
::   - A few inconsequential code changes
::
:: 2.1  2013-07-20
::   - Reworked interprocess communication. No more hanging games (I hope).
::   - Fixed parameterization of movement key definition.
::   - Temp file location now controlled by TEMP (or TMP) environment variable.
::   - Implemented a game session lock into temp file names so multiple game
::     instances can share the same TEMP folder without interference.
::
:: 2.0  2013-07-17
::   - First attempt at using XCOPY instead of CHOICE. Game now runs as
::     pure native batch on all Windows versions from XP onward.
::
:: 1.0  2013-07-13  to  1.x
::   - Game required CHOICE command, so did not work on XP without download of
::     a non-standard exe or com file.
::
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

@echo off
if "%~1" == "startGame" goto :game
if "%~1" == "startController" goto :controller


::---------------------------------------------------------------------
:: setup some global variables used by both the game and the controller

setlocal disableDelayedExpansion
set "toggleVT100="
:getSession
if defined temp (set "tempFileBase=%temp%\") else if defined tmp set "tempFileBase=%tmp%\"
set "tempFileBase=%tempFileBase%Snake%time::=_%"
set "keyFile=%tempFileBase%_key.txt"
set "cmdFile=%tempFileBase%_cmd.txt"
set "gameLock=%tempFileBase%_gameLock.txt"
set "gameLog=%tempFileBase%_gameLog.txt"
set "signal=%tempFileBase%_signal.txt"
set "saveLoc=%userprofile%\Snake"
set "userPref=%saveLoc%\SnakeUserPref.txt"
set "hiFile=%saveLoc%\Snake!size!!growth!Hi"
set "keyStream=9"
set "cmdStream=8"
set "lockStream=7"


::------------------------------------------
:: Lock this game session and launch.
:: Loop back and try a new session if failure.
:: Cleanup and exit when finished

call :launch %lockStream%>"%gameLock%" || goto :getSession
del "%tempFileBase%*"
exit /b


::------------------------------------------
:launch the game and the controller

call :fixLogs
:relaunch
copy nul "%keyFile%" >nul
copy nul "%cmdFile%" >nul
start "" /b cmd /c ^""%~f0" startController %keyStream%^>^>"%keyFile%" %cmdStream%^<"%cmdFile%" 2^>nul ^>nul^"
cmd /c ^""%~f0" startGame %keyStream%^<"%keyFile%" %cmdStream%^>^>"%cmdFile%" ^<nul^"
echo(


::--------------------------------------------------------------
:: Upon exit, wait for the controller to close before returning

:close
2>nul (>>"%keyFile%" call )||goto :close
if "%=exitcode%" equ "00000002" (
  set "toggleVT100=1"
  goto :relaunch
) else if "%=exitcode%" equ "00000001" (
  echo Game play can be improved by installing
  echo Aacini's CursorPos.exe, available at
  echo http://goo.gl/hr6Kkn
  echo(
  echo Alternatively, if your console supports
  echo VT100 escape sequences, then you can
  echo enable VT100 mode within the SNAKE.BAT
  echo Graphic options menu.
  echo(
  echo %cmdcmdline%|find /i "%~f0">nul&&pause
)
exit /b 0


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:game
title %~nx0
cls

::---------------------------------------
:: Default playfield size
:: max playing field: (width-2)*(height-2) <= 1365

set "size=Medium"
set "dispWidth=40"   max=99
set "dispHeight=25"  max=99
set "defaultSize=%size%"
set /a "defaultWidth=dispWidth, defaultHeight=dispHeight"

::----------------------------
:: Other default values

set "moveKeys=4"

set "up=W"
set "down=S"
set "left=A"
set "right=D"
set "pause=P"

set "space= "
set "bound=#"
set "food=+"
set "head=@"
set "body=O"
set "death=X"

set "vt0=OFF"
set "vt1=ON"
set "vt=0"

set "growth=1"

::--- sendCmd macro ---
:: sendCmd  command
:::  sends a command to the controller
set "sendCmd=>&%cmdStream% echo"

::---------------------------
:: Load user preferences
if exist "%userPref%" for /f "usebackq delims=" %%V in ("%userPref%") do set "%%V"
call :resize

::---------------------------
:: Variable constants

set "configOptions=diffCode difficulty growth moveKeys up down left right size dispWidth dispHeight"

for %%S in (
 "T Tiny   15 10"
 "S Small  25 15"
 "M Medium 40 25"
 "L Large  47 32"
 "W Wide   82 19"
 "N Narrow 20 40"
) do for /f "tokens=1-4" %%A in (%%S) do (
  set "size%%A=%%B"
  set /a "width%%A=%%C, height%%A=%%D"
)

set "spinner1=-"
set "spinner2=\"
set "spinner3=|"
set "spinner4=/"
set "spinner= spinner1 spinner2 spinner3 spinner4 "

set "delay1=20"
set "delay2=15"
set "delay3=10"
set "delay4=7"
set "delay5=5"
set "delay6=3"

set "desc1=Sluggard"
set "desc2=Crawl"
set "desc3=Slow"
set "desc4=Normal"
set "desc5=Fast"
set "desc6=Insane"

set "spinnerDelay=3"

:: define LF as a Line Feed (newline) character
set ^"LF=^

^" Above empty line is required - do not remove

:: define CR as a Carriage Return character
for /f %%A in ('copy /Z "%~dpf0" nul') do set "CR=%%A"

:: define BS as a BackSpace character
for /f %%A in ('"prompt $H&for %%B in (1) do rem"') do set "BS=%%A"

set "upper=A B C D E F G H I J K L M N O P Q R S T U V W X Y Z"
set "invalid=*~="

::---------------------------
:: define macros

if %vt% equ 1 (
  for /f "delims=" %%E in (
    'forfiles /p "%~dp0." /m "%~nx0" /c "cmd /c echo(0x1B"'
  ) do (
    cls
    <nul set /p "=%%E7"
    set "cls=<nul set /p "=%%E8""
    set "ClearLine=<nul set /p "=%%E[K""
    set "ClearPrev=echo(&echo(%%E[F%%E[K"
    set "Up4=echo(%%E[F%%E[F%%E[F%%E[F%%E[F"
    set "ShowCursor=<nul set /p "=%%E[?25h""
    set "HideCursor=<nul set /p "=%%E[?25l""
    set "exitCode=0"
  )
) else if exist "%~dp0CursorPos.exe" (
  set "cls=CursorPos 0 0"
  set "ClearLine=echo(                                   &CursorPos 0 -1"
  set "ClearPrev=CursorPos 0 -0&echo(                                   "
  set "Up4=CursorPos 0 -4"
  set "ShowCursor="
  set "HideCursor="
  set "exitCode=0"
) else (
  set "cls=cls"
  set "ClearLine="
  set "ClearPrev="
  set "Up4="
  set "ShowCursor="
  set "HideCursor="
  set "exitCode=1"
)

:: define a newline with line continuation
set ^"\n=^^^%LF%%LF%^%LF%%LF%^^"

:: setErr
:::  Sets the ERRORLEVEL to 1
set "setErr=(call)"

:: clrErr
:::  Sets the ERRORLEVEL to 0
set "clrErr=(call )"

:: getKey  [ValidKey]  [ValidKey...]
::: Check for keypress from the controller. Only accept a ValidKey.
::: Token delimiters and poison characters must be quoted.
::: Accept any key if no ValidKey specified.
::: Return result in Key variable. Key is undefined if no valid keypress.
set getKey=%\n%
for %%# in (1 2) do if %%#==2 (%\n%
  set key=%\n%
  set inKey=%\n%
  set keyTest=%\n%
  ^<^&%keyStream% set /p "inKey="%\n%
  if defined inKey (%\n%
    set inKey=!inKey:~0,-1!%\n%
    for %%C in (!args!) do set /a keyTest=1^&if /i !inKey! equ %%~C set key=!inKey!%\n%
  )%\n%
  if not defined keyTest set key=!inKey!%\n%
) else set args=


:: draw
:::  draws the board
set draw=%\n%
set screen=%\n%
for /l %%Y in (0,1,!height!) do set screen=!screen!!line%%Y!!LF!%\n%
set screen=!screen!Speed = !Difficulty! !replay!!LF!Growth Rate = !growth!   HighScore = !hi!!LF!Score = !score!   Time = !m!:!s!%\n%
if defined replay if not defined replayFinished (%\n%
  set screen=!screen!!LF!!LF!Press a key to abort the replay%\n%
)%\n%
%cls%^&echo(!screen!

:: test  X  Y  ValueListVar
:::  tests if value at coordinates X,Y is within contents of ValueListVar
set test=%\n%
for %%# in (1 2) do if %%#==2 (for /f "tokens=1-3" %%1 in ("!args!") do (%\n%
  for %%A in ("!line%%2:~%%1,1!") do if "!%%3:%%~A=!" neq "!%%3!" %clrErr% else %setErr%%\n%
)) else set args=


:: plot  X  Y  ValueVar
:::  places contents of ValueVar at coordinates X,Y
set plot=%\n%
for %%# in (1 2) do if %%#==2 (for /f "tokens=1-3" %%1 in ("!args!") do (%\n%
  set "part2=!line%%2:~%%1!"%\n%
  set "line%%2=!line%%2:~0,%%1!!%%3!!part2:~1!"%\n%
)) else set args=


::--------------------------------------
:: start the game
setlocal enableDelayedExpansion
if not exist "%saveLoc%\" md "%saveLoc%"
set "replay= Aborting... "
set "replayAvailable="
if exist "!gameLog!" set "replayAvailable=R"
call :loadHighScores
call :mainMenu


::--------------------------------------
:: main loop (infinite loop)
for /l %%. in () do (

  %=== check for and process abort signal if in replay mode ===%
  if defined replay if exist "%signal%" (
    del "%signal%"
    set "replayFinished=1"
    %draw%
    echo(
    %ClearLine%
    <nul set /p "=Aborting... "
    findstr "^" >nul <&%keyStream%
    for %%A in (!configOptions!) do set "%%A=!%%ASave!"
    %ShowCursor%
    call :mainMenu
  )

  %=== compute time since last move ===%
  for /f "tokens=1-4 delims=:.," %%a in ("!time: =0!") do set /a "t2=(((1%%a*60)+1%%b)*60+1%%c)*100+1%%d-36610100, tDiff=t2-t1"
  if !tDiff! lss 0 set /a tDiff+=24*60*60*100

  if !tDiff! geq !delay! (
    %=== delay has expired, so time for movement ===%
    set /a t1=t2

    %=== compute game time ===%
    if not defined gameStart set "gameStart=!t2!"
    set /a "gameTime=(t2-gameStart)"
    if !gameTime! lss 0 set /a "gameTime+=24*60*60*100"
    set /a "gameTime=(gameTime-pauseTime)/100, m=gameTime/60, s=gameTime%%60"
    if !m! lss 10 set "m=0!m!"
    if !s! lss 10 set "s=0!s!"

    %=== get keypress ===%
    %getKey% !keys!
    if /i !key! equ !pause! (

      %=== pause game ===%
      echo(
      %ShowCursor%
      call :ask "PAUSED - Press a key to continue..."
      %HideCursor%
      %ClearPrev%
      %sendCmd% go
      for /f "tokens=1-4 delims=:.," %%a in ("!time: =0!") do set /a "t2=(((1%%a*60)+1%%b)*60+1%%c)*100+1%%d-36610100, tDiff=t2-t1"
      if !tDiff! lss 0 set /a tDiff+=24*60*60*100
      set /a pauseTime+=tDiff

    ) else (

      %=== establish direction ===%
      if not defined replay (echo(!key!.) >>"!gameLog!"
      for %%K in (!key!) do if !moveKeys! equ 2 (
        set /a "xDiff=xTurn%%K*!yDiff!, yDiff=yTurn%%K*!xDiff!"
      ) else if "!%%KAxis!" neq "!axis!" (
        set /a "xDiff=xDiff%%K, yDiff=yDiff%%K"
        set "axis=!%%KAxis!"
      )

      %=== erase the tail ===%
      set "TX=!snakeX:~-2!"
      set "TY=!snakeY:~-2!"
      set "snakeX=!snakeX:~0,-2!"
      set "snakeY=!snakeY:~0,-2!"
      %plot% !TX! !TY! space

      %=== compute new head location and attempt to move ===%
      set /a "X=PX+xDiff, Y=PY+yDiff"
      set "X= !X!"
      set "Y= !Y!"
      set "X=!X:~-2!"
      set "Y=!Y:~-2!"
      (%test% !X! !Y! playerSpace) && (

        %=== move successful ===%

        %=== remove the new head location from the empty list ===%
        for %%X in ("!X!") do for %%Y in ("!Y!") do set "empty=!empty:#%%~X %%~Y=!"

        %=== eat any food that may be present ===%
        (%test% !X! !Y! food) && (
          %=== initiate growth ===%
          set /a grow+=growth

          %=== locate and draw new food ===%
          if defined replay (
            <&%keyStream% set /p "F="
          ) else (
            set /a "F=(!random!%%(emptyCnt-1))*6+1"
            (echo !F!) >>"!gameLog!"
          )
          for %%F in (!F!) do (%plot% !empty:~%%F,5! food)
        )

        if !grow! gtr 0 (
          %=== restore the tail ===%
          %plot% !TX! !TY! body
          set "snakeX=!snakeX!!TX!"
          set "snakeY=!snakeY!!TY!"
          set /a emptyCnt-=1

          %=== manage score ===%
          set /a "score+=1, grow-=1"
          if not defined replay if !score! gtr !hi! set /a "hi+=1, newHi=1"

        ) else (
          %=== add the former tail position to the empty list ===%
          set "empty=!empty!#!TX! !TY!"
        )

        %=== draw the new head ===%
        if defined snakeX (%plot% !PX! !PY! body)
        %plot% !X! !Y! head

        %=== Add the new head position to the snake strings ===%
        set "snakeX=!X!!snakeX!"
        set "snakeY=!Y!!snakeY!"
        set "PX=!X!"
        set "PY=!Y!"

        %draw%

      ) || (

        %=== failed move - game over ===%
        set "replayFinished=1"
        %plot% !TX! !TY! body
        call :spinner !PX! !PY! death
        %draw%
        if defined newHi (
          echo(
          echo New High Score - Congratulations^^!
          set "hi!diffCode!=!score!"
          copy "!gameLog!" "%hiFile%!diffCode!.txt" >nul
          >>"%hiFile%!diffCode!.txt" echo ::!score!
        )
        echo(
        %ClearLine%
        %ShowCursor%
        call :ask "Press a key to continue..."
        for %%A in (!configOptions!) do set "%%A=!%%ASave!"
        call :mainMenu
      )
    )
  )
)


::-------------------------------------
:getString  Prompt  Var  MaxLen
:: Prompt for a string with max lengh of MaxLen.
:: Valid keys are alpha-numeric, space, underscore, and dash
:: String is terminated by Enter
:: Backspace works to delete previous character
:: Result is returned in Var
set /a "maxLen=%3"
set "%2="
%sendCmd% prompt
<nul set /p "=%~1 "
call :purge
:getStringLoop
(%getKey% !upper! 0 1 2 3 4 5 6 7 8 9 " " _ - {Enter} !BS!)
if defined key (
  if !key! equ {Enter} (
    echo(
    exit /b
  )
  if !key! neq !BS! if !maxLen! gtr 0 (
    set /a maxLen-=1
    <nul set /p "=.!BS!!key!"
    set "%2=!%2!!key!
  )
  if !key! equ !BS! if defined %2 (
    set /a maxLen+=1
    <nul set /p "=!BS! !BS!"
    set "%2=!%2:~0,-1!"
  )
)
if defined inKey %sendCmd% one
goto :getStringLoop


::-------------------------------------
:ask  Prompt  ValidKey [Validkey]...
:: Prompt for a keypress.
:: Wait until a ValidKey is pressed and return result in Key variable.
:: Token delimiters, ), and poison characters must be quoted.
%sendCmd% prompt
<nul set /p "=%~1 "
(set validKeys=%*)
(set validKeys=!validKeys:%1=!)
call :purge
:getResponse
(%getKey% !validKeys!)
if not defined key (
  if defined inKey %sendCmd% one
  goto :getResponse
)
exit /b


:purge
set "inKey="
for /l %%N in (1 1 1000) do (
  set /p "inKey="
  if "!inKey!" equ "{purged}." exit /b
)<&%keyStream%
goto :purge


::-------------------------------------
:spinner  X  Y  ValueVar
set /a d1=-1000000
for /l %%N in (1 1 5) do for %%C in (%spinner%) do (
  call :spinnerDelay
  %plot% %1 %2 %%C
  %draw%
)
call :spinnerDelay
(%plot% %1 %2 %3)
exit /b


::-------------------------------------
:delay  centiSeconds
setlocal
for /f "tokens=1-4 delims=:.," %%a in ("!time: =0!") do set /a "spinnerDelay=%1, d1=(((1%%a*60)+1%%b)*60+1%%c)*100+1%%d-36610100"
:: fall through to :spinnerDelay

::-------------------------------------
:spinnerDelay
for /f "tokens=1-4 delims=:.," %%a in ("!time: =0!") do set /a "d2=(((1%%a*60)+1%%b)*60+1%%c)*100+1%%d-36610100, dDiff=d2-d1"
if %dDiff% lss 0 set /a dDiff+=24*60*60*100
if %dDiff% lss %spinnerDelay% goto :spinnerDelay
set /a d1=d2
exit /b


::-------------------------------------
:mainMenu
if defined toggleVT100 call :graphicOptions
cls
call :resize
set "loadAvailable="
echo SNAKE.BAT v4.0 by Dave Benham
echo(
echo Main Menu:
echo(
echo   N - New game
echo   F - Field size..... !size!
echo   W - groWth rate.... !growth!
echo   C - Control options
echo   G - Graphic options

if defined replayAvailable echo   R - Replay previous game
if defined saveAvailable   echo   S - Save a game
if exist *.snake.txt       echo   L - Load and watch a saved game&set "loadAvailable=L"

echo   Q - Quit
echo(
set "hiAvailable="
for /l %%N in (1 1 6) do if defined hi%%N (
  if not defined hiAvailable (
    echo Replay High Score:
    echo(
  )
  set "desc=!desc%%N!........"
  set "hiAvailable=!hiAvailable! %%N"
  echo   %%N - !desc:~0,8! !hi%%N!
)
if defined hiAvailable echo(
set "keys=N F W C G Q !hiAvailable! !replayAvailable! !saveAvailable! !loadAvailable!"
call :ask ">" !keys!
if /i !key! equ Q (
  %sendCmd% quit
  cls
  exit %exitCode%
) else if /i !key! equ N (
  set "replay="
  set "replayAvailable=R"
  set "saveAvailable=S"
  goto :initialize
) else if /i !key! equ S (
  if defined replayAvailable (
    call :ask "HighScore # or P for Previous:" !hiAvailable! P
  ) else (
    call :ask "HighScore #:" !hiAvailable!
  )
  echo !key!
  if /i !key! equ P (set "src=!gameLog!") else set "src=%hiFile%!key!.txt"
  call :getString "Save file name:" file 20
  copy "!src!" "!file!.snake.txt"
  call :ask "Press a key to continue..."
) else if /i !key! equ L (
  call :getString "Load file name:" file 20
  if exist "!file!.snake.txt" (
    set "replay=!file!.snake.txt"
    goto :initialize
  )
  echo Error: File "!file!.snake.txt" not found
  call :ask "Press a key to continue..."
) else if /i !key! equ R (
  set "replay=!gameLog!"
  goto :initialize
) else if /i !key! equ C (
  call :controlOptions
) else if /i !key! equ G (
  call :graphicOptions
) else if /i !key! equ F (
  call :sizeOptions
) else if /i !key! equ W (
  call :ask "Press a digit for growth rate (0 = 10)" 0 1 2 3 4 5 6 7 8 9
  if !key! equ 0 set "key=10"
  set "growth=!key!"
  call :loadHighScores
) else if !key! geq 1 if !key! leq 6 (
  set "replay=%hiFile%!key!.txt"
  goto :initialize
)
goto :mainMenu


::-------------------------------------
:sizeOptions
cls
set "keys=T S M L W N"
echo Field Size Options:
echo(
echo   T - Tiny   15 x 10
echo   S - Small  30 x 20
echo   M - Medium 40 x 25
echo   L - Large  47 x 32
echo   W - Wide   82 x 19
echo   N - Narrow 15 x 40
echo(
call :ask ">" !keys!
set "size=!size%key%!"
set /a "dispWidth=!width%key%!, dispHeight=!height%key%!"
call :loadHighScores
goto :saveUserPrefs
exit /b


::-------------------------------------
:controlOptions
cls
set "keys={Enter} T L R P"
if !moveKeys! equ 4 set "keys=!keys! U D"
                    echo Control Options:
                    echo(
                    echo   T - Type... = !moveKeys! keys
                    echo(
                    echo   L - Left... = !left!
                    echo   R - Right.. = !right!
if !moveKeys! equ 4 echo   U - Up..... = !up!
if !moveKeys! equ 4 echo   D - Down... = !down!
                    echo(
                    echo   P - Pause.. = !pause!
                    echo(
                    echo   {Enter} - Return to Main Menu
                    echo(
call :ask ">" !keys!
if !key! equ {Enter} goto :saveUserPrefs
if /i !key! equ T (
  if !moveKeys! equ 2 (set "moveKeys=4") else set "moveKeys=2"
  goto :controlOptions
)
set "option= LLeft RRight UUp DDown PPause"
for /f %%O in ("!option:* %key%=!") do (
  call :ask "Press a key for %%O:"
  for %%K in (0 1 2) do if "!key!" equ "!invalid:~%%K,1!" goto :controlOptions
  for %%C in (!upper!) do set "key=!key:%%C=%%C!"
  set "%%O=!key!"
)
goto :controlOptions


::-------------------------------------
:graphicOptions
set "toggleVT100="
cls
echo Graphic Options:
echo(
echo   B - Border...... = !bound!
echo   E - Empty space. = !space!
echo   H - snake Head.. = !head!
echo   S - Snake body.. = !body!
echo   F - Food........ = !food!
echo   D - Death....... = !death!
echo(
echo   V - VT100 mode.. = !vt%vt%!
echo(
echo   {Enter} - Rturn to Main Menu
echo(
call :ask ">" B E H S F D V {Enter}
if !key! equ {Enter} goto :saveUserPrefs
if /i !key! equ V (
  set /a "vt=^!vt"
  call :saveUserPrefs
  %sendCmd% quit
  exit 2
) else (
  set "option=-BBorder:bound:-EEmpty Space:space:-HSnake Head:head:-SSnake Body:body:-FFood:food:-DDeath:death:"
  for /f "tokens=1,2 delims=:" %%A in ("!option:*-%key%=!") do (
    call :ask "Press a key for %%A"
    for %%K in (0 1 2) do if "!key!" equ "!invalid:~%%K,1!" goto :graphicOptions
    set "%%B=!key!"
  )
)
goto :graphicOptions


::------------------------------------
:saveUserPrefs
(for %%V in (moveKeys up down left right space bound food head body death pause growth vt size dispWidth dispHeight) do echo %%V=!%%V!) >"%userPref%"
exit /b


::-------------------------------------
:initialize
cls
if defined replay (
  echo Replay Speed Options:
) else (
  echo Speed Options:
)
echo                       delay
echo    #   Description  (seconds)
echo   ---  -----------  ---------
for /l %%N in (1 1 6) do (
  set "delay=0!delay%%N!"
  set "desc=!desc%%N!           "
  echo    %%N   !desc:~0,11!    0.!delay:~-2!
)
echo(
call :ask "Pick a speed (1-6):" 1 2 3 4 5 6
set "difficulty=!desc%key%!"
set "delay=!delay%key%!"
set "diffCode=%key%"
echo %key% - %difficulty%
echo(
<nul set /p "=Initializing."
for %%A in (!configOptions!) do set "%%ASave=!%%A!"
if defined replay (
  %sendCmd% replay
  %sendCmd% !replay!
  call :waitForSignal
  set "replay=(REPLAY at !difficulty!)"
  set "size=%defaultSize%"
  set /a "dispWidth=defaultWidth, dispHeight=defaultHeight"
  :loadReplayConfig
  <&%keyStream% set /p "ln="
  if "!ln!" neq "END" set "!ln!" & goto :loadReplayConfig
  call :resize
)
set "axis=X"
set "xDiff=+1"
set "yDiff=+0"
set "empty="
set /a "PX=1, PY=height/2, FX=width/2+1, FY=PY, score=0, emptyCnt=0, t1=-1000000"
set "gameStart="
set "m=00"
set "s=00"
set "snakeX= %PX%"
set "snakeY= %PY%"
set "snakeX=%snakeX:~-2%"
set "snakeY=%snakeY:~-2%"
for /l %%Y in (0 1 %height%) do (
  <nul set /p "=."
  set "line%%Y="
  for /l %%X in (0,1,%width%) do (
    set "cell="
    if %%Y equ 0        set "cell=%bound%"
    if %%Y equ %height% set "cell=%bound%"
    if %%X equ 0        set "cell=%bound%"
    if %%X equ %width%  set "cell=%bound%"
    if %%X equ %PX% if %%Y equ %PY% set "cell=%head%"
    if not defined cell (
      set "cell=%space%"
      set "eX= %%X"
      set "eY= %%Y"
      set "empty=!empty!#!eX:~-2! !eY:~-2!"
      set /a emptyCnt+=1
    )
    if %%X equ %FX% if %%Y equ %FY% set "cell=%food%"
    set "line%%Y=!line%%Y!!cell!"
  )
)
set "replayFinished="
if defined replay (
  set "keys="
  set "hi=0"
  for /f "delims=:" %%A in ('findstr "^::" "%hiFile%!diffCode!.txt" 2^>nul') do set "hi=%%A"
  %HideCursor%
  cls
  (%draw%)
  call :delay 100
) else (
  if defined hi%diffCode% (set "hi=!hi%diffCode%!") else set "hi=0"
  cls
  (%draw%)
  >"!gameLog!" ( 
    for %%A in (!configOptions!) do (echo %%A=!%%A!)
    (echo END)
  )
  echo(
  if !moveKeys! equ 4 (
    echo Controls: !up!=up !down!=down !left!=left !right!=right !pause!=pause
  ) else (
    echo Controls: !left!=left !right!=right !pause!=pause
  )
  echo Avoid running into yourself (!body!!body!!head!^) or wall (!bound!^)
  echo Eat food (!food!^) to grow.
  echo(
  call :ask "Press a key to start..."
  %HideCursor%
  %sendCmd% go
)
set "pauseTime=0"
set "xDiff!up!=+0"
set "xDiff!down!=+0"
set "xDiff!left!=-1"
set "xDiff!right!=+1"
set "yDiff!up!=-1"
set "yDiff!down!=+1"
set "yDiff!left!=+0"
set "yDiff!right!=+0"
set "!up!Axis=Y"
set "!down!Axis=Y"
set "!left!Axis=X"
set "!right!Axis=X"
set "xTurn!left!=1"
set "xTurn!right!=-1"
set "yTurn!left!=-1"
set "yTurn!right!=1"
set "playerSpace=!space!!food!"
set ^"keys="!left!" "!right!" "!pause!"^"
set "newHi="
set "grow=0"
if !moveKeys! equ 4 set ^"keys=!keys! "!up!" "!down!"^"
if defined Up4 if not defined replay (
  %Up4%
  for /l %%N in (1 1 5) do (echo(                                             )
)
exit /b


::-------------------------------------
:waitForSignal
if not exist "%signal%" goto :waitForSignal
del "%signal%"
exit /b


::-------------------------------------
:loadHighScores
set "saveAvailable="
for /l %%N in (1 1 6) do (
  set "hi%%N="
  for /f "delims=:" %%A in ('findstr "^::" "%hiFile%%%N.txt" 2^>nul') do (
    set "hi%%N=%%A"
    set "saveAvailable=S"
  )
)
exit /b


::----------------------------
:resize the console window
set /a cols=dispWidth+1, lines=dispHeight+10, area=(dispWidth-2)*(dispHeight-2)
if %area% gtr 1365 (
  echo ERROR: Playfield area too large
  %sendCmd% quit
  exit
)
if %lines% lss 25 set lines=25
if %cols% lss 46 set cols=46
mode con: cols=%cols% lines=%lines%
set /a "width=dispWidth-1, height=dispHeight-1"
set "resize="
exit /b


::-------------------------------------
:fixLogs
setlocal enableDelayedExpansion
for %%F in (*.snake) do (
  ren "%%F" "%%F.txt"
  call :fixLog "%%F.txt"
)
pushd "%SaveLoc%"
for /f "delims=" %%F in ('dir /b SnakeHi*.txt 2^>nul') do (
  set "file=%%~nF"
  set "file=Snake1Hi!file:~-1!.txt"
  ren "%%F" "!file!"
  call :fixLog "!file!"
)
for /f "tokens=1* delims=eE" %%A in (
  'dir /b Snake*Hi*.txt ^| findstr /i "^Snake[0-9]"'
) do ren "Snake%%B" "SnakeMedium%%B"
popd
exit /b

:fixLog  filePath
>"%~1.new" (
  <"%~1" (
    for %%A in (diffCode difficulty moveKeys up down left right) do (
      set /p "val="
      (echo %%A=!val!)
    )
  )
  (echo growth=1)
  (echo END)
  more +7 "%~1"
)
move /y "%~1.new" "%~1" >nul
exit /b


::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:controller
:: Detects keypresses and sends the information to the game via a key file.
:: The controller has various modes of input that are activated by commands sent
:: from the game via a cmd file.
::
:: Modes:
::
::   hold   - No input, wait for command
::
::   go     - Continuously get/send key presses
::
::   prompt - Send {purged} marker to allow game to purge input buffer, then
::            get/send a single key press and hold
::
::   one    - Get/send a single key press and hold
::
::   replay - Copy a game log to the key file. The next line in cmd file
::            specifies name of log file to copy. During replay, the controller
::            will send an abort signal to the game if a key is pressed.
::
::   quit   - Immediately exit the controller process
::
:: As written, this routine incorrectly reports ! as ), but that doesn't matter
:: since we don't need that key. Both <CR> and Enter key are reported as {Enter}.
:: An extra character is appended to the output to preserve any control chars
:: when read by SET /P.

setlocal enableDelayedExpansion
for /f %%a in ('copy /Z "%~dpf0" nul') do set "CR=%%a"
set "cmd=hold"
set "inCmd="
set "key="
for /l %%. in () do (
  if "!cmd!" neq "hold" (
    for /f "delims=" %%A in ('xcopy /w "%~f0" "%~f0" 2^>nul') do (
      if not defined key set "key=%%A"
    )
    set "key=!key:~-1!"
    if !key! equ !CR! set "key={Enter}"
  )
  <&%cmdStream% set /p "inCmd="
  if defined inCmd (
    if !inCmd! equ quit exit
    set "cmd=!inCmd!"
    if !inCmd! equ replay (
      <&%cmdStream% set /p "file="
      type "!file!" >&%keyStream%
      copy nul "%signal%"
    )
    set "inCmd="
  )
  if defined key (
    if "!cmd!" equ "prompt" (echo {purged}.)
    if "!cmd!" equ "replay" (
      copy nul "%signal%" >nul
      set "cmd=go"
    ) else (echo(!key!.)
    if "!cmd!" neq "go" set "cmd=hold"
    set "key="
  )>&%keyStream%
)