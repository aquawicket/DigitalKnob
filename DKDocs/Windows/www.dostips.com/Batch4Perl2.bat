@rem = 'Perl, ccperl will read this as an array of assignment & skip this block
@CD /d "%~dp0"
@perl -s "%~nx0" %*
@FOR /L %%c in (4,-1,1) do @(TITLE %~nx0 - %%cs to close & ping -n 2 -w 1000 127.0.0.1 >NUL)
@TITLE Press any key to close the window&ECHO.&GOTO:EOF
@rem ';

#perl script starts below here
print 'Hi there!  DOS rocks!\n'
