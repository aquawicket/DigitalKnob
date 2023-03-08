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
#include "EventTest/ConsoleInput.h"


bool ConsoleInput::Init(){
	DKDEBUGFUNC();

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
	
	// Keyboard
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
	
	// Mouse
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
	
    DKApp::AppendLoopFunc(&ConsoleInput::Loop, this);
    return true;
}

bool ConsoleInput::End(){
	DKDEBUGFUNC();

#if WIN
    // Restore input mode on exit.
    SetConsoleMode(hStdin, fdwSaveOldMode);
#endif

	return true;
}

void ConsoleInput::Loop() {

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
            ErrorExit("ReadConsoleInput");

    // Dispatch the events to the appropriate handler. 
    for (i = 0; i < cNumRead; i++) {
        switch (irInBuf[i].EventType) {
            case KEY_EVENT: // keyboard input 
                KeyEventProc(irInBuf[i].Event.KeyEvent);
                break;
            case MOUSE_EVENT: // mouse input 
                MouseEventProc(irInBuf[i].Event.MouseEvent);
                break;
            case WINDOW_BUFFER_SIZE_EVENT: // scrn buf. resizing 
                ResizeEventProc(irInBuf[i].Event.WindowBufferSizeEvent);
                break;
            case FOCUS_EVENT:  // disregard focus events 
            case MENU_EVENT:   // disregard menu events 
                break;
            default:
                ErrorExit("Unknown event type");
                break;
        }
    }
#endif
}

#if WIN
void ConsoleInput::ErrorExit(LPCSTR lpszMessage){
    fprintf(stderr, "%s\n", lpszMessage);
    // Restore input mode on exit.
    SetConsoleMode(hStdin, fdwSaveOldMode);
    ExitProcess(0);
}

void ConsoleInput::KeyEventProc(KEY_EVENT_RECORD ker){
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

void ConsoleInput::MouseEventProc(MOUSE_EVENT_RECORD mer){
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
                DKINFO("1 ");
                buttons = buttons + 1;
            }
            else {
                DKINFO("0 ");
            }
            if (mer.dwButtonState & FROM_LEFT_2ND_BUTTON_PRESSED) {  // 0x0004
                DKINFO("2 ");
                buttons = buttons + 4;
            }
            else {
                DKINFO("0 ");
            }
            if (mer.dwButtonState & RIGHTMOST_BUTTON_PRESSED) {      // 0x0002
                DKINFO("3 ");
                buttons = buttons + 2;
            }
            else {
                DKINFO("0 ");
            }
            if (mer.dwButtonState & FROM_LEFT_3RD_BUTTON_PRESSED) {  // 0x0008
                DKINFO("4 ");
                buttons = buttons + 8;
            }
            else {
                DKINFO("0 ");
            }
            if (mer.dwButtonState & FROM_LEFT_4TH_BUTTON_PRESSED) {  // 0x0010
                DKINFO("5 \n");
                buttons = buttons + 16;
            }
            else {
                DKINFO("0 \n");
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
            code = "doWheelEvent('wheel','','" + address + "')";
            DKDuktape::RunDuktape(code, rval);
			break;
		case MOUSE_WHEELED: //vertical mouse wheel
            button = 0;
            code = "doWheelEvent('wheel','','" + address + "')";
            DKDuktape::RunDuktape(code, rval);
			break;
        case MOUSE_MOVED:
            //// Cursor Position ////
            // colume = mer.dwMousePosition.X;
            // row = mer.dwMousePosition.Y;

            //// Get window client rect screen position ////
            // https://stackoverflow.com/a/15734569/688352
            RECT rc;
            GetClientRect(GetConsoleWindow(), &rc); // get client coords
            ClientToScreen(GetConsoleWindow(), reinterpret_cast<POINT*>(&rc.left)); // convert top-left
            ClientToScreen(GetConsoleWindow(), reinterpret_cast<POINT*>(&rc.right)); // convert bottom-right

            //// Mouse Position ////
            int mousex, mousey;
            DKUtil::GetMousePos(mousex, mousey);

            clientX = mousex - rc.left;
            clientY = mousey - rc.top;
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

void ConsoleInput::ResizeEventProc(WINDOW_BUFFER_SIZE_RECORD wbsr){
	DKString address = DKDuktape::pointerToAddress(this);
    DKString rval;
    DKString code;
	
	DKINFO("resize     columns="+toString(wbsr.dwSize.X)+", rows="+toString(wbsr.dwSize.Y)+" \n");
	code = "doMouseEvent('resize','','" + address + "')";
    DKDuktape::RunDuktape(code, rval);
}
#endif
