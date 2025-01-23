# Get the script's own (full) command line
# https://www.robvanderwoude.com/powershellsnippets.php#GetOwnCommandLine
[System.Environment]::CommandLine # single string including powershell executable and script name
[System.Environment]::GetCommandLineArgs( ) # array of strings including powershell executable and script name
$Args # array of strings, script arguments only
