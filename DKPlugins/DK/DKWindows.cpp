#include "DK/stdafx.h"
#ifdef WIN32
#include "DKWindows.h"
#include "DKFile.h"
#include "DKLog.h"

#include "conio.h"
#include <mmdeviceapi.h>
#include <endpointvolume.h>
#include <psapi.h>
#include "shlobj.h"

//Monitor brightness
#include "PhysicalMonitorEnumerationAPI.h"
#include "HighLevelMonitorConfigurationAPI.h"

HINSTANCE DKWindows::hInstance = 0L;
HWND DKWindows::consoleWindow;


int main(int argc, char **argv);
//////////// WIN32 MAIN //////////////////////////////////////////////////////////////////////////
int APIENTRY WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPTSTR lpCmdLine, int nCmdShow) 
{
	DKLog("APIENTRY WinMain()\n", DKDEBUG);
	UNREFERENCED_PARAMETER(hPrevInstance);
	UNREFERENCED_PARAMETER(lpCmdLine);
	DKWindows::hInstance = hInstance;
	return main(__argc, __argv);
}


/////////////////////////////////////////////////
bool WINAPI DKWindows::ConsoleHandler(DWORD type)
{
	//FIXME - this is not the main thread
	DKLog("DKApp::ConsoleHandler(DWORD)\n", DKDEBUG);
	switch(type){
	case CTRL_CLOSE_EVENT:
		//ExitThread(0);  //This is a hack
		DKApp::Exit(); //we need the main thread to call this and wait
		return true;
	}
	return false;
}

/////////////////////////
bool DKWindows::CpuInit()
{
	DKLog("DKWindows::CpuInit()\n", DKDEBUG);
	//Init for DKWindows::CpuUsed()
	PdhOpenQuery(NULL, NULL, &cpuQuery);
	// You can also use L"\\Processor(*)\\% Processor Time" and get individual CPU values with PdhGetFormattedCounterArray()
	PdhAddEnglishCounter(cpuQuery, "\\Processor(_Total)\\% Processor Time", NULL, &cpuTotal);
	PdhCollectQueryData(cpuQuery);

	//Init for DKWindows::CpuUsedByApp()
	SYSTEM_INFO sysInfo;
	FILETIME ftime, fsys, fuser;
	GetSystemInfo(&sysInfo);
	numProcessors = sysInfo.dwNumberOfProcessors;
	GetSystemTimeAsFileTime(&ftime);
	memcpy(&lastCPU, &ftime, sizeof(FILETIME));
	self = GetCurrentProcess();
	GetProcessTimes(self, &ftime, &ftime, &fsys, &fuser);
	memcpy(&lastSysCPU, &fsys, sizeof(FILETIME));
	memcpy(&lastUserCPU, &fuser, sizeof(FILETIME));

	cpuInit = true;
	Sleep(1000);
	return true;
}

//////////////////////////////////
bool DKWindows::CpuUsed(int& cpu)
{
	DKLog("DKWindows::CpuUsed()\n", DKDEBUG);
	if(!cpuInit){ CpuInit(); }
	PDH_FMT_COUNTERVALUE counterVal;
	PdhCollectQueryData(cpuQuery);
	PdhGetFormattedCounterValue(cpuTotal, PDH_FMT_DOUBLE, NULL, &counterVal);
	cpu = (int)counterVal.doubleValue;
	return true;
}

//////////////////////////////////////
bool DKWindows::CpuUsedByApp(int& cpu)
{
	DKLog("DKWindows::CpuUsedByApp()\n", DKDEBUG);
	if(!cpuInit){ CpuInit(); }
	FILETIME ftime, fsys, fuser;
	ULARGE_INTEGER now, sys, user;
	float percent;
	GetSystemTimeAsFileTime(&ftime);
	memcpy(&now, &ftime, sizeof(FILETIME));
	GetProcessTimes(self, &ftime, &ftime, &fsys, &fuser);
	memcpy(&sys, &fsys, sizeof(FILETIME));
	memcpy(&user, &fuser, sizeof(FILETIME));
	percent = (float)((sys.QuadPart - lastSysCPU.QuadPart) + (user.QuadPart - lastUserCPU.QuadPart));
	percent /= (now.QuadPart - lastCPU.QuadPart);
	percent /= numProcessors;
	lastCPU = now;
	lastUserCPU = user;
	lastSysCPU = sys;
	cpu = (int)(percent * 100);
	return true;
}

