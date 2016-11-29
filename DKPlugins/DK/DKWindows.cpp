#include "stdafx.h"
#ifdef WIN32
#include "DKWindows.h"
#include "DKLog.h"

#include "conio.h"
#include <mmdeviceapi.h>
#include <endpointvolume.h>


//////////////////////////////////////////////////
bool DKWindows::SetClipboard(const DKString& text)
{
	DKLog("DKWindows::SetClipboard("+text+")\n", DKFILTER);
	
	if(OpenClipboard(NULL)){
		HGLOBAL clipbuffer;
		char * buffer;
		EmptyClipboard();
		clipbuffer = GlobalAlloc(GMEM_DDESHARE, text.size()+1);
		buffer = (char*)GlobalLock(clipbuffer);
		strcpy(buffer, LPCSTR(text.c_str()));
		GlobalUnlock(clipbuffer);
		SetClipboardData(CF_TEXT,clipbuffer);
		CloseClipboard();
		return true;
	}
	DKLog("Clipboard error! \n", DKERROR);
	return false; 
}

////////////////////////////////////////////
bool DKWindows::GetClipboard(DKString& text)
{
	DKLog("DKWindows::GetClipboard("+text+")\n", DKFILTER);
	
	char * buffer;
	if(OpenClipboard(NULL)){
		buffer = (char*)GetClipboardData(CF_TEXT);
		if (!buffer){ return false; }
		text = buffer;
		CloseClipboard(); 
		return true;
	}
	DKLog("Clipboard error! \n", DKERROR);
	return false; 
}

////////////////////////////////////////////////////////////////////////
bool DKWindows::GetPixelFromScreen(int x, int y, int& r, int& g, int& b)
{
	DKLog("DKWindows::GetPixelFromScreen("+toString(x)+","+toString(y)+",int&,int&,int&")\n", DKFILTER);
	
	HDC hdc_ = GetDC(GetDesktopWindow()) ;  //not sure if this is right or what exactly it does.
	COLORREF color = GetPixel(hdc_, x, y);
	r = GetRValue(color);
	g = GetGValue(color);
	b = GetBValue(color);
	return true;
}

//////////////////////////////////////////////////////////////////////
bool DKWindows::GetPixelFromImage(const DKString& image, int x, int y)
{
	DKLog("DKWindows::GetPixelFromImage("+image+","+toString(y)+","+toString(x)+","+toString(y)+")\n", DKFILTER);
	
	HANDLE hBmp = LoadImage(NULL, image.c_str(), IMAGE_BITMAP, 0, 0, LR_LOADFROMFILE);
	if(NULL == hBmp){
		DKLog("Could not load file\n",DKERROR);
		return false;
	}

	HDC dcmem = CreateCompatibleDC(NULL);
	if (NULL == SelectObject(dcmem, hBmp)){
		DeleteDC(dcmem); 
		DKLog("Could not select object\n",DKERROR);
		return false; 
	}

	BITMAP bm;
	GetObject(hBmp, sizeof(bm), &bm);
	bm.bmWidth;
	bm.bmHeight;
	COLORREF centerColor = GetPixel(dcmem, x, y);
	return true;
}

////////////////////////////////////////////
bool DKWindows::ChangeVolume(double nVolume) 
{
	DKLog("DKWindows::ChangeVolume("+toString(nVolume)+")\n", DKFILTER);
	
	//Windows Vista and up only
	if(nVolume > 1.0){nVolume = 1.0;}
	if(nVolume < 0.0){nVolume = 0.0;}
	bool bScalar = true;
    HRESULT hr=NULL;
    bool decibels = false;
    bool scalar = false;
    double newVolume=nVolume;
 
    CoInitialize(NULL);
    IMMDeviceEnumerator *deviceEnumerator = NULL;
    hr = CoCreateInstance(__uuidof(MMDeviceEnumerator), NULL, CLSCTX_INPROC_SERVER, 
                          __uuidof(IMMDeviceEnumerator), (LPVOID *)&deviceEnumerator);
    IMMDevice *defaultDevice = NULL;
 
    hr = deviceEnumerator->GetDefaultAudioEndpoint(eRender, eConsole, &defaultDevice);
    deviceEnumerator->Release();
    deviceEnumerator = NULL;
 
    IAudioEndpointVolume *endpointVolume = NULL;
    hr = defaultDevice->Activate(__uuidof(IAudioEndpointVolume), 
         CLSCTX_INPROC_SERVER, NULL, (LPVOID *)&endpointVolume);
    defaultDevice->Release();
    defaultDevice = NULL;
 
    // -------------------------
    float currentVolume = 0;
    endpointVolume->GetMasterVolumeLevel(&currentVolume);
    //printf("Current volume in dB is: %f\n", currentVolume);

    hr = endpointVolume->GetMasterVolumeLevelScalar(&currentVolume);
    //CString strCur=L"";
    //strCur.Format(L"%f",currentVolume);
    //AfxMessageBox(strCur);

    // printf("Current volume as a scalar is: %f\n", currentVolume);
    if (bScalar==false)
    {
        hr = endpointVolume->SetMasterVolumeLevel((float)newVolume, NULL);
    }
    else if (bScalar==true)
    {
        hr = endpointVolume->SetMasterVolumeLevelScalar((float)newVolume, NULL);
    }
    endpointVolume->Release();
 
    CoUninitialize();
 
    return true;
}

