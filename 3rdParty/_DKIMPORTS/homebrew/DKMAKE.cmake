# https://github.com/Homebrew/brew
# https://brew.sh/
if(NOT MAC_HOST)
	dk_return()
endif()

#dk_import(https://github.com/Homebrew/brew)

MAC_dk_queueCommand("ruby -e \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\"")
# https://github.com/Homebrew/brew/issues/10368
MAC_dk_queueCommand(rm -fr "$(brew --repo homebrew/core)")
MAC_dk_queueCommand(brew tap homebrew/core)
