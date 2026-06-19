@echo off
start "" /wait %SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe "Get-AppxPackage -AllUsers -PackageTypeFilter Bundle -Name "Microsoft.WidgetsPlatformRuntime" | Remove-AppxPackage -AllUsers"
start "" /wait %SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe "Get-AppxPackage -AllUsers -PackageTypeFilter Bundle -Name "MicrosoftWindows.Client.WebExperience" | Remove-AppxPackage -AllUsers"

reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "TaskbarDa" /t REG_DWORD /d "0" /f
reg add "HKCU\Software\Microsoft\PolicyManager\default\NewsAndInterests\AllowNewsAndInterests" /v "value" /t REG_DWORD /d "0" /f
reg add "HKLM\Software\Policies\Microsoft\Dsh" /v "AllowNewsAndInterests" /t REG_DWORD /d "0" /f