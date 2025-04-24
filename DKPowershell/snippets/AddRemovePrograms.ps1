# Open the Add/Remove Programs dialog
# https://www.robvanderwoude.com/powershellsnippets.php#AddRemoveProgramsDialog
# Source: "Shell folders: the best-kept Windows time saving secret" by Mike Williams
# https://www.techradar.com/news/computing/pc/shell-folders-the-best-kept-windows-time-saving-secret-464668
Start-Process shell:ChangeRemoveProgramsFolder

# or:

Start-Process shell:::{26EE0668-A00A-44D7-9371-BEB064C98683}\0\::{7b81be6a-ce2b-4676-a29e-eb907a5126c5}
