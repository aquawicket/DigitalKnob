if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1 } else { . '${PSScriptRoot}/DK.ps1' }
if(!$dk_mousePosition_ps1){ $dk_mousePosition_ps1 = 1; } else{ return; } #include guard

function Global:dk_mousePosition(){

	Add-Type -AssemblyName System.Windows.Forms;
	
	###### SET ######
	if($($args[0]) -AND $($args[1])){
		${global:dk_mousePosition.x} = $($args[0]);
		${global:dk_mousePosition.y} = $($args[1]);
		[System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point(${dk_mousePosition.x}, ${dk_mousePosition.y});
	}
	###### GET ######
	else{
		${global:dk_mousePosition.x} = [System.Windows.Forms.Cursor]::Position.X;
		${global:dk_mousePosition.y} = [System.Windows.Forms.Cursor]::Position.Y;
	}
}













function Global:DKTEST(){
	
	### Get ###
	echo "";
	echo "Getting mouse position";
	dk_mousePosition;
	echo "dk_mousePosition.x = ${dk_mousePosition.x}";
	echo "dk_mousePosition.y = ${dk_mousePosition.y}";
	
	
	### Set ###
	echo "";
	echo "Setting mouse position (10, 10)";
	dk_mousePosition 10 10;
}