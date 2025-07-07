if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_setConsoleIcon_ps1){ $dk_setConsoleIcon_ps1 = 1; } else{ return; } #include guard


################################################################################
# dk_setConsoleIcon()
#
#    Function description
#
#    @arg1	- arg1 description
#
function Global:dk_setConsoleIcon() {
	dk_debugFunc 0 99

	# arg1 = $($args[0]);
	# arg2 = $($args[1]);
	
	$iconFile = "C:\Users\Administrator\Desktop\icon.ico"
	[System.Reflection.Assembly]::LoadWithPartialName('System.Drawing') | Out-Null

	# Verify the file exists
	if ([System.IO.File]::Exists($iconFile) -eq $true) {
		$ch = Invoke-Win32 'kernel32' ([IntPtr]) 'GetConsoleWindow'
		$i = 0;
		$size = 16;
		while ($i -ne 4) {
			$ico = New-Object System.Drawing.Icon($iconFile, $size, $size)
			if ($ico -ne $null) {
				Send-Message $ch 0x80 $i $ico.Handle | Out-Null
			}
			if ($i -eq 4) {
				break
			}
			$i += 1
			$size += 16
		}
	}
  else {
    Write-Host 'Icon file not found' -ForegroundColor 'Red'
  }
}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
	dk_call dk_setConsoleIcon "C:\Users\Administrator\Desktop\icon.ico"
}
