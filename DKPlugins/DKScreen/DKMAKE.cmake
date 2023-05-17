#dk_depend(libx11-dev)	# XOpenDisplay()

dk_depend(DKInterface)

dk_generateCmake(DKScreen)
dk_assets(DKScreen)
