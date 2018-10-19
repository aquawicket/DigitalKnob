#include "DK/stdafx.h"
#ifdef WIN32
#include <tchar.h>
#include <Commctrl.h>
#include "DKHandles/DKHandles.h"


DKStringArray DKHandles::_windows;
bool DKHandles::searching = false;
WNDPROC DKHandles::prevWndProc;
HHOOK DKHandles::hMouseHook;
HPEN DKHandles::rectanglePen;
HWND DKHandles::hwndFoundWindow;
std::map<HWND,HWND> DKHandles::handles;
HWND DKHandles::currentHandle = NULL;
bool DKHandles::highlight = false;
std::vector<HWND> DKHandles::winhandles;

//////////////////////
bool DKHandles::Init()
{
	DKLog("DKHandles::Init\n", DKDEBUG);
	DKClass::DKCreate("DKHandlesJS");
	DKClass::DKCreate("DKHandlesV8");
	highlight = false;

	rectanglePen = CreatePen(PS_SOLID, 3, RGB(0, 0, 255));
	if(!rectanglePen){
		DKLog("DKHandles::Init(): g_hRectanglePen invalide\n");
		return false;
	}

	return true;
}

/////////////////////
bool DKHandles::End()
{
	DKLog("DKHandles::End\n", DKDEBUG);
	return true;
}



//////////////////////////////////
bool DKHandles::Click(HWND handle)
{
	DKLog("DKHandles::Click()\n", DKDEBUG);
	SendMessage(handle, BM_CLICK, 0, 0);
	return true;
}



/////////////////////////////
bool DKHandles::DoMouseMove()
{
	//DKLog("DKHandles::DoMouseMove\n", DKDEBUG);

	POINT screenpoint;
	HWND new_hwndFoundWindow = NULL;
	GetCursorPos(&screenpoint); //Must use GetCursorPos() instead of calculating from "lParam".

	// Determine the window that lies underneath the mouse cursor.
	new_hwndFoundWindow = WindowFromPoint(screenpoint);
	//new_hwndFoundWindow = RealChildWindowFromPoint(hwnd, screenpoint);
	if(!new_hwndFoundWindow){
		DKLog("DKHandles::DoMouseMove(): new_hwndFoundWindow invalid\n", DKERROR);
		return false;
	}

	//DKLog("DKHandles::DoMouseMove(): x = "+toString(screenpoint.x)+"\n");
	//DKLog("DKHandles::DoMouseMove(): y = "+toString(screenpoint.y)+"\n");

	if(hwndFoundWindow != new_hwndFoundWindow){
		//DKLog("DKHandles::DoMouseMove(): x = "+toString(screenpoint.x)+"\n");
		//DKLog("DKHandles::DoMouseMove(): y = "+toString(screenpoint.y)+"\n");

		//Display some information on this found window.
		//DisplayInfoOnFoundWindow(new_hwndFoundWindow);

		// If there was a previously found window, we must instruct it to refresh itself. 
		// This is done to remove any highlighting effects drawn by us.
		if(hwndFoundWindow){
			RefreshWindow(hwndFoundWindow);
		}
		
		hwndFoundWindow = new_hwndFoundWindow;
		//HighlightFoundWindow(hwndFoundWindow);
		HighlightFoundWindow(hwndFoundWindow);
	}

	return true;
}

