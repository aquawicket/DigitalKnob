@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

del %DK3RDPARTY_DIR%\sdl-release-2.26.0 /F /S /Q