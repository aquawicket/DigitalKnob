@echo off
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" | findstr /I /C:"{36EF257E-21D5-44F7-8451-07923A8C465E}" 1>nul && (
	echo Window-Subsystem-For-Linux-Update is installed
) || (
	echo Window-Subsystem-For-Linux-Update is NOT installed
)