///////////////////////////
bool DKHandles::DoMouseUp()
{
	DKLog("DKHandles::DoMouseUp()\n", DKDEBUG);

	// If we had a previous cursor, set the screen cursor to the previous one.
	// The cursor is to stay exactly where it is currently located when the 
	// left mouse button is lifted.
	//if(g_hCursorPrevious){
	//	SetCursor (g_hCursorPrevious);
	//}

	// If there was a found window, refresh it so that its highlighting is erased. 
	if(hwndFoundWindow){
		RefreshWindow(hwndFoundWindow);
	}

	// Set the bitmap on the Finder Tool icon to be the bitmap with the bullseye bitmap.
	//SetFinderToolImage(hwndDialog, TRUE);

	ReleaseCapture();

	//Bring back the main window
	HWND hwnd = NULL;
	
	//DKWindow::GetHandle((void*&)hwnd);
	if(DKClass::HasFunc("DKCefWindow::GetHandle")){
		DKClass::CallFunc("DKCefWindow::GetHandle", NULL, &hwnd);
	}
	if(DKClass::HasFunc("DKSDLWindow::GetHandle")){
		DKClass::CallFunc("DKSDLWindow::GetHandle", NULL, &hwnd);
	}

	if(!hwnd){
		DKLog("DKHandles::StartSearch(): hwnd is NULL\n", DKERROR);
		return false;
	}
	::ShowWindow(hwnd, SW_SHOWNORMAL);

	PopulateHandles();

	std::map<HWND,HWND>::iterator it;
	for(it=handles.begin(); it!=handles.end(); it++){
		if(it->first == hwndFoundWindow){
			currentHandle = it->first;
			DKEvent::SendEvent("GLOBAL", "DKHandles_WindowChanged", toString(it->first));
		}
	}

	return true;
}

///////////////////////////////////////////////////
bool DKHandles::GetBottom(HWND handle, int& bottom)
{
	DKLog("DKHandles::GetBottom()\n", DKDEBUG);
	RECT rect;
	GetWindowRect(handle, &rect);
	bottom = rect.bottom;
	DKLog("DKHandles::GetBottom(): bottom = "+toString(bottom)+"\n");
	return true;
}

/////////////////////////////////////////////////////
bool DKHandles::GetClass(HWND handle, DKString& clas)
{
	DKLog("DKHandles::GetClass()\n", DKDEBUG);
	char classname[256];
	if(!GetClassName(handle, classname, 256)){
		DKLog("DKHandles::GetClass(): GetClassName failed\n", DKWARN);
		return false; 
	}
	clas = classname;
	return true;
}

/////////////////////////////////////////////////
bool DKHandles::GetIndex(HWND handle, int& index)
{
	DKLog("DKHandles::GetIndex()\n", DKDEBUG);
	int i = 0;
	std::map<HWND,HWND>::iterator it;
	for(it=handles.begin(); it!=handles.end(); it++){
		if(it->first == handle){
			index = i;
			return true;
		}
		i++;
	}
	return false;
}

///////////////////////////////////////////////
bool DKHandles::GetLeft(HWND handle, int& left)
{
	DKLog("DKHandles::GetLeft()\n", DKDEBUG);
	RECT rect;
	GetWindowRect(handle, &rect);
	left = rect.left;
	DKLog("DKHandles::GetLeft(): left = "+toString(left)+"\n");
	return true;
}

////////////////////////////////////////////////////////
bool DKHandles::GetParent(HWND handle, DKString& parent)
{
	DKLog("DKHandles::GetParent()\n", DKDEBUG);
	HWND par = ::GetAncestor(handle, GA_PARENT);
	if(!par){
		DKString error;
		DKWindows::GetLastError(error);
		DKLog("DKHandles::GetParent("+toString(handle)+"): "+error+"\n", DKWARN);
		return false; 
	}
	parent = toString(par);
	return true;
}

/////////////////////////////////////////////////
bool DKHandles::GetRight(HWND handle, int& right)
{
	DKLog("DKHandles::GetRight()\n", DKDEBUG);
	RECT rect;
	GetWindowRect(handle, &rect);
	right = rect.right;
	DKLog("DKHandles::GetRight(): right = "+toString(right)+"\n");
	return true;
}

//////////////////////////////////////////////////////
bool DKHandles::GetString(HWND handle, DKString& text)
{
	DKLog("DKHandles::GetString()\n", DKDEBUG);
	int len = SendMessage(handle, WM_GETTEXTLENGTH, 0, 0);
	char* buffer = new char[len];
	SendMessage(handle, WM_GETTEXT, (WPARAM)len+1, (LPARAM)buffer);
	text = buffer;
	return true;
}

