/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

#include "DKSDLCefKeyboard.h"

WARNING_DISABLE
	#include "include/internal/cef_types.h"
	#include "SDL.h"
	#if WIN
	  #include <windows.h>
	#elif X11
	  #include <X11/keysym.h>
	#endif
WARNING_ENABLE


int DKSDLCefKeyboard::getCefModifiers(int modKeyMask){
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
