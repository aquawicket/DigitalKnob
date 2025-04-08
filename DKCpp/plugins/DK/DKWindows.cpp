/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2025 Digitalknob Team, and contributors
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

#include "DK/stdafx.h"

#if WIN
#include "DK/DKWindows.h"
#include "DK/DKFile.h"
#include "DK/DKLog.h"

//WARNING_DISABLE
#include <shellapi.h>       //DKFile::Execute()
#include "conio.h"          //getch, getche
#include <mmdeviceapi.h>
#include <endpointvolume.h>
#include <psapi.h>
#include "shlobj.h"
#include <cstdlib>          //DKUtil::GetUsername() std::getenv()
//#include <Lmcons.h>       //DKUtil::GetUsername() GetUserName()
//Monitor brightness
#ifdef HAVE_pdh
	#include "PhysicalMonitorEnumerationAPI.h"
	#include "HighLevelMonitorConfigurationAPI.h"
#endif
//WARNING_ENABLE


HINSTANCE DKWindows::hInstance = 0L;
HWND DKWindows::consoleWindow;


extern int main(int argc, char** argv);

//////////// WIN MAIN ////////////////////////////////////////////////////////////////////////////
int APIENTRY WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPTSTR lpCmdLine, int nCmdShow){
	DKDEBUGFUNC(hInstance, hPrevInstance, lpCmdLine, nCmdShow);
	UNREFERENCED_PARAMETER(hPrevInstance);
	UNREFERENCED_PARAMETER(lpCmdLine);
	DKWindows::hInstance = hInstance;
	return main(__argc, __argv);
}

bool WINAPI DKWindows::ConsoleHandler(DWORD type){
	DKDEBUGFUNC(type);
	//NOTE: this is not the main thread
	switch(type){
		case CTRL_CLOSE_EVENT:
			//ExitThread(0);  //This is a hack
			DKApp::active = false;
			//DKApp::Exit(); //we need the main thread to call this and wait
			Sleep(20000);
			return true;
	}
	return false;
}

bool DKWindows::CpuInit(){
	DKDEBUGFUNC();
	//Init for DKWindows::CpuUsed()
#ifdef HAVE_pdh
	PdhOpenQuery(NULL, 0, &cpuQuery);
	// You can also use L"\\Processor(*)\\% Processor Time" and get individual CPU values with PdhGetFormattedCounterArray()
	PdhAddEnglishCounter(cpuQuery, "\\Processor(_Total)\\% Processor Time", 0, &cpuTotal);
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
#endif	
	Sleep(1000);
	return true;
}

bool DKWindows::CpuUsed(int& cpu){
	DKDEBUGFUNC(cpu);
	if(!cpuInit){ CpuInit(); }
#ifdef HAVE_pdh	
	PDH_FMT_COUNTERVALUE counterVal;
	PdhCollectQueryData(cpuQuery);
	PdhGetFormattedCounterValue(cpuTotal, PDH_FMT_DOUBLE, NULL, &counterVal);
	cpu = (int)counterVal.doubleValue;
#endif
	return true;
}