/////////////////////////////////////////////
bool DKHandles::GetTop(HWND handle, int& top)
{
	DKLog("DKHandles::GetTop()\n", DKDEBUG);
	RECT rect;
	GetWindowRect(handle, &rect);
	top = rect.top;
	DKLog("DKHandles::GetTop(): top = "+toString(top)+"\n");
	return true;
}

////////////////////////////////////////////////////
bool DKHandles::GetWindow(HWND handle, HWND& window)
{
	DKLog("DKHandles::GetWindow()\n", DKDEBUG);
	HWND win = handle;
	static TCHAR buffer[50]; 
	while(!GetWindowText(win, buffer, 50) && win != ::GetDesktopWindow()){
		win = ::GetAncestor(win, GA_PARENT);
	}
	window = win;
	return true;
}

///////////////////////////////////////////////////////
bool DKHandles::GetWindowIndex(HWND handle, int& index)
{
	DKLog("DKHandles::GetWindowIndex()\n", DKDEBUG);
	HWND window;
	if(!GetWindow(handle, window)){ return false; }
	winhandles.clear();
	winhandles.push_back(window);
	EnumChildWindows(window, EnumChildProcTemp, 0);
	for(unsigned int i=0; i<winhandles.size(); i++){
		if(handle == winhandles[i]){
			index = i;
			return true;
		}
	}
	return false;
}

//////////////////////////////////////////////////
bool DKHandles::GetWindows(DKStringArray& windows)
{
	DKLog("DKHandles::GetWindows()\n", DKDEBUG);
	PopulateHandles();
	_windows.clear();
	bool rval = (EnumChildWindows(::GetDesktopWindow(), GetWindows, NULL) != 0);
	windows = _windows;
	return rval;
}

///////////////////////////////////////////////
bool DKHandles::HighlightFoundWindow(HWND hwnd)
{
	DKLog("DKHandles::HighlightFoundWindow()\n", DKDEBUG);
	HDC hWindowDC = NULL;  // The DC of the found window.
	HGDIOBJ	hPrevPen = NULL;   // Handle of the existing pen in the DC of the found window.
	HGDIOBJ	hPrevBrush = NULL; // Handle of the existing brush in the DC of the found window.
	RECT rect;              // Rectangle area of the found window.
	long lRet = 0;

	// Get the screen coordinates of the rectangle of the found window.
	GetWindowRect(hwnd, &rect);

	// Get the window DC of the found window.
	hWindowDC = GetWindowDC (hwnd);

	if(hWindowDC){
		// Select our created pen into the DC and backup the previous pen.
		hPrevPen = SelectObject (hWindowDC, rectanglePen);

		// Select a transparent brush into the DC and backup the previous brush.
		hPrevBrush = SelectObject (hWindowDC, GetStockObject(HOLLOW_BRUSH));

		// Draw a rectangle in the DC covering the entire window area of the found window.
		Rectangle(hWindowDC, 0, 0, rect.right - rect.left, rect.bottom - rect.top);
		SelectObject(hWindowDC, hPrevPen); // Reinsert the previous pen and brush into the found window's DC.
		SelectObject(hWindowDC, hPrevBrush);
		ReleaseDC(hwnd, hWindowDC); // Finally release the DC.
	}

	return true;
}

////////////////////////////////////////////
bool DKHandles::HighlightWindow(HWND handle)
{
	DKLog("DKHandles::HighlightWindow()\n", DKDEBUG);
	//if(!highlight){ return false; }

	RefreshWindow(handle);

	RECT rect;
	GetWindowRect(handle, &rect);
	HDC screenDC = ::GetDC(GetDesktopWindow());

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
	return true;
}

