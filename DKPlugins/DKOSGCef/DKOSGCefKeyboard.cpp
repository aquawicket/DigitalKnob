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
#include "DKOSGCef/DKOSGCefKeyboard.h"

//WARNING_DISABLE
#include "include/internal/cef_types.h"
#if WIN
  #include <windows.h>
#elif X11
  #include <X11/keysym.h>
#endif
//WARNING_ENABLE


unsigned int DKOSGCefKeyboard::getCefModifiers(int modKeyMask){
	DKDEBUGFUNC(modKeyMask);
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