bool DKWindows::CpuUsedByApp(int& cpu){
	DKDEBUGFUNC(cpu);
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

bool DKWindows::CreateConsoleHandler(){
	DKDEBUGFUNC();
	if(!SetConsoleCtrlHandler((PHANDLER_ROUTINE)DKWindows::ConsoleHandler, true))
		return DKERROR("Could not set Console Handler\n");
	DKWindows::consoleWindow = GetConsoleWindow();
	RECT desktop;
	const HWND hDesktop = GetDesktopWindow();
	GetWindowRect(hDesktop, &desktop);
	LONG width = desktop.right / 2 - 100;
	LONG height = desktop.bottom - 40;
	MoveWindow(DKWindows::consoleWindow, 0, 0, width, height, TRUE);
	return true;
}

bool DKWindows::DrawTextOnScreen(const DKString& text){
	DKDEBUGFUNC(text);
	HDC screenDC = ::GetDC(GetDesktopWindow());
	::SetBkColor(screenDC, TRANSPARENT);
	::SetTextColor(screenDC, RGB(0, 255, 0));
	::TextOut(screenDC, 10, 10, TEXT(text.c_str()), (int)strlen(text.c_str()));
	::ReleaseDC(0, screenDC);
	return true;
}

bool DKWindows::FindImageOnScreen(const DKString& file, int& x, int& y){
	DKDEBUGFUNC(file, x, y);
	//// Screen to RGB ////
	int SCREEN_WIDTH = 1280;
	int SCREEN_HEIGHT = 1024;
	HDC hdc = GetDC(HWND_DESKTOP);
	HDC hdcTemp = CreateCompatibleDC(hdc);
	BITMAPINFO bitmap = BITMAPINFO();
	bitmap.bmiHeader.biSize = sizeof(bitmap.bmiHeader);
	bitmap.bmiHeader.biWidth = SCREEN_WIDTH;
	bitmap.bmiHeader.biHeight = SCREEN_HEIGHT;
	bitmap.bmiHeader.biPlanes = 1;
	bitmap.bmiHeader.biBitCount = 32;
	bitmap.bmiHeader.biCompression = BI_RGB;
	bitmap.bmiHeader.biSizeImage = SCREEN_WIDTH * 4 * SCREEN_HEIGHT;
	bitmap.bmiHeader.biClrUsed = 0;
	bitmap.bmiHeader.biClrImportant = 0;
	#if _MSC_VER
		BYTE* sP = BYTE();
	#else
		BYTE* sP = new BYTE;
	#endif
	HBITMAP hBitmap = CreateDIBSection(hdcTemp, &bitmap, DIB_RGB_COLORS, (void**)(&sP), nullptr, 0);
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
	if(NULL == hBmp)
		return DKERROR("Could not load file\n");
	HDC hDC = ::GetDC( 0 );
	HDC memDC1 = ::CreateCompatibleDC(hDC);
	HDC memDC2 = ::CreateCompatibleDC(hDC);
	BITMAP bm = BITMAP();
	GetObject(hBmp, sizeof(bm), &bm);
	BITMAPINFO bitmap2 = BITMAPINFO();
	bitmap2.bmiHeader.biSize = sizeof(bitmap2.bmiHeader);
	bitmap2.bmiHeader.biWidth = bm.bmWidth;
	bitmap2.bmiHeader.biHeight = bm.bmHeight;
	bitmap2.bmiHeader.biPlanes = 1;
	bitmap2.bmiHeader.biBitCount = 32;
	bitmap2.bmiHeader.biCompression = BI_RGB;
	bitmap2.bmiHeader.biSizeImage = bm.bmWidth * 4 * bm.bmHeight;
	bitmap2.bmiHeader.biClrUsed = 0;
	bitmap2.bmiHeader.biClrImportant = 0;
	#if _MSC_VER
		BYTE* iP = BYTE();
	#else
		BYTE* iP = new BYTE;
	#endif
	HBITMAP hDIBMemBM  = ::CreateDIBSection(0, &bitmap2, DIB_RGB_COLORS, (void**)&iP, nullptr, 0);
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
			if(iP[i] == sP[i+s+a] && iP[i+1] == sP[i+s+a+1] && iP[i+2] == sP[i+s+a+2])
				match = true;
			else
				match = false;
				i=(bm.bmHeight * bm.bmWidth * 4); //FIXME: does this go with the else clause above?
		}
		if(match == true){
			DKINFO("image match!\n");
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

bool DKWindows::GetClipboard(DKString& text){
	DKDEBUGFUNC(text);
	char * buffer;
	if(OpenClipboard(NULL)){
		buffer = (char*)GetClipboardData(CF_TEXT);
		if(!buffer)
			return DKERROR("buffer invalid\n");
		text = buffer;
		CloseClipboard(); 
		return true;
	}
	return DKERROR("Clipboard error! \n");
}

bool DKWindows::GetKey(int& key){
	DKDEBUGFUNC(key);
	key = _getch();
	return true;
}

bool DKWindows::GetLastError(DKString& error){
	DKDEBUGFUNC(error);
	//Get the error message, if any.
	DWORD errorMessageID = ::GetLastError();
	if (errorMessageID == 0)
		return true; //No error message has been recorded
	LPSTR messageBuffer = NULL;
	size_t size = FormatMessageA(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS,
		NULL, errorMessageID, MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), (LPSTR)&messageBuffer, 0, NULL);
	std::string message(messageBuffer, size);
	//Free the buffer.
	LocalFree(messageBuffer);
	error = message;
	return true;
}

bool DKWindows::GetMousePos(int& x, int& y){
	DKDEBUGFUNC(x, y);
	POINT p;
	if(!::GetCursorPos(&p))
		return DKERROR("::GetCursorPos() failed\n");
	x = p.x;
	y = p.y;
	return true;
}

bool DKWindows::GetPixelFromImage(const DKString& image, int x, int y){
	DKDEBUGFUNC(image, x, y);
	HANDLE hBmp = LoadImage(NULL, image.c_str(), IMAGE_BITMAP, 0, 0, LR_LOADFROMFILE);
	if(NULL == hBmp)
		return DKERROR("Could not load file\n");
	HDC dcmem = CreateCompatibleDC(NULL);
	if (NULL == SelectObject(dcmem, hBmp)){
		DeleteDC(dcmem); 
		return DKERROR("Could not select object\n");
	}
	BITMAP bm = BITMAP();
	GetObject(hBmp, sizeof(bm), &bm);
	bm.bmWidth;
	bm.bmHeight;
	//COLORREF centerColor = GetPixel(dcmem, x, y);
	return true;
}

bool DKWindows::GetPixelFromScreen(int x, int y, int& r, int& g, int& b){
	DKDEBUGFUNC(x, y, r, g, b);
	HDC hdc_ = GetDC(GetDesktopWindow()) ;  //not sure if this is right or what exactly it does.
	COLORREF color = GetPixel(hdc_, x, y);
	r = GetRValue(color);
	g = GetGValue(color);
	b = GetBValue(color);
	return true;
}

bool DKWindows::GetProcessList(DKString& list){
	DKDEBUGFUNC(list);
	//list = "this,is,a,test";
	// Get the list of process identifiers.
	DWORD aProcesses[1024], cbNeeded, cProcesses;
	unsigned int i;
	if(!EnumProcesses( aProcesses, sizeof(aProcesses), &cbNeeded)){ return 0; }
	// Calculate how many process identifiers were returned.
	cProcesses = cbNeeded / sizeof(DWORD);
	// Print the name and process identifier for each process.
	for (i = 0; i < cProcesses; i++){
		if (aProcesses[i] != 0){
			TCHAR szProcessName[MAX_PATH] = TEXT("<unknown>");
			//Get a handle to the process.
			HANDLE hProcess = OpenProcess(PROCESS_QUERY_INFORMATION | PROCESS_VM_READ, FALSE, aProcesses[i]);
			//Get the process name.
			if (NULL != hProcess){
				HMODULE hMod;
				DWORD _cbNeeded;
				if (EnumProcessModules(hProcess, &hMod, sizeof(hMod), &_cbNeeded))
					GetModuleBaseName(hProcess, hMod, szProcessName, sizeof(szProcessName) / sizeof(TCHAR));
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

bool DKWindows::GetScreenWidth(int& w){
	DKDEBUGFUNC(w);
	RECT desktop;
	const HWND hDesktop = GetDesktopWindow();
	if(!GetWindowRect(hDesktop, &desktop))
		return DKERROR("GetWindowRect() failed\n");
	w = desktop.right;
	return true && DKDEBUGRETURN(w);
}

bool DKWindows::GetScreenHeight(int& h){
	DKDEBUGFUNC(h);
	RECT desktop;
	const HWND hDesktop = GetDesktopWindow();
	if(!GetWindowRect(hDesktop, &desktop))
		return DKERROR("GetWindowRect() failed\n");
	h = desktop.bottom;
	return true && DKDEBUGRETURN(h);
}

bool DKWindows::GetUsername(DKString& username){
	DKDEBUGFUNC(username);
	if(const char* usr_a = std::getenv("USERname")){
		username = usr_a;
		return true && DKDEBUGRETURN(username);
	}
	/*
	TCHAR name[UNLEN + 1];
	DWORD size = UNLEN + 1;
	if (GetUserName((TCHAR*)name, &size)){
		username = toString(name);
		return true;
	}
	*/
	return DKERROR("cannot get username\n");
}

bool DKWindows::GetVolume(int& percent){
	DKDEBUGFUNC(percent);
	//bool bScalar = true;
	HRESULT hr = 0;
	//bool decibels = false;
	//bool scalar = false;
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
	percent = (int)(volume * 100);
	return true && DKDEBUGRETURN(percent);
}

bool DKWindows::KeyIsDown(const int& key){
	DKDEBUGFUNC(key);
	if(GetKeyState(key) & 0x8000)
		return true && DKDEBUGRETURN(true);
	return false && DKDEBUGRETURN(false);
}

bool DKWindows::LeftClick(){
	DKDEBUGFUNC();
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

bool DKWindows::LeftPress(){
	DKDEBUGFUNC();
	INPUT Input={0};							// Create our input.
	Input.type = INPUT_MOUSE;					// Let input know we are using the mouse.
	Input.mi.dwFlags = MOUSEEVENTF_LEFTDOWN;	// We are setting left mouse button down.
	SendInput(1, &Input, sizeof(INPUT));		// Send the input.
	return true;
}

bool DKWindows::LeftRelease(){
	DKDEBUGFUNC();
	INPUT Input={0};							// Create our input.
	Input.type = INPUT_MOUSE;					// Let input know we are using the mouse.
	Input.mi.dwFlags = MOUSEEVENTF_LEFTUP;		// We are setting left mouse button up.
	SendInput(1, &Input, sizeof(INPUT));		// Send the input.
	return true;
}

bool DKWindows::LowPowerMonitor(){
	DKDEBUGFUNC();
	return SendMessage(HWND_BROADCAST, WM_SYSCOMMAND, SC_MONITORPOWER, (LPARAM) 1);
}

bool DKWindows::MiddlePress(){
	DKDEBUGFUNC();
	INPUT Input={0};							// Create our input.
	Input.type = INPUT_MOUSE;					// Let input know we are using the mouse.
	Input.mi.dwFlags = MOUSEEVENTF_MIDDLEDOWN;	// We are setting middle mouse button down.
	SendInput(1, &Input, sizeof(INPUT));		// Send the input.
	return true;
}

bool DKWindows::MiddleRelease(){
	DKDEBUGFUNC();
	INPUT Input={0};							// Create our input.
	Input.type = INPUT_MOUSE;					// Let input know we are using the mouse.
	Input.mi.dwFlags = MOUSEEVENTF_MIDDLEUP;	// We are setting middle mouse button up.
	SendInput(1, &Input, sizeof(INPUT));		// Send the input.
	return true;
}

bool DKWindows::PhysicalMemory(unsigned long long& physicalMemory){
	DKDEBUGFUNC(physicalMemory);
	MEMORYSTATUSEX memInfo = MEMORYSTATUSEX();
	memInfo.dwLength = sizeof(MEMORYSTATUSEX);
	GlobalMemoryStatusEx(&memInfo);
	DWORDLONG totalPhysMem = memInfo.ullTotalPhys;
	physicalMemory = totalPhysMem / MB;
	return true;
}

bool DKWindows::PhysicalMemoryUsed(unsigned long long& physicalMemory){
	DKDEBUGFUNC(physicalMemory);
	MEMORYSTATUSEX memInfo = MEMORYSTATUSEX();
	memInfo.dwLength = sizeof(MEMORYSTATUSEX);
	GlobalMemoryStatusEx(&memInfo);
	DWORDLONG physMemUsed = memInfo.ullTotalPhys - memInfo.ullAvailPhys;
	physicalMemory = physMemUsed / MB;
	return true;
}

bool DKWindows::PhysicalMemoryUsedByApp(unsigned long long& physicalMemory){
	DKDEBUGFUNC(physicalMemory);
	PROCESS_MEMORY_COUNTERS pmc;
	GetProcessMemoryInfo(GetCurrentProcess(), &pmc, sizeof(pmc));
	SIZE_T physMemUsedByMe = pmc.WorkingSetSize;
	physicalMemory = physMemUsedByMe / MB;
	return true;
}

bool DKWindows::PressKey(WORD key){
	DKDEBUGFUNC(key);
	INPUT ip = INPUT();
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

bool DKWindows::RefreshWindowsEnvironment(){
	DKDEBUGFUNC();
#if !WIN_X86_64
	PDWORD_PTR dwReturnValue = 0;
	::SendMessageTimeout(HWND_BROADCAST, WM_SETTINGCHANGE, 0, (LPARAM) "Environment", SMTO_ABORTIFHUNG, 5000, dwReturnValue);
	return true;
#else
	return DKERROR("DKWindows::RefreshWindowsEnvironment() not implemented on the OS\n");
#endif
}

bool DKWindows::ReleaseKey(WORD key){
	DKDEBUGFUNC(key);
	INPUT ip = INPUT();
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

bool DKWindows::RightClick(){
	DKDEBUGFUNC();
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

bool DKWindows::RightPress(){
	DKDEBUGFUNC();
	INPUT Input={0};							// Create our input.
	Input.type = INPUT_MOUSE;					// Let input know we are using the mouse.
	Input.mi.dwFlags = MOUSEEVENTF_RIGHTDOWN;	// We are setting right mouse button down.
	SendInput(1, &Input, sizeof(INPUT));		// Send the input.
	return true;
}

bool DKWindows::RightRelease(){
	DKDEBUGFUNC();
	INPUT Input={0};							// Create our input.
	Input.type = INPUT_MOUSE;					// Let input know we are using the mouse.
	Input.mi.dwFlags = MOUSEEVENTF_RIGHTUP;		// We are setting right mouse button up.
	SendInput(1, &Input, sizeof(INPUT));		// Send the input.
	return true;
}

bool DKWindows::Run(const DKString& command){
	DKDEBUGFUNC(command);
	ShellExecute(NULL,NULL,command.c_str(),NULL,NULL,SW_SHOWNORMAL); //TODO: error control
	return true;
}

bool DKWindows::SetBrightness(const int& percent){
	DKDEBUGFUNC(percent);
	// Prepare variables
	HMONITOR hMonitor = NULL;
	//HMONITOR hMonitorTest = NULL;
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
			int count = (int)cPhysicalMonitors;
			DWORD dwNewBrightness = percent;
			for(int i=0; i<count; i++){
				HANDLE hPhysicalMonitor = pPhysicalMonitors[i].hPhysicalMonitor;
				success = SetMonitorBrightness(hPhysicalMonitor, dwNewBrightness);
			}
			// Free resources
			free(pPhysicalMonitors);
		}
	}
	return true;
}

bool DKWindows::SetClipboard(const DKString& text){
	DKDEBUGFUNC(text);
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
	return DKERROR("Clipboard error! \n");
}

bool DKWindows::SetClipboardFiles(const DKString& filelist){
	DKDEBUGFUNC(filelist);
	//char sFiles[] = "C:/Users/aquawicket/digitalknob/README.md\0";
	DKString sFiles = filelist;
	replace(sFiles, ",", "\0"); //not working
	DROPFILES dobj = { 20, { 0, 0 }, 0, 1 };
	//int nLen = sFiles.size(); //sizeof(sFiles);
	size_t nLen = sFiles.size();
	//int nGblLen = sizeof(dobj) + nLen*2 + 5; //lots of nulls and multibyte_char
	size_t nGblLen = sizeof(dobj) + nLen * 2 + 5; //lots of nulls and multibyte_char
	HGLOBAL hGbl = GlobalAlloc(GMEM_ZEROINIT|GMEM_MOVEABLE|GMEM_DDESHARE, nGblLen);
	char* sData = (char*)::GlobalLock(hGbl);
	memcpy(sData, &dobj, 20);
	char* sWStr = sData+20;
	//for(int i = 0; i < nLen*2; i += 2)
	for (size_t i = 0; i < nLen * 2; i += 2)
		sWStr[i] = sFiles[i/2];
	::GlobalUnlock(hGbl);
	if(OpenClipboard(NULL)){
		EmptyClipboard();
		SetClipboardData(CF_HDROP, hGbl);
		CloseClipboard();
	}
	return true;
}

bool DKWindows::SetClipboardImage(const DKString& file){
	DKDEBUGFUNC(file);
	//TODO - other formats besides .bmp
	HBITMAP hBM = (HBITMAP) LoadImage( NULL, file.c_str(), IMAGE_BITMAP, 0, 0, LR_LOADFROMFILE);
	HWND hWnd = ::GetActiveWindow();
	if(!::OpenClipboard(hWnd))
		return DKERROR("file:("+file+"): ::OpenClipboard(hWnd) failed\n");
	::EmptyClipboard();
	BITMAP bm = BITMAP();
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

	// https://docs.microsoft.com/en-us/cpp/error-messages/compiler-warnings/compiler-warning-level-3-c4334?view=msvc-170
	// Get size of color table.
#if WIN_X86
	SIZE_T dwColTableLen = (bi.biBitCount <= 8) ? (1 << bi.biBitCount) * sizeof(RGBQUAD) : 0;
#elif WIN_X86_64
	#if _MSC_VER
		SIZE_T dwColTableLen = (bi.biBitCount <= 8) ? (1i64 << bi.biBitCount) * sizeof(RGBQUAD) : 0;
	#else
		#include <stdint.h>
		SIZE_T dwColTableLen = (bi.biBitCount <= 8) ? (INT64_C( 1) << bi.biBitCount) * sizeof(RGBQUAD) : 0;
	#endif
#endif
	// Create a device context with palette
	HDC hDC = ::GetDC(NULL);
	HPALETTE hPal = static_cast<HPALETTE>(::GetStockObject(DEFAULT_PALETTE));
	HPALETTE hOldPal = ::SelectPalette(hDC, hPal, FALSE);
	::RealizePalette(hDC);
	// Use GetDIBits to calculate the image size.
	::GetDIBits(hDC, hBM, 0, static_cast<UINT>(bi.biHeight), NULL, reinterpret_cast<LPBITMAPINFO>(&bi), DIB_RGB_COLORS);
	// If the driver did not fill in the biSizeImage field, then compute it.
	// Each scan line of the image is aligned on a DWORD (32bit) boundary.
	if (0 == bi.biSizeImage)
		bi.biSizeImage = ((((bi.biWidth * bi.biBitCount) + 31) & ~31) / 8) * bi.biHeight;
	// Allocate memory
	HGLOBAL hDIB = ::GlobalAlloc(GMEM_MOVEABLE, sizeof(BITMAPINFOHEADER) + dwColTableLen + bi.biSizeImage);
	if(hDIB){
		union tagHdr_u{
			LPVOID             p;
			LPBYTE             pByte;
			LPBITMAPINFOHEADER pHdr;
			LPBITMAPINFO       pInfo;
		} Hdr = tagHdr_u();
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
	if(hDIB)
		::SetClipboardData(CF_DIB, hDIB);
	::CloseClipboard();
	::SelectPalette(hDC, hOldPal, FALSE);
	::ReleaseDC(NULL, hDC);
	if(!hDIB)
		return DKERROR("hDIB invalid\n");
	return true;
}

bool DKWindows::SetMousePos(const int& x, const int& y){
	DKDEBUGFUNC(x, y);
	if(!::SetCursorPos(x, y))
		return DKERROR("::SetCursorPos() failed\n");
	return true;
}

bool DKWindows::SetTitle(const DKString& title){
	DKDEBUGFUNC(title);
	if (!SetConsoleTitle(title.c_str()))
		return DKERROR("SetConsoleTitle() failed\n");
	return true;
}

bool DKWindows::SetVolume(int& percent){
	DKDEBUGFUNC(percent);
	//Windows Vista and up only
	if(percent > 100)
		percent = 100;
	if(percent < 0)
		percent = 0;
	bool bScalar = true;
    HRESULT hr = 0;
    //bool decibels = false;
    //bool scalar = false;
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
    if (bScalar==false)
        hr = endpointVolume->SetMasterVolumeLevel((float)newVolume, NULL);
    else if (bScalar==true)
        hr = endpointVolume->SetMasterVolumeLevelScalar((float)newVolume, NULL);
    endpointVolume->Release();
    CoUninitialize();
    return true;
}

bool DKWindows::Sleep(int milliseconds){
	//DKDEBUGFUNC(milliseconds);  //EXCESSIVE LOGGING
	::Sleep(milliseconds);
	return true;;
}

bool DKWindows::StrokeKey(const WORD& key){
	DKDEBUGFUNC(key);
	PressKey(key);
	return ReleaseKey(key);
}

bool DKWindows::TurnOffMonitor(){
	DKDEBUGFUNC();
	Sleep(500); // Eliminate user's interaction for 500 ms
	return SendMessage(HWND_BROADCAST, WM_SYSCOMMAND, SC_MONITORPOWER, (LPARAM) 2);
}

bool DKWindows::TurnOnMonitor(){
	DKDEBUGFUNC();
	return SendMessage(HWND_BROADCAST, WM_SYSCOMMAND, SC_MONITORPOWER, (LPARAM) -1);
}

bool DKWindows::VirtualMemory(unsigned long long& virtualMemory){
	DKDEBUGFUNC(virtualMemory);
	MEMORYSTATUSEX memInfo = MEMORYSTATUSEX();
	memInfo.dwLength = sizeof(MEMORYSTATUSEX);
	GlobalMemoryStatusEx(&memInfo);
	DWORDLONG totalVirtualMem = memInfo.ullTotalPageFile;
	virtualMemory = totalVirtualMem / MB;
	return true;
}

bool DKWindows::VirtualMemoryUsed(unsigned long long& virtualMemory){
	DKDEBUGFUNC(virtualMemory);
	MEMORYSTATUSEX memInfo = MEMORYSTATUSEX();
	memInfo.dwLength = sizeof(MEMORYSTATUSEX);
	GlobalMemoryStatusEx(&memInfo);
	DWORDLONG virtualMemUsed = memInfo.ullTotalPageFile - memInfo.ullAvailPageFile;
	virtualMemory = virtualMemUsed / MB;
	return true;
}

bool DKWindows::VirtualMemoryUsedByApp(unsigned long long& virtualMemory){
	DKDEBUGFUNC(virtualMemory);
	PROCESS_MEMORY_COUNTERS pmc;
	GetProcessMemoryInfo(GetCurrentProcess(), &pmc, sizeof(pmc));
	SIZE_T virtualMemUsedByMe = pmc.PagefileUsage;
	virtualMemory = virtualMemUsedByMe / MB;
	return true;
}

bool DKWindows::WaitForImage(const DKString& file, int timeout){
	DKDEBUGFUNC(file, timeout);
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

bool DKWindows::WheelDown(){
	DKDEBUGFUNC();
	mouse_event(MOUSEEVENTF_WHEEL, 0, 0, (DWORD)-WHEEL_DELTA, 0);
	return true;
}

bool DKWindows::WheelUp(){
	DKDEBUGFUNC();
	mouse_event(MOUSEEVENTF_WHEEL, 0, 0, WHEEL_DELTA, 0);
	return true;
}

/*
bool DKWindows::PrintStack(){
	DKDEBUGFUNC();
	unsigned int i;
    void* stack[100];
    unsigned short frames;
    SYMBOL_INFO* symbol;
    HANDLE process;
    process = GetCurrentProcess();
    SymInitialize(process, NULL, TRUE);
    frames = CaptureStackBackTrace( 0, 100, stack, NULL);
    symbol = (SYMBOL_INFO *)calloc(sizeof(SYMBOL_INFO) + 256 * sizeof(char), 1);
    symbol->MaxNameLen = 255;
    symbol->SizeOfStruct = sizeof(SYMBOL_INFO);
    for(i = 0; i < frames; i++){
         SymFromAddr(process, (DWORD64)(stack[ i ]), 0, symbol);
         printf("%i: %s - 0x%0X\n", frames - i - 1, symbol->Name, symbol->Address);
	}
    free(symbol);
	return true;
}
*/

#endif //WIN