/////////////////////////////////////////////////
bool DKHandles::NextHandle(HWND hwnd, HWND& next)
{
	DKLog("DKHandles::NextHandle()\n", DKDEBUG);
	std::map<HWND,HWND>::iterator it;
	for(it=handles.begin(); it!=handles.end(); it++){
		if(hwnd == it->first){
			it++;
			next = it->first;
			currentHandle = it->first;
			return true;
		}
	}
	return false;
}

/////////////////////////////////
bool DKHandles::PopulateHandles()
{
	DKLog("DKHandles::PopulateHandles()\n", DKDEBUG);
	//TODO - get a hierarchy of all window handles
	//std::map<HWND,HWND> DKHandles::handles;
	handles.clear();
	handles.insert(std::pair<HWND,HWND>(::GetDesktopWindow(), NULL));

	EnumChildWindows(::GetDesktopWindow(), EnumChildProc, 0);
	
	DKLog("hande size: "+toString(handles.size())+"\n");

	/*
	//std::map<HWND,HWND>::iterator it;
	for(it=handles.begin(); it!=handles.end(); it++){
		char class_name[80];
		char title[80];
		GetClassName(it->first, class_name, sizeof(class_name));
		GetWindowText(it->first, title, sizeof(title));

		if(!same("",title)){
		DKLog("Window: ");
		DKLog(title);
		DKLog(" Class: ");
		DKLog(class_name);
		DKLog("\n");
		}
	}
	*/

	return true;
}

/////////////////////////////////////////////////
bool DKHandles::PrevHandle(HWND hwnd, HWND& prev)
{
	DKLog("DKHandles::PrevHandle()\n", DKDEBUG);
	std::map<HWND,HWND>::iterator it;
	for(it=handles.end(); it!=handles.begin(); it--){
		if(hwnd == it->first){
			it--;
			prev = it->first;
			currentHandle = it->first;
			return true;
		}
	}
	return false;
}

////////////////////////////////////////
bool DKHandles::RefreshWindow(HWND hwnd)
{
	DKLog("DKHandles::RefreshWindow()\n", DKDEBUG);
	InvalidateRect(hwnd, NULL, TRUE);
	UpdateWindow(hwnd);
	RedrawWindow(hwnd, NULL, NULL, RDW_FRAME | RDW_INVALIDATE | RDW_UPDATENOW | RDW_ALLCHILDREN);
	return true;
}

/*
//////////////////////////////////////////////////////////////////////////////////////////////
bool DKHandles::SendHook(const DKString& window, const DKString& handle, const DKString& data)
{
	DKLog("DKHandles::SendHook("+window+", "+handle+", "+data+")\n", DKDEBUG);

	if(!SetWindowHandle(window, 1)){ return false; }
	if(!SetHandle(toInt(handle), 1)){ return false; }

	DKStringArray arry;
	toStringArray(arry, data, ",");

	if(same(arry[0], "click")){
		Click();
	}
	if(same(arry[0], "GetValue")){
		DKString value;
		GetString(value);
		DKLog("Hook GetValue returned: "+value+"\n");
	}
	if(same(arry[0], "SetValue")){
		SetString(arry[1]);
	}
	return true;
}
*/

////////////////////////////////////////////////////////////////////////////////////////////
bool DKHandles::SetHandle(const DKString& clas, const DKString& value, unsigned int timeout)
{
	DKLog("DKHandles::SetHandle("+clas+","+value+","+toString(timeout)+")\n", DKDEBUG);
	unsigned int t = 0;
	unsigned int h = 0;
	DKString text;
	char classname[256];

	while(t < timeout){
		PopulateHandles();
		std::map<HWND,HWND>::iterator it;
		for(it=handles.begin(); it!=handles.end(); it++){
			int len = SendMessage(it->first, WM_GETTEXTLENGTH, 0, 0);
			char* buffer = new char[len];
			SendMessage(it->first, WM_GETTEXT, (WPARAM)len+1, (LPARAM)buffer);
			DKString text = buffer;
			if(value.empty()){
				int test = 0;
			}
			if(text == value){
				if(!GetClassName(it->first, classname, 256)){
					DKLog("DKHandles::SetHandle("+clas+","+value+"): GetClassName failed. \n", DKWARN);
					return false; 
				}
				if(clas == (DKString)classname){
					currentHandle = it->first;
					return true;
				}
			}
		}
		Sleep(1000); //FIXME
		++t;
	}
	
	DKLog("DKHandles::SetHandle("+clas+","+value+","+toString(timeout)+"): timed out.\n", DKWARN);
	return false;
}

