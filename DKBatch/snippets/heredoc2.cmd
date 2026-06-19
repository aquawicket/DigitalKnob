@echo off
 for /f "delims=:" %%a in (
     'findstr -n "^___" %0') do set "Line=%%a"

 (for /f "skip=%Line% tokens=* eol=_" %%a in (
       'type %0') do echo(%%a) > out.html
:: out.html
pause
goto: EOF



___DATA___
<!Doctype html>
<html>
  <head>
   title></title>
  </head>
  <body>
    <svg width="900" height="600">
        <text x="230" 
              y="150"
              font-size="100"
              fill="blue"
              stroke="gray"
              stroke-width="1">
                  Hello World              
        </text>
    </svg>
  </body>
</html>