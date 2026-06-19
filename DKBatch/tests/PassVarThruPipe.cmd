@echo off
setlocal enableDelayedExpansion 
:: Passing variables between commands in a batch script using pipes requires a slightly different approach than directly assigning the output. 
:: The set /p command is commonly used to capture input from a pipe. However, it's crucial to understand how set /p and pipes interact to avoid common pitfalls.
:: To pass a variable using pipes:
:: Echo the variable: Use echo to send the variable's value to the standard output.
:: Capture with set /p: Use set /p variable_name= to read the output from the pipe and assign it to the specified variable.


set myVarA=origin
echo Hello | (set /p myVarB=)
echo myVarB = %myVarB%
pause

:: In this example, the value of my_variable is echoed and then captured by set /p into received_variable. 
:: The key is that set /p reads a line from standard input, making it suitable for receiving data from a pipe.
:: When dealing with multiple variables or multi-line output, it's important to consider that set /p reads only one line at a time. 
:: For more complex scenarios, temporary files or more advanced scripting techniques may be necessary.