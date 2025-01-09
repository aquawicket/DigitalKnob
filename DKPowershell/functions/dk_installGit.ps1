if( $env:DKPOWERSHELL_FUNCTIONS_DIR ){ . $env:DKPOWERSHELL_FUNCTIONS_DIR\DK.ps1 } else { . '.\DK.ps1' }
#TODO #include guard

####################################################################
# dk_installGit()
#
#
function Global:dk_installGit() {
	dk_debugFunc 0
	
	$GIT_DL_WIN_X86    = "https://github.com/git-for-windows/git/releases/download/v2.46.2.windows.1/PortableGit-2.46.2-32-bit.7z.exe"
	$GIT_DL_WIN_X86_64 = "https://github.com/git-for-windows/git/releases/download/v2.46.2.windows.1/PortableGit-2.46.2-64-bit.7z.exe"

	dk_call dk_validate "HOST_ARCH" "dk_call dk_host_triple"
    if($HOST_ARCH -eq "arm32") { ${GIT_DL} = "" }
    if($HOST_ARCH -eq "arm64") { ${GIT_DL} = $GIT_DL_WIN_ARM64 }
    if($HOST_ARCH -eq "x86")   { ${GIT_DL} = $GIT_DL_WIN_X86 }
    if($HOST_ARCH -eq "x86_64"){ ${GIT_DL} = $GIT_DL_WIN_X86_64 }
    if(!$GIT_DL){ dk_call dk_error "GIT_DL is invalid"; return ${false} }
	  
    $GIT_DL_FILE = dk_call dk_basename ${GIT_DL}
	$GIT_FOLDER = dk_call dk_removeExtension $GIT_DL_FILE
	$GIT_FOLDER = dk_call dk_removeExtension $GIT_FOLDER
    #$GIT_FOLDER = dk_call dk_convertToCIdentifier $GIT_FOLDER 
    #$GIT_FOLDER = dk_call dk_toLower $GIT_FOLDER
	dk_call dk_validate DKTOOLS_DIR "dk_call dk_DKTOOLS_DIR"
	
	
	### DO NOT USE GIT_DIR ###
	$global:GIT = "$DKTOOLS_DIR/$GIT_FOLDER"
	
    $global:GIT_EXE = "$GIT/bin/git.exe"
	$global:BASH_EXE = "$GIT/bin/bash.exe"
	$global:GITBASH_EXE = "$GIT/git-bash.exe"
	$global:PATCH_EXE = "$GIT/usr/bin/patch.exe"

        
    if(dk_call dk_pathExists $GIT_EXE){ return }
        
    dk_call dk_info ""  
    dk_call dk_info "Installing git . . ."
	dk_call dk_validate DKDOWNLOAD_DIR "dk_call dk_DKDOWNLOAD_DIR"
    dk_call dk_download ${GIT_DL} $DKDOWNLOAD_DIR/$GIT_DL_FILE
	dk_call dk_info "$DKDOWNLOAD_DIR/$GIT_DL_FILE -y -o $GIT"
    dk_call $ENV{COMSPEC} /c "$DKDOWNLOAD_DIR/$GIT_DL_FILE" -y -o $GIT
	   
    if(!(dk_call dk_pathExists $GIT_EXE)){ dk_call dk_error "cannot find git" }
}







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST #####
function Global:DKTEST() { 
	dk_debugFunc 0
	
    dk_call dk_installGit
}
