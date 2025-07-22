if(${env:DKPOWERSHELL_FUNCTIONS_DIR}){ . ${env:DKPOWERSHELL_FUNCTIONS_DIR}/DK.ps1; } else { . ${PSScriptRoot}/DK.ps1; }
if(!$dk_dirname_ps1){ $dk_dirname_ps1 = 1; } else{ return; } #include guard

################################################################################
# dk_dirname(path)
#
#
function Global:dk_dirname() {
	dk_debugFunc 1;
	
	${path} = $($args[0]); 
	#$dirname = (Get-Item $path).DirectoryName;
	#$dirname = (Resolve-Path -Path "$path" -ErrorAction SilentlyContinue -ErrorVariable _frperror).DirectoryName;    #Calls Resolve-Path but works for files that don't exist.
	#if(-not($dirname)){ $dirname = $_frperror[0].TargetObject; } # http://devhawk.net/blog/2010/1/22/fixing-powershells-busted-resolve-path-cmdlet
	${dk_dirname} = Split-Path ${path} -Parent;
	return ${dk_dirname};
}










###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0;
	
	${dk_dirname} = dk_call dk_dirname "C:/Windows/System32";
	dk_call dk_echo "dk_dirname = $dk_dirname\n";
	
	${dk_dirname} = dk_call dk_dirname "Test1/Test2";
	dk_call dk_echo "dk_dirname = $dk_dirname\n";
}
