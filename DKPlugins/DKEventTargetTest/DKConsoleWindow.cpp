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
//https://github.com/uNetworking/uWebSockets/blob/master/tests/main.cpp
#include "DK/stdafx.h"
#include "DKEventTargetTest/DKConsoleWindow.h"
#include "DKEventTargetTest/DKEventTarget.h"
#include "DKEventTargetTest/DKFocusEvent.h"
#include "DKEventTargetTest/DKMouseEvent.h"
#include "DKEventTargetTest/DKWheelEvent.h"
#include "DKEventTargetTest/DKKeyboardEvent.h"
#include "DKDuktape/DKDuktape.h"

#if !WIN && !EMSCRIPTEN && !ANDROID
	#include <stdlib.h>
	#include <signal.h>
	#include <curses.h>
#endif

#if WIN
	// fullScreen
	WINDOWPLACEMENT DKConsoleWindow::wpc;
	LONG DKConsoleWindow::HWNDStyle = 0;
	LONG DKConsoleWindow::HWNDStyleEx = 0;
#endif

DKConsoleWindow::DKConsoleWindow() : DKWindow() {
	DKDEBUGFUNC();
	//DKINFO("DKConsoleWindow::Init() \n");
	
	eventTargetClass = "ConsoleWindow";
	eventTargetAddress = DKDuktape::pointerToAddress(this);
		
	#if !WIN && !EMSCRIPTEN && !ANDROID
		SCREEN *screen = newterm((char *) 0, stdout, stdin);
		if(!screen){
			DKERROR("screen invalid! \n");
			return;
		}
	#endif

	#if WIN
		// Get the standard input handle. 
		hStdin = GetStdHandle(STD_INPUT_HANDLE);
		if (hStdin == INVALID_HANDLE_VALUE)
			ErrorExit("GetStdHandle");

			// Save the current input mode, to be restored on exit. 
		if (!GetConsoleMode(hStdin, &fdwSaveOldMode))
			ErrorExit("GetConsoleMode");

		// Enable the window and mouse input events. 
		DWORD fdwMode = ENABLE_WINDOW_INPUT | ENABLE_MOUSE_INPUT | ENABLE_INSERT_MODE | ENABLE_EXTENDED_FLAGS;
		if (!SetConsoleMode(hStdin, fdwMode))
			ErrorExit("SetConsoleMode");
			
		// fullScreen
		HWNDStyle = 0;
		HWNDStyleEx = 0;
	#endif
		
	// KeyboardEvent
	altKey = false;
	code = "";
	ctrlKey = false;
	isComposing = false;
	key = ' ';
	locale = "";
	location = 0;
	metaKey = false;
	repeat = false;
	shiftKey = false;
	
	// MouseEvent
	button_state[0] = false;
	button_state[1] = false;
	button_state[2] = false;
	button_state[3] = false;
	button_state[4] = false;
	button = 0;
	buttons = 0;
	clientX = 0;
	clientY = 0;
	layerX = 0;
	layerY = 0;
	movementX = 0;
	movementY = 0;
	offsetX = 0;
	offsetY = 0;
	pageX = 0;
	pageY = 0;
	relatedTarget = "";
	screenX = 0;
	screenY = 0;
	mozPressure = 0.0;
	mozInputSource = "";
	webkitForce = 0;
	x = 0;
	y = 0;

	// WheelEvent
	deltaX = 0;
	deltaY = 0;
	deltaZ = 0;
	deltaMode = 0;
	wheelDelta = 0;
	wheelDeltaX = 0;
	wheelDeltaY = 0;

	// FocusEvent
	//relatedTarget = "";

	//// Instance properties ////
	/*
	DKDuktape::AttachFunction("CPP_DKConsoleWindow_closed", DKConsoleWindow::closed);
	DKDuktape::AttachFunction("CPP_DKConsoleWindow_columns", DKConsoleWindow::Columns);
	DKDuktape::AttachFunction("CPP_DKConsoleWindow_fullScreen", DKConsoleWindow::fullScreen);
	DKDuktape::AttachFunction("CPP_DKConsoleWindow_innerHeight", DKConsoleWindow::innerHeight);
	DKDuktape::AttachFunction("CPP_DKConsoleWindow_innerWidth", DKConsoleWindow::innerWidth);
	DKDuktape::AttachFunction("CPP_DKConsoleWindow_name", DKConsoleWindow::name);
	DKDuktape::AttachFunction("CPP_DKConsoleWindow_outerHeight", DKConsoleWindow::outerHeight);
	DKDuktape::AttachFunction("CPP_DKConsoleWindow_outerWidth", DKConsoleWindow::outerWidth);
	DKDuktape::AttachFunction("CPP_DKConsoleWindow_rows", DKConsoleWindow::Rows);
	DKDuktape::AttachFunction("CPP_DKConsoleWindow_screenX", DKConsoleWindow::ScreenX);
	DKDuktape::AttachFunction("CPP_DKConsoleWindow_screenLeft", DKConsoleWindow::screenLeft);
	DKDuktape::AttachFunction("CPP_DKConsoleWindow_screenY", DKConsoleWindow::ScreenY);
	DKDuktape::AttachFunction("CPP_DKConsoleWindow_screenTop", DKConsoleWindow::screenTop);
		
	//// Instance methods ////
	DKDuktape::AttachFunction("CPP_DKConsoleWindow_blur", DKConsoleWindow::blur);
	DKDuktape::AttachFunction("CPP_DKConsoleWindow_close", DKConsoleWindow::close);
	DKDuktape::AttachFunction("CPP_DKConsoleWindow_focus", DKConsoleWindow::focus);
	DKDuktape::AttachFunction("CPP_DKConsoleWindow_moveBy", DKConsoleWindow::moveBy);
	DKDuktape::AttachFunction("CPP_DKConsoleWindow_moveTo", DKConsoleWindow::moveTo);
	DKDuktape::AttachFunction("CPP_DKConsoleWindow_resizeBy", DKConsoleWindow::resizeBy);
	DKDuktape::AttachFunction("CPP_DKConsoleWindow_resizeTo", DKConsoleWindow::resizeTo);
	*/

	DKApp::AppendLoopFunc(&DKConsoleWindow::Loop, this);
	
	DKString address = DKDuktape::pointerToAddress(this);
	DKINFO("CPP ConsoleWindow address = "+address+"\n");
}