////////////////////////////
float DKWindows::GetVolume()
{
	DKLog("DKWindows::GetVolume()\n", DKFILTER);
	
	bool bScalar = true;
    HRESULT hr=NULL;
    bool decibels = false;
    bool scalar = false;
  
    CoInitialize(NULL);
    IMMDeviceEnumerator *deviceEnumerator = NULL;
    hr = CoCreateInstance(__uuidof(MMDeviceEnumerator), NULL, CLSCTX_INPROC_SERVER, 
                          __uuidof(IMMDeviceEnumerator), (LPVOID *)&deviceEnumerator);
    IMMDevice *defaultDevice = NULL;
 
    hr = deviceEnumerator->GetDefaultAudioEndpoint(eRender, eConsole, &defaultDevice);
    deviceEnumerator->Release();
    deviceEnumerator = NULL;
 
    IAudioEndpointVolume *endpointVolume = NULL;
    hr = defaultDevice->Activate(__uuidof(IAudioEndpointVolume), 
         CLSCTX_INPROC_SERVER, NULL, (LPVOID *)&endpointVolume);
    defaultDevice->Release();
    defaultDevice = NULL;
 
    // -------------------------
    float currentVolume = 0;
    endpointVolume->GetMasterVolumeLevel(&currentVolume);
	hr = endpointVolume->GetMasterVolumeLevelScalar(&currentVolume);
	return currentVolume;
}

///////////////////////
int DKWindows::GetKey()
{
	DKLog("DKWindows::GetKey()\n", DKFILTER);
	
	//DKLog("Press a key...\n", DKINFO);
	return _getch();
}

/////////////////////////////////
bool DKWindows::PressKey(int key)
{
	DKLog("DKWindows::PressKey("+toString(key)+")\n", DKFILTER);
	
	INPUT ip;
	// Set up a generic keyboard event.
    ip.type = INPUT_KEYBOARD;
    ip.ki.wScan = 0; // hardware scan code for key
    ip.ki.time = 0;
    ip.ki.dwExtraInfo = 0;
    ip.ki.wVk = key; // virtual-key code for the "a" key
    ip.ki.dwFlags = 0; // 0 for key press
    SendInput(1, &ip, sizeof(INPUT));
	return true;
}

///////////////////////////////////
bool DKWindows::ReleaseKey(int key)
{
	DKLog("DKWindows::ReleaseKey("+toString(key)+")\n", DKFILTER);
	
	INPUT ip;
	// Set up a generic keyboard event.
    ip.type = INPUT_KEYBOARD;
    ip.ki.wScan = 0; // hardware scan code for key
    ip.ki.time = 0;
    ip.ki.dwExtraInfo = 0;
    ip.ki.wVk = key; // virtual-key code for the "a" key
    ip.ki.dwFlags = KEYEVENTF_KEYUP;
    SendInput(1, &ip, sizeof(INPUT));
	return true;
}

///////////////////////////////////////////////////////////////
bool DKWindows::WaitForImage(const DKString& file, int timeout)
{
	DKLog("DKWindows::WaitForImage("+file+","+toString(timeout)+")\n", DKFILTER);
	
	//FIXME - this is blocking,  thread this out
	int i = 0;
	int x,y;
	while(!FindImageOnScreen(file, x, y) && i < timeout){
		Sleep(1000);
		++i;
	}
	Sleep(1000);
	return true;
}

