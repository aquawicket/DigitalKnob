@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


:: https://www.avatarapi.com
%CURL_EXE% --location --request POST https://avatarapi.com/v2/api.aspx --data-raw "{'username':'aquawicket','password':'Triad2393!!','email':'lusiverain@gmail.com'}"
