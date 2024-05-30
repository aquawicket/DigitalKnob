if (!$DKINIT){ . $PWD\DK.ps1 }
if (!$dk_validateGit){ $dk_validateGit = 1 } else{ return }

dk_load dk_validate
dk_load dk_getFilename
dk_load dk_error
dk_load dk_convertToCIdentifier
dk_load dk_toLower
dk_load dk_removeExtension
dk_load dk_convertToCIdentifier
dk_load dk_toLower
dk_load dk_fileExists
####################################################################
# dk_validateGit()
#
#
function Global:dk_validateGit () {
	dk_debugFunc
	if ( $(__ARGC__) -ne 0 ){ dk_error "$(__FUNCTION__)($(__ARGC__)): incorrect number of arguments" }
	
	$GIT_DL_WIN_X86    = "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-32-bit.7z.exe"
	$GIT_DL_WIN_X86_64 = "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe"

	dk_validate HOST_ARCH dk_getHostTriple
    if ($HOST_ARCH -eq "arm32") { $GIT_DL = "" }
    if ($HOST_ARCH -eq "arm64") { $GIT_DL = $GIT_DL_WIN_ARM64 }
    if ($HOST_ARCH -eq "x86")   { $GIT_DL = $GIT_DL_WIN_X86 }
    if ($HOST_ARCH -eq "x86_64"){ $GIT_DL = $GIT_DL_WIN_X86_64 }
    if(!$GIT_DL){ dk_error "GIT_DL is invalid" }
	  
    $GIT_DL_FILE = dk_getFilename $GIT_DL
	$GIT_DL_NAME = dk_removeExtension $GIT_DL_FILE
    $GIT_FOLDER = dk_convertToCIdentifier $GIT_DL_NAME 
    $GIT_FOLDER = dk_toLower $GIT_FOLDER GIT_FOLDER
	dk_validate DKTOOLS_DIR dk_getDKPaths
    $GIT_EXE = "$DKTOOLS_DIR\$GIT_FOLDER\bin\git.exe"
        
    if(dk_fileExists $GIT_EXE){ return }
        
    dk_info ""  
    dk_info "Installing git . . ."
    dk_download $GIT_DL $DKDOWNLOAD_DIR\$GIT_DL_FILE
    #echo "$DKDOWNLOAD_DIR\$GIT_DL_FILE" /DIR=$DKTOOLS_DIR\$GIT_FOLDER
    #"$DKDOWNLOAD_DIR\$GIT_DL_FILE" /DIR="$DKTOOLS_DIR\$GIT_FOLDER" /VERYSILENT
	dk_info "$DKDOWNLOAD_DIR\$GIT_DL_FILE -y -o $DKTOOLS_DIR\$GIT_FOLDER"
    "$DKDOWNLOAD_DIR\$GIT_DL_FILE -y -o $DKTOOLS_DIR\$GIT_FOLDER"
	   
    if(!dk_fileExists $GIT_EXE){ dk_error "cannot find git" }
        
    dk_checkError
}



function Global:DKTEST () { ########################################################################
	
    dk_validateGit
}