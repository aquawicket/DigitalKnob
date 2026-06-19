@rem shebang
rem set "Remove_Autorun=0"
if "%Remove_Autorun%" equ "1" (
	rem ### Remove AutoRun
	reg delete "HKCU\Software\Microsoft\Command Processor" /v AutoRun

) else ( 
	rem ### Create AutoRun
	reg add "HKCU\Software\Microsoft\Command Processor" /v AutoRun /t REG_EXPAND_SZ /d "C:\Users\Administrator\DigitalKnob\Development\DKBatch\functions\DKAutorun.cmd" /f
)