////////////////////////////////////////////////////////////////////////
bool DKWindows::FindImageOnScreen(const DKString& file, int& x, int& y)
{
	//// Screen to RGB ////
	int SCREEN_WIDTH = 1280;
    int SCREEN_HEIGHT = 1024;
	
	HDC hdc = GetDC(HWND_DESKTOP);
    HDC hdcTemp = CreateCompatibleDC(hdc);
    BITMAPINFO bitmap;
    bitmap.bmiHeader.biSize = sizeof(bitmap.bmiHeader);
    bitmap.bmiHeader.biWidth = SCREEN_WIDTH;
    bitmap.bmiHeader.biHeight = SCREEN_HEIGHT;
    bitmap.bmiHeader.biPlanes = 1;
    bitmap.bmiHeader.biBitCount = 32;
    bitmap.bmiHeader.biCompression = BI_RGB;
    bitmap.bmiHeader.biSizeImage = SCREEN_WIDTH * 4 * SCREEN_HEIGHT;
    bitmap.bmiHeader.biClrUsed = 0;
    bitmap.bmiHeader.biClrImportant = 0;
	BYTE* sP;
    HBITMAP hBitmap = CreateDIBSection(hdcTemp, &bitmap, DIB_RGB_COLORS, (void**)(&sP), NULL, NULL);
    SelectObject(hdcTemp, hBitmap);
    BitBlt(hdcTemp, 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, hdc, 0, 0, SRCCOPY);

	// clean up
	//::SelectObject(hdcTemp, hBitmap);
	//::ReleaseDC(0, hdc);
	//::DeleteObject(hBitmap);
	//::DeleteDC(hdcTemp);
	//Screen RGB data is now accessible in sP

	//// Image to RGB ////
	HANDLE hBmp = LoadImage(NULL, file.c_str(), IMAGE_BITMAP, 0, 0, LR_LOADFROMFILE);
	if(NULL == hBmp){
		DKLog("Could not load file\n",DKERROR);
		return false;
	}

	HDC hDC = ::GetDC( 0 );
	HDC memDC1 = ::CreateCompatibleDC(hDC);
	HDC memDC2 = ::CreateCompatibleDC(hDC);

	BITMAP bm;
	GetObject(hBmp, sizeof(bm), &bm);

	BITMAPINFO bitmap2;
    bitmap2.bmiHeader.biSize = sizeof(bitmap2.bmiHeader);
    bitmap2.bmiHeader.biWidth = bm.bmWidth;
    bitmap2.bmiHeader.biHeight = bm.bmHeight;
    bitmap2.bmiHeader.biPlanes = 1;
    bitmap2.bmiHeader.biBitCount = 32;
    bitmap2.bmiHeader.biCompression = BI_RGB;
    bitmap2.bmiHeader.biSizeImage = bm.bmWidth * 4 * bm.bmHeight;
    bitmap2.bmiHeader.biClrUsed = 0;
    bitmap2.bmiHeader.biClrImportant = 0;

	BYTE* iP;
	HBITMAP hDIBMemBM  = ::CreateDIBSection( 0, &bitmap2, DIB_RGB_COLORS, (void**)&iP, NULL, NULL );
	HBITMAP hOldBmp1  = (HBITMAP)::SelectObject(memDC1,hDIBMemBM);  
	HBITMAP hOldBmp2  = (HBITMAP)::SelectObject(memDC2,hBmp);
	BitBlt(memDC1, 0, 0, bm.bmWidth, bm.bmHeight, memDC2, 0, 0, SRCCOPY);

	// clean up
	//::SelectObject(memDC1, hOldBmp1);
	//::SelectObject(memDC2, hOldBmp2);
	//::ReleaseDC(0, hDC);
	//::DeleteObject(hDIBMemBM);
	//::DeleteObject(hOldBmp1);
	//::DeleteObject(hOldBmp2);
	//::DeleteDC(memDC1);
	//::DeleteDC(memDC2);
	//Image RGB data is now accessible in iP


	//// COMPAIR ////
	bool match = false;

	for(int s=0; s<(SCREEN_WIDTH * SCREEN_HEIGHT * 4); s+=4){
		for(int i=0; i<(bm.bmHeight * bm.bmWidth * 4); i+=4){

			int a = (((SCREEN_WIDTH - bm.bmWidth) * 4) * ((i / 4) / bm.bmWidth));		

			if(iP[i] == sP[i+s+a] && iP[i+1] == sP[i+s+a+1] && iP[i+2] == sP[i+s+a+2]){
				match = true;
			}
			else{
				match = false;
				i=(bm.bmHeight * bm.bmWidth * 4);
			}
		}
		if(match == true){
			DKLog("image match!\n", DKINFO);
			int cy = (s / (4 * SCREEN_WIDTH));
			int cx = (s-(cy*4*SCREEN_WIDTH)) / 4;
			x = cx + (bm.bmWidth / 2);
			y = SCREEN_HEIGHT - cy - (bm.bmHeight / 2);

			// clean up
			::SelectObject(hdcTemp, hBitmap);
			::ReleaseDC(0, hdc);
			::DeleteObject(hBitmap);
			::DeleteDC(hdcTemp);
			// clean up
			::SelectObject(memDC1, hOldBmp1);
			::SelectObject(memDC2, hOldBmp2);
			::ReleaseDC(0, hDC);
			::DeleteObject(hDIBMemBM);
			::DeleteObject(hOldBmp1);
			::DeleteObject(hOldBmp2);
			::DeleteDC(memDC1);
			::DeleteDC(memDC2);
			return true;
		}
	}

	// clean up
	::SelectObject(hdcTemp, hBitmap);
	::ReleaseDC(0, hdc);
	::DeleteObject(hBitmap);
	::DeleteDC(hdcTemp);
	// clean up
	::SelectObject(memDC1, hOldBmp1);
	::SelectObject(memDC2, hOldBmp2);
	::ReleaseDC(0, hDC);
	::DeleteObject(hDIBMemBM);
	::DeleteObject(hOldBmp1);
	::DeleteObject(hOldBmp2);
	::DeleteDC(memDC1);
	::DeleteDC(memDC2);
	return false;
}

