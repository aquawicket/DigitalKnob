#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
dk_load(dk_builder)

#dk_depend(netsurf)
dk_depend(webref)

dk_depend(DKDuktape)
dk_depend(DK)
dk_depend(DKAssets)


###### Standard Interfaces ######
dk_depend(DKInterface)
dk_depend(DKConsole)
dk_depend(DKEvent)
dk_depend(DKEventListener)
dk_depend(DKEventTarget)
dk_depend(DKCustomEvent)
dk_depend(DKNonElementParentNode)		# Mixin
dk_depend(DKDocument)
dk_depend(DKScreen)
dk_depend(DKWindow)
dk_depend(DKUIEvent)
dk_depend(DKFocusEvent)
dk_depend(DKMouseEvent)
dk_depend(DKWheelEvent)
dk_depend(DKInputEvent)
dk_depend(DKKeyboardEvent)
dk_depend(DKCompositionEvent)
dk_depend(DKDragEvent)
dk_depend(DKNavigator)
dk_depend(DKURL)
dk_depend(DKLocation)
dk_depend(DKCSSStyleDeclaration)
dk_depend(DKNode)
dk_depend(DKInnerHTML)					# Mixin
dk_depend(DKElementCSSInlineStyle)		# Mixin
dk_depend(DKElement)
dk_depend(DKHTMLCollection)
dk_depend(DKHTMLElement)
dk_depend(DKHTMLBodyElement)
dk_depend(DKHTMLImageElement)


###### DigitalKnob Interfaces ######
dk_depend(DKConsoleWindow)
dk_depend(DKSDLWindow)
dk_depend(DKSDLRmlDocument)

dk_depend(DKRmlInterface)
dk_depend(DKRmlEventListener)
dk_depend(DKRmlEventTarget)
dk_depend(DKRmlLocation)
dk_depend(DKRmlCSSStyleDeclaration)
dk_depend(DKRmlNode)
dk_depend(DKRmlElementCSSInlineStyle)	# Mixin
dk_depend(DKRmlInnerHTML)				# Mixin
dk_depend(DKRmlElement)
dk_depend(DKRmlNonElementParentNode)	# Mixin
dk_depend(DKRmlDocument)
dk_depend(DKRmlHTMLElement)
dk_depend(DKWebTest)