void DKConsoleWindow::Loop() {
    //DKDEBUGFUNC(); //EXCESSIVE LOGGING
    /*
    if (GetAsyncKeyState(VK_LBUTTON) & 0x01)
        DKINFO("VK_LBUTTON \n");
    if (GetAsyncKeyState(VK_RBUTTON) & 0x01)
        DKINFO("VK_RBUTTON \n");
    if (GetAsyncKeyState(VK_MBUTTON) & 0x01)
        DKINFO("VK_MBUTTON \n");
    if (GetAsyncKeyState(VK_XBUTTON1) & 0x01)
        DKINFO("VK_XBUTTON1 \n");
    if (GetAsyncKeyState(VK_XBUTTON2) & 0x01)
        DKINFO("VK_XBUTTON2 \n");
    */
#if WIN
    DWORD lpcNumberOfEvents;
    GetNumberOfConsoleInputEvents(hStdin, &lpcNumberOfEvents);
    if (!lpcNumberOfEvents)
        return;

    DWORD cNumRead;
    //DWORD fdwMode;
    DWORD i;
    INPUT_RECORD irInBuf[128];
    if (!ReadConsoleInput(
        hStdin,      // input buffer handle 
        irInBuf,     // buffer to read into 
        128,         // size of read buffer 
        &cNumRead))  // number of records read 
            ErrorExit("ReadDKConsoleWindow");

    // Dispatch the events to the appropriate handler. 
    for (i = 0; i < cNumRead; i++) {
        switch (irInBuf[i].EventType) {
            case KEY_EVENT:
                KeyboardEventProc(irInBuf[i].Event.KeyEvent);
                break;
            case MOUSE_EVENT:
                MouseEventProc(irInBuf[i].Event.MouseEvent);
                break;
            case WINDOW_BUFFER_SIZE_EVENT:
                ResizeEventProc(irInBuf[i].Event.WindowBufferSizeEvent);
                break;
            case FOCUS_EVENT:
                FocusEventProc(irInBuf[i].Event.FocusEvent);
                break;
            case MENU_EVENT: // disregard menu events
                MenuEventProc(irInBuf[i].Event.MenuEvent);
                break;
            default:
                ErrorExit("Unknown event type");
                break;
        }
    }
#endif
}

