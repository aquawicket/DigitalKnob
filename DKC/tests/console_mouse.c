// https://stackoverflow.com/a/46802726/688352

#include <windows.h>
#include <stdio.h>

HANDLE hStdin;
DWORD fdwSaveOldMode;

VOID ErrorExit (LPSTR lpszMessage);
VOID KeyEventProc(KEY_EVENT_RECORD);
VOID MouseEventProc(MOUSE_EVENT_RECORD);
VOID ResizeEventProc(WINDOW_BUFFER_SIZE_RECORD);

int main(VOID)
{
    DWORD cNumRead, fdwMode, i;
    INPUT_RECORD irInBuf[128];
    int counter=0;

    // Get the standard input handle.
    hStdin = GetStdHandle(STD_INPUT_HANDLE);
    if (hStdin == INVALID_HANDLE_VALUE)
        ErrorExit("GetStdHandle");

    // Save the current input mode, to be restored on exit.
    if (! GetConsoleMode(hStdin, &fdwSaveOldMode))
        ErrorExit("GetConsoleMode");

    // Enable the window and mouse input events.

    // Disable 'Quick Edit Mode' option programmatically
	fdwMode = ENABLE_EXTENDED_FLAGS;
    if (! SetConsoleMode(hStdin, fdwMode))
		ErrorExit("SetConsoleMode");
		 
    fdwMode = ENABLE_WINDOW_INPUT | ENABLE_MOUSE_INPUT;
    if (! SetConsoleMode(hStdin, fdwMode))
        ErrorExit("SetConsoleMode");

    // Loop to read and handle the next 100 input events.
    while (1){
        // Wait for the events.
        if (! ReadConsoleInput(
                hStdin,      // input buffer handle
                irInBuf,     // buffer to read into
                128,         // size of read buffer
                &cNumRead)) // number of records read
        ErrorExit("ReadConsoleInput");

        // Dispatch the events to the appropriate handler.
        for (i = 0; i < cNumRead; i++){
            switch(irInBuf[i].EventType){
                case KEY_EVENT: // keyboard input
                    KeyEventProc(irInBuf[i].Event.KeyEvent);
                    break;
				
                case MOUSE_EVENT: // mouse input
                    MouseEventProc(irInBuf[i].Event.MouseEvent);
                    break;

                case WINDOW_BUFFER_SIZE_EVENT: // scrn buf. resizing
                    ResizeEventProc( irInBuf[i].Event.WindowBufferSizeEvent );
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
    return 0;
}

VOID ErrorExit (LPSTR lpszMessage)
{
    fprintf(stderr, "%s\n", lpszMessage);

    // Restore input mode on exit.

    SetConsoleMode(hStdin, fdwSaveOldMode);

    ExitProcess(0);
}

VOID KeyEventProc(KEY_EVENT_RECORD ker)
{
    dk_echo("Key event: ");

    if(ker.bKeyDown)
        dk_echo("key pressed\n");
    else dk_echo("key released\n");
}

VOID MouseEventProc(MOUSE_EVENT_RECORD mer)
{
#ifndef MOUSE_HWHEELED
#define MOUSE_HWHEELED 0x0008
#endif
    dk_echo("Mouse event: ");

	int colume = mer.dwMousePosition.X;
    int row = mer.dwMousePosition.Y;
    switch(mer.dwEventFlags)
    {
        case 0:
			if(mer.dwButtonState == FROM_LEFT_1ST_BUTTON_PRESSED)
            {
                dk_echo("X:%d, Y:%d - Left Press\n",colume, row);
            }
            else if(mer.dwButtonState == RIGHTMOST_BUTTON_PRESSED)
            {
                dk_echo("X:%d, Y:%d - Right Press\n",colume, row);
            }
            else
            {
                dk_echo("X:%d, Y:%d - Button Press\n",colume, row);
            }
            break;
        case DOUBLE_CLICK:
            dk_echo("X:%d, Y:%d - Double Click\n",colume, row);
            break;
        case MOUSE_HWHEELED:
			dk_echo("X:%d, Y:%d - H Wheel\n",colume, row);
            break;
        case MOUSE_MOVED:
            dk_echo("X:%d, Y:%d - Move\n",colume, row);
            break;
        case MOUSE_WHEELED:
			dk_echo("X:%d, Y:%d - V Wheel\n",colume, row);
            break;
        default:
            dk_echo("unknown\n");
            break;
    }
}

VOID ResizeEventProc(WINDOW_BUFFER_SIZE_RECORD wbsr)
{
    dk_echo("Resize event\n");
    dk_echo("Console screen buffer is %d columns by %d rows.\n", wbsr.dwSize.X, wbsr.dwSize.Y);
}