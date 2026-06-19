@echo off
:: ######################################################
:: ## Heredoc syntax:                                  ##
:: ## call :heredoc uniqueIDX [>outfile] && goto label ##
:: ## contents                                         ##
:: ## contents                                         ##
:: ## contents                                         ##
:: ## etc.                                             ##
:: ## :label                                           ##
:: ##                                                  ##
:: ## Notes:                                           ##
:: ## Variables to be evaluated within the heredoc     ##
:: ## should be called in the delayed expansion style  ##
:: ## (!var! rather than %var%, for instance).         ##
:: ##                                                  ##
:: ## Literal exclamation marks (!) and carats (^)     ##
:: ## must be escaped with a carat (^).                ##
:: ######################################################



:--------------------------------------------
: calling heredoc with results sent to stdout
:--------------------------------------------

call :heredoc stickman && goto next1

\o/
 | This is the "stickman" heredoc, echoed to stdout.
/ \
:next1



:-----------------------------------------------------------------
: calling heredoc containing vars with results sent to a text file
:-----------------------------------------------------------------

set bodyText=Hello world!
set lipsum=Lorem ipsum dolor sit amet, consectetur adipiscing elit.

call :heredoc html >out.txt && goto next2
<html lang="en">
    <body>
        <h3>!bodyText!</h3>
        <p>!lipsum!</p>
    </body>
</html>

Thus endeth the heredoc.  :)
:next2



echo;
echo Does the redirect to a file work?  Press any key to type out.txt and find out.
echo;

pause>NUL
type out.txt
rem del out.txt

:: End of main script
pause
goto :EOF

:: ########################################
:: ## Here's the heredoc processing code ##
:: ########################################
:heredoc <uniqueIDX>
setlocal enabledelayedexpansion
set go=
for /f "delims=" %%A in ('findstr /n "^" "%~f0"') do (
    set "line=%%A" && set "line=!line:*:=!"
    if defined go (if #!line:~1!==#!go::=! (goto :EOF) else echo(!line!)
    if "!line:~0,13!"=="call :heredoc" (
        for /f "tokens=3 delims=>^ " %%i in ("!line!") do (
            if #%%i==#%1 (
                for /f "tokens=2 delims=&" %%I in ("!line!") do (
                    for /f "tokens=2" %%x in ("%%I") do set "go=%%x"
                )
            )
        )
    )
)
goto :EOF