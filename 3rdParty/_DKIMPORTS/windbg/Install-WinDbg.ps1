function Install-WinDbg {
    param(
        [switch] $Start
    )

    # Change default progress preference (faster downloads)
    $DefaultProgressPreference = $ProgressPreference
    $ProgressPreference = 'SilentlyContinue'

    Write-Host "Downloading windbg.appinstaller (XML manifest file)"
    $AppInstallerUrl = "https://aka.ms/windbg/download"
    $AppInstallerPath = Join-Path -Path $env:TEMP -ChildPath "windbg.appinstaller"
    Invoke-WebRequest -Uri $AppInstallerUrl -OutFile $AppInstallerPath

    Write-Host "Parsing .appinstaller XML for windbg.msixbundle URL"
    [xml]$AppInstallerXml = Get-Content -Path $AppInstallerPath
    $NamespaceManager = New-Object System.Xml.XmlNamespaceManager($AppInstallerXml.NameTable)
    $NamespaceManager.AddNamespace("ns", "http://schemas.microsoft.com/appx/appinstaller/2018")
    $BundleUrl = $AppInstallerXml.SelectSingleNode("//ns:MainBundle", $NamespaceManager).Uri

    Write-Host "Downloading windbg.msixbundle (actual package file)"
    $MsixBundlePath = Join-Path -Path $env:TEMP -ChildPath "windbg.msixbundle"
    Invoke-WebRequest -Uri $BundleUrl -OutFile $MsixBundlePath
    $ProgressPreference = $DefaultProgressPreference

    Write-Host "Invoking Add-AppxPackage to install windbg.msixbundle"
    if ($PSEdition -eq 'Core') {
        $Command = "Add-AppxPackage -Path `"$MsixBundlePath`""
        Start-Process powershell.exe -ArgumentList "-Command", $Command -Wait
    } else {
        Add-AppxPackage -Path $MsixBundlePath
    }

    Write-Host "WinDbg is now installed!"

    # Start WinDbg if the -Start switch is used
    if ($Start) {
        $WinDbgAppID = (Get-StartApps | Where-Object { $_.Name -eq 'WinDbg' }).AppID
        if ($WinDbgAppID) {
            Write-Host "Launching WinDbg..."
            Start-Process "shell:AppsFolder\$WinDbgAppID"
        } else {
            Write-Warning "WinDbg not found or could not be started."
        }
    }
}

Install-WinDbg -Start