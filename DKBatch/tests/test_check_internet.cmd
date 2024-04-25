@ECHO OFF
REM Create temporary batch file
ECHO @ECHO OFF> REPLY.BAT
ECHO SET connect=1>>REPLY.BAT
ECHO Checking connection, please wait...
ECHO @ECHO OFF> CHKCONN.BAT
PING 194.109.6.66 | FIND "Reply from " >>CHKCONN.BAT
REM Set "default" value, which may or may not be altered by CHKCONN.BAT
SET connect=0
CALL CHKCONN.BAT
DEL CHKCONN.BAT
DEL REPLY.BAT
IF "%connect%"=="0" ECHO You have NO active connection to the internet
IF "%connect%"=="1" ECHO You have an active connection to the internet