//////////////////////////////////////////////////////////////////////
bool DKHandles::SetHandle(const DKString& value, unsigned int timeout)
{
	DKLog("DKHandles::SetHandle("+value+","+toString(timeout)+")\n", DKDEBUG);
	unsigned int t = 0;
	unsigned int h = 0;
	DKString text;
	while(t < timeout){
		PopulateHandles();
		std::map<HWND,HWND>::iterator it;
		for(it=handles.begin(); it!=handles.end(); it++){
			int len = SendMessage(it->first, WM_GETTEXTLENGTH, 0, 0);
			char* buffer = new char[len];
			SendMessage(it->first, WM_GETTEXT, (WPARAM)len+1, (LPARAM)buffer);
			text = buffer;
			if(text == value){
				currentHandle = it->first;
				return true;
			}
		}
		Sleep(1000); //FIXME
		++t;
	}

	DKLog("DKHandles::SetHandle("+value+","+toString(timeout)+"): timed out.\n", DKWARN);
	return false;
}

///////////////////////////////////////////////////////////////////
bool DKHandles::SetHandle(unsigned int index, unsigned int timeout)
{
	DKLog("DKHandles::SetHandle("+toString(index)+","+toString(timeout)+")\n", DKDEBUG);
	unsigned int t = 0;
	while(index > handles.size() && t < timeout){
		PopulateHandles();
		Sleep(1000); //FIXME
		++t;
	}
	if(index > handles.size()){
		DKLog("DKHandles::SetHandle("+toString(index)+","+toString(timeout)+"): timed out.\n", DKWARN);
		return false;
	}
	//currentHandle = index;
	return true;
}

//////////////////////////////////////////////////////////
bool DKHandles::SetString(HWND hwnd, const DKString& text)
{
	DKLog("DKHandles::SetString(hwnd,"+text+")\n", DKDEBUG);
	SendMessage(hwnd, WM_SETTEXT, (WPARAM)text.size(), (LPARAM)text.c_str());
	return true;
}

//////////////////////////////////////////////////////////////////////////////////////////////
bool DKHandles::SetWindowHandle(const DKString& title, const unsigned int timeout, HWND& hwnd)
{
	DKLog("DKHandles::SetWindowHandle("+title+","+toString(timeout)+")\n", DKDEBUG);
	HWNDname temp;
	temp.caption = title.c_str();
	unsigned int t = 0;
	while(EnumChildWindows(::GetDesktopWindow(), FindWindow, (LPARAM)&temp) && t < timeout, 0){
		Sleep(1000); //FIXME
		++t;
	}
	if(t >= timeout){
		DKLog("DKHandles::SetWindowHandle("+title+","+toString(timeout)+"): timed out.\n", DKWARN);
		return false;
	}
	
	hwnd = currentHandle;
	DKLog("Selected Window: "+title+"\n");
	return true;
}

////////////////////////////////////////////////////////
bool DKHandles::ShowWindow(HWND hwnd, unsigned int flag)
{
	DKLog("DKHandles::ShowWindow(hwnd,"+toString(flag)+")\n", DKDEBUG);
	::ShowWindow(hwnd, flag);
	return true;
}

