@echo off
setlocal EnableDelayedExpansion

if "%~1" neq "" goto %1

title Tetris.BAT by Aacini
rem Written by Antonio Perez Ayala
rem Proportions fixed by Lassie23
rem http://www.dostips.com/forum/viewtopic.php?f=3&t=6812
rem Reference: http://colinfahey.com/tetris/tetris.html
rem 2015/11/27 - version 1.0

rem Delete the next line when Bitmap font 16x8 is used
set "F16x8=REM"

cls
echo/
echo ===  Pure .BATch-file Tetris game by Aacini  ===
echo/
echo/
echo Tetris pieces are controlled with these keys:
echo/
echo          180                    rot.right
echo rot.      W      rot.     move      I      move
echo left ^<- A S D -^> right    left ^<- J K L -^> right
echo           ^|                         ^|
echo           v                         v
echo       soft drop                 hard drop
echo/
echo/
echo Press P to pause the game; press N to end game
echo/
echo/
pause
cls


rem Field dimensions
set /A cols=20, lines=20

set /A col=cols+6, lin=lines+8
%F16x8% set /A lin+=lines+2
mode CON: cols=%col% lines=%lin%
if %errorlevel% neq 0 (
   echo Configuration error^^^!
   echo You must select a font size that allows to set
   echo a text window of %col% columns X %lin% lines
   pause
   goto :EOF
)

chcp 850 > NUL
cd . > pipeFile.txt
"%~F0" Input >> pipeFile.txt  |  "%~F0" Main < pipeFile.txt
ping localhost -n 2 > NUL
del pipeFile.txt
goto :EOF



:Input
set "com[J]=Dx=-2"
set "com[L]=Dx=2"
set "com[K]=del=3"
set "com[W]=R=2"
set "com[I]=R=-1"
set "com[A]=R=1"
set "com[D]=R=-1"
set "com[S]=Dy=-1"
set "com[Y]=Y"
set "com[N]=N=1"
set "com[P]=pause=1"
set "com[T]=Dy=1"

for /L %%# in () do (
   set "key="
   for /F "delims=" %%k in ('xcopy /W "%~F0" "%~F0" 2^>NUL') do if not defined key set "key=%%k"
   for /F %%k in ("!key:~-1!") do (
      echo(!com[%%k]!
      if /I "%%k" equ "N" exit
   )
)
rem exit



:Main

(
   for /F "delims==" %%v in ('set') do set "%%v="
   set /A cols=%cols%, lines=%lines%
   set "F16x8=%F16x8%"
)

rem Initialize the Field
for /L %%i in (1,1,%cols%) do set "spc=!spc! "
for /L %%i in (1,1,%lines%) do set "F%%i=  ³%spc%³"
set /A top=lines+1
set "F%top%=  Ú" & set "F0=  À"
for /L %%i in (1,1,%cols%) do set "F%top%=!F%top%!Ä" & set "F0=!F0!Ä"
set "F%top%=!F%top%!¿" & set "F0=%F0%Ù"
set "F-1=  Level: 1" & set "Level=1"
set "F-2=   Rows: 0" & set "Rows=0"
set "F-3=  Score: 0" & set "Score=0"
for /L %%i in (1,1,%cols%) do set "blk=!blk!Û"
set /A top=lines+3, delay=50
%F16x8% set /A linesP2=lines+2

rem Define all ":orientations:" of the O I S Z L J T pieces via "triplets":
rem (offset Y . offset X . length X); one "triplet" for each horizontal line
for %%t in ( "O:0.-2.4 -1.-2.4"
             "I:0.-4.8:1.0.2 0.0.2 -1.0.2 -2.0.2"
             "S:0.0.4 -1.-2.4:1.0.2 0.0.4 -1.2.2"
             "Z:0.-2.4 -1.0.4:1.2.2 0.0.4 -1.0.2"
             "L:0.-2.6 -1.-2.2:1.0.2 0.0.2 -1.0.4:1.2.2 0.-2.6:1.-2.4 0.0.2 -1.0.2"
             "J:0.-2.6 -1.2.2:1.0.4 0.0.2 -1.0.2:1.-2.2 0.-2.6:1.0.2 0.0.2 -1.-2.4"
             "T:0.-2.6 -1.0.2:1.0.2 0.0.4 -1.0.2:1.0.2 0.-2.6:1.0.2 0.-2.4 -1.0.2" ) do (
   set "pc=%%~t"
   set "i=-1"
   for /F "delims=" %%p in (^"!pc::^=^
% New line %
!^") do (
      if !i! lss 0 (set "pc=%%p") else set "!pc!!i!=%%p"
      set /A i+=1
   )
   set "!pc!N=!i!"
)
set "pcs=OISZLJT"

