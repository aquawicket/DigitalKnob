::websocketd --devconsole --port=8080 count.cmd
::websocketd --devconsole --port=8080 C:\Users\Administrator\DigitalKnob\Development\DKBatch\functions\DKBuilder\DKBuilder.cmd
websocketd --port=8080 --staticdir=. cmd

if %errorlevel% gtr 0 (
	echo errorlevel = %errorlevel%
	pause
)