//////////////////////////////////////
bool DKWindows::CreateConsoleHandler()
{
	DKLog("DKWindows::CreateConsoleHandler()\n", DKDEBUG);
	if(!SetConsoleCtrlHandler((PHANDLER_ROUTINE)DKWindows::ConsoleHandler, true)){
		DKLog("Could not set Console Handler. \n", DKWARN);
		return false;
	}
	DKWindows::consoleWindow = GetConsoleWindow();
	RECT desktop;
	const HWND hDesktop = GetDesktopWindow();
	GetWindowRect(hDesktop, &desktop);
	LONG horizontal = desktop.right;
	LONG vertical = desktop.bottom - 35;
	MoveWindow(DKWindows::consoleWindow, 0, 0, horizontal, vertical, TRUE);
	return true;
}

//////////////////////////////////////////////////////
bool DKWindows::DrawTextOnScreen(const DKString& text)
{
	DKLog("DKWindows::DrawTextOnScreen("+text+")\n", DKDEBUG);
	HDC screenDC = ::GetDC(GetDesktopWindow());
	::SetBkColor(screenDC, TRANSPARENT);
	::SetTextColor(screenDC, RGB(0, 255, 0));
	::TextOut(screenDC, 10, 10, TEXT(text.c_str()), strlen(text.c_str()));
	::ReleaseDC(0, screenDC);
	return true;
}

