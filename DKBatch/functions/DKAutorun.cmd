@rem shebang
@echo off
if not defined cmdlvl (
	set /a "cmdlvl=1"
) else (
	set /a "cmdlvl=%cmdlvl%+1"
)

