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
        if (ker.bKeyDown) {
            //DKINFO("KeyDown: vkk:"+toString(ker.wVirtualKeyCode)+", vsc:"+toString(ker.wVirtualScanCode) + "\n");
            //DKDuktape::doEvent(this, "keydown");
            DKString address = DKDuktape::pointerToAddress(this);
            DKString type = "keydown";
            DKString code = "doKeyboardEvent('" + address + "','" + type + "')";
            DKString rval;
            DKDuktape::RunDuktape(code, rval);
            //DKINFO("rval = " + rval + "\n");
			
			//Only fire keypress on alphanumeric keys.
            if (ker.uChar.AsciiChar < 32)
                return;
			type = "keypress";
			code = "doKeyboardEvent('" + address + "','" + type + "')";
			DKDuktape::RunDuktape(code, rval);
			//DKINFO("rval = " + rval + "\n");
        }
        else {
            //DKINFO("KeyUp: vkk:" + toString(ker.wVirtualKeyCode) + ", vsc:" + toString(ker.wVirtualScanCode) + "\n");
            //DKDuktape::doEvent(this, "keyup");
            DKString address = DKDuktape::pointerToAddress(this);
            DKString type = "keyup";
            DKString code = "doKeyboardEvent('" + address + "','" + type + "')";
            DKString rval;
            DKDuktape::RunDuktape(code, rval);
            //DKINFO("rval = " + rval + "\n");
        }
    }

    void ConsoleInput::MouseEventProc(MOUSE_EVENT_RECORD mer){
    #ifndef MOUSE_HWHEELED
    #define MOUSE_HWHEELED 0x0008
    #endif

        switch (mer.dwEventFlags){
			case 0:
				//printf("onmousedown\n");
				
                // To event.button
                // 0 = Left button(primary)
                // 1 = Middle button(auxiliary)
                // 2 = Right button(secondary)
                // 3 = X1 button(back)
                // 4 = X2 button(forward)


                if (mer.dwButtonState == FROM_LEFT_1ST_BUTTON_PRESSED) {  // 0x0001
                    buttons[0] = true;
                    printf("mousedown     button=0\n");
                }
                else if (buttons[0]) {
                    buttons[0] = false;
                    printf("mouseup     button=0\n");
                    printf("click     button=0\n");
                }

                if (mer.dwButtonState == FROM_LEFT_2ND_BUTTON_PRESSED) {  // 0x0004
                    buttons[1] = true;
                    printf("mousedown     button=1\n");
                }
                else if (buttons[1]) {
                    buttons[1] = false;
                    printf("mouseup     button=1\n");
                }

                if (mer.dwButtonState == RIGHTMOST_BUTTON_PRESSED) {      // 0x0002
                    buttons[2] = true;
                    printf("mousedown     button=2\n");
                }
                else if (buttons[2]) {
                    buttons[2] = false;
                    printf("mouseup     button=2\n");
                    printf("contextmenu     button=2\n");
                }

                if (mer.dwButtonState == FROM_LEFT_3RD_BUTTON_PRESSED) {  // 0x0008
                    buttons[3] = true;
                    printf("mousedown     button=3\n");
                }
                else if (buttons[3]) {
                    buttons[3] = false;
                    printf("mouseup     button=3\n");
                }

                if (mer.dwButtonState == FROM_LEFT_4TH_BUTTON_PRESSED) { // 0x0010
                    buttons[4] = true;
                    printf("mousedown     button=4\n");
                }
                else if (buttons[4]) {
                    buttons[4] = false;
                    printf("mouseup     button=4\n");
                }
				break;
			case DOUBLE_CLICK:
				printf("ondblclick \n");
				break;
			case MOUSE_HWHEELED:
				printf("horizontal mouse wheel \n");
				break;
			case MOUSE_MOVED:
				printf("onmousemove \n");
				break;
			case MOUSE_WHEELED:
				printf("vertical mouse wheel \n");
				break;
			default:
				printf("unknown \n");
				break;
        }
    }

    void ConsoleInput::ResizeEventProc(WINDOW_BUFFER_SIZE_RECORD wbsr){
        DKINFO("Resize event\n");
        printf("Console screen buffer is %d columns by %d rows.\n", wbsr.dwSize.X, wbsr.dwSize.Y);
    }
#endif