///////////////////////////////////////////////////////////////////////
bool DKWindows::FindImageOnScreen(const DKString& file, int& x, int& y)
{
	DKLog("DKWindows::FindImageOnScreen("+file+")\n", DKDEBUG);
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

////////////////////////////////////////////
bool DKWindows::GetClipboard(DKString& text)
{
	DKLog("DKWindows::GetClipboard("+text+")\n", DKDEBUG);
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

////////////////////////////////
bool DKWindows::GetKey(int& key)
{
	DKLog("DKWindows::GetKey()\n", DKDEBUG);
	//DKLog("Press a key...\n", DKINFO);
	key = _getch();
	return true;
}

/////////////////////////////////////////////
bool DKWindows::GetLastError(DKString& error)
{
	DKLog("DKWindows::GetLastError()\n", DKDEBUG);
	//Get the error message, if any.
	DWORD errorMessageID = ::GetLastError();
	if (errorMessageID == 0)
		return true;//std::string(); //No error message has been recorded

	LPSTR messageBuffer = nullptr;
	size_t size = FormatMessageA(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,
		NULL, errorMessageID, MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), (LPSTR)&messageBuffer, 0, NULL);

	std::string message(messageBuffer, size);

	//Free the buffer.
	LocalFree(messageBuffer);
	error = message;
	return true;
}

///////////////////////////////////////////
bool DKWindows::GetMousePos(int& x, int& y)
{
	DKLog("DKWindows::GetMousePos()\n", DKDEBUG);
	POINT p;
	if(::GetCursorPos(&p)){
		x = p.x;
		y = p.y;
		return true;
	}
	return false;
}

//////////////////////////////////////////////////////////////////////
bool DKWindows::GetPixelFromImage(const DKString& image, int x, int y)
{
	DKLog("DKWindows::GetPixelFromImage("+image+","+toString(y)+","+toString(x)+","+toString(y)+")\n", DKDEBUG);
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

////////////////////////////////////////////////////////////////////////
bool DKWindows::GetPixelFromScreen(int x, int y, int& r, int& g, int& b)
{
	DKLog("DKWindows::GetPixelFromScreen("+toString(x)+","+toString(y)+",int&,int&,int&)\n", DKDEBUG);
	HDC hdc_ = GetDC(GetDesktopWindow()) ;  //not sure if this is right or what exactly it does.
	COLORREF color = GetPixel(hdc_, x, y);
	r = GetRValue(color);
	g = GetGValue(color);
	b = GetBValue(color);
	return true;
}

//////////////////////////////////////////////
bool DKWindows::GetProcessList(DKString& list)
{
	DKLog("DKWindows::GetProcessList()\n", DKDEBUG);
	//list = "this,is,a,test";

	// Get the list of process identifiers.
	DWORD aProcesses[1024], cbNeeded, cProcesses;
	unsigned int i;
	if(!EnumProcesses( aProcesses, sizeof(aProcesses), &cbNeeded)){ return 0; }


	// Calculate how many process identifiers were returned.
	cProcesses = cbNeeded / sizeof(DWORD);

	// Print the name and process identifier for each process.
	for(i = 0; i < cProcesses; i++){
		if(aProcesses[i] != 0){
			TCHAR szProcessName[MAX_PATH] = TEXT("<unknown>");

			//Get a handle to the process.
			HANDLE hProcess = OpenProcess( PROCESS_QUERY_INFORMATION | PROCESS_VM_READ,FALSE, aProcesses[i]);

			//Get the process name.
			if(NULL != hProcess){
				HMODULE hMod;
				DWORD cbNeeded;

				if(EnumProcessModules(hProcess, &hMod, sizeof(hMod),  &cbNeeded)){
					GetModuleBaseName( hProcess, hMod, szProcessName, sizeof(szProcessName)/sizeof(TCHAR) );
				}
			}

			// Print the process name and identifier.
			//tprintf( TEXT("%s  (PID: %u)\n"), szProcessName, processID );
			list += toString(szProcessName);
			list += ",";

			//Release the handle to the process.
			CloseHandle(hProcess);
		}
	}

	return true;
}

//////////////////////////////////////
bool DKWindows::GetScreenWidth(int& w)
{
	DKLog("DKWindows::GetScreenWidth()\n", DKDEBUG);
	RECT desktop;
	const HWND hDesktop = GetDesktopWindow();
	if(!GetWindowRect(hDesktop, &desktop)){ return false; }
	w = desktop.right;
	return true;
}

///////////////////////////////////////
bool DKWindows::GetScreenHeight(int& h)
{
	DKLog("DKWindows::GetScreenHeight()\n", DKDEBUG);
	RECT desktop;
	const HWND hDesktop = GetDesktopWindow();
	if(!GetWindowRect(hDesktop, &desktop)){ return false; }
	h = desktop.bottom;
	return true;
}

//////////////////////////////////////////////////
bool DKWindows::GetThreadId(unsigned long int& id)
{
	DKLog("DKWindows::GetThreadId()\n", DKDEBUG);
	id = GetCurrentThreadId();
	return true;
}

///////////////////////////////////////
bool DKWindows::GetVolume(int& percent)
{
	DKLog("DKWindows::GetVolume()\n", DKDEBUG);
	bool bScalar = true;
	HRESULT hr=NULL;
	bool decibels = false;
	bool scalar = false;

	CoInitialize(NULL);
	IMMDeviceEnumerator *deviceEnumerator = NULL;
	hr = CoCreateInstance(__uuidof(MMDeviceEnumerator), NULL, CLSCTX_INPROC_SERVER, __uuidof(IMMDeviceEnumerator), (LPVOID *)&deviceEnumerator);
	IMMDevice *defaultDevice = NULL;

	hr = deviceEnumerator->GetDefaultAudioEndpoint(eRender, eConsole, &defaultDevice);
	deviceEnumerator->Release();
	deviceEnumerator = NULL;

	IAudioEndpointVolume *endpointVolume = NULL;
	hr = defaultDevice->Activate(__uuidof(IAudioEndpointVolume), CLSCTX_INPROC_SERVER, NULL, (LPVOID *)&endpointVolume);
	defaultDevice->Release();
	defaultDevice = NULL;

	float volume;
	endpointVolume->GetMasterVolumeLevel(&volume);
	hr = endpointVolume->GetMasterVolumeLevelScalar(&volume);
	percent = volume * 100;
	return true;
}

/////////////////////////////////////////
bool DKWindows::KeyIsDown(const int& key)
{
	DKLog("DKWindows::KeyIsDown()\n", DKDEBUG);
	if(GetKeyState(key) & 0x8000){ return true; }
	return false;
}

///////////////////////////
bool DKWindows::LeftClick()
{
	DKLog("DKWindows::LeftClick()\n", DKDEBUG);
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

///////////////////////////
bool DKWindows::LeftPress()
{
	DKLog("DKWindows::LeftPress()\n", DKDEBUG);
	INPUT Input={0};							// Create our input.
	Input.type = INPUT_MOUSE;					// Let input know we are using the mouse.
	Input.mi.dwFlags = MOUSEEVENTF_LEFTDOWN;	// We are setting left mouse button down.
	SendInput(1, &Input, sizeof(INPUT));		// Send the input.
	return true;
}

/////////////////////////////
bool DKWindows::LeftRelease()
{
	DKLog("DKWindows::LeftRelease()\n", DKDEBUG);
	INPUT Input={0};							// Create our input.
	Input.type = INPUT_MOUSE;					// Let input know we are using the mouse.
	Input.mi.dwFlags = MOUSEEVENTF_LEFTUP;		// We are setting left mouse button up.
	SendInput(1, &Input, sizeof(INPUT));		// Send the input.
	return true;
}

/////////////////////////////////
bool DKWindows::LowPowerMonitor()
{
	DKLog("DKWindows::LowPowerMonitor()\n", DKDEBUG);
	SendMessage(HWND_BROADCAST, WM_SYSCOMMAND, SC_MONITORPOWER, (LPARAM) 1);
	return true;
}

/////////////////////////////
bool DKWindows::MiddlePress()
{
	DKLog("DKWindows::MiddlePress()\n", DKDEBUG);
	INPUT Input={0};							// Create our input.
	Input.type = INPUT_MOUSE;					// Let input know we are using the mouse.
	Input.mi.dwFlags = MOUSEEVENTF_MIDDLEDOWN;	// We are setting middle mouse button down.
	SendInput(1, &Input, sizeof(INPUT));		// Send the input.
	return true;
}

///////////////////////////////
bool DKWindows::MiddleRelease()
{
	DKLog("DKWindows::MiddleRelease()\n", DKDEBUG);
	INPUT Input={0};							// Create our input.
	Input.type = INPUT_MOUSE;					// Let input know we are using the mouse.
	Input.mi.dwFlags = MOUSEEVENTF_MIDDLEUP;	// We are setting middle mouse button up.
	SendInput(1, &Input, sizeof(INPUT));		// Send the input.
	return true;
}

//////////////////////////////////////////////////////////////////
bool DKWindows::PhysicalMemory(unsigned long long& physicalMemory)
{
	DKLog("DKWindows::PhysicalMemory()\n", DKDEBUG);
	MEMORYSTATUSEX memInfo;
	memInfo.dwLength = sizeof(MEMORYSTATUSEX);
	GlobalMemoryStatusEx(&memInfo);
	DWORDLONG totalPhysMem = memInfo.ullTotalPhys;
	physicalMemory = totalPhysMem / MB;
	return true;
}

//////////////////////////////////////////////////////////////////////
bool DKWindows::PhysicalMemoryUsed(unsigned long long& physicalMemory)
{
	DKLog("DKWindows::PhysicalMemoryUsed()\n", DKDEBUG);
	MEMORYSTATUSEX memInfo;
	memInfo.dwLength = sizeof(MEMORYSTATUSEX);
	GlobalMemoryStatusEx(&memInfo);
	DWORDLONG physMemUsed = memInfo.ullTotalPhys - memInfo.ullAvailPhys;
	physicalMemory = physMemUsed / MB;
	return true;
}

/////////////////////////////////////////////////////////////////////
bool DKWindows::PhysicalMemoryUsedByApp(unsigned int& physicalMemory)
{
	DKLog("DKWindows::PhysicalMemoryUsedByApp()\n", DKDEBUG);
	PROCESS_MEMORY_COUNTERS pmc;
	GetProcessMemoryInfo(GetCurrentProcess(), &pmc, sizeof(pmc));
	SIZE_T physMemUsedByMe = pmc.WorkingSetSize;
	physicalMemory = physMemUsedByMe / MB;
	return true;
}

/////////////////////////////////
bool DKWindows::PressKey(int key)
{
	DKLog("DKWindows::PressKey("+toString(key)+")\n", DKDEBUG);
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

///////////////////////////////////////////
bool DKWindows::RefreshWindowsEnvironment()
{
	DKLog("DKWindows::RefreshWindowsEnvironment()\n", DKDEBUG);
#if !defined(WIN64)
	DWORD dwReturnValue;
	::SendMessageTimeout(HWND_BROADCAST, WM_SETTINGCHANGE, 0, (LPARAM) "Environment", SMTO_ABORTIFHUNG, 5000, &dwReturnValue);
	return true;
#endif
	return false;
}

///////////////////////////////////
bool DKWindows::ReleaseKey(int key)
{
	DKLog("DKWindows::ReleaseKey("+toString(key)+")\n", DKDEBUG);
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

////////////////////////////
bool DKWindows::RightClick()
{
	DKLog("DKWindows::RightClick()\n", DKDEBUG);
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

////////////////////////////
bool DKWindows::RightPress()
{
	DKLog("DKWindows::RightPress()\n", DKDEBUG);
	INPUT Input={0};							// Create our input.
	Input.type = INPUT_MOUSE;					// Let input know we are using the mouse.
	Input.mi.dwFlags = MOUSEEVENTF_RIGHTDOWN;	// We are setting right mouse button down.
	SendInput(1, &Input, sizeof(INPUT));		// Send the input.
	return true;
}

//////////////////////////////
bool DKWindows::RightRelease()
{
	DKLog("DKWindows::RightRelease()\n", DKDEBUG);
	INPUT Input={0};							// Create our input.
	Input.type = INPUT_MOUSE;					// Let input know we are using the mouse.
	Input.mi.dwFlags = MOUSEEVENTF_RIGHTUP;		// We are setting right mouse button up.
	SendInput(1, &Input, sizeof(INPUT));		// Send the input.
	return true;
}

////////////////////////////////////////////
bool DKWindows::Run(const DKString& command)
{
	DKLog("DKWindows::Run("+command+")\n", DKDEBUG);
	ShellExecute(NULL,NULL,command.c_str(),NULL,NULL,SW_SHOWNORMAL); //TODO: error control
	return true;
}

////////////////////////////////////////////////
bool DKWindows::SetBrightness(const int& percent)
{
	// Prepare variables
	HMONITOR hMonitor = NULL;
	HMONITOR hMonitorTest = NULL;
	DWORD cPhysicalMonitors;
	LPPHYSICAL_MONITOR pPhysicalMonitors = NULL;

	// Get the screen
	HWND hWnd = GetDesktopWindow();
	hMonitor = MonitorFromWindow(hWnd, MONITOR_DEFAULTTOPRIMARY);

	_BOOL success = GetNumberOfPhysicalMonitorsFromHMONITOR(hMonitor, &cPhysicalMonitors);
	if(success){
		pPhysicalMonitors = (LPPHYSICAL_MONITOR)malloc(cPhysicalMonitors* sizeof(PHYSICAL_MONITOR));        
		if(pPhysicalMonitors != NULL){
			success = GetPhysicalMonitorsFromHMONITOR(hMonitor,cPhysicalMonitors, pPhysicalMonitors);
			HANDLE hPhysicalMonitor = pPhysicalMonitors[0].hPhysicalMonitor;

			// Set brightness to 50%
			DWORD dwNewBrightness = percent;
			success = SetMonitorBrightness(hPhysicalMonitor, dwNewBrightness);

			// Free resources
			free(pPhysicalMonitors);
		}
	}
	return true;
}

//////////////////////////////////////////////////
bool DKWindows::SetClipboard(const DKString& text)
{
	DKLog("DKWindows::SetClipboard("+text+")\n", DKDEBUG);
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

///////////////////////////////////////////////////////////
bool DKWindows::SetClipboardFiles(const DKString& filelist)
{
	DKLog("DKWindows::SetClipboardFiles("+filelist+")\n", DKDEBUG);
	//char sFiles[] = "C:/digitalknob/README.md\0";
	DKString sFiles = filelist;
	replace(sFiles, ",", "\0"); //not working

	DROPFILES dobj = { 20, { 0, 0 }, 0, 1 };
	int nLen = sFiles.size(); //sizeof(sFiles);
	int nGblLen = sizeof(dobj) + nLen*2 + 5; //lots of nulls and multibyte_char
	HGLOBAL hGbl = GlobalAlloc(GMEM_ZEROINIT|GMEM_MOVEABLE|GMEM_DDESHARE, nGblLen);
	char* sData = (char*)::GlobalLock(hGbl);
	memcpy(sData, &dobj, 20);
	char* sWStr = sData+20;
	for(int i = 0; i < nLen*2; i += 2){
		sWStr[i] = sFiles[i/2];
	}
	::GlobalUnlock(hGbl);
	if(OpenClipboard(NULL)){
		EmptyClipboard();
		SetClipboardData(CF_HDROP, hGbl);
		CloseClipboard();
	}

	return true;
}

///////////////////////////////////////////////////////
bool DKWindows::SetClipboardImage(const DKString& file)
{
	DKLog("DKWindows::SetClipboardImage("+file+")\n", DKDEBUG);

	//TODO - other formats besides .bmp
	HBITMAP hBM = (HBITMAP) LoadImage( NULL, file.c_str(), IMAGE_BITMAP, 0, 0, LR_LOADFROMFILE);
	HWND hWnd = ::GetActiveWindow();
	if(!::OpenClipboard(hWnd)){ 
		DKLog("DKWindows::SetClipboardImage("+file+"): ::OpenClipboard(hWnd) failed\n", DKERROR);
		return false; 
	}

	::EmptyClipboard();
	BITMAP bm;
	::GetObject(hBM, sizeof(bm), &bm);
	BITMAPINFOHEADER bi;
	::ZeroMemory(&bi, sizeof(BITMAPINFOHEADER));
	bi.biSize = sizeof(BITMAPINFOHEADER);
	bi.biWidth = bm.bmWidth;
	bi.biHeight = bm.bmHeight;
	bi.biPlanes = 1;
	bi.biBitCount = bm.bmBitsPixel;
	bi.biCompression = BI_RGB;
	if (bi.biBitCount <= 1)	// make sure bits per pixel is valid
		bi.biBitCount = 1;
	else if (bi.biBitCount <= 4)
		bi.biBitCount = 4;
	else if (bi.biBitCount <= 8)
		bi.biBitCount = 8;
	else // if greater than 8-bit, force to 24-bit
		bi.biBitCount = 24;

	// Get size of color table.
	SIZE_T dwColTableLen = (bi.biBitCount <= 8) ? (1 << bi.biBitCount) * sizeof(RGBQUAD) : 0;
	
	// Create a device context with palette
	HDC hDC = ::GetDC(NULL);
	HPALETTE hPal = static_cast<HPALETTE>(::GetStockObject(DEFAULT_PALETTE));
	HPALETTE hOldPal = ::SelectPalette(hDC, hPal, FALSE);
	::RealizePalette(hDC);

	// Use GetDIBits to calculate the image size.
	::GetDIBits(hDC, hBM, 0, static_cast<UINT>(bi.biHeight), NULL, reinterpret_cast<LPBITMAPINFO>(&bi), DIB_RGB_COLORS);
		
	// If the driver did not fill in the biSizeImage field, then compute it.
	// Each scan line of the image is aligned on a DWORD (32bit) boundary.
	if (0 == bi.biSizeImage){
		bi.biSizeImage = ((((bi.biWidth * bi.biBitCount) + 31) & ~31) / 8) * bi.biHeight;
	}

	// Allocate memory
	HGLOBAL hDIB = ::GlobalAlloc(GMEM_MOVEABLE, sizeof(BITMAPINFOHEADER) + dwColTableLen + bi.biSizeImage);
	if(hDIB){
		union tagHdr_u{
			LPVOID             p;
			LPBYTE             pByte;
			LPBITMAPINFOHEADER pHdr;
			LPBITMAPINFO       pInfo;
		} Hdr;

		Hdr.p = ::GlobalLock(hDIB);
		// Copy the header
		::CopyMemory(Hdr.p, &bi, sizeof(BITMAPINFOHEADER));
		// Convert/copy the image bits and create the color table
		int nConv = ::GetDIBits(hDC, hBM, 0, static_cast<UINT>(bi.biHeight), Hdr.pByte + sizeof(BITMAPINFOHEADER) + dwColTableLen, Hdr.pInfo, DIB_RGB_COLORS);
		::GlobalUnlock(hDIB);
		if(!nConv){
			::GlobalFree(hDIB);
			hDIB = NULL;
		}
	}
	if(hDIB){ 
		::SetClipboardData(CF_DIB, hDIB);
	}
	::CloseClipboard();
	::SelectPalette(hDC, hOldPal, FALSE);
	::ReleaseDC(NULL, hDC);
	if(!hDIB){ return false; }
	return true;
}

///////////////////////////////////////////////////////
bool DKWindows::SetMainThreadNow(unsigned long int& id)
{
	DKLog("DKWindows::SetMainThreadNow("+toString(id)+")\n", DKDEBUG);
	id = GetCurrentThreadId();
	return true;
}

///////////////////////////////////////////////////////
bool DKWindows::SetMousePos(const int& x, const int& y)
{
	DKLog("DKWindows::SetMousePos("+toString(x)+","+toString(y)+")\n", DKDEBUG);
	::SetCursorPos(x, y);
	return true;
}

//////////////////////////
void DKWindows::SetTitle()
{
	//TODO - add string variable for title input
	DKLog("DKWindows::SetTitle()\n", DKDEBUG);
	/////  Set the window title
	DKString title; 
	DKFile::GetExeName(title);
	title += " - WIN32";
#ifdef DEBUG
	title += " DEBUG ";
#else
	title += " RELEASE ";
#endif
	DKString mTime;
	DKString file;
	DKFile::GetExePath(file);
	DKFile::GetModifiedTime(file, mTime);
	title += mTime;
	SetConsoleTitle(title.c_str());
}

///////////////////////////////////////
bool DKWindows::SetVolume(int& percent)
{
	DKLog("DKWindows::SetVolume("+toString(percent)+")\n", DKDEBUG);
	//Windows Vista and up only
	if(percent > 100){percent = 100;}
	if(percent < 0){percent = 0;}
	bool bScalar = true;
    HRESULT hr=NULL;
    bool decibels = false;
    bool scalar = false;
    double newVolume = (double)percent / 100;
 
    CoInitialize(NULL);
    IMMDeviceEnumerator *deviceEnumerator = NULL;
    hr = CoCreateInstance(__uuidof(MMDeviceEnumerator), NULL, CLSCTX_INPROC_SERVER, __uuidof(IMMDeviceEnumerator), (LPVOID *)&deviceEnumerator);
    IMMDevice *defaultDevice = NULL;
 
    hr = deviceEnumerator->GetDefaultAudioEndpoint(eRender, eConsole, &defaultDevice);
    deviceEnumerator->Release();
    deviceEnumerator = NULL;
 
    IAudioEndpointVolume *endpointVolume = NULL;
    hr = defaultDevice->Activate(__uuidof(IAudioEndpointVolume), CLSCTX_INPROC_SERVER, NULL, (LPVOID *)&endpointVolume);
    defaultDevice->Release();
    defaultDevice = NULL;
 
    float currentVolume = 0;
    endpointVolume->GetMasterVolumeLevel(&currentVolume);
    //printf("Current volume in dB is: %f\n", currentVolume);

    hr = endpointVolume->GetMasterVolumeLevelScalar(&currentVolume);
    //CString strCur=L"";
    //strCur.Format(L"%f",currentVolume);
    //AfxMessageBox(strCur);

    // printf("Current volume as a scalar is: %f\n", currentVolume);
    if (bScalar==false){
        hr = endpointVolume->SetMasterVolumeLevel((float)newVolume, NULL);
    }
    else if (bScalar==true){
        hr = endpointVolume->SetMasterVolumeLevelScalar((float)newVolume, NULL);
    }
    endpointVolume->Release();
    CoUninitialize();
    return true;
}

///////////////////////////////////////
bool DKWindows::Sleep(int milliseconds)
{
	DKLog("DKWindows::Sleep("+toString(milliseconds)+")\n", DKDEBUG);
	::Sleep(milliseconds);
	return true;;
}

////////////////////////////////
bool DKWindows::TurnOffMonitor()
{
	DKLog("DKWindows::TurnOffMonitor()\n", DKDEBUG);
	Sleep(500); // Eliminate user's interaction for 500 ms
	SendMessage(HWND_BROADCAST, WM_SYSCOMMAND, SC_MONITORPOWER, (LPARAM) 2);
	return true;
}

///////////////////////////////
bool DKWindows::TurnOnMonitor()
{
	DKLog("DKWindows::TurnOnMonitor()\n", DKDEBUG);
	SendMessage(HWND_BROADCAST, WM_SYSCOMMAND, SC_MONITORPOWER, (LPARAM) -1);
	return true;
}

////////////////////////////////////////////////////////////////
bool DKWindows::VirtualMemory(unsigned long long& virtualMemory)
{
	DKLog("DKWindows::VirtualMemory()\n", DKDEBUG);
	MEMORYSTATUSEX memInfo;
	memInfo.dwLength = sizeof(MEMORYSTATUSEX);
	GlobalMemoryStatusEx(&memInfo);
	DWORDLONG totalVirtualMem = memInfo.ullTotalPageFile;
	virtualMemory = totalVirtualMem / MB;
	return true;
}

////////////////////////////////////////////////////////////////////
bool DKWindows::VirtualMemoryUsed(unsigned long long& virtualMemory)
{
	DKLog("DKWindows::VirtualMemoryUsed()\n", DKDEBUG);
	MEMORYSTATUSEX memInfo;
	memInfo.dwLength = sizeof(MEMORYSTATUSEX);
	GlobalMemoryStatusEx(&memInfo);
	DWORDLONG virtualMemUsed = memInfo.ullTotalPageFile - memInfo.ullAvailPageFile;
	virtualMemory = virtualMemUsed / MB;
	return true;
}

///////////////////////////////////////////////////////////////////
bool DKWindows::VirtualMemoryUsedByApp(unsigned int& virtualMemory)
{
	DKLog("DKWindows::VirtualMemoryUsedByApp()\n", DKDEBUG);
	PROCESS_MEMORY_COUNTERS pmc;
	GetProcessMemoryInfo(GetCurrentProcess(), &pmc, sizeof(pmc));
	SIZE_T virtualMemUsedByMe = pmc.PagefileUsage;
	virtualMemory = virtualMemUsedByMe / MB;
	return true;
}

///////////////////////////////////////////////////////////////
bool DKWindows::WaitForImage(const DKString& file, int timeout)
{
	DKLog("DKWindows::WaitForImage("+file+","+toString(timeout)+")\n", DKDEBUG);
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

///////////////////////////
bool DKWindows::WheelDown()
{
	DKLog("DKWindows::WheelDown()\n", DKDEBUG);
	mouse_event(MOUSEEVENTF_WHEEL, 0, 0, -WHEEL_DELTA, NULL);
	return true;
}

/////////////////////////
bool DKWindows::WheelUp()
{
	DKLog("DKWindows::WheelUp()\n", DKDEBUG);
	mouse_event(MOUSEEVENTF_WHEEL, 0, 0, WHEEL_DELTA, NULL);
	return true;
}

/*
////////////////////////////
bool DKWindows::PrintStack()
{
	DKLog("DKWindows::PrintStack()\n", DKDEBUG);
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