///////////////////////////////////////////////////////
bool DKWindows::SetMousePos(const int& x, const int& y)
{
	::SetCursorPos(x, y);
	return true;
}

///////////////////////////////////////////
bool DKWindows::GetMousePos(int& x, int& y)
{
	POINT p;
	if(::GetCursorPos(&p)){
		x = p.x;
		y = p.y;
		return true;
	}
	return false;
}


///////////////////////////
bool DKWindows::LeftClick()
{
	INPUT Input={0};							// Create our input.

	Input.type = INPUT_MOUSE;					// Let input know we are using the mouse.
	Input.mi.dwFlags = MOUSEEVENTF_LEFTDOWN;	// We are setting left mouse button down.
	SendInput(1, &Input, sizeof(INPUT));		// Send the input.

	ZeroMemory(&Input,sizeof(INPUT));			// Fills a block of memory with zeros.
	Input.type = INPUT_MOUSE;					// Let input know we are using the mouse.
	Input.mi.dwFlags = MOUSEEVENTF_LEFTUP;		// We are setting left mouse button up.
	SendInput(1, &Input, sizeof(INPUT));		// Send the input.
	return true;
}

////////////////////////////
bool DKWindows::RightClick()
{
	INPUT Input={0};							// Create our input.

	Input.type = INPUT_MOUSE;					// Let input know we are using the mouse.
	Input.mi.dwFlags = MOUSEEVENTF_RIGHTDOWN;	// We are setting right mouse button down.
	SendInput(1, &Input, sizeof(INPUT));		// Send the input.

	ZeroMemory(&Input,sizeof(INPUT));			// Fills a block of memory with zeros.
	Input.type = INPUT_MOUSE;					// Let input know we are using the mouse.
	Input.mi.dwFlags = MOUSEEVENTF_RIGHTUP;		// We are setting right mouse button up.
	SendInput(1, &Input, sizeof(INPUT));		// Send the input.
	return true;
}

///////////////////////////////////////
bool DKWindows::Sleep(int milliseconds)
{
	::Sleep(milliseconds);
	return true;;
}

#if !defined(WIN64)
///////////////////////////////////////////
void DKWindows::RefreshWindowsEnvironment()
{
	DKLog("DKWindows::RefreshWindowsEnvironment() \n", DKDEBUG);
    DWORD dwReturnValue;
    ::SendMessageTimeout(HWND_BROADCAST, WM_SETTINGCHANGE, 0, (LPARAM) "Environment", SMTO_ABORTIFHUNG, 5000, &dwReturnValue);
}
#endif

//////////////////////////////////
DKString DKWindows::GetLastError()
{
	//Get the error message, if any.
	DWORD errorMessageID = ::GetLastError();
	if (errorMessageID == 0)
		return std::string(); //No error message has been recorded

	LPSTR messageBuffer = nullptr;
	size_t size = FormatMessageA(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,
		NULL, errorMessageID, MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), (LPSTR)&messageBuffer, 0, NULL);

	std::string message(messageBuffer, size);

	//Free the buffer.
	LocalFree(messageBuffer);

	return message;
}

/*
////////////////////////////
bool DKWindows::PrintStack()
{
	unsigned int   i;
    void         * stack[ 100 ];
    unsigned short frames;
    SYMBOL_INFO  * symbol;
    HANDLE         process;

    process = GetCurrentProcess();
    SymInitialize( process, NULL, TRUE );
    frames               = CaptureStackBackTrace( 0, 100, stack, NULL );
    symbol               = ( SYMBOL_INFO * )calloc( sizeof( SYMBOL_INFO ) + 256 * sizeof( char ), 1 );
    symbol->MaxNameLen   = 255;
    symbol->SizeOfStruct = sizeof( SYMBOL_INFO );

    for( i = 0; i < frames; i++ ){
         SymFromAddr( process, ( DWORD64 )( stack[ i ] ), 0, symbol );
         printf( "%i: %s - 0x%0X\n", frames - i - 1, symbol->Name, symbol->Address );
	}

    free( symbol );
}
*/


#endif //WIN32