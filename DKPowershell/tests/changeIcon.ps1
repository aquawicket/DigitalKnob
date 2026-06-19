# Set the icon of the current console window to the specified icon.
#
# AUTHOR:    Aaron Lerch <http://www.aaronlerch.com/blog>
# COPYRIGHT: © 2009 Aaron Lerch
# LINK:      http://gallery.technet.microsoft.com/scriptcenter/9d476461-899f-4c98-9d63-03b99596c2c3
#
# PARAM:
#   -IconFile
#     Absolute path to the icon file.
# RETURN:
#   $null
#function Set-ConsoleIcon {
  #Param(
   # [parameter(Mandatory = $true)] [string] $IconFile
  #)
	
	$IconFile = "C:\Users\Administrator\Desktop\icon.ico"
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
#}