$file = "C:\Windows\System32\cleanmgr.exe";
#$bytes = [System.IO.File]::ReadAllBytes("$file") | Format-Hex;
#Write-Host "$($bytes[0][0])";
#Read-Host;




#$bytes = Get-Content "$file" -Encoding byte -TotalCount 16 | Format-Hex;

#Write-Host "$bytes" 


Format-Hex -Path "$file" -TotalCount 48

Read-Host;
