#include "DKOSGCefKeyboard.h"
#include "include/internal/cef_types.h"

#ifdef WIN32
  #include <windows.h>
#elif X11
  #include <X11/keysym.h>
#endif


//////////////////////////////////////////////////////////////
unsigned int DKOSGCefKeyboard::getCefModifiers(int modKeyMask)
{
	int modifiers = 0;
    if (modKeyMask & osgGA::GUIEventAdapter::MODKEY_CTRL)
		modifiers |= EVENTFLAG_CONTROL_DOWN;
    if (modKeyMask & osgGA::GUIEventAdapter::MODKEY_SHIFT)
		modifiers |= EVENTFLAG_SHIFT_DOWN;
    if (modKeyMask & osgGA::GUIEventAdapter::MODKEY_ALT)
		modifiers |= EVENTFLAG_ALT_DOWN;
    if (modKeyMask & osgGA::GUIEventAdapter::MODKEY_CAPS_LOCK)
		modifiers |= EVENTFLAG_CAPS_LOCK_ON;
    if (modKeyMask & osgGA::GUIEventAdapter::MODKEY_NUM_LOCK)
		modifiers |= EVENTFLAG_NUM_LOCK_ON;
    if (modKeyMask & osgGA::GUIEventAdapter::MODKEY_LEFT_ALT ||
		modKeyMask & osgGA::GUIEventAdapter::MODKEY_LEFT_CTRL ||
        modKeyMask & osgGA::GUIEventAdapter::MODKEY_LEFT_SHIFT)
        modifiers |= EVENTFLAG_IS_LEFT;
    if (modKeyMask & osgGA::GUIEventAdapter::MODKEY_RIGHT_ALT ||
		modKeyMask & osgGA::GUIEventAdapter::MODKEY_RIGHT_CTRL ||
        modKeyMask & osgGA::GUIEventAdapter::MODKEY_RIGHT_SHIFT)
        modifiers |= EVENTFLAG_IS_RIGHT;

    //if (modKeyMask & osgGA::GUIEventAdapter:)
    //  modifiers |= EVENTFLAG_LEFT_MOUSE_BUTTON;
    //if (modKeyMask & osgGA::GUIEventAdapter::MODKEY_CTRL)
    //  modifiers |= EVENTFLAG_MIDDLE_MOUSE_BUTTON;
    //if (modKeyMask & osgGA::GUIEventAdapter::MODKEY_CTRL)
    //  modifiers |= EVENTFLAG_RIGHT_MOUSE_BUTTON;

    return modifiers;
}
