if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_startPackage){ $dk_startPackage = 1 } else{ return }

##################################################################################
# dk_startPackage()
#
#    https://superuser.com/a/1678974/600216
#
function Global:dk_startPackage (){
	dk_debugFunc 0

	$name = "$($args[0])"
	Write-Output "name = ${name}"
	
	Get-AppxPackage | ForEach-Object {
	  $packageFamilyName = $_.PackageFamilyName
	  $packageManifest = Get-AppxPackageManifest $_
	  $displayName = $packageManifest.Package.Properties.DisplayName
	  $appId = $packageManifest.Package.Applications.Application.Id
 
		if(${name} -eq ${displayName}){
			Write-Output "${displayName}: ${packageFamilyName}!${appId}"
			$exec = "shell:AppsFolder\${packageFamilyName}!${appId}"
			Write-Output "exec = ${exec}"
			
			start-process ${exec}
		}
	}
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_startPackage Debian
}
