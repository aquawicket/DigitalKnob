@ECHO OFF
SETLOCAL ENABLEEXTENSIONS

SETLOCAL DISABLEDELAYEDEXPANSION
echo.delayed expansion is DISABLED
echo.1. ^^! :exclamation mark
echo.2. !! :exclamation mark
echo.3. ! :exclamation mark
echo.4. %% :percent
echo.5. ^& :ampersand
echo.6. ^| :vertical line
echo.7. ^^ :caret
echo.

SETLOCAL ENABLEDELAYEDEXPANSION
echo.delayed expansion is ENABLED
echo.1. ^^! :exclamation mark
echo.2. !! :exclamation mark
echo.3. ! :exclamation mark
echo.4. %% :percent
echo.5. ^& :ampersand
echo.6. ^| :vertical line
echo.7. ^^ :caret
echo.
