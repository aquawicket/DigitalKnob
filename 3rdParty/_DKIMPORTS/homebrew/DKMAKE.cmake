# https://github.com/Homebrew/brew
# https://brew.sh/

if(NOT MAC_HOST)
	return()
endif()


#dk_import(https://github.com/Homebrew/brew)

MAC_DKQCOMMAND("ruby -e \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\"")
# https://github.com/Homebrew/brew/issues/10368
MAC_DKQCOMMAND(rm -fr "$(brew --repo homebrew/core)")
MAC_DKQCOMMAND(brew tap homebrew/core)
