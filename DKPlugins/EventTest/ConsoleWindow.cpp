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
#include "EventTest/ConsoleWindow.h"


bool ConsoleWindow::Init(){
	DKDEBUGFUNC();

	//// Instance properties ////
	DKDuktape::AttachFunction("CPP_ConsoleWindow_innerHeight", ConsoleWindow::innerHeight);
	DKDuktape::AttachFunction("CPP_ConsoleWindow_innerWidth", ConsoleWindow::innerWidth);
	DKDuktape::AttachFunction("CPP_ConsoleWindow_outerHeight", ConsoleWindow::outerHeight);
	DKDuktape::AttachFunction("CPP_ConsoleWindow_outerWidth", ConsoleWindow::outerWidth);
	DKDuktape::AttachFunction("CPP_ConsoleWindow_screenX", ConsoleWindow::ScreenX);
	DKDuktape::AttachFunction("CPP_ConsoleWindow_screenLeft", ConsoleWindow::screenLeft);
	DKDuktape::AttachFunction("CPP_ConsoleWindow_screenY", ConsoleWindow::ScreenY);
	DKDuktape::AttachFunction("CPP_ConsoleWindow_screenTop", ConsoleWindow::screenTop);
	
	//// Instance methods ////
	DKDuktape::AttachFunction("CPP_ConsoleWindow_blur", ConsoleWindow::blur);
	DKDuktape::AttachFunction("CPP_ConsoleWindow_close", ConsoleWindow::close);
	DKDuktape::AttachFunction("CPP_ConsoleWindow_focus", ConsoleWindow::focus);
	DKDuktape::AttachFunction("CPP_ConsoleWindow_moveBy", ConsoleWindow::moveBy);
	DKDuktape::AttachFunction("CPP_ConsoleWindow_moveTo", ConsoleWindow::moveTo);
	DKDuktape::AttachFunction("CPP_ConsoleWindow_resizeBy", ConsoleWindow::resizeBy);
	DKDuktape::AttachFunction("CPP_ConsoleWindow_resizeTo", ConsoleWindow::resizeTo);
	
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
	relativeTarget = "";
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
    //wheelDelta = 0;
    //wheelDeltaX = 0;
    //wheelDeltaY = 0;

    // FocusEvent
    relatedTarget = "";

    DKApp::AppendLoopFunc(&ConsoleWindow::Loop, this);
    return true;
}

bool ConsoleWindow::End(){
	DKDEBUGFUNC();
#if WIN
    SetConsoleMode(hStdin, fdwSaveOldMode); // Restore input mode on exit.
#endif
	return true;
}

void ConsoleWindow::Loop() {
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

    DWORD cNumRead, fdwMode, i;
    INPUT_RECORD irInBuf[128];
    if (!ReadConsoleInput(
        hStdin,      // input buffer handle 
        irInBuf,     // buffer to read into 
        128,         // size of read buffer 
        &cNumRead))  // number of records read 
            ErrorExit("ReadConsoleWindow");

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
            case MENU_EVENT: // disregard menu events 
                break;
            default:
                ErrorExit("Unknown event type");
                break;
        }
    }
#endif
}

//// Instance properties ////
int ConsoleWindow::innerHeight(duk_context* ctx){ //Read only
    RECT rect;
    GetClientRect(GetConsoleWindow(), &rect);
    ClientToScreen(GetConsoleWindow(), reinterpret_cast<POINT*>(&rect.left)); // convert top-left
    ClientToScreen(GetConsoleWindow(), reinterpret_cast<POINT*>(&rect.right)); // convert bottom-right
    unsigned int iHeight = rect.right - rect.left;
	duk_push_uint(ctx, iHeight);
	return true;
}

int ConsoleWindow::innerWidth(duk_context* ctx){ //Read only
    RECT rect;
    GetClientRect(GetConsoleWindow(), &rect);
    ClientToScreen(GetConsoleWindow(), reinterpret_cast<POINT*>(&rect.left)); // convert top-left
    ClientToScreen(GetConsoleWindow(), reinterpret_cast<POINT*>(&rect.right)); // convert bottom-right
    unsigned int iWidth = rect.bottom - rect.top;
    duk_push_uint(ctx, iWidth);
	return true;
}

int ConsoleWindow::outerHeight(duk_context* ctx){ //Read only
	RECT rect;
	GetWindowRect(GetConsoleWindow(), &rect);
    unsigned int oHeight = rect.bottom - rect.top;
	duk_push_uint(ctx, oHeight);
	return true;
}

int ConsoleWindow::outerWidth(duk_context* ctx){ //Read only
	RECT rect;
	GetWindowRect(GetConsoleWindow(), &rect);
    unsigned int oWidth = rect.right - rect.left;
    duk_push_uint(ctx, oWidth);
	return true;
}

