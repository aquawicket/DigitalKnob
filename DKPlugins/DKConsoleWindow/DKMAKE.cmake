#FIXME:  Unix probobly needs curses
dk_depend(DKWindow)
dk_depend(DKFocusEvent)
dk_depend(DKMouseEvent)
dk_depend(DKWheelEvent)
dk_depend(DKKeyboardEvent)

dk_generateCmake(DKConsoleWindow)
dk_assets(DKConsoleWindow)