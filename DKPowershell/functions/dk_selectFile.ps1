if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
if(!$dk_selectFile){ $dk_selectFile = 1 } else{ return }

##############################################################################
# dk_selectFile(rtn_var)
# 
#
function Global:dk_selectFile(){
	dk_debugFunc 0
	
	Add-Type -AssemblyName System.Windows.Forms
	$f = new-object Windows.Forms.OpenFileDialog
	$f.InitialDirectory = pwd
	#$f.Filter = "Text Files (*.txt)|*.txt|All Files (*.*)|*.*"
	$f.ShowHelp = $true
	$f.Multiselect = $true
	[void]$f.ShowDialog()
	if ($f.Multiselect) { $f.FileNames } else { $f.FileName }
}













###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() {
	dk_debugFunc 0
	
	dk_call dk_selectFile
	
	dk_call dk_pause
}
