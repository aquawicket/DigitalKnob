@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# dk_installPackage()
::#
::#
:dk_installPackage
%setlocal%
	%dk_call% dk_debugFunc 0
	%dk_call% dk_debug "dk_installPackage[%*]"
	
::  [ -n "$(command -v "${1}")" ] && return    #
::  #if dk_call dk_packageInstalled ${1}; then
::	dk_call dk_warning "${1} already installed"
::	return $(false);
::   fi
::  
::   dk_call dk_info "installing ${1}. . ."
::   # https://en.wikipedia.org/wiki/List_of_software_package_management_systems
::   # https://en.wikipedia.org/wiki/Package_manager
::   # https://www.digitalocean.com/community/tutorials/package-management-basics-apt-yum-dnf-pkg
::  
::   if dk_call dk_commandExists apk; then
::   	dk_call apk add "${1}"					# Alpine Package Keeper (alpine linux)
::   elif dk_call dk_commandExists apt-get; then
::   	dk_call apt-get -y install "${1}"		# Apt-get (debian)
::   elif dk_call dk_commandExists apt; then	
::   	dk_call apt -y install "${1}"			# Apt (debian)
::   elif dk_call dk_commandExists brew; then	
::   	dk_call brew install "${1}"				# Homebrew (MacOS)
::   elif dk_call dk_commandExists dnf; then
::   	dk_call dnf install "${1}"				# Dnf (yum)
::   elif dk_call dk_commandExists emerge; then	
::   	dk_call emerge "${1}"					# Portage
::   elif dk_call dk_commandExists nix-env; then	
::   	dk_call nix-env -i "${1}"				# Nix
::   elif dk_call dk_commandExists ohpm; then	
::   	dk_call ohpm install "${1}"				# Ohpm
::   elif dk_call dk_commandExists pkg; then
::   	dk_call pkg install "${1}"				# Termux
::   elif dk_call dk_commandExists pacman; then
::   	dk_call pacman -S "${1}" --noconfirm	# Pacman
::   elif dk_call dk_commandExists swupd; then
::   	dk_call swupd bundle-add "${1}"			# Swupd
::   elif dk_call dk_commandExists tce-load; then
::   	dk_call tce-load -wil "${1}"     		# Tiny core linux
::   elif dk_call dk_commandExists winget; then
::   	dk_call dk_call winget install "${1}"	# WinGet
::   elif dk_call dk_commandExists xbps-install; then
::   	dk_call xbps-install "${1}"				# Xbps
::   elif dk_call dk_commandExists zypper; then
::   	dk_call zypper in "${1}"				# Zypper
::   else
::   	dk_call dk_error "ERROR: no package managers found"
::   fi
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

    %dk_call% dk_installPackage zlib
%endfunction%