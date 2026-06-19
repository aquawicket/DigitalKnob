@echo off
setlocal EnableDelayedExpansion

if "%~1" neq "" goto %1

rem Written by Antonio Perez Ayala
rem http://www.dostips.com/forum/viewtopic.php?f=3&t=6812
rem Reference: http://colinfahey.com/tetris/tetris.html
rem 2015/11/27 - version 1.0
rem 2016/03/31 - version 2.0: Use PowerShell to read arrow keys and mouse movements
rem 2016/04/11 - version 3.0: Use PowerShell to show text in color
rem 2016/04/12 - version 3.1: Synchronization problem fixed, change window/buffer size bug fixed
rem http://www.dostips.com/forum/viewtopic.php?f=3&t=6936&p=46206#p46206

rem The best appearance is obtained with a square font, like Raster Font 8x8

color 0F
chcp 850 > NUL
cls
echo/
echo ===  Pure .BATch-file Tetris game by Aacini  ===
echo/
echo/
echo Tetris pieces are controlled with these keys:
echo/
echo                                 rot.right
echo                                     ^^
echo rot.               rot.     move    ^|     move
echo left ^<ÄÄ A S D ÄÄ^> right    left ^<ÄÄúÄÄ^> right
echo            ^|                        ^|
echo            v                        v
echo        soft drop                hard drop
echo/
echo Mouse movements emulate arrow key presses,
echo left button pause/continue the game.
echo/
echo/
echo Press P to pause/continue; press N to end game.
echo/
echo/
pause
cls

rem Field dimensions
set /A cols=10, lines=20

set /P "=Loading PS engine..." < NUL
cd . > pipeFile.txt
"%~F0" Input >> pipeFile.txt  |  "%~F0" Main < pipeFile.txt  |  "%~F0" Output
ping localhost -n 2 > NUL
del pipeFile.txt
goto :EOF



