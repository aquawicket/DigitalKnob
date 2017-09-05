#include "stdafx.h"

#ifdef WIN32
#include "DKHook.h"
#include "DKAssets.h"
#include "DKFile.h"
#include <tchar.h>

DKStringArray DKHook::windows;
std::vector<HWND> DKHook::handle;

///////////////////
void DKHook::Init()
{
	DKCreate("DKHookJS");
	DKCreate("DKHookV8");
	DKString path = DKFile::local_assets + "DKHook/hookdll.dll";
	hModule = LoadLibrary(path.c_str());
	if(NULL == hModule){
		DKLog("DKHook::DKHook(): cannot find hookdll.dll \n", DKERROR);
	}
	highlight = false;
	//gw = NULL;
	currentHandle = 0;
}

//////////////////
void DKHook::End()
{
	if(hModule){FreeLibrary(hModule);}
}

/////////////////////////////////////////////////////
bool DKHook::SetWindowHandle(const DKString& caption)
{
	//const char* 
	handle.clear();
	//This method fills handle with window whose title partially matches
	HWNDname temp;
	temp.caption = caption.c_str();
	if(EnumWindows(FindWindowPartial, (LPARAM)&temp)){//true - fail
		DKLog("DKHook::SetWindowHandle() cannot find window "+caption+" \n", DKERROR);
		return false;
	}

	DKLog("Selected Window: "+caption+"\n", DKINFO);
	GetHandles();
	SetHandle(0);
	return true;
}

/////////////////////////
bool DKHook::GetHandles()
{
	if(handle.empty() || handle[0] == NULL){ //Window is not open so don't look for its items.
		DKLog("DKHook::GetHandles() window not found! \n", DKERROR);
		return false;
	}
		
	//Window IS open, so look for all of the items and assigne handles
	bool searchFromBase = true;
	unsigned int s = 0;
	unsigned int h = 1;
	while(s < handle.size()){
		HWND temp = NULL;
		if(searchFromBase){
			temp = FindWindowEx(handle[s], NULL, NULL, NULL);
			if(temp){ handle.push_back(temp); }
			searchFromBase = false;
		}
		else{
			temp = FindWindowEx(handle[s], handle[h-1], NULL, NULL);
			if(temp){ handle.push_back(temp); }
		}
		if(temp != NULL){
			h++;
		}
		else{
			s++; searchFromBase = true;
		}
	}

	return true;
}

///////////////////////////////////////////////////////////////
BOOL CALLBACK DKHook::EnumWindowsProc(HWND hwnd, LPARAM lParam)
{
	char class_name[80];
	char title[80];
	GetClassName(hwnd,class_name, sizeof(class_name));
	GetWindowText(hwnd,title,sizeof(title));

	/*
	if(!same("",title)){
		DKLog("Window: ");
		DKLog(title);
		DKLog(" Class: ");
		DKLog(class_name);
		DKLog("\n");
	}
	*/

	return TRUE;
}

/////////////////////////////////////////////////////////////////
BOOL CALLBACK DKHook::FindWindowPartial(HWND hwnd, LPARAM lparam) 
{     
	HWNDname *temp = (HWNDname*)lparam;
	static TCHAR buffer[50];      
	GetWindowText(hwnd, buffer, 50);     
	if(_tcsstr(buffer, temp->caption)) { 
		handle.push_back(hwnd);
		return FALSE;     
	}      
	return TRUE; 
}

//////////////////////////////////////////////////////////
BOOL CALLBACK DKHook::GetWindows(HWND hwnd, LPARAM lparam) 
{     
	static TCHAR buffer[50];      
	GetWindowText(hwnd, buffer, 50);
	DKString title = buffer;
	if(!title.empty()){
		windows.push_back(title);
	}    
	return true; 
}


//////////////////////////////
void DKHook::ToggleHighlight()
{
	if(highlight){
		highlight = false;
		DoHighlight();
		return;
	}
	highlight = true;
	DoHighlight();
}

//////////////////////////
void DKHook::DoHighlight()
{
	if(!highlight){ return; }
	if(handle.empty()){ return; }
	 
	RedrawWindow(GetDesktopWindow(), NULL, NULL, RDW_INVALIDATE | RDW_UPDATENOW); //FIXME

	RECT rect;
	GetWindowRect(handle[currentHandle], &rect);
	screenDC = ::GetDC(GetDesktopWindow());

	HPEN pen, oldPen;
	pen = CreatePen(PS_SOLID, 2, RGB(0, 0, 255)); 
    oldPen = (HPEN)SelectObject(screenDC, pen);

	::MoveToEx(screenDC, rect.left, rect.top, NULL);
	::LineTo(screenDC, rect.right, rect.top);
	::LineTo(screenDC, rect.right, rect.bottom);
	::LineTo(screenDC, rect.left, rect.bottom);
	::LineTo(screenDC, rect.left, rect.top);
	::ReleaseDC(0, screenDC);

	SelectObject(screenDC, oldPen); 
    DeleteObject(pen);
}

