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
#include "DKConsoleWindow/DKConsoleWindow.h"
#include "DKEventTarget/DKEventTarget.h"
#include "DKFocusEvent/DKFocusEvent.h"
#include "DKMouseEvent/DKMouseEvent.h"
#include "DKWheelEvent/DKWheelEvent.h"
#include "DKKeyboardEvent/DKKeyboardEvent.h"
#include "DKDuktape/DKDuktape.h"

#if !WIN && !EMSCRIPTEN && !ANDROID && !IOS
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
	interfaceName = "ConsoleWindow";
	interfaceAddress = pointerToAddress(this);
	DKINFO("DKConsoleWindow("+interfaceAddress+") \n");
		
	#if !WIN && !EMSCRIPTEN && !ANDROID && !IOS
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
	//layerX = 0;
	//layerY = 0;
	movementX = 0;
	movementY = 0;
	offsetX = 0;
	offsetY = 0;
	pageX = 0;
	pageY = 0;
	relatedTarget = "";
	screenX = 0;
	screenY = 0;
	//mozPressure = 0.0;
	//mozInputSource = "";
	//webkitForce = 0;
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
	columns = 0;
	rows = 0;

	DKApp::AppendLoopFunc(&DKConsoleWindow::Loop, this);
}

DKConsoleWindow::~DKConsoleWindow() {
	DKDEBUGFUNC();
	DKINFO("DKConsoleWindow::~DKConsoleWindow() \n");
	#if WIN
		SetConsoleMode(hStdin, fdwSaveOldMode); // Restore input mode on exit.
	#endif
}

bool DKConsoleWindow::Init() {
	DKDEBUGFUNC();
	DKINFO("DKConsoleWindow::Init() \n");
	return true;
}