set "init=1"
for /L %%# in () do (

   if defined init (
      setlocal EnableDelayedExpansion
      set "init="

      rem Create the first "previous" piece
      for /L %%i in (0,1,!time:~-1!) do set /A p=!random!%%7
      for %%p in (!p!) do set "p2=!pcs:~%%p,1!"
      for %%p in (!p2!) do set "p3=!%%p0!" & set "p4=!%%pN!"

      set "new=1"
   )

   if defined new (
      set "new="

      rem Take the "previous" piece as current one
      set "pc=!p2!" & set "p0=!p3!" & set "pN=!p4!"

      rem Create a new "previous" piece
      for /L %%i in (1,1,2) do (
         set /A p=!random!*7/32768
         for %%p in (!p!) do (
            set "p=!pcs:~%%p,1!"
            if !p! neq !pc! set "p2=!p!"
         )
      )
      for %%p in (!p2!) do set "p3=!%%p0!" & set "p4=!%%pN!"

      rem Insert the new "previous" piece in its place, above Field
      set /A x=3+cols/2, y=top, yp=top-1
      set "F!yp!=   %spc%"
      for %%p in (!p3!) do (
         for /F "tokens=1-3 delims=." %%i in ("%%p") do (
            set /A yp=y+%%i, xp=x+%%j, xL=xp+%%k
            for /F "tokens=1-3" %%a in ("!yp! !xp! !xL!") do (
               set "F%%a=!spc:~0,%%b!!blk:~0,%%k!!spc:~%%c!"
            )
         )
      )

      rem Try to insert the new current piece in the Field...
      set /A x=3+cols/2, y=lines,   b=1
      for %%p in (!p0!) do (
         for /F "tokens=1-3 delims=." %%i in ("%%p") do (
            set /A yp=y+%%i, xp=x+%%j, xL=xp+%%k
            for /F "tokens=1-3" %%a in ("!yp! !xp! !xL!") do (
               if "!F%%a:~%%b,%%k!" neq "!spc:~0,%%k!" set     "b="
               set "F%%a=!F%%a:~0,%%b!!blk:~0,%%k!!F%%a:~%%c!"
            )
         )
      )
      cls
      for /L %%i in (%top%,-1,-3) do (
         echo(!F%%i!
%F16x8%  if %%i geq %linesP2% echo(!F%%i!
%F16x8%  if %%i geq 1 if %%i leq %lines% echo(!F%%i!
      )

      rem ... if that was not possible:
      if not defined b call :endGame & endlocal

      set "p1=!p0!"
      set /A "pI=0, del=delay, b=1!time:~-2!"

   )

   rem Control module: move the piece as requested via a key, or down one row each %del% centiseconds
   set "move="
   set /A "Dy=Dx=0"
   set /P "com="
   if defined com (
      set /A "!com!, move=1"
      set "com="
      if defined N exit
      if defined pause call :Pause & set "move="
      set "b=1!time:~-2!"
   ) else (
      set /A "e=1!time:~-2!, elap=e-b, elap-=(elap>>31)*100"
      if !elap! geq !del! set /A b=e, Dy=move=-1
   )

   if defined move (

      rem Delete the piece from its current position, and store current coordinates
      set i=0
      for %%p in (!p0!) do for /F "tokens=1-3 delims=." %%i in ("%%p") do (
         set /A yp=y+%%i, xp=x+%%j, xL=xp+%%k
         for /F "tokens=1-3" %%a in ("!yp! !xp! !xL!") do (
            set "F%%a=!F%%a:~0,%%b!!spc:~0,%%k!!F%%a:~%%c!"
            set /A i+=1
            set "c!i!=%%a %%b %%c %%k"
         )
      )

      rem If move is Rotate: get rotated piece
      if defined R (
         set /A "p=(pI+R+pN)%%pN"
         for /F "tokens=1,2" %%i in ("!pc! !p!") do set "p1=!%%i%%j!"
      )

      rem Test if the piece can be placed at the new position, and store new coordinates
      set j=0
      for %%p in (!p1!) do if defined move (
         for /F "tokens=1-3 delims=." %%i in ("%%p") do (
            set /A yp=y+%%i+Dy, xp=x+%%j+Dx, xL=xp+%%k
            for /F "tokens=1-3" %%a in ("!yp! !xp! !xL!") do (
               if "!F%%a:~%%b,%%k!" equ "!spc:~0,%%k!" (
                  set /A j+=1
                  set "n!j!=%%a %%b %%c %%k"
               ) else (
                  set "move="
               )
            )
         )
      )

      if defined move (

         rem Place the piece at the new position
         for /L %%j in (1,1,!j!) do (
            for /F "tokens=1-4" %%a in ("!n%%j!") do (
               set "F%%a=!F%%a:~0,%%b!!blk:~0,%%d!!F%%a:~%%c!"
            )
         )

         rem Update the Field in screen
         cls
         for /L %%i in (%top%,-1,-3) do (
            echo(!F%%i!
%F16x8%     if %%i geq %linesP2% echo(!F%%i!
%F16x8%     if %%i geq 1 if %%i leq %lines% echo(!F%%i!
         )

         rem Update any changes in the piece
         set /A y+=Dy, x+=Dx
         if defined R set "p0=!p1!" & set "pI=!p!" & set "R="

      ) else (   rem The piece can not be moved

         rem Recover the piece at its current position
         for /L %%i in (1,1,!i!) do (
            for /F "tokens=1-4" %%a in ("!c%%i!") do (
               set "F%%a=!F%%a:~0,%%b!!blk:~0,%%d!!F%%a:~%%c!"
            )
         )
         if defined R set "p1=!p0!" & set "R="

         if !Dy! neq 0 (   rem The piece "lands"

            rem Count completed lines
            set "j=0"
            for /L %%i in (1,1,!i!) do for /F %%a in ("!c%%i!") do (
               if "!F%%a:~3,%cols%!" equ "%blk%" (
                  set "F%%a=  ³%spc: ==%³"
                  set /A j+=1
               )
            )

            if !j! neq 0 (
               rem Update scores (See N-Blox at http://www.tetrisfriends.com/help/tips_appendix.php#rankingsystem)
               set /A "xp=Level*(40+((j-2>>31)+1)*60+((j-3>>31)+1)*200+((j-4>>31)+1)*900), Score+=xp, Rows+=j, xL=Level, Level=(Rows-1)/10+1"
               set "F-2=!F-2:~0,8!+!j!     "
               set "xp=!xp!     "
               set "F-3=!F-3:~0,8!+!xp:~0,6!"
               echo  BEL Ctrl-G Ascii-7
               cls
               for /L %%i in (%top%,-1,-3) do (
                  echo(!F%%i!
%F16x8%           if %%i geq %linesP2% echo(!F%%i!
%F16x8%           if %%i geq 1 if %%i leq %lines% echo(!F%%i!
               )
               set "F-1=!F-1:~0,8! !Level!"
               set "F-2=!F-2:~0,8! !Rows!"
               set "F-3=!F-3:~0,8! !Score!"
               if !Level! neq !xL! if !delay! gtr 5 set /A delay-=5

               rem Remove completed lines
               set "i=1"
               for /L %%i in (1,1,%lines%) do (
                  set "F!i!=!F%%i!"
                  if "!F%%i:~3,1!" neq "=" set /A i+=1
               )
               for /L %%i in (!i!,1,%lines%) do set "F%%i=  ³%spc%³"
               call :Delay 95
               cls
               for /L %%i in (%top%,-1,-3) do (
                  echo(!F%%i!
%F16x8%           if %%i geq %linesP2% echo(!F%%i!
%F16x8%           if %%i geq 1 if %%i leq %lines% echo(!F%%i!
               )
            )

            rem Request to show a new piece
            set "new=1"

         )

      )

   )

)

:endGame
set /P "=Play again? " < NUL
:choice
   set /P "com="
if not defined com goto choice
if /I "%com%" equ "Y" exit /B
if /I "%com:~0,1%" neq "N" set "com=" & goto choice
echo N
exit


:Pause
set "pause=!F%lines%!"
set "F%lines%=  ³%spc:          =  PAUSED  %³"
cls & for /L %%i in (%top%,-1,-3) do (
         echo(!F%%i!
%F16x8%  if %%i geq %linesP2% echo(!F%%i!
%F16x8%  if %%i geq 1 if %%i leq %lines% echo(!F%%i!
      )
:wait
   set /P "com="
if not defined com goto wait
set "com="
set "F%lines%=%pause%"
cls & for /L %%i in (%top%,-1,-3) do (
         echo(!F%%i!
%F16x8%  if %%i geq %linesP2% echo(!F%%i!
%F16x8%  if %%i geq 1 if %%i leq %lines% echo(!F%%i!
      )
set "pause="
exit /B


:Delay centisecs
set "b=1%time:~-2%"
:wait2
   set /A "e=1%time:~-2%, elap=e-b, elap-=(elap>>31)*100"
if %elap% lss %1 goto wait2
set "b=1%time:~-2%"
exit /B