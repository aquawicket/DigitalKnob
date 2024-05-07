Write-Output "Loading DigitalKnob . . ."

$CallStack = Get-PSCallStack
Write-Output "CallStack = $CallStack"

$MainCall = $CallStack[$CallStack.Count - 2];
$DKSCRIPT_PATH = $MainCall.ScriptName
Write-Output "DKSCRIPT_PATH = $DKSCRIPT_PATH"

$DKSCRIPT_DIR = Split-Path -Parent $DKSCRIPT_PATH
Write-Output "DKSCRIPT_DIR = $DKSCRIPT_DIR"

$DKSCRIPT_NAME = Split-Path -Leaf $DKSCRIPT_PATH
Write-Output "DKSCRIPT_NAME = $DKSCRIPT_NAME"

$DKPOWERSHELL_FUNCTIONS_DIR = Split-Path -Parent $PSCommandPath
Write-Output "DKPOWERSHELL_FUNCTIONS_DIR = $DKPOWERSHELL_FUNCTIONS_DIR"

$DKPOWERSHELL_DIR = Split-Path -Parent $DKPOWERSHELL_FUNCTIONS_DIR
Write-Output "DKPOWERSHELL_DIR = $DKPOWERSHELL_DIR"

#Import-Module ./dk_download.ps1
#$GIT_DL = "https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/PortableGit-2.44.0-64-bit.7z.exe"
#$DEST = "$CurrentDirectory\PortableGit-2.44.0-64-bit.7z.exe"
#dk_download $GIT_DL $DEST

