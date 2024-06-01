# https://learn.microsoft.com/en-us/powershell/scripting/install/install-debian?view=powershell-7.4

# Prerequisites
sudo apt-get update 																						# Update the list of packages
sudo apt-get install -y wget																				# Install pre-requisite packages.
wget https://github.com/PowerShell/PowerShell/releases/download/v7.2.19/powershell_7.2.19-1.deb_amd64.deb	# Download the PowerShell package file

sudo dpkg -i powershell_7.4.2-1.deb_amd64.deb 																# Install the PowerShell package
sudo apt-get install -f																						# Resolve missing dependencies and finish the install (if necessary)
rm powershell_7.4.2-1.deb_amd64.deb  																		# Delete the downloaded package file
pwsh																										# Start PowerShell
