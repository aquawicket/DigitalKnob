#include "DKSDLCefKeyboard.h"
#include "include/internal/cef_types.h"
#include "SDL.h"

#ifdef WIN32
  #include <windows.h>
#elif X11
  #include <X11/keysym.h>
#endif


/////////////////////////////////////////////////////
int DKSDLCefKeyboard::getCefModifiers(int modKeyMask)
{
	DKDEBUGFUNC(modKeyMask);
	int modifiers = 0;
    if (modKeyMask & KMOD_CTRL)
		modifiers |= EVENTFLAG_CONTROL_DOWN;
    if (modKeyMask & KMOD_SHIFT)
		modifiers |= EVENTFLAG_SHIFT_DOWN;
    if (modKeyMask & KMOD_ALT)
		modifiers |= EVENTFLAG_ALT_DOWN;
    if (modKeyMask & KMOD_CAPS)
		modifiers |= EVENTFLAG_CAPS_LOCK_ON;
    if (modKeyMask & KMOD_NUM)
		modifiers |= EVENTFLAG_NUM_LOCK_ON;
	if (modKeyMask & KMOD_LALT ||
		modKeyMask & KMOD_LCTRL ||
        modKeyMask & KMOD_LSHIFT)
        modifiers |= EVENTFLAG_IS_LEFT;
    if (modKeyMask & KMOD_RALT ||
		modKeyMask & KMOD_RCTRL ||
        modKeyMask & KMOD_RSHIFT)
        modifiers |= EVENTFLAG_IS_RIGHT;

	/*
	if (modKeyMask & SDL_LEFT_MOUSE_BUTTON)
		modifiers |= EVENTFLAG_LEFT_MOUSE_BUTTON;
	if (modKeyMask & SDL_MIDDLE_MOUSE_BUTTON)
		modifiers |= EVENTFLAG_MIDDLE_MOUSE_BUTTON;
	if (modKeyMask & SDL_RIGHT_MOUSE_BUTTON)
		modifiers |= EVENTFLAG_RIGHT_MOUSE_BUTTON;
	*/

    return modifiers;
}