int ConsoleWindow::ScreenX(duk_context* ctx){ //Read only
    RECT rect;
    GetClientRect(GetConsoleWindow(), &rect);
    ClientToScreen(GetConsoleWindow(), reinterpret_cast<POINT*>(&rect.left)); // convert top-left
    ClientToScreen(GetConsoleWindow(), reinterpret_cast<POINT*>(&rect.right)); // convert bottom-right
    int sX = rect.left;
    duk_push_int(ctx, sX);
	return true;
}

int ConsoleWindow::screenLeft(duk_context* ctx){ //Read only
    RECT rect;
    GetClientRect(GetConsoleWindow(), &rect);
    ClientToScreen(GetConsoleWindow(), reinterpret_cast<POINT*>(&rect.left)); // convert top-left
    ClientToScreen(GetConsoleWindow(), reinterpret_cast<POINT*>(&rect.right)); // convert bottom-right
    int sLeft = rect.left;
    duk_push_int(ctx, sLeft);
	return true;
}

int ConsoleWindow::ScreenY(duk_context* ctx){ //Read only
    RECT rect;
    GetClientRect(GetConsoleWindow(), &rect);
    ClientToScreen(GetConsoleWindow(), reinterpret_cast<POINT*>(&rect.left)); // convert top-left
    ClientToScreen(GetConsoleWindow(), reinterpret_cast<POINT*>(&rect.right)); // convert bottom-right
    int sY = rect.top;
    duk_push_int(ctx, sY);
	return true;
}

int ConsoleWindow::screenTop(duk_context* ctx){ //Read only
    RECT rect;
    GetClientRect(GetConsoleWindow(), &rect);
    ClientToScreen(GetConsoleWindow(), reinterpret_cast<POINT*>(&rect.left)); // convert top-left
    ClientToScreen(GetConsoleWindow(), reinterpret_cast<POINT*>(&rect.right)); // convert bottom-right
    int sTop = rect.top;
    duk_push_int(ctx, sTop);
    return true;
}

//// Instance methods ////
int ConsoleWindow::blur(duk_context* ctx){
	// TODO
	return true;
}
int ConsoleWindow::close(duk_context* ctx){
	// TODO
	return true;
}
int ConsoleWindow::focus(duk_context* ctx){
	// TODO
	return true;
}
int ConsoleWindow::moveBy(duk_context* ctx){
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
	return true;
}
int ConsoleWindow::moveTo(duk_context* ctx){
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
	return true;
}
int ConsoleWindow::resizeBy(duk_context* ctx){
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
	return true;
}
int ConsoleWindow::resizeTo(duk_context* ctx){
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
    return true;
}
	
	
#if WIN
void ConsoleWindow::ErrorExit(LPCSTR lpszMessage){
    fprintf(stderr, "%s\n", lpszMessage);
    // Restore input mode on exit.
    SetConsoleMode(hStdin, fdwSaveOldMode);
    ExitProcess(0);
}

void ConsoleWindow::FocusEventProc(FOCUS_EVENT_RECORD fer) {
    DKString address = DKDuktape::pointerToAddress(this);
    DKString rval;
    DKString code;

    relatedTarget = address;

    if (!fer.bSetFocus) {
        //1. blur: sent after element A loses focus.
        code = "doFocusEvent('blur','','" + address + "')";
        DKDuktape::RunDuktape(code, rval);

        //2. focusout: sent after the blur event.
        code = "doFocusEvent('focusout','','" + address + "')";
        DKDuktape::RunDuktape(code, rval);
    }
    else {
        //3. focus: sent after element B receives focus.
        code = "doFocusEvent('focus','','" + address + "')";
        DKDuktape::RunDuktape(code, rval);

        //4. focusin: sent after the focus event.
        code = "doFocusEvent('focusin','','" + address + "')";
        DKDuktape::RunDuktape(code, rval);
    }
}

void ConsoleWindow::KeyboardEventProc(KEY_EVENT_RECORD ker){
    DKString address = DKDuktape::pointerToAddress(this);
    DKString rval;
    DKString code;

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
        code = "doKeyboardEvent('keydown','','" + address + "')";
        DKDuktape::RunDuktape(code, rval);

		//Only fire keypress on alphanumeric keys.
        if (ker.uChar.AsciiChar < 32)
            return;
		code = "doKeyboardEvent('keypress','','" + address + "')";
		DKDuktape::RunDuktape(code, rval);
    }
    else {
        code = "doKeyboardEvent('keyup','','" + address + "')";
        DKDuktape::RunDuktape(code, rval);
    }
}

