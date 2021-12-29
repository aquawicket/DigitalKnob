:: Using colors in batch files
:: 0 = black	
:: 1 = navy	
:: 2 = green	
:: 3 = teal	
:: 4 = maroon	
:: 5 = purple	
:: 6 = olive	
:: 7 = silver	
:: 8 = gray
:: 9 = blue
:: A = lime
:: B = aqua
:: C = red
:: D = fuchsia
:: E = yellow
:: F = white

:: Color <background><foreground>  
:: Example: Color 0c    "black backgroung with red text"
@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

cls
Color 72
echo green on silver

pause
