if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
#TODO #include guard

##################################################################################
# dk_listPackages()
#
#    https://superuser.com/a/1678974/600216
#
function Global:dk_listPackages (){
	dk_debugFunc 0

	Get-AppxPackage | ForEach-Object {
	  $packageFamilyName = $_.PackageFamilyName
	  $packageManifest = Get-AppxPackageManifest $_
	  $displayName = $packageManifest.Package.Properties.DisplayName
	  $appId = $packageManifest.Package.Applications.Application.Id

	  Write-Output "${displayName}: ${packageFamilyName}!${appId}"
	}
}





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_listPackages
}
