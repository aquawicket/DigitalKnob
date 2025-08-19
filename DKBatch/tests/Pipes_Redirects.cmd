@echo off
    setlocal enableextensions disabledelayedexpansion

    rem Part that reads from console, NOT piped input
    < con (
        set "data="
        set /p "data=Type something: "
    )

    echo(
    echo You have typed: [%data%]
    echo(
	
	pause









