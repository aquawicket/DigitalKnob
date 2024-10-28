if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_getPackagePath){ $dk_getPackagePath = 1 } else{ return }

##################################################################################
# dk_getPackagePath()
#
#    https://superuser.com/a/1678974/600216
#
function Global:dk_getPackagePath (){
	dk_debugFunc 0

	$name = "$($args[0])"
	#Write-Output "name = ${name}"
	
	Get-AppxPackage | ForEach-Object {
	  $packageFamilyName = $_.PackageFamilyName
	  $packageManifest = Get-AppxPackageManifest $_
	  $displayName = $packageManifest.Package.Properties.DisplayName
	  $appId = $packageManifest.Package.Applications.Application.Id
 
		if(${name} -eq ${displayName}){
			#Write-Output "${displayName}: ${packageFamilyName}!${appId}"
			$exec = "shell:AppsFolder\${packageFamilyName}!${appId}"
			#Write-Output "exec = ${exec}"
			
			return ${exec}
		}
	}
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	$packagePath=dk_getPackagePath("Debian")
	Write-Output "packagePath = ${packagePath}"
}