/////////////////////////////
bool DKHandles::StartSearch()
{
	DKLog("DKHandles::StartSearch()\n", DKDEBUG);

	HWND hwnd = NULL;
	//DKWindow::GetHandle((void*&)hwnd);
	if(DKClass::HasFunc("DKCefWindow::GetHandle")){
		DKClass::CallFunc("DKCefWindow::GetHandle", NULL, &hwnd);
	}
	if(DKClass::HasFunc("DKSDLWindow::GetHandle")){
		DKClass::CallFunc("DKSDLWindow::GetHandle", NULL, &hwnd);
	}

	if(!hwnd){
		DKLog("DKHandles::StartSearch(): hwnd is NULL\n", DKERROR);
		return false;
	}

	hMouseHook = SetWindowsHookEx(WH_MOUSE_LL, &SearchProc, DKWindows::hInstance, NULL);

	searching = TRUE;
	//TODO - MoveCursorPositionToBullsEye
	//TODO - Set the screen cursor to the BullsEye cursor.

	SetCapture(hwnd);

	// Hide the main window.
	::ShowWindow(hwnd, SW_HIDE);

	return true;
}

/////////////////////////////////
bool DKHandles::ToggleHighlight()
{
	DKLog("DKHandles::ToggleHighlight()\n", DKDEBUG);
	if(highlight){
		highlight = false;
		return true;
	}
	highlight = true;
	return true;
}

///////////////////////////////////////////////////////////////////////////////////////
bool DKHandles::WaitForHandle(const DKString& clas, const DKString& value, int timeout)
{
	DKLog("DKHandles::WaitForHandle("+clas+","+value+","+toString(timeout)+")\n", DKDEBUG);
	int i = 0;
	DKString text;
	char classname[256];
	
	while(text != value && clas != (DKString)classname && i < timeout){
		PopulateHandles();
		std::map<HWND,HWND>::iterator it;
		for(it=handles.begin(); it!=handles.end(); it++){
			int len = SendMessage(it->first, WM_GETTEXTLENGTH, 0, 0);
			char* buffer = new char[len];
			SendMessage(it->first, WM_GETTEXT, (WPARAM)len+1, (LPARAM)buffer);
			DKString text = buffer;
			if(text == value){
				if(!GetClassName(it->first, classname, 256)){
					DKLog("DKHandles::SetHandle("+clas+","+value+"): GetClassName failed. \n", DKWARN);
					return false; 
				}
			}
		}
		Sleep(1000); //FIXME
		++i;
	}
	if(i >= timeout){
		DKLog("DKHandles::WaitForHandle("+clas+","+value+","+toString(timeout)+"): timed out.\n", DKWARN);
		return false;
	}
	return true;
}

/////////////////////////////////////////////////////////////////
bool DKHandles::WaitForHandle(const DKString& value, int timeout)
{
	DKLog("DKHandles::WaitForHandle("+value+","+toString(timeout)+")\n", DKDEBUG);
	int i = 0;
	DKString text;
	while(text != value && i < timeout){
		PopulateHandles();
		std::map<HWND,HWND>::iterator it;
		for(it=handles.begin(); it!=handles.end(); it++){
			int len = SendMessage(it->first, WM_GETTEXTLENGTH, 0, 0);
			char* buffer = new char[len];
			SendMessage(it->first, WM_GETTEXT, (WPARAM)len+1, (LPARAM)buffer);
			text = buffer;
		}
		Sleep(1000); //FIXME
		++i;
	}
	if(i >= timeout){
		DKLog("DKHandles::WaitForHandle("+value+","+toString(timeout)+"): timed out.\n", DKWARN);
		return false;
	}
	return true;
}

//////////////////////////////////////////////////////////////
bool DKHandles::WaitForHandle(unsigned int index, int timeout)
{
	DKLog("DKHandles::WaitForHandle("+toString(index)+","+toString(timeout)+")\n", DKDEBUG);
	int i = 0;
	while(index > handles.size() && i < timeout){
		PopulateHandles();
		Sleep(1000); //FIXME
		++i;
	}
	if(i >= timeout){
		DKLog("DKHandles::WaitForHandle("+toString(index)+","+toString(timeout)+"): timed out.\n", DKWARN);
		return false;
	}
	//currentHandle = index;
	return true;
}

