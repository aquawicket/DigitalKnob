@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

%dk_call% dk_validate DK3RDPARTY_DIR "dk_DKBRANCH_DIR"
del %DK3RDPARTY_DIR%\sdl-release-2.26.0 /F /S /Q