@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


:: https://www.avatarapi.com
curl --location --request POST https://avatarapi.com/v2/api.aspx --data-raw "{'username':'aquawicket','password':'Triad2393!!','email':'lusiverain@gmail.com'}"
