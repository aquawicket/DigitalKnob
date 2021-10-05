# https://brew.sh/

#DKSET(HOMEBREW_VERSION ???)

MAC_COMMAND("ruby -e \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\"")
# https://github.com/Homebrew/brew/issues/10368
MAC_COMMAND("rm -fr $(brew --repo homebrew/core)")
MAC_COMMAND("brew tap homebrew/core")
