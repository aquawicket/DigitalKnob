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
    if (ker.dwControlKeyState & RIGHT_ALT_PRESSED || ker.dwControlKeyState & LEFT_ALT_PRESSED)
        altKey = true;
    else
        altKey = false;

    // code
    code = "todo";

    // ctrlKey
    if (ker.dwControlKeyState & RIGHT_CTRL_PRESSED || ker.dwControlKeyState & LEFT_CTRL_PRESSED)
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
    metaKey = false; //FIXME: todo

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
            // To event.button
            // 0 = Left button(primary)
            // 1 = Middle button(auxiliary)
            // 2 = Right button(secondary)
            // 3 = X1 button(back)
            // 4 = X2 button(forward)

            if (mer.dwButtonState == FROM_LEFT_1ST_BUTTON_PRESSED) {  // 0x0001
                button = 0;
                buttons[0] = true;
                //DKINFO("mousedown     button=0\n");
                code = "doMouseEvent('mousedown','','" + address + "')";
                DKDuktape::RunDuktape(code, rval);
            }
            else if (buttons[0]) {
                button = 0;
                buttons[0] = false;
                //DKINFO("mouseup     button=0\n");
                code = "doMouseEvent('mouseup','','" + address + "')";
                DKDuktape::RunDuktape(code, rval);

                //DKINFO("click     button=0\n");
                code = "doMouseEvent('" + address + "','click')";
                DKDuktape::RunDuktape(code, rval);
            }

            if (mer.dwButtonState == FROM_LEFT_2ND_BUTTON_PRESSED) {  // 0x0004
                button = 1;
                buttons[1] = true;
                //DKINFO("mousedown     button=1\n");
                code = "doMouseEvent('mousedown','','" + address + "')";
                DKDuktape::RunDuktape(code, rval);
            }
            else if (buttons[1]) {
                button = 1;
                buttons[1] = false;
                //DKINFO("mouseup     button=1\n");
                code = "doMouseEvent('mouseup','','" + address + "')";
                DKDuktape::RunDuktape(code, rval);
            }

            if (mer.dwButtonState == RIGHTMOST_BUTTON_PRESSED) {      // 0x0002
                button = 2;
                buttons[2] = true;
                //DKINFO("mousedown     button=2\n");
                code = "doMouseEvent('mousedown','','" + address + "')";
                DKDuktape::RunDuktape(code, rval);
            }
            else if (buttons[2]) {
                button = 2;
                buttons[2] = false;
                //DKINFO("mouseup     button=2\n");
                code = "doMouseEvent('mouseup','','" + address + "')";
                DKDuktape::RunDuktape(code, rval);

                //DKINFO("contextmenu     button=2\n");
                code = "doMouseEvent('" + address + "','contextmenu')";
                DKDuktape::RunDuktape(code, rval);
            }

            if (mer.dwButtonState == FROM_LEFT_3RD_BUTTON_PRESSED) {  // 0x0008
                button = 3;
                buttons[3] = true;
                //DKINFO("mousedown     button=3\n");
                code = "doMouseEvent('mousedown','','" + address + "')";
                DKDuktape::RunDuktape(code, rval);
            }
            else if (buttons[3]) {
                button = 3;
                buttons[3] = false;
                //DKINFO("mouseup     button=3\n");
                code = "doMouseEvent('mouseup','','" + address + "')";
                DKDuktape::RunDuktape(code, rval);
            }

            if (mer.dwButtonState == FROM_LEFT_4TH_BUTTON_PRESSED) { // 0x0010
                button = 4;
                buttons[4] = true;
                //DKINFO("mousedown     button=4\n");
                code = "doMouseEvent('mousedown','','" + address + "')";
                DKDuktape::RunDuktape(code, rval);
            }
            else if (buttons[4]) {
                button = 4;
                buttons[4] = false;
                //DKINFO("mouseup     button=4\n");
                code = "doMouseEvent('mouseup','','" + address + "')";
                DKDuktape::RunDuktape(code, rval);
            }
			break;
		case DOUBLE_CLICK:
			//DKINFO("ondblclick \n");
            code = "doMouseEvent('dblclick','','" + address + "')";
            DKDuktape::RunDuktape(code, rval);
			break;
		case MOUSE_HWHEELED: //horizontal mouse wheel
			//DKINFO("onwheel \n");
            code = "doWheelEvent('wheel','','" + address + "')";
            DKDuktape::RunDuktape(code, rval);
			break;
		case MOUSE_WHEELED: //vertical mouse wheel
			//DKINFO("onwheel \n");
            code = "doWheelEvent('wheel','','" + address + "')";
            DKDuktape::RunDuktape(code, rval);
			break;
        case MOUSE_MOVED:
            //DKINFO("onmousemove \n");
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
