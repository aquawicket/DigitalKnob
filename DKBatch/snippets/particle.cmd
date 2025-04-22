@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


SETLOCAL ENABLEDELAYEDEXPANSION
FOR /F %%A in ('ECHO prompt $E^| cmd') DO SET "ESC=%%A"
::d = dummy variable, par = particle
SET /A "par[life]=11","par[rate]=2","par[orgcol]=0","par[rmax]=3","par[rmin]=1","orgin[x]=15","orgin[y]=10"
SET "par[fade]=+ 20"
SET "par[col]=255;^!d[col]^!;0"
SET "par[end]=%ESC%[^!d[y]^!;^!d[x]^!H*"
SET par[mov1]="d[x]-=1"
SET par[mov2]="d[y]-=1"
SET par[mov3]="d[x]+=1"
SET par[mov4]="d[y]+=1"
ECHO %ESC%[?25l

FOR /L %%# in () DO (
    <NUL SET /P "=%ESC%[2J%ESC%[38;2;173;71;28m%ESC%[11;11Hлллллллл%ESC%[12;12Hлллллл!par[disp]!"
    FOR /L %%J in (1,40,1000000) DO REM
    SET "par[disp]="
    SET /A "life+=1","d[new]=life%%par[rate]"
    IF !d[new]! EQU 0 (
        SET /A "par[num]+=1","d[life]=life+par[life]"
        SET "par[list]=!par[list]! !par[num]!"
        SET "par[!par[num]!]=!d[life]! !orgin[x]! !orgin[y]! %par[orgcol]%"
    )
    FOR %%Q in (!par[list]!) DO (
        FOR /F "tokens=1-4" %%A in ("!par[%%Q]!") DO (
            SET /A "d[x]=%%B","d[y]=%%C","d[rand]=!RANDOM! * (par[rmax] - par[rmin] + 1) / 32768 + par[rmin]","d[col]=%%D %par[fade]%"
            IF !life! EQU %%A (
                SET "par[disp]=!par[disp]!%par[end]%"
                SET "par[list]=!par[list]:%%Q=!"
            ) else (
                FOR %%R in (!d[rand]!) DO (
                    SET /A !par[mov%%R]!
                )
                SET "par[%%Q]=%%A !d[x]! !d[y]! !d[col]!"
                SET "par[disp]=!par[disp]!%ESC%[!d[y]!;!d[x]!H%ESC%[38;2;%par[col]%mл"
            )
        )
    )
)