/////////////////////////
bool DKHook::NextHandle()
{
	if(handle.empty()){ return false; }
	if(currentHandle < handle.size()-1){currentHandle++;}
	if(currentHandle <= handle.size()){
		DoHighlight();
	}
	return true;
}

/////////////////////////
bool DKHook::PrevHandle()
{
	if(handle.empty()){ return false; }
	if(currentHandle > 0){currentHandle--;}
	if(currentHandle <= handle.size()){
		DoHighlight();
	}
	return true;
}

//////////////////////////////////////////
bool DKHook::SetHandle(unsigned int index)
{
	if(handle.empty()){ return false; }
	if(index < handle.size()){
		currentHandle = index;
		return true;
	}
	return false;
}

/////////////////////////////////////////////
bool DKHook::SetHandle(const DKString& value)
{
	if(handle.empty()){ return false; }
	for(int i=0; i<handle.size(); i++){
		int len = SendMessage(handle[i], WM_GETTEXTLENGTH, 0, 0);
		char* buffer = new char[len];
		SendMessage(handle[i], WM_GETTEXT, (WPARAM)len+1, (LPARAM)buffer);
		DKString text = buffer;
		if(text == value){
			currentHandle = i;
			return true;
		}
	}
	return false;
}

//////////////////////////////////////
bool DKHook::GetString(DKString& text)
{
	if(handle.empty()){ return false; }
	int len = SendMessage(handle[currentHandle], WM_GETTEXTLENGTH, 0, 0);
    char* buffer = new char[len];
    SendMessage(handle[currentHandle], WM_GETTEXT, (WPARAM)len+1, (LPARAM)buffer);
    text = buffer;
	return true;
}

////////////////////////////////////////////
bool DKHook::SetString(const DKString& text)
{
	if(handle.empty()){ return false; }
	SendMessage(handle[currentHandle], WM_SETTEXT, (WPARAM)text.size(), (LPARAM)text.c_str());
	return true;
}

/////////////////////////////
bool DKHook::GetTop(int& top)
{
	if(handle.empty()){ return false; }
	RECT rect;
	GetWindowRect(handle[currentHandle], &rect);
	top = rect.top;
	return true;
}

///////////////////////////////
bool DKHook::GetLeft(int& left)
{
	if(handle.empty()){ return false; }
	RECT rect;
	GetWindowRect(handle[currentHandle], &rect);
	left = rect.left;
	return true;
}

/////////////////////////////////////
bool DKHook::GetClass(DKString& clas)
{
	char classname[256];
	if(!GetClassName(handle[currentHandle], classname, 256)){ return false; }
	clas = classname;
	return true;
}

////////////////////
bool DKHook::Click()
{
	if(handle.empty()){ return false; }
	SendMessage(handle[currentHandle], BM_CLICK, 0, 0);
	return true;
}

//////////////////////////////////
DKStringArray DKHook::GetWindows()
{
	windows.clear();
	EnumWindows(GetWindows, NULL);
	return windows;
}

////////////////////////////////////////////////
bool DKHook::WindowExists(const DKString& title)
{
	HWNDname temp;
	temp.caption = title.c_str();
	if(EnumWindows(FindWindowPartial, (LPARAM)&temp)){
		//TODO: GetLastError
		return false;
	}

	return true;
}

//////////////////////////////////////////////////////////////
bool DKHook::WaitForWindow(const DKString& title, int timeout)
{
	//FIXME - this is blocking,  thread this out
	int i = 0;
	while(!WindowExists(title) && i < timeout){
		Sleep(1000);
		++i;
	}
	Sleep(1000);
	if(!WindowExists(title)){ return false; }
	return true;
}

///////////////////////////////////////////////////////////////////////////////////////////
bool DKHook::SendHook(const DKString& window, const DKString& handle, const DKString& data)
{
	DKLog("DKHook::SendHook("+window+", "+handle+", "+data+")\n", DKDEBUG);
	
	if(!SetWindowHandle(window)){ return false; }
	if(!SetHandle(toInt(handle))){ return false; }

	DKStringArray arry;
	toStringArray(arry, data, ",");

	if(same(arry[0], "click")){
		Click();
	}
	if(same(arry[0], "GetValue")){
		DKString value;
		GetString(value);
		DKLog("Hook GetValue returned: "+value+"\n", DKINFO);
	}
	if(same(arry[0], "SetValue")){
		SetString(arry[1]);
	}
	return true;
}

#endif //WIN32