#!/bin/bash

# to run this script requires privledges
# > chmod 777 build.sh

# https://blog.opstree.com/2020/02/11/shell-initialization-files/
# https://www.tecmint.com/understanding-shell-initialization-files-and-user-profiles-linux/

clear

##################################
#	Functions
#################################

message() {
	echo "$@"
}

### file_exists [file.ext]
file_exists() {
	#echo "file_exists($1)"
	[ -e $1 ]
}

file_contains() {
	grep -q "$1" "$2"
}

### append_file ["string"] [file.ext]
append_file() {
	#echo "append_file($1, $2)"
	echo "$1" >> $2
	#echo "appended \"$1\" to $2s"
}

### remove_from_file [string] [file.ext]
remove_from_file() {
	sed -i -e "/$1/d" $2
}

get_dk_host() {
	DK_HOST=$(uname -s)
	echo "DK_HOST = $DK_HOST"
}

get_dk_arch() {
	DK_ARCH=$(uname -m)
	echo "DK_ARCH = $DK_ARCH"
}

get_dk_version() {
	DK_VERSION=$(uname -v)
	echo "DK_VERSION = $DK_VERSION"
}

get_dk_ostype() {
	DK_OSTYPE=$OSTYPE
	echo "DK_OSTYPE = $DK_OSTYPE"
}

get_dk_model() {
	if [ -e /proc/device-tree/model ]; then
		DK_MODEL=$(tr -d '\0' </proc/device-tree/model)
	fi
	echo "DK_MODEL = $DK_MODEL"
}

get_dk_machtype() {
	DK_MACHTYPE=$MACHTYPE
	echo "DK_MACHTYPE = $DK_MACHTYPE"
}

get_dk_lang() {
	DK_LANG=$LANG
	echo "DK_LANG = $DK_LANG"
}

get_dk_username() {
	if [[ -n "$USER" ]]; then
		DK_USERNAME=$USER
	elif [[ -n "$USERNAME" ]]; then
		DK_USERNAME=$USERNAME
	fi
	echo "DK_USERNAME = $DK_USERNAME"
}

get_dk_logname() {
	DK_LOGNAME=$LOGNAME
	echo "DK_LOGNAME = $DK_LOGNAME"
}

get_dk_home() {
	DK_HOME=$HOME
	echo "DK_HOME = $DK_HOME"
}

get_dk_prefix() {
	DK_PREFIX=$PREFIX
	echo "DK_PREFIX = $DK_PREFIX"
}

get_dk_term() {
	DK_TERM=$TERM
	echo "DK_TERM = $DK_TERM"
}

get_dk_shell() {
	DK_SHELL=$SHELL
	echo "DK_SHELL = $DK_SHELL"
}

get_dk_path() {
	DK_PATH=$PATH
	echo "DK_PATH = $DK_PATH"
}

get_dk_pwd() {
	DK_PWD=$PWD
	echo "DK_PWD = $DK_PWD"
}

reload_environment() {
	if file_exists ~/.profile; then
		source ~/.profile
	fi
	if file_exists ~/.bash_profile; then
		source ~/.bash_profile
	fi
	if file_exists ~/.bash_login; then
		source ~/.bash_login
	fi
	if file_exists ~/.bashrc; then
		source ~/.bashrc
	fi
	if file_exists ~/.zshenv; then
		source ~/.zshenv
	fi
}

### set_dk_root [path/to/digitalknob]
set_dk_root(){
	#echo "set_dk_root($1)"
	DK_ROOT=$1
	export DK_ROOT=$DK_ROOT
	
	if file_exists ~/.profile; then
		remove_from_file DK_ROOT ~/.profile
		append_file "export DK_ROOT=$DK_ROOT" ~/.profile
	fi
	if file_exists ~/.bash_profile; then
		remove_from_file DK_ROOT ~/.bash_profile
		append_file "export DK_ROOT=$DK_ROOT" ~/.bash_profile
	fi
	if file_exists ~/.bash_login; then
		remove_from_file DK_ROOT ~/.bash_login
		append_file "export DK_ROOT=$DK_ROOT" ~/.bash_login
	fi
	if file_exists ~/.bashrc; then
		remove_from_file DK_ROOT ~/.bashrc
		append_file "export DK_ROOT=$DK_ROOT" ~/.bashrc
	fi
	if file_exists ~/.zshenv; then
		remove_from_file DK_ROOT ~/.zshenv
		append_file "export DK_ROOT=$DK_ROOT" ~/.zshenv
	fi
	
	echo "DK_ROOT = $DK_ROOT"
}

get_dk_root() {
	#echo "get_dk_root()"
	if [[ -n "$DK_ROOT" ]]; then
		echo "DK_ROOT = $DK_ROOT"
	else
		echo "setting DK_ROOT to default directory"
		set_dk_root $DK_HOME/digitalknob
	fi
}

clear_dk_root() {
	if file_exists ~/.profile; then
		remove_from_file DK_ROOT ~/.profile
	fi
	if file_exists ~/.profile; then
		remove_from_file DK_ROOT ~/.bash_profile
	fi
	if file_exists ~/.profile; then
		remove_from_file DK_ROOT ~/.bash_login
	fi
	if file_exists ~/.profile; then	
		remove_from_file DK_ROOT ~/.bashrc
	fi
	if file_exists ~/.profile; then
		remove_from_file DK_ROOT ~/.zshenv
	fi
	
	export -n DK_ROOT
	unset DK_ROOT
}





##################################
#	main
#################################
main() {
	echo "main()"
	
	get_dk_host
	get_dk_arch
	get_dk_version
	get_dk_ostype
	get_dk_model
	get_dk_machtype
	get_dk_lang
	get_dk_username
	get_dk_logname
	get_dk_home
	get_dk_prefix
	get_dk_term
	get_dk_shell
	get_dk_path
	get_dk_pwd
	echo ""
	
	#clear_dk_root
	get_dk_root
}


# if the script is called with arguments, call the arguments and exit
if [ $# -ne 0 ]; then
    "$@"
	echo ""
	exit
fi
main