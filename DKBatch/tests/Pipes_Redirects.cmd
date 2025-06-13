@echo off
    setlocal enableextensions disabledelayedexpansion

    rem Part that reads from console, not piped input
    < con (
        set "data="
        set /p "data=Type something: "
    )

    echo(
    echo You have typed: [%data%]
    echo(
	
	pause