:Input
set "letter=ABCDEFGHIJKLMNOPQRSTUVWXYZ"
for /L %%i in (0,1,25) do (
   set /A "Letter!letter:~%%i,1!=%%i+65"
)
set /A "LeftArrow=37, UpArrow=38, RightArrow=39, DownArrow=40"
PowerShell  ^
   $mouseSens = 10;  ^
   $command = @{     ^
      %LeftArrow%  = 'Dx=-1';  ^
      %RightArrow% = 'Dx=1';   ^
      %DownArrow%  = 'del=3';  ^
      %UpArrow%    = 'R=-1';   ^
      %LetterA%    = 'R=1';    ^
      %LetterD%    = 'R=-1';   ^
      %LetterS%    = 'Dy=-1';  ^
      %LetterY%    = 'Y';      ^
      %LetterN%    = 'N=1';    ^
      %LetterP%    = 'pause=1';  ^
   };  ^
   [Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms') ^| Out-Null; ^
   $lX = [System.Windows.Forms.Control]::MousePosition.X; ^
   $lY = [System.Windows.Forms.Control]::MousePosition.Y; ^
   Start-Sleep -m 1500;  ^
   Write-Output 0;  ^
   while ( $key -ne %LetterN% ) {  ^
      if ( $Host.UI.RawUI.KeyAvailable ) {  ^
         $key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyUp').VirtualKeyCode;  ^
         Write-Output $command[$key];  ^
      } else {  ^
         $mX = [System.Windows.Forms.Control]::MousePosition.X;  ^
         $mY = [System.Windows.Forms.Control]::MousePosition.Y;  ^
         $mB = [System.Windows.Forms.Control]::MouseButtons;     ^
         $dX = $mX - $lX;  $dY = $mY - $lY;  ^
         if ( [math]::abs($dX) -gt $mouseSens ) {   ^
            $if = if ($dX -lt 0) {%LeftArrow%} else {%RightArrow%};  ^
            Write-Output $command[$if];  ^
            $lX = $mX;  $lY = $mY;  ^
         } else { if ( [math]::abs($dY) -gt $mouseSens ) {  ^
            $if = if ($dY -lt 0) {%UpArrow%} else {%DownArrow%};  ^
            Write-Output $command[$if];  ^
            $lX = $mX;  $lY = $mY;  ^
         } else { if ( $mB -eq 'Left' ) {  ^
            Write-Output $command[%LetterP%];  ^
         }}}  ^
      }  ^
      Start-Sleep -m 100;  ^
   }
%End PowerShell%
echo Ending game... > CON
exit



:Output
rem Parameters received via lines read have one of these four forms:
rem - 'cls' = Clear screen and initialize the field
rem - X,Y  =  Move cursor to X,Y position
rem - X,Y,'ColorString' = Move cursor to such position and show the "Color Codes String"
rem - X,Y,Color,Wide = Move cursor to such position and show Wide chars in given Color;
rem                    if Color is '=', show an equal-sign character Wide times
rem - 'del',Filename = Delete the given file (for synchro purposes)
PowerShell  ^
   function ClearScreen () {  ^
      cls; for ( $i=0; $i -lt $lnN; ++$i ) { Write-Host; Write-Host }  ^
      Write-Host -NoNewLine (' '*2); Write-Host "Ú$frame¿";  ^
      for ( $i=1; $i -le %lines%*$lnN; ++$i ) { Write-Host -NoNewLine (' '*2); Write-Host "³$spc³" }  ^
      Write-Host -NoNewLine (' '*2); Write-Host "À$frameÙ";  ^
      Write-Host -NoNewLine (' '*2); Write-Host ' Level: 1';  ^
      Write-Host -NoNewLine (' '*3); Write-Host ' Rows: 0';  ^
      Write-Host -NoNewLine (' '*2); Write-Host ' Score: 0';  ^
   }  ^
   $console = $Host.UI.RawUI;  ^
   $console.WindowTitle = 'Tetris.BAT by Aacini';  ^
   $curSize = $console.CursorSize;  ^
   $console.CursorSize = 0;  ^
   for ( $i=1; $i -le 3; ++$i ) {  ^
      if ( $i*(%lines%+2)+6 -le $console.MaxPhysicalWindowSize.Height ) { $lnN = $i } ^
   }  ^
   $col = $lnN*%cols%+6;  $lin = $lnN*(%lines%+2)+6;  ^
   $winSize = $console.WindowSize; $bufSize = $console.BufferSize;  ^
   $winSize.Width = $col;  $bufSize.Width = $col;  ^
   if ( $col -lt $console.WindowSize.Width ) {  ^
      $console.WindowSize = $winSize; $console.BufferSize = $bufSize;  ^
   } else {  ^
      $console.BufferSize = $bufSize; $console.WindowSize = $winSize;  ^
   }  ^
   $winSize.Height = $lin; $bufSize.Height = $lin;  ^
   if ( $lin -lt $console.WindowSize.Height ) {  ^
      $console.WindowSize = $winSize; $console.BufferSize = $bufSize;  ^
   } else {  ^
      $console.BufferSize = $bufSize; $console.WindowSize = $winSize;  ^
   }  ^
   $ln = ( ('X'), ('Úª','ÀÙ'), ('ÚÄ¿','³ ³','ÀÄÙ') )[$lnN-1];  ^
   $frame = ''; $spc = ''; for ( $i=1; $i -le $col-6; ++$i ) { $frame+='Ä'; $spc+=' '; }  ^
   $coords = $console.CursorPosition;  ^
   foreach ( $line in $input ) {  ^
      $X,$Y,$Color,$Wide = $line.Split(',');  ^
      if ( $X -eq 'cls' ) {  ^
         ClearScreen  ^
      } else { if ($X -eq 'del') {  ^
         del $Y  ^
      } else {  ^
         $coords.X = 3 + ([int]$X-1) * $lnN;  ^
         $Y = [int]$Y; $coords.Y = (%lines%+3-$Y) * $lnN ;  ^
         if ( $Y -le %lines% ) { $coords.Y -= $lnN-1 }  ^
         if ( $Y -lt 0 ) { $coords.Y += $Y*($lnN-1) }  ^
         $console.CursorPosition = $coords;  ^
         if ( $Wide ) {  ^
            $Wide = [int]$Wide;  ^
            if ( $Color -ne '=' ) {  ^
               $Color = [int]('0x'+$Color);  ^
               for ( $i=0; $i -lt $lnN; ++$i ) {  ^
                  for ( $j=0; $j -lt $Wide; ++$j ) {  ^
                     Write-Host  -BackgroundColor $Color  -ForegroundColor 'Black'  -NoNewLine  $ln[$i]  ^
                  }  ^
                  ++$coords.Y; $console.CursorPosition = $coords;  ^
               }  ^
            } else {  ^
               for ( $i=0; $i -lt $lnN; ++$i ) {  ^
                  Write-Host  ('='*($Wide*$lnN));  ^
                  ++$coords.Y; $console.CursorPosition = $coords;  ^
               }  ^
            }  ^
         } else { if ( $Color ) {  ^
            for ( $i=0; $i -lt $lnN; ++$i ) {  ^
               for ( $j=0; $j -lt $Color.Length; ++$j ) {  ^
                  $colr = [int]('0x'+$Color[$j]);  ^
                  Write-Host  -BackgroundColor $colr  -ForegroundColor 'Black'  -NoNewLine  $ln[$i]  ^
               }  ^
               ++$coords.Y; $console.CursorPosition = $coords;  ^
            }  ^
         }}  ^
      }}  ^
   }  ^
   $console.CursorSize = $curSize;
%End PowerShell%
exit /B



:Main

(
   for /F "delims==" %%v in ('set') do set "%%v="
   set /A cols=%cols%, lines=%lines%
)

rem Initialize the Field
for /L %%i in (1,1,%cols%) do set "spc=!spc!0"
for /L %%i in (1,1,%lines%) do set "F%%i=³%spc%³"
set /A "Level=1, Rows=0, Score=0,  top=lines+3, delay=50"

rem The pieces are defined via 3 groups of values:  Piece : Color : Orientations
rem The ":orientations:" (piece positions) are defined via "triplets":
rem (offset Y . offset X . length X); one "triplet" for each horizontal line
rem See: http://colinfahey.com/tetris/tetris.html
set "pcs="
for %%t in ( "O:9:0.-1.2 -1.-1.2"
             "I:C:0.-2.4:1.0.1 0.0.1 -1.0.1 -2.0.1"
             "S:A:0.0.2 -1.-1.2:1.0.1 0.0.2 -1.1.1"
             "Z:B:0.-1.2 -1.0.2:1.1.1 0.0.2 -1.0.1"
             "L:D:0.-1.3 -1.-1.1:1.0.1 0.0.1 -1.0.2:1.1.1 0.-1.3:1.-1.2 0.0.1 -1.0.1"
             "J:7:0.-1.3 -1.1.1:1.0.2 0.0.1 -1.0.1:1.-1.1 0.-1.3:1.0.1 0.0.1 -1.-1.2"
             "T:E:0.-1.3 -1.0.1:1.0.1 0.0.2 -1.0.1:1.0.1 0.-1.3:1.0.1 0.-1.2 -1.0.1" ) do (
   set "pc=%%~t" & set "i=-2"
   for /F "delims=" %%p in (^"!pc::^=^
% New line %
!^") do (
      if !i! equ -2 (
         set "pc=%%p" & set "pcs=!pcs!%%p"
      ) else if !i! equ -1 (
         set "!pc!R=%%p"
      ) else (
         set "!pc!!i!=%%p"
      )
      set /A i+=1
   )
   set "!pc!N=!i!"
)

:WaitPS for PowerShell Input part start signal
   set /P "com="
if not defined com goto WaitPS
set "com="

set "init=1"
for /L %%# in () do (

   if defined init (
      setlocal EnableDelayedExpansion
      set "init="
      echo cls

      rem Create the first "previous" -hidden- piece
      for /L %%i in (0,1,!time:~-1!) do set /A p=!random!%%7
      for %%p in (!p!) do set "p2=!pcs:~%%p,1!"
      for %%p in (!p2!) do set "p3=!%%p0!" & set "p4=!%%pN!" & set "p5=!%%pR!!%%pR!!%%pR!!%%pR!"

      set "new=1"
   )

   if defined new (
      set "new="

      rem Take the "previous" piece as current one
      set "pc=!p2!" & set "p0=!p3!" & set "pN=!p4!" & set "pR=!p5!"

      rem Create a new "previous" piece
      for /L %%i in (1,1,2) do (
         set /A p=!random!*7/32768
         for %%p in (!p!) do (
            set "p=!pcs:~%%p,1!"
            if !p! neq !pc! set "p2=!p!"
         )
      )
      for %%p in (!p2!) do set "p3=!%%p0!" & set "p4=!%%pN!" & set "p5=!%%pR!!%%pR!!%%pR!!%%pR!"

      rem Show the new "previous" piece in its place, above Field
      set /A x=cols/2-1
      for %%p in (!p3!) do (
         for /F "tokens=1-3 delims=." %%i in ("%%p") do (
            set /A yp=top+%%i, xp=2+%%j, xL=xp+%%k
            for /F "tokens=1,2" %%a in ("!xp! !xL!") do (
               set "pce=0000"
               set "pce=!pce:~0,%%a!!p5:~0,%%k!!pce:~%%b!"
               echo !x!,!yp!,!pce!
            )
         )
      )
      if !p2! equ I set /A yp=top-1 & echo !x!,!yp!,0000

      rem Try to insert the new current piece in the Field...
      set /A x=cols/2+1, y=lines,   b=1
      for %%p in (!p0!) do (
         for /F "tokens=1-3 delims=." %%i in ("%%p") do (
            set /A yp=y+%%i, xp=x+%%j, xL=xp+%%k
            for /F "tokens=1-3" %%a in ("!yp! !xp! !xL!") do (
               if "!F%%a:~%%b,%%k!" neq "!spc:~0,%%k!" set     "b="
               set "F%%a=!F%%a:~0,%%b!!pR:~0,%%k!!F%%a:~%%c!"
               echo %%b,%%a,!F%%a:~%%b,1!,%%k
            )
         )
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
      if "!pause!" equ "1" call :Pause & set "move="
      set "b=1!time:~-2!"
   ) else (
      set /A "e=1!time:~-2!, elap=e-b, elap-=(elap>>31)*100"
      if !elap! geq !del! set /A b=e, Dy=move=-1
   )

   if defined move (

      rem Delete the piece from its current position in the field, and store current coordinates
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

         rem Clear the piece from its current position, on the screen
         for /L %%i in (1,1,!i!) do (
            for /F "tokens=1-4" %%a in ("!c%%i!") do (
               echo %%b,%%a,!F%%a:~%%b,1!,%%d
            )
         )

         rem Place the piece at the new position, both in field and screen
         for /L %%j in (1,1,!j!) do (
            for /F "tokens=1-4" %%a in ("!n%%j!") do (
               set "F%%a=!F%%a:~0,%%b!!pR:~0,%%d!!F%%a:~%%c!"
               echo %%b,%%a,!F%%a:~%%b,1!,%%d
            )
         )

         rem Update any changes in the piece
         set /A y+=Dy, x+=Dx
         if defined R set "p0=!p1!" & set "pI=!p!" & set "R="

      ) else (   rem The piece can not be moved

         rem Recover the piece at its current position, in the field
         for /L %%i in (1,1,!i!) do (
            for /F "tokens=1-4" %%a in ("!c%%i!") do (
               set "F%%a=!F%%a:~0,%%b!!pR:~0,%%d!!F%%a:~%%c!"
            )
         )
         if defined R set "p1=!p0!" & set "R="

         if !Dy! neq 0 (   rem The piece "lands"

            rem Check completed lines
            set "j=" & set "m=0"
            for /L %%i in (1,1,!i!) do for /F %%a in ("!c%%i!") do (
               if "!F%%a:0=!" equ "!F%%a!" (
                  set "F%%a=X"
                  set "j=!j! %%a"
                  set /A m+=1
               )
            )

            if !m! gtr 0 (

               rem Blink completed lines on screen
               for %%i in (!j!) do (
                  echo 1,%%i,=,%cols%
               )

               rem Update level and scores
               rem See: N-Blox at http://www.tetrisfriends.com/help/tips_appendix.php#rankingsystem
               set /A "xp=Level*(40+((j-2>>31)+1)*60+((j-3>>31)+1)*200+((j-4>>31)+1)*900)"
               set /A "Score+=xp, Rows+=j, xL=Level, Level=(Rows-1)/10+1"
               if !Level! neq !xL! if !delay! gtr 5 set /A delay-=5
               rem BEL Ctrl-G Ascii-7:
               set /P "=" < NUL > CON

               rem Remove completed lines from field
               set "i=1"
               for /L %%i in (1,1,%lines%) do (
                  set "F!i!=!F%%i!"
                  if "!F%%i!" neq "X" set /A i+=1
               )
               for /L %%i in (!i!,1,%lines%) do set "F%%i=³%spc%³"

               rem Update scores and the whole field on screen
               echo 1,-1
               call :Delay 95
               (
               echo Level: !Level!
               echo     Rows: !Rows!
               echo    Score: !Score!
               ) > CON
               echo X > PSbusy.txt
               for /L %%i in (%lines%,-1,1) do echo 1,%%i,!F%%i:~1,-1!
               echo del,PSbusy.txt
               call :WaitPSbusy

            )

            rem Request to show a new piece
            set "new=1"

         )

      )

   )

)


:endGame
echo 1,-4
echo X > PSbusy.txt
echo del,PSbusy.txt
call :WaitPSbusy
set /P "=Play again? " < NUL > CON
:choice
   set /P "com="
if not defined com goto choice
if "%com%" equ "Y" exit /B
if "%com:~0,1%" neq "N" set "com=" & goto choice
echo N > CON
exit


:WaitPSbusy
   if exist PSbusy.txt goto WaitPSbusy
exit /B


:Pause
title PAUSED
:wait
   set /P "com="
   if not defined com goto wait
if "%com%" neq "pause=1" set "com=" & goto wait
set "com="
set "pause="
title Tetris.BAT by Aacini
exit /B


:Delay centisecs
set "b=1%time:~-2%"
:wait2
   set /A "e=1%time:~-2%, elap=e-b, elap-=(elap>>31)*100"
if %elap% lss %1 goto wait2
set "b=1%time:~-2%"
exit /B