/////////////////////////////////////////////////////////////////
bool DKHandles::WaitForWindow(const DKString& title, int timeout)
{
	DKLog("DKHandles::WaitForWindow("+title+","+toString(timeout)+")\n", DKDEBUG);
	//FIXME - this is blocking,  thread this out
	int i = 0;
	while(!WindowExists(title) && i < timeout){
		Sleep(1000); //FIXME
		++i;
	}
	if(i >= timeout){
		DKLog("DKHandles::WaitForWindow("+title+","+toString(timeout)+"): timed out.\n", DKWARN);
		return false;
	}
	return true;
}

///////////////////////////////////////////////////
bool DKHandles::WindowExists(const DKString& title)
{
	DKLog("DKHandles::WindowExists("+title+")\n", DKDEBUG);
	HWNDname temp;
	temp.caption = title.c_str();
	if(EnumChildWindows(::GetDesktopWindow(), FindWindowPartial, (LPARAM)&temp)){
		//TODO: GetLastError
		return false;
	}

	return true;
}




////////////////////////////////////////////////////////////////
BOOL CALLBACK DKHandles::EnumChildProc(HWND hwnd, LPARAM lParam) 
{
	handles.insert(std::pair<HWND,HWND>(hwnd, ::GetParent(hwnd)));
	return TRUE;
}

////////////////////////////////////////////////////////////////////
BOOL CALLBACK DKHandles::EnumChildProcTemp(HWND hwnd, LPARAM lParam) 
{
	winhandles.push_back(hwnd);
	return TRUE;
}

/*
//////////////////////////////////////////////////////////////////
BOOL CALLBACK DKHandles::EnumWindowsProc(HWND hwnd, LPARAM lParam)
{
	char class_name[80];
	char title[80];
	GetClassName(hwnd,class_name, sizeof(class_name));
	GetWindowText(hwnd,title,sizeof(title));

	//if(!same("",title)){
	//DKLog("Window: ");
	//DKLog(title);
	//DKLog(" Class: ");
	//DKLog(class_name);
	//DKLog("\n");
	}

	return TRUE;
}
*/

/////////////////////////////////////////////////////////////
BOOL CALLBACK DKHandles::FindWindow(HWND hwnd, LPARAM lparam) 
{     
	HWNDname *temp = (HWNDname*)lparam;
	static TCHAR buffer[50];      
	GetWindowText(hwnd, buffer, 50);     
	if(strcmp(buffer, temp->caption) == 0){
		currentHandle = hwnd;
		return FALSE;     
	} 
	return TRUE; 
}

////////////////////////////////////////////////////////////////////
BOOL CALLBACK DKHandles::FindWindowPartial(HWND hwnd, LPARAM lparam) 
{     
	HWNDname *temp = (HWNDname*)lparam;
	static TCHAR buffer[50];      
	GetWindowText(hwnd, buffer, 50);     
	if(_tcsstr(buffer, temp->caption)){ 
		currentHandle = hwnd;
		return FALSE;     
	}      
	return TRUE; 
}

/////////////////////////////////////////////////////////////
BOOL CALLBACK DKHandles::GetWindows(HWND hwnd, LPARAM lparam) 
{     
	static TCHAR buffer[50];      
	GetWindowText(hwnd, buffer, 50);
	DKString title = buffer;
	if(!title.empty()){
		_windows.push_back(title);
	}    
	return true; 
}

//////////////////////////////////////////////////////////////////////////////
LRESULT CALLBACK DKHandles::SearchProc(int code, WPARAM wParam, LPARAM lParam)
{
	//DKLog("DKHandles::SearchProc\n", DKDEBUG);

	if(wParam == WM_MOUSEMOVE){
		if(searching){
			DoMouseMove();
		}
	}
	if(wParam == WM_LBUTTONUP){
		if(searching){
			DoMouseUp();
			searching = false;
		}
	}

	return CallNextHookEx(hMouseHook, code, wParam, lParam);
}

#endif //WIN32