void ConsoleWindow::MouseEventProc(MOUSE_EVENT_RECORD mer){
    //DKINFO("ConsoleWindow::MouseEventProc()\n");
	#ifndef MOUSE_HWHEELED
		#define MOUSE_HWHEELED 0x0008
	#endif
    DKString address = DKDuktape::pointerToAddress(this);
    DKString rval;
    DKString code;

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
                    code = "doMouseEvent('mousedown','','" + address + "')";
                    DKDuktape::RunDuktape(code, rval);
                    break;
                }
            }
            else if (button_state[0]) {
                button_state[0] = false;
                button = 0;
                code = "doMouseEvent('mouseup','','" + address + "')";
                DKDuktape::RunDuktape(code, rval);

                code = "doMouseEvent('click','','" + address + "')";
                DKDuktape::RunDuktape(code, rval);
                break;
            }

            if ((mer.dwButtonState & RIGHTMOST_BUTTON_PRESSED)) {      // 0x0002
                if (!button_state[1]) {
                    button_state[1] = true;
                    button = 2;
                    code = "doMouseEvent('mousedown','','" + address + "')";
                    DKDuktape::RunDuktape(code, rval);
                    break;
                }
            }
            else if (button_state[1]) {
                button_state[1] = false;
                button = 2;
                code = "doMouseEvent('mouseup','','" + address + "')";
                DKDuktape::RunDuktape(code, rval);

                code = "doMouseEvent('contextmenu','','" + address + "')";
                DKDuktape::RunDuktape(code, rval);
                break;
            }

            if (mer.dwButtonState & FROM_LEFT_2ND_BUTTON_PRESSED) {  // 0x0004
                if (!button_state[2]) {
                    button_state[2] = true;
                    button = 1;
                    code = "doMouseEvent('mousedown','','" + address + "')";
                    DKDuktape::RunDuktape(code, rval);
                    break;
                }
            }
            else if (button_state[2]) {
                button_state[2] = false;
                button = 1;
                code = "doMouseEvent('mouseup','','" + address + "')";
                DKDuktape::RunDuktape(code, rval);
                break;
            }

            if (mer.dwButtonState & FROM_LEFT_3RD_BUTTON_PRESSED) {  // 0x0008
                if (!button_state[3]) {
                    button_state[3] = true;
                    button = 3;
                    code = "doMouseEvent('mousedown','','" + address + "')";
                    DKDuktape::RunDuktape(code, rval);
                    break;
                }
            }
            else if (button_state[3]) {
                button_state[3] = false;
                button = 3;
                code = "doMouseEvent('mouseup','','" + address + "')";
                DKDuktape::RunDuktape(code, rval);
                break;
            }

            if (mer.dwButtonState & FROM_LEFT_4TH_BUTTON_PRESSED) { // 0x0010
                if (!button_state[4]) {
                    button_state[4] = true;
                    button = 4;
                    code = "doMouseEvent('mousedown','','" + address + "')";
                    DKDuktape::RunDuktape(code, rval);
                    break;
                }
            }
            else if (button_state[4]) {
                button_state[4] = false;
                button = 4;
                code = "doMouseEvent('mouseup','','" + address + "')";
                DKDuktape::RunDuktape(code, rval);
                break;
            }
			break;
		case DOUBLE_CLICK:
            code = "doMouseEvent('dblclick','','" + address + "')";
            DKDuktape::RunDuktape(code, rval);
			break;
		case MOUSE_HWHEELED: //horizontal mouse wheel
            button = 0;
            if ((int32_t)mer.dwButtonState > 0)
                deltaX = -100;
            if ((int32_t)mer.dwButtonState < 0)
                deltaX = 100;
            code = "doWheelEvent('wheel','','" + address + "')";
            DKDuktape::RunDuktape(code, rval);
			break;
		case MOUSE_WHEELED: //vertical mouse wheel
            button = 0;
            if ((int32_t)mer.dwButtonState > 0)
                deltaY = -100;
            if ((int32_t)mer.dwButtonState < 0)
                deltaY = 100;
            code = "doWheelEvent('wheel','','" + address + "')";
            DKDuktape::RunDuktape(code, rval);
			break;
        case MOUSE_MOVED:
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
            
            code = "doMouseEvent('mousemove','','" + address + "')";
            DKDuktape::RunDuktape(code, rval);
            break;
		default:
			DKERROR("unknown event! \n");
			break;
    }
}

void ConsoleWindow::ResizeEventProc(WINDOW_BUFFER_SIZE_RECORD wbsr){
	DKString address = DKDuktape::pointerToAddress(this);
    DKString rval;
    DKString code;
	
	//DKINFO("resize     columns="+toString(wbsr.dwSize.X)+", rows="+toString(wbsr.dwSize.Y)+" \n");
	code = "doMouseEvent('resize','','" + address + "')";
    DKDuktape::RunDuktape(code, rval);
}
#endif
