:: use this one on commmand lines
:: for /f "delims=" %d in ('dir /s /b /ad ^| sort /r') do rd "%d"

for /f "delims=" %%d in ('dir /s /b /ad ^| sort /r') do rd "%%d"