/*
//// Instance properties ////
int DKConsoleWindow::closed(duk_context* ctx) {
    DKDEBUGFUNC(ctx);
	// TODO
	bool isClosed = false;
	duk_push_boolean(ctx, isClosed);
	return true;
}

int DKConsoleWindow::Columns(duk_context* ctx) {
    DKDEBUGFUNC(ctx);
    duk_push_uint(ctx, DKConsoleWindow::Get()->columns);
    return true;
}

int DKConsoleWindow::fullScreen(duk_context* ctx) {
    DKDEBUGFUNC(ctx);
    //get
    if (!duk_is_boolean(ctx, 0)) {
        // TODO
        bool isFullScreen = false;
        duk_push_boolean(ctx, isFullScreen);
        return true;
    }
    //set
    else {
        bool fullscreen = duk_require_boolean(ctx, 0);
        if (fullscreen) {
			#if WIN
				GetWindowPlacement(GetConsoleWindow(), &wpc);
				if (!HWNDStyle)
					HWNDStyle = GetWindowLong(GetConsoleWindow(), GWL_STYLE);
				if (!HWNDStyleEx)
					HWNDStyleEx = GetWindowLong(GetConsoleWindow(), GWL_EXSTYLE);
				LONG NewHWNDStyle = HWNDStyle;
				NewHWNDStyle &= ~WS_BORDER;
				NewHWNDStyle &= ~WS_DLGFRAME;
				NewHWNDStyle &= ~WS_THICKFRAME;
				LONG NewHWNDStyleEx = HWNDStyleEx;
				NewHWNDStyleEx &= ~WS_EX_WINDOWEDGE;
				SetWindowLong(GetConsoleWindow(), GWL_STYLE, NewHWNDStyle | WS_POPUP);
				SetWindowLong(GetConsoleWindow(), GWL_EXSTYLE, NewHWNDStyleEx | WS_EX_TOPMOST);
				ShowWindow(GetConsoleWindow(), SW_SHOWMAXIMIZED);
			#endif
        }
        else {
            //if (!wpc)
            //    GetWindowPlacement(GetConsoleWindow(), wpc);
			#if WIN
				if (!HWNDStyle)
					HWNDStyle = GetWindowLong(GetConsoleWindow(), GWL_STYLE);
				if (!HWNDStyleEx)
					HWNDStyleEx = GetWindowLong(GetConsoleWindow(), GWL_EXSTYLE);
				SetWindowLong(GetConsoleWindow(), GWL_STYLE, HWNDStyle);
				SetWindowLong(GetConsoleWindow(), GWL_EXSTYLE, HWNDStyleEx);
				ShowWindow(GetConsoleWindow(), SW_SHOWNORMAL);
				SetWindowPlacement(GetConsoleWindow(), &wpc);
			#endif
        }
        return true;
    }
}

int DKConsoleWindow::innerHeight(duk_context* ctx) {
    DKDEBUGFUNC(ctx);
	#if WIN
		RECT rect;
		GetClientRect(GetConsoleWindow(), &rect);
		ClientToScreen(GetConsoleWindow(), reinterpret_cast<POINT*>(&rect.left)); // convert top-left
		ClientToScreen(GetConsoleWindow(), reinterpret_cast<POINT*>(&rect.right)); // convert bottom-right
		unsigned int iHeight = rect.right - rect.left;
		duk_push_uint(ctx, iHeight);
	#endif
	return true;
}

int DKConsoleWindow::innerWidth(duk_context* ctx) {
    DKDEBUGFUNC(ctx);
	#if WIN
		RECT rect;
		GetClientRect(GetConsoleWindow(), &rect);
		ClientToScreen(GetConsoleWindow(), reinterpret_cast<POINT*>(&rect.left)); // convert top-left
		ClientToScreen(GetConsoleWindow(), reinterpret_cast<POINT*>(&rect.right)); // convert bottom-right
		unsigned int iWidth = rect.bottom - rect.top;
		duk_push_uint(ctx, iWidth);
	#endif
	return true;
}

int DKConsoleWindow::name(duk_context* ctx) {
    DKDEBUGFUNC(ctx);
    //get
    if (!duk_is_string(ctx, 0)) {
        char _title[1024];
		#if WIN
			GetConsoleTitle(_title, sizeof(_title));
		#endif
        DKString title = _title;
        duk_push_string(ctx, title.c_str());
        return true;
    }
    //set
    else {
        DKString str = duk_require_string(ctx, 0);
		#if WIN
			if (!SetConsoleTitle(str.c_str()))
				return DKERROR("SetConsoleTitle() failed! \n");
		#endif
        return true;
    }
}

int DKConsoleWindow::outerHeight(duk_context* ctx) {
    DKDEBUGFUNC(ctx);
	#if WIN
		RECT rect;
		GetWindowRect(GetConsoleWindow(), &rect);
		unsigned int oHeight = rect.bottom - rect.top;
		duk_push_uint(ctx, oHeight);
	#endif
	return true;
}

int DKConsoleWindow::outerWidth(duk_context* ctx) {
    DKDEBUGFUNC(ctx);
	#if WIN
		RECT rect;
		GetWindowRect(GetConsoleWindow(), &rect);
		unsigned int oWidth = rect.right - rect.left;
		duk_push_uint(ctx, oWidth);
	#endif
	return true;
}

int DKConsoleWindow::Rows(duk_context* ctx) {
    DKDEBUGFUNC(ctx);
    duk_push_uint(ctx, DKConsoleWindow::Get()->rows);
    return true;
}

int DKConsoleWindow::ScreenX(duk_context* ctx) {
    DKDEBUGFUNC(ctx);
	#if WIN
		RECT rect;
		GetClientRect(GetConsoleWindow(), &rect);
		ClientToScreen(GetConsoleWindow(), reinterpret_cast<POINT*>(&rect.left)); // convert top-left
		ClientToScreen(GetConsoleWindow(), reinterpret_cast<POINT*>(&rect.right)); // convert bottom-right
		duk_push_int(ctx, rect.left);
	#endif
	return true;
}

int DKConsoleWindow::screenLeft(duk_context* ctx) {
    DKDEBUGFUNC(ctx);
	#if WIN
		RECT rect;
		GetClientRect(GetConsoleWindow(), &rect);
		ClientToScreen(GetConsoleWindow(), reinterpret_cast<POINT*>(&rect.left)); // convert top-left
		ClientToScreen(GetConsoleWindow(), reinterpret_cast<POINT*>(&rect.right)); // convert bottom-right
		duk_push_int(ctx, rect.left);
	#endif
	return true;
}

int DKConsoleWindow::ScreenY(duk_context* ctx) {
    DKDEBUGFUNC(ctx);
	#if WIN
		RECT rect;
		GetClientRect(GetConsoleWindow(), &rect);
		ClientToScreen(GetConsoleWindow(), reinterpret_cast<POINT*>(&rect.left)); // convert top-left
		ClientToScreen(GetConsoleWindow(), reinterpret_cast<POINT*>(&rect.right)); // convert bottom-right
		duk_push_int(ctx, rect.top);
	#endif
	return true;
}

int DKConsoleWindow::screenTop(duk_context* ctx) {
    DKDEBUGFUNC(ctx);
	#if WIN
		RECT rect;
		GetClientRect(GetConsoleWindow(), &rect);
		ClientToScreen(GetConsoleWindow(), reinterpret_cast<POINT*>(&rect.left)); // convert top-left
		ClientToScreen(GetConsoleWindow(), reinterpret_cast<POINT*>(&rect.right)); // convert bottom-right
		duk_push_int(ctx, rect.top);
	#endif
    return true;
}

//// Instance methods ////
int DKConsoleWindow::blur(duk_context* ctx) {
    DKDEBUGFUNC(ctx);
	#if WIN
		ShowWindow(GetConsoleWindow(), SW_SHOWMINNOACTIVE);
	#endif
	return true;
}
int DKConsoleWindow::close(duk_context* ctx) {
    DKDEBUGFUNC(ctx);
	#if WIN
		ShowWindow(GetConsoleWindow(), SW_HIDE);
	#endif
	return true;
}
int DKConsoleWindow::focus(duk_context* ctx) {
    DKDEBUGFUNC(ctx);
	#if WIN
		ShowWindow(GetConsoleWindow(), SW_SHOW);
	#endif
	return true;
}
int DKConsoleWindow::moveBy(duk_context* ctx) {
    DKDEBUGFUNC(ctx);
	#if WIN
		int deltaX = duk_require_int(ctx, 0);
		int deltaY = duk_require_int(ctx, 1);
		RECT rect;
		GetWindowRect(GetConsoleWindow(), &rect);
		int X = rect.left + deltaX;
		int Y = rect.top + deltaY;
		int nWidth = rect.right - rect.left;
		int nHeight = rect.bottom - rect.top;
		if (!MoveWindow(GetConsoleWindow(), X, Y, nWidth, nHeight, TRUE))
			return DKERROR("MoveWindow() failed");
	#endif
	return true;
}
int DKConsoleWindow::moveTo(duk_context* ctx) {
    DKDEBUGFUNC(ctx);
	#if WIN
		int x = duk_require_int(ctx, 0);
		int y = duk_require_int(ctx, 1);
		RECT rect;
		GetWindowRect(GetConsoleWindow(), &rect);
		int X = x;
		int Y = y;
		int nWidth = rect.right - rect.left;
		int nHeight = rect.bottom - rect.top;
		if (!MoveWindow(GetConsoleWindow(), X, Y, nWidth, nHeight, TRUE))
			return DKERROR("MoveWindow() failed");
	#endif
	return true;
}
int DKConsoleWindow::resizeBy(duk_context* ctx) {
    DKDEBUGFUNC(ctx);
	#if WIN
		int xDelta = duk_require_int(ctx, 0);
		int yDelta = duk_require_int(ctx, 1);
		RECT rect;
		GetWindowRect(GetConsoleWindow(), &rect);
		int X = rect.left;
		int Y = rect.top;
		int nWidth = rect.right - rect.left + xDelta;
		int nHeight = rect.bottom - rect.top + yDelta;
		if (!MoveWindow(GetConsoleWindow(), X, Y, nWidth, nHeight, TRUE))
			return DKERROR("MoveWindow() failed");
	#endif
	return true;
}
int DKConsoleWindow::resizeTo(duk_context* ctx) {
    DKDEBUGFUNC(ctx);
	#if WIN
		int width = duk_require_int(ctx, 0);
		int height = duk_require_int(ctx, 1);
		RECT rect;
		GetWindowRect(GetConsoleWindow(), &rect);
		int X = rect.left;
		int Y = rect.top;
		int nWidth = width;
		int nHeight = height;
		if (!MoveWindow(GetConsoleWindow(), X, Y, nWidth, nHeight, TRUE))
			return DKERROR("MoveWindow() failed");
	#endif
    return true;
}
*/	
	
#if WIN
void DKConsoleWindow::ErrorExit(LPCSTR lpszMessage) {
    DKDEBUGFUNC(lpszMessage);
    fprintf(stderr, "%s\n", lpszMessage);
    // Restore input mode on exit.
    SetConsoleMode(hStdin, fdwSaveOldMode);
    ExitProcess(0);
}

void DKConsoleWindow::FocusEventProc(FOCUS_EVENT_RECORD fer) {
    DKDEBUGFUNC(fer);
    relatedTarget = eventTargetAddress;

    if (!fer.bSetFocus) {
        //1. blur: sent after element A loses focus.
		DKFocusEvent blur_event("blur", "");
		blur_event.relatedTarget = relatedTarget;
		dispatchEvent(&blur_event);

        //2. focusout: sent after the blur event.
        DKFocusEvent focusout_event("focusout", "");
		focusout_event.relatedTarget = relatedTarget;
		dispatchEvent(&focusout_event);
    }
    else {
        //3. focus: sent after element B receives focus.
        DKFocusEvent focus_event("focus", "");
		focus_event.relatedTarget = relatedTarget;
		dispatchEvent(&focus_event);

        //4. focusin: sent after the focus event.
        DKFocusEvent focusin_event("focusin", "");
		focusin_event.relatedTarget = relatedTarget;
		dispatchEvent(&focusin_event);
    }
}

void DKConsoleWindow::KeyboardEventProc(KEY_EVENT_RECORD ker){
    DKDEBUGFUNC(ker);

    // altKey
    if (ker.dwControlKeyState & LEFT_ALT_PRESSED || ker.dwControlKeyState & RIGHT_ALT_PRESSED)
        altKey = true;
    else
        altKey = false;

    // code
    code = "todo";

    // ctrlKey
    if (ker.dwControlKeyState & LEFT_CTRL_PRESSED || ker.dwControlKeyState & RIGHT_CTRL_PRESSED)
        ctrlKey = true;
    else
        ctrlKey = false;

    // isComposing
    isComposing = false; //FIXME: todo

    // key
    key = ker.uChar.AsciiChar;

    // locale
    locale = "todo";

    // location
    location = 0; //FIXME: todo

    // metaKey
    if (ker.wVirtualKeyCode == VK_LWIN || ker.wVirtualKeyCode == VK_RWIN)
        metaKey = true;
    else
        metaKey = false;

    // repeat
    if (ker.wRepeatCount > 1)
        repeat = true;
    else
        repeat = false;

    // shiftKey
    if (ker.dwControlKeyState & SHIFT_PRESSED)
        shiftKey = true;
    else
        shiftKey = false;

    if (ker.bKeyDown) {
		DKKeyboardEvent keydown_event("keydown", "");
		keydown_event.altKey = altKey;
		keydown_event.code = code;
		keydown_event.ctrlKey = ctrlKey;
		keydown_event.isComposing = isComposing;
		keydown_event.key = key;
		keydown_event.locale = locale;
		keydown_event.location = location;
		keydown_event.metaKey = metaKey;
		keydown_event.repeat = repeat;
		keydown_event.shiftKey = shiftKey;
		dispatchEvent(&keydown_event);

		//Only fire keypress on alphanumeric keys.
        if (ker.uChar.AsciiChar < 32)
            return;
		DKKeyboardEvent keypress_event("keypress", "");
		keypress_event.altKey = altKey;
		keypress_event.code = code;
		keypress_event.ctrlKey = ctrlKey;
		keypress_event.isComposing = isComposing;
		keypress_event.key = key;
		keypress_event.locale = locale;
		keypress_event.location = location;
		keypress_event.metaKey = metaKey;
		keypress_event.repeat = repeat;
		keypress_event.shiftKey = shiftKey;
		dispatchEvent(&keypress_event);
    }
    else {
		DKKeyboardEvent keyup_event("keyup", "");
		keyup_event.altKey = altKey;
		keyup_event.code = code;
		keyup_event.ctrlKey = ctrlKey;
		keyup_event.isComposing = isComposing;
		keyup_event.key = key;
		keyup_event.locale = locale;
		keyup_event.location = location;
		keyup_event.metaKey = metaKey;
		keyup_event.repeat = repeat;
		keyup_event.shiftKey = shiftKey;
		dispatchEvent(&keyup_event);
    }
}

void DKConsoleWindow::MenuEventProc(MENU_EVENT_RECORD mer) {
    DKDEBUGFUNC(mer);
    DKINFO("DKConsoleWindow::MenuEventProc() \n");
}

void DKConsoleWindow::MouseEventProc(MOUSE_EVENT_RECORD mer) {
    DKDEBUGFUNC(mer);
    //DKINFO("DKConsoleWindow::MouseEventProc()\n");
	#ifndef MOUSE_HWHEELED
		#define MOUSE_HWHEELED 0x0008
	#endif

    switch (mer.dwEventFlags){
		case 0:
            // event.button
            // 0 = Left button(primary)
            // 1 = Middle button(auxiliary)
            // 2 = Right button(secondary)
            // 3 = X1 button(back)
            // 4 = X2 button(forward)

            // event.buttons
            //  0 : No button or un-initialized
            //  1 : Primary button(usually the left button)
            //  2 : Secondary button(usually the right button)
            //  4 : Auxiliary button(usually the mouse wheel button or middle button)
            //  8 : 4th button(typically the "Browser Back" button)
            // 16 : 5th button(typically the "Browser Forward" button)
            buttons = 0;
            if (mer.dwButtonState & FROM_LEFT_1ST_BUTTON_PRESSED) {  // 0x0001
                //DKINFO("1 ");
                buttons = buttons + 1;
            }
            else {
                //DKINFO("0 ");
            }
            if (mer.dwButtonState & FROM_LEFT_2ND_BUTTON_PRESSED) {  // 0x0004
                //DKINFO("2 ");
                buttons = buttons + 4;
            }
            else {
                //DKINFO("0 ");
            }
            if (mer.dwButtonState & RIGHTMOST_BUTTON_PRESSED) {      // 0x0002
                //DKINFO("3 ");
                buttons = buttons + 2;
            }
            else {
                //DKINFO("0 ");
            }
            if (mer.dwButtonState & FROM_LEFT_3RD_BUTTON_PRESSED) {  // 0x0008
                //DKINFO("4 ");
                buttons = buttons + 8;
            }
            else {
                //DKINFO("0 ");
            }
            if (mer.dwButtonState & FROM_LEFT_4TH_BUTTON_PRESSED) {  // 0x0010
                //DKINFO("5 \n");
                buttons = buttons + 16;
            }
            else {
                //DKINFO("0 \n");
            }

            if (mer.dwButtonState & FROM_LEFT_1ST_BUTTON_PRESSED) {  // 0x0001
                if (!button_state[0]) {
                    button_state[0] = true;
                    button = 0;

					DKMouseEvent mousedown_event("mousedown", "");
					mousedown_event.button = button;
					mousedown_event.buttons = buttons;
					dispatchEvent(&mousedown_event);
					
                    break;
                }
            }
            else if (button_state[0]) {
                button_state[0] = false;
                button = 0;

				DKMouseEvent mouseup_event("mouseup", "");
				mouseup_event.button = button;
				mouseup_event.buttons = buttons;
				dispatchEvent(&mouseup_event);

				DKMouseEvent* click_event = new DKMouseEvent("click", "");
				click_event->button = button;
				click_event->buttons = buttons;
				this->dispatchEvent(click_event);
				delete click_event;
				
                break;
            }

            if ((mer.dwButtonState & RIGHTMOST_BUTTON_PRESSED)) {      // 0x0002
                if (!button_state[1]) {
                    button_state[1] = true;
                    button = 2;
					
					DKMouseEvent* mousedown_event = new DKMouseEvent("mousedown", "");
					mousedown_event->button = button;
					mousedown_event->buttons = buttons;
					this->dispatchEvent(mousedown_event);
					delete mousedown_event;
				
                    break;
                }
            }
            else if (button_state[1]) {
                button_state[1] = false;
                button = 2;

				DKMouseEvent* mouseup_event = new DKMouseEvent("mouseup", "");
				mouseup_event->button = button;
				mouseup_event->buttons = buttons;
				this->dispatchEvent(mouseup_event);
				delete mouseup_event;

				DKMouseEvent* contextmenu_event = new DKMouseEvent("contextmenu", "");
				contextmenu_event->button = button;
				contextmenu_event->buttons = buttons;
				this->dispatchEvent(contextmenu_event);
				delete contextmenu_event;
				
                break;
            }

            if (mer.dwButtonState & FROM_LEFT_2ND_BUTTON_PRESSED) {  // 0x0004
                if (!button_state[2]) {
                    button_state[2] = true;
                    button = 1;
                    
					DKMouseEvent* mousedown_event = new DKMouseEvent("mousedown", "");
					mousedown_event->button = button;
					mousedown_event->buttons = buttons;
					this->dispatchEvent(mousedown_event);
					delete mousedown_event;
					
                    break;
                }
            }
            else if (button_state[2]) {
                button_state[2] = false;
                button = 1;
                
				DKMouseEvent* mouseup_event = new DKMouseEvent("mouseup", "");
				mouseup_event->button = button;
				mouseup_event->buttons = buttons;
				this->dispatchEvent(mouseup_event);
				delete mouseup_event;
				
                break;
            }

            if (mer.dwButtonState & FROM_LEFT_3RD_BUTTON_PRESSED) {  // 0x0008
                if (!button_state[3]) {
                    button_state[3] = true;
                    button = 3;
                    
					DKMouseEvent* mousedown_event = new DKMouseEvent("mousedown", "");
					mousedown_event->button = button;
					mousedown_event->buttons = buttons;
					this->dispatchEvent(mousedown_event);
					delete mousedown_event;
					
                    break;
                }
            }
            else if (button_state[3]) {
                button_state[3] = false;
                button = 3;
                
				DKMouseEvent* mouseup_event = new DKMouseEvent("mouseup", "");
				mouseup_event->button = button;
				mouseup_event->buttons = buttons;
				this->dispatchEvent(mouseup_event);
				delete mouseup_event;
				
                break;
            }

            if (mer.dwButtonState & FROM_LEFT_4TH_BUTTON_PRESSED) { // 0x0010
                if (!button_state[4]) {
                    button_state[4] = true;
                    button = 4;
                    
					DKMouseEvent* mousedown_event = new DKMouseEvent("mousedown", "");
					mousedown_event->button = button;
					mousedown_event->buttons = buttons;
					this->dispatchEvent(mousedown_event);
					delete mousedown_event;
					
                    break;
                }
            }
            else if (button_state[4]) {
                button_state[4] = false;
                button = 4;
                
				DKMouseEvent* mouseup_event = new DKMouseEvent("mouseup", "");
				mouseup_event->button = button;
				mouseup_event->buttons = buttons;
				this->dispatchEvent(mouseup_event);
				delete mouseup_event;
				
                break;
            }
			break;
		case DOUBLE_CLICK: {
			DKMouseEvent* dblclick_event = new DKMouseEvent("dblclick", "");
			dblclick_event->button = button;
			dblclick_event->buttons = buttons;
			this->dispatchEvent(dblclick_event);
			delete dblclick_event;
			break;
		}
		case MOUSE_HWHEELED: { //horizontal mouse wheel
            button = 0;
            if ((int32_t)mer.dwButtonState > 0)
                deltaX = -100;
            if ((int32_t)mer.dwButtonState < 0)
                deltaX = 100;
            DKWheelEvent* wheel_event = new DKWheelEvent("wheel", "");
			wheel_event->button = button;
			wheel_event->deltaX = deltaX;
			this->dispatchEvent(wheel_event);
			delete wheel_event;
			break;
		}
		case MOUSE_WHEELED: { //vertical mouse wheel
            button = 0;
            if ((int32_t)mer.dwButtonState > 0)
                deltaY = -100;
            if ((int32_t)mer.dwButtonState < 0)
                deltaY = 100;
			DKWheelEvent* wheel_event = new DKWheelEvent("wheel", "");
			wheel_event->button = button;
			wheel_event->deltaY = deltaY;
			this->dispatchEvent(wheel_event);
			delete wheel_event;
			break;
		}
        case MOUSE_MOVED: {
            //// Cursor Position ////
            // colume = mer.dwMousePosition.X;
            // row = mer.dwMousePosition.Y;

            //// Get window client rect screen position ////
            // https://stackoverflow.com/a/15734569/688352
            RECT rect;
            GetClientRect(GetConsoleWindow(), &rect); // get client coords
            ClientToScreen(GetConsoleWindow(), reinterpret_cast<POINT*>(&rect.left)); // convert top-left
            ClientToScreen(GetConsoleWindow(), reinterpret_cast<POINT*>(&rect.right)); // convert bottom-right

            //// Mouse Position ////
            int mousex, mousey;
            DKUtil::GetMousePos(mousex, mousey);

            clientX = mousex - rect.left;
            clientY = mousey - rect.top;
            if (clientX == x && clientY == y)
                break;

            button = 0;
            layerX = clientX;
            layerY = clientY;
            movementX = clientX - x;
            movementY = clientY - y;
            offsetX = clientX;
            offsetY = clientY;
            pageX = clientX;
            pageY = clientY;
            x = clientX;
            y = clientY;
            
			DKMouseEvent* mousemove_event = new DKMouseEvent("mousemove", "");
			mousemove_event->button = button;
			mousemove_event->buttons = buttons;
			this->dispatchEvent(mousemove_event);
			delete mousemove_event;
				
            break;
		}
		default:
			DKERROR("unknown event! \n");
			break;
    }
}

void DKConsoleWindow::ResizeEventProc(WINDOW_BUFFER_SIZE_RECORD wbsr) {
    DKDEBUGFUNC(wbsr);
	//DKString address = DKDuktape::pointerToAddress(this);
    columns = wbsr.dwSize.X;
    rows = wbsr.dwSize.Y;
	//code = "dispatchMouseEvent('resize','','" + address + "')";
    //DKDuktape::RunDuktape(code, rval);
}
#endif