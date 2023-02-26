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

    DWORD cNumRead, fdwMode, i;
    INPUT_RECORD irInBuf[128];
    int counter = 0;

    // Get the standard input handle. 

    hStdin = GetStdHandle(STD_INPUT_HANDLE);
    if (hStdin == INVALID_HANDLE_VALUE)
        ErrorExit("GetStdHandle");

    // Save the current input mode, to be restored on exit. 

    if (!GetConsoleMode(hStdin, &fdwSaveOldMode))
        ErrorExit("GetConsoleMode");

    // Enable the window and mouse input events. 

    fdwMode = ENABLE_WINDOW_INPUT | ENABLE_MOUSE_INPUT | ENABLE_INSERT_MODE | ENABLE_EXTENDED_FLAGS;
    if (!SetConsoleMode(hStdin, fdwMode))
        ErrorExit("SetConsoleMode");

    // Loop to read and handle the next 500 input events. 

    while (counter++ <= 500){
        // Wait for the events. 
        if (!ReadConsoleInput(
            hStdin,      // input buffer handle 
            irInBuf,     // buffer to read into 
            128,         // size of read buffer 
            &cNumRead)) // number of records read 
            ErrorExit("ReadConsoleInput");

        // Dispatch the events to the appropriate handler. 
        for (i = 0; i < cNumRead; i++){
            switch (irInBuf[i].EventType){
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
    }
    // Restore input mode on exit.
    SetConsoleMode(hStdin, fdwSaveOldMode);
    return true;
}

bool ConsoleInput::End(){
	DKDEBUGFUNC();
	return true;
}

VOID ConsoleInput::ErrorExit(LPCSTR lpszMessage){
    fprintf(stderr, "%s\n", lpszMessage);
    // Restore input mode on exit.
    SetConsoleMode(hStdin, fdwSaveOldMode);
    ExitProcess(0);
}

VOID ConsoleInput::KeyEventProc(KEY_EVENT_RECORD ker){
    printf("Key event: ");
    if (ker.bKeyDown)
        printf("key pressed\n");
    else printf("key released\n");
}

VOID ConsoleInput::MouseEventProc(MOUSE_EVENT_RECORD mer){
#ifndef MOUSE_HWHEELED
#define MOUSE_HWHEELED 0x0008
#endif
    printf("Mouse event: ");
    switch (mer.dwEventFlags){
    case 0:
        if (mer.dwButtonState == FROM_LEFT_1ST_BUTTON_PRESSED){
            printf("left button press \n");
        }
        else if (mer.dwButtonState == RIGHTMOST_BUTTON_PRESSED){
            printf("right button press \n");
        }
        else{
            printf("button press\n");
        }
        break;
    case DOUBLE_CLICK:
        printf("double click\n");
        break;
    case MOUSE_HWHEELED:
        printf("horizontal mouse wheel\n");
        break;
    case MOUSE_MOVED:
        printf("mouse moved\n");
        break;
    case MOUSE_WHEELED:
        printf("vertical mouse wheel\n");
        break;
    default:
        printf("unknown\n");
        break;
    }
}

VOID ConsoleInput::ResizeEventProc(WINDOW_BUFFER_SIZE_RECORD wbsr){
    printf("Resize event\n");
    printf("Console screen buffer is %d columns by %d rows.\n", wbsr.dwSize.X, wbsr.dwSize.Y);
}
