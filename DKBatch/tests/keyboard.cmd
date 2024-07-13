@setlocal enableextensions enabledelayedexpansion
@echo off
set length=
for %%a in (1 2 3) do (
set "length=!length!                                                                                "
)
:controls
  cls
  echo Use WASD to move your character ([]).
  echo:
  echo %length%[]
  choice /c wasd /n
  if %errorlevel% equ 1 call:up
  if %errorlevel% equ 2 call:left
  if %errorlevel% equ 3 call:down
  if %errorlevel% equ 4 call:right

:left
  set length=!length:~0,-1!
  goto controls

:right
  set "length= %length%"
  goto controls

:up
  set length=!length:~0,-80!
  goto controls

:down
  set "length=                                                                                %length%"
  goto controls