bool DKConsoleWindow::End() {
	DKDEBUGFUNC();
	DKINFO("DKConsoleWindow::End() \n");
	return true;
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
	relatedTarget = interfaceAddress;

    if (!fer.bSetFocus) {
        //1. blur: sent after element A loses focus.
		DKFocusEvent blur_event("blur", "");
		blur_event.relatedTarget(relatedTarget);
		dispatchEvent(blur_event);

        //2. focusout: sent after the blur event.
        DKFocusEvent focusout_event("focusout", "");
		focusout_event.relatedTarget(relatedTarget);
		dispatchEvent(focusout_event);
    }
    else {
        //3. focus: sent after element B receives focus.
        DKFocusEvent focus_event("focus", "");
		focus_event.relatedTarget(relatedTarget);
		dispatchEvent(focus_event);

        //4. focusin: sent after the focus event.
        DKFocusEvent focusin_event("focusin", "");
		focusin_event.relatedTarget(relatedTarget);
		dispatchEvent(focusin_event);
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
		keydown_event.key(key);
		keydown_event.code(code);
		keydown_event.location(location);
		keydown_event.ctrlKey(ctrlKey);
		keydown_event.shiftKey(shiftKey);
		keydown_event.altKey(altKey);
		keydown_event.metaKey(metaKey);
		keydown_event.repeat(repeat);
		keydown_event.isComposing(isComposing);
		//keydown_event.charCode(charCode);
		//keydown_event.keyCode(keyCode);
		dispatchEvent(keydown_event);

		//Only fire keypress on alphanumeric keys.
        if (ker.uChar.AsciiChar < 32)
            return;
		DKKeyboardEvent keypress_event("keypress", "");
		keypress_event.key(key);
		keypress_event.code(code);
		keypress_event.location(location);
		keypress_event.ctrlKey(ctrlKey);
		keypress_event.shiftKey(shiftKey);
		keypress_event.altKey(altKey);
		keypress_event.metaKey(metaKey);
		keypress_event.repeat(repeat);
		keypress_event.isComposing(isComposing);
		//keypress_event.charCode(charCode);
		//keypress_event.keyCode(keyCode);
		dispatchEvent(keypress_event);
    }
    else {
		DKKeyboardEvent keyup_event("keyup", "");
		keyup_event.key(key);
		keyup_event.code(code);
		keyup_event.location(location);
		keyup_event.ctrlKey(ctrlKey);
		keyup_event.shiftKey(shiftKey);
		keyup_event.altKey(altKey);
		keyup_event.metaKey(metaKey);
		keyup_event.repeat(repeat);
		keyup_event.isComposing(isComposing);
		//keyup_event.charCode(charCode);
		//keyup_event.keyCode(keyCode);
		dispatchEvent(keyup_event);
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
					mousedown_event.screenX(screenX);
					mousedown_event.screenY(screenY);
					mousedown_event.clientX(clientX);
					mousedown_event.clientY(clientY);
					mousedown_event.ctrlKey(ctrlKey);
					mousedown_event.shiftKey(shiftKey);
					mousedown_event.altKey(altKey);
					mousedown_event.metaKey(metaKey);
					mousedown_event.button(button);
					mousedown_event.buttons(buttons);
					mousedown_event.relatedTarget(relatedTarget);
					mousedown_event.pageX(pageX);
					mousedown_event.pageY(pageY);
					mousedown_event.x(x);
					mousedown_event.y(y);
					mousedown_event.offsetX(offsetX);
					mousedown_event.offsetY(offsetY);
					mousedown_event.movementX(movementX);
					mousedown_event.movementY(movementY);
					dispatchEvent(mousedown_event);
					
                    break;
                }
            }
            else if (button_state[0]) {
                button_state[0] = false;
                button = 0;

				DKMouseEvent mouseup_event("mouseup", "");
				mouseup_event.screenX(screenX);
				mouseup_event.screenY(screenY);
				mouseup_event.clientX(clientX);
				mouseup_event.clientY(clientY);
				mouseup_event.ctrlKey(ctrlKey);
				mouseup_event.shiftKey(shiftKey);
				mouseup_event.altKey(altKey);
				mouseup_event.metaKey(metaKey);
				mouseup_event.button(button);
				mouseup_event.buttons(buttons);
				mouseup_event.relatedTarget(relatedTarget);
				mouseup_event.pageX(pageX);
				mouseup_event.pageY(pageY);
				mouseup_event.x(x);
				mouseup_event.y(y);
				mouseup_event.offsetX(offsetX);
				mouseup_event.offsetY(offsetY);
				mouseup_event.movementX(movementX);
				mouseup_event.movementY(movementY);
				dispatchEvent(mouseup_event);

				DKMouseEvent click_event("click", "");
				click_event.screenX(screenX);
				click_event.screenY(screenY);
				click_event.clientX(clientX);
				click_event.clientY(clientY);
				click_event.ctrlKey(ctrlKey);
				click_event.shiftKey(shiftKey);
				click_event.altKey(altKey);
				click_event.metaKey(metaKey);
				click_event.button(button);
				click_event.buttons(buttons);
				click_event.relatedTarget(relatedTarget);
				click_event.pageX(pageX);
				click_event.pageY(pageY);
				click_event.x(x);
				click_event.y(y);
				click_event.offsetX(offsetX);
				click_event.offsetY(offsetY);
				click_event.movementX(movementX);
				click_event.movementY(movementY);
				dispatchEvent(click_event);
				
                break;
            }

            if ((mer.dwButtonState & RIGHTMOST_BUTTON_PRESSED)) {      // 0x0002
                if (!button_state[1]) {
                    button_state[1] = true;
                    button = 2;
					
					DKMouseEvent mousedown_event("mousedown", "");
					mousedown_event.screenX(screenX);
					mousedown_event.screenY(screenY);
					mousedown_event.clientX(clientX);
					mousedown_event.clientY(clientY);
					mousedown_event.ctrlKey(ctrlKey);
					mousedown_event.shiftKey(shiftKey);
					mousedown_event.altKey(altKey);
					mousedown_event.metaKey(metaKey);
					mousedown_event.button(button);
					mousedown_event.buttons(buttons);
					mousedown_event.relatedTarget(relatedTarget);
					mousedown_event.pageX(pageX);
					mousedown_event.pageY(pageY);
					mousedown_event.x(x);
					mousedown_event.y(y);
					mousedown_event.offsetX(offsetX);
					mousedown_event.offsetY(offsetY);
					mousedown_event.movementX(movementX);
					mousedown_event.movementY(movementY);
					dispatchEvent(mousedown_event);
				
                    break;
                }
            }
            else if (button_state[1]) {
                button_state[1] = false;
                button = 2;

				DKMouseEvent mouseup_event("mouseup", "");
				mouseup_event.screenX(screenX);
				mouseup_event.screenY(screenY);
				mouseup_event.clientX(clientX);
				mouseup_event.clientY(clientY);
				mouseup_event.ctrlKey(ctrlKey);
				mouseup_event.shiftKey(shiftKey);
				mouseup_event.altKey(altKey);
				mouseup_event.metaKey(metaKey);
				mouseup_event.button(button);
				mouseup_event.buttons(buttons);
				mouseup_event.relatedTarget(relatedTarget);
				mouseup_event.pageX(pageX);
				mouseup_event.pageY(pageY);
				mouseup_event.x(x);
				mouseup_event.y(y);
				mouseup_event.offsetX(offsetX);
				mouseup_event.offsetY(offsetY);
				mouseup_event.movementX(movementX);
				mouseup_event.movementY(movementY);
				dispatchEvent(mouseup_event);

				DKMouseEvent contextmenu_event("contextmenu", "");
				contextmenu_event.screenX(screenX);
				contextmenu_event.screenY(screenY);
				contextmenu_event.clientX(clientX);
				contextmenu_event.clientY(clientY);
				contextmenu_event.ctrlKey(ctrlKey);
				contextmenu_event.shiftKey(shiftKey);
				contextmenu_event.altKey(altKey);
				contextmenu_event.metaKey(metaKey);
				contextmenu_event.button(button);
				contextmenu_event.buttons(buttons);
				contextmenu_event.relatedTarget(relatedTarget);
				contextmenu_event.pageX(pageX);
				contextmenu_event.pageY(pageY);
				contextmenu_event.x(x);
				contextmenu_event.y(y);
				contextmenu_event.offsetX(offsetX);
				contextmenu_event.offsetY(offsetY);
				contextmenu_event.movementX(movementX);
				contextmenu_event.movementY(movementY);
				dispatchEvent(contextmenu_event);
				
                break;
            }

            if (mer.dwButtonState & FROM_LEFT_2ND_BUTTON_PRESSED) {  // 0x0004
                if (!button_state[2]) {
                    button_state[2] = true;
                    button = 1;
                    
					DKMouseEvent mousedown_event("mousedown", "");
					mousedown_event.screenX(screenX);
					mousedown_event.screenY(screenY);
					mousedown_event.clientX(clientX);
					mousedown_event.clientY(clientY);
					mousedown_event.ctrlKey(ctrlKey);
					mousedown_event.shiftKey(shiftKey);
					mousedown_event.altKey(altKey);
					mousedown_event.metaKey(metaKey);
					mousedown_event.button(button);
					mousedown_event.buttons(buttons);
					mousedown_event.relatedTarget(relatedTarget);
					mousedown_event.pageX(pageX);
					mousedown_event.pageY(pageY);
					mousedown_event.x(x);
					mousedown_event.y(y);
					mousedown_event.offsetX(offsetX);
					mousedown_event.offsetY(offsetY);
					mousedown_event.movementX(movementX);
					mousedown_event.movementY(movementY);
					dispatchEvent(mousedown_event);
					
                    break;
                }
            }
            else if (button_state[2]) {
                button_state[2] = false;
                button = 1;
                
				DKMouseEvent mouseup_event("mouseup", "");
				mouseup_event.screenX(screenX);
				mouseup_event.screenY(screenY);
				mouseup_event.clientX(clientX);
				mouseup_event.clientY(clientY);
				mouseup_event.ctrlKey(ctrlKey);
				mouseup_event.shiftKey(shiftKey);
				mouseup_event.altKey(altKey);
				mouseup_event.metaKey(metaKey);
				mouseup_event.button(button);
				mouseup_event.buttons(buttons);
				mouseup_event.relatedTarget(relatedTarget);
				mouseup_event.pageX(pageX);
				mouseup_event.pageY(pageY);
				mouseup_event.x(x);
				mouseup_event.y(y);
				mouseup_event.offsetX(offsetX);
				mouseup_event.offsetY(offsetY);
				mouseup_event.movementX(movementX);
				mouseup_event.movementY(movementY);
				dispatchEvent(mouseup_event);
				
                break;
            }

            if (mer.dwButtonState & FROM_LEFT_3RD_BUTTON_PRESSED) {  // 0x0008
                if (!button_state[3]) {
                    button_state[3] = true;
                    button = 3;
                    
					DKMouseEvent mousedown_event("mousedown", "");
					mousedown_event.screenX(screenX);
					mousedown_event.screenY(screenY);
					mousedown_event.clientX(clientX);
					mousedown_event.clientY(clientY);
					mousedown_event.ctrlKey(ctrlKey);
					mousedown_event.shiftKey(shiftKey);
					mousedown_event.altKey(altKey);
					mousedown_event.metaKey(metaKey);
					mousedown_event.button(button);
					mousedown_event.buttons(buttons);
					mousedown_event.relatedTarget(relatedTarget);
					mousedown_event.pageX(pageX);
					mousedown_event.pageY(pageY);
					mousedown_event.x(x);
					mousedown_event.y(y);
					mousedown_event.offsetX(offsetX);
					mousedown_event.offsetY(offsetY);
					mousedown_event.movementX(movementX);
					mousedown_event.movementY(movementY);
					dispatchEvent(mousedown_event);
					
                    break;
                }
            }
            else if (button_state[3]) {
                button_state[3] = false;
                button = 3;
                
				DKMouseEvent mouseup_event("mouseup", "");
				mouseup_event.screenX(screenX);
				mouseup_event.screenY(screenY);
				mouseup_event.clientX(clientX);
				mouseup_event.clientY(clientY);
				mouseup_event.ctrlKey(ctrlKey);
				mouseup_event.shiftKey(shiftKey);
				mouseup_event.altKey(altKey);
				mouseup_event.metaKey(metaKey);
				mouseup_event.button(button);
				mouseup_event.buttons(buttons);
				mouseup_event.relatedTarget(relatedTarget);
				mouseup_event.pageX(pageX);
				mouseup_event.pageY(pageY);
				mouseup_event.x(x);
				mouseup_event.y(y);
				mouseup_event.offsetX(offsetX);
				mouseup_event.offsetY(offsetY);
				mouseup_event.movementX(movementX);
				mouseup_event.movementY(movementY);
				dispatchEvent(mouseup_event);
				
                break;
            }

            if (mer.dwButtonState & FROM_LEFT_4TH_BUTTON_PRESSED) { // 0x0010
                if (!button_state[4]) {
                    button_state[4] = true;
                    button = 4;
                    
					DKMouseEvent mousedown_event("mousedown", "");
					mousedown_event.screenX(screenX);
					mousedown_event.screenY(screenY);
					mousedown_event.clientX(clientX);
					mousedown_event.clientY(clientY);
					mousedown_event.ctrlKey(ctrlKey);
					mousedown_event.shiftKey(shiftKey);
					mousedown_event.altKey(altKey);
					mousedown_event.metaKey(metaKey);
					mousedown_event.button(button);
					mousedown_event.buttons(buttons);
					mousedown_event.relatedTarget(relatedTarget);
					mousedown_event.pageX(pageX);
					mousedown_event.pageY(pageY);
					mousedown_event.x(x);
					mousedown_event.y(y);
					mousedown_event.offsetX(offsetX);
					mousedown_event.offsetY(offsetY);
					mousedown_event.movementX(movementX);
					mousedown_event.movementY(movementY);
					dispatchEvent(mousedown_event);
					
                    break;
                }
            }
            else if (button_state[4]) {
                button_state[4] = false;
                button = 4;
                
				DKMouseEvent mouseup_event("mouseup", "");
				mouseup_event.screenX(screenX);
				mouseup_event.screenY(screenY);
				mouseup_event.clientX(clientX);
				mouseup_event.clientY(clientY);
				mouseup_event.ctrlKey(ctrlKey);
				mouseup_event.shiftKey(shiftKey);
				mouseup_event.altKey(altKey);
				mouseup_event.metaKey(metaKey);
				mouseup_event.button(button);
				mouseup_event.buttons(buttons);
				mouseup_event.relatedTarget(relatedTarget);
				mouseup_event.pageX(pageX);
				mouseup_event.pageY(pageY);
				mouseup_event.x(x);
				mouseup_event.y(y);
				mouseup_event.offsetX(offsetX);
				mouseup_event.offsetY(offsetY);
				mouseup_event.movementX(movementX);
				mouseup_event.movementY(movementY);
				dispatchEvent(mouseup_event);
				
                break;
            }
			break;
		case DOUBLE_CLICK: {
			DKMouseEvent dblclick_event("dblclick", "");
			dblclick_event.screenX(screenX);
			dblclick_event.screenY(screenY);
			dblclick_event.clientX(clientX);
			dblclick_event.clientY(clientY);
			dblclick_event.ctrlKey(ctrlKey);
			dblclick_event.shiftKey(shiftKey);
			dblclick_event.altKey(altKey);
			dblclick_event.metaKey(metaKey);
			dblclick_event.button(button);
			dblclick_event.buttons(buttons);
			dblclick_event.relatedTarget(relatedTarget);
			dblclick_event.pageX(pageX);
			dblclick_event.pageY(pageY);
			dblclick_event.x(x);
			dblclick_event.y(y);
			dblclick_event.offsetX(offsetX);
			dblclick_event.offsetY(offsetY);
			dblclick_event.movementX(movementX);
			dblclick_event.movementY(movementY);
			dispatchEvent(dblclick_event);
			break;
		}
		case MOUSE_HWHEELED: { //horizontal mouse wheel
            button = 0;
            if ((int32_t)mer.dwButtonState > 0)
                deltaX = -100;
            if ((int32_t)mer.dwButtonState < 0)
                deltaX = 100;
            DKWheelEvent wheel_event("wheel", "");
			wheel_event.deltaX(deltaX);
			wheel_event.screenX(screenX);
			wheel_event.screenY(screenY);
			wheel_event.clientX(clientX);
			wheel_event.clientY(clientY);
			wheel_event.ctrlKey(ctrlKey);
			wheel_event.shiftKey(shiftKey);
			wheel_event.altKey(altKey);
			wheel_event.metaKey(metaKey);
			wheel_event.button(button);
			wheel_event.buttons(buttons);
			wheel_event.relatedTarget(relatedTarget);
			wheel_event.pageX(pageX);
			wheel_event.pageY(pageY);
			wheel_event.x(x);
			wheel_event.y(y);
			wheel_event.offsetX(offsetX);
			wheel_event.offsetY(offsetY);
			wheel_event.movementX(movementX);
			wheel_event.movementY(movementY);
			dispatchEvent(wheel_event);
			break;
		}
		case MOUSE_WHEELED: { //vertical mouse wheel
            button = 0;
            if ((int32_t)mer.dwButtonState > 0)
                deltaY = -100;
            if ((int32_t)mer.dwButtonState < 0)
                deltaY = 100;
			DKWheelEvent wheel_event("wheel", "");
			wheel_event.deltaY(deltaY);
			wheel_event.screenX(screenX);
			wheel_event.screenY(screenY);
			wheel_event.clientX(clientX);
			wheel_event.clientY(clientY);
			wheel_event.ctrlKey(ctrlKey);
			wheel_event.shiftKey(shiftKey);
			wheel_event.altKey(altKey);
			wheel_event.metaKey(metaKey);
			wheel_event.button(button);
			wheel_event.buttons(buttons);
			wheel_event.relatedTarget(relatedTarget);
			wheel_event.pageX(pageX);
			wheel_event.pageY(pageY);
			wheel_event.x(x);
			wheel_event.y(y);
			wheel_event.offsetX(offsetX);
			wheel_event.offsetY(offsetY);
			wheel_event.movementX(movementX);
			wheel_event.movementY(movementY);
			dispatchEvent(wheel_event);
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
            //layerX = clientX;
            //layerY = clientY;
            movementX = clientX - x;
            movementY = clientY - y;
            offsetX = clientX;
            offsetY = clientY;
            pageX = clientX;
            pageY = clientY;
            x = clientX;
            y = clientY;
            
			DKMouseEvent mousemove_event("mousemove", "");
			mousemove_event.screenX(screenX);
			mousemove_event.screenY(screenY);
			mousemove_event.clientX(clientX);
			mousemove_event.clientY(clientY);
			mousemove_event.ctrlKey(ctrlKey);
			mousemove_event.shiftKey(shiftKey);
			mousemove_event.altKey(altKey);
			mousemove_event.metaKey(metaKey);
			mousemove_event.button(button);
			mousemove_event.buttons(buttons);
			mousemove_event.relatedTarget(relatedTarget);
			mousemove_event.pageX(pageX);
			mousemove_event.pageY(pageY);
			mousemove_event.x(x);
			mousemove_event.y(y);
			mousemove_event.offsetX(offsetX);
			mousemove_event.offsetY(offsetY);
			mousemove_event.movementX(movementX);
			mousemove_event.movementY(movementY);
			dispatchEvent(mousemove_event);
				
            break;
		}
		default:
			DKERROR("unknown event! \n");
			break;
    }
}

void DKConsoleWindow::ResizeEventProc(WINDOW_BUFFER_SIZE_RECORD wbsr) {
    DKDEBUGFUNC(wbsr);
	DKWARN("DKConsoleWindow::ResizeEventProc()\n");
    columns = wbsr.dwSize.X;
    rows = wbsr.dwSize.Y;

	/*
	DKResizeEvent resize_event("resize", "");
	dispatchEvent(resize_event);
	*/
}
#endif