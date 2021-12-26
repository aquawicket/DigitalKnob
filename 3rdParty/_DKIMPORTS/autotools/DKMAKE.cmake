# http://autogen.sourceforge.net
# https://macappstore.org/autogen/
# https://www.xmodulo.com/fix-failed-to-run-aclocal.html
# https://thoughtbot.com/blog/the-magic-behind-configure-make-make-install

if(MAC_HOST)
	MAC_DKQCOMMAND(brew install autogen)
	MAC_DKQCOMMAND(brew install autoconf)
	MAC_DKQCOMMAND(brew install automake)
endif()
