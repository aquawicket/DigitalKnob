/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
* Copyright(c) 2010 - 2024 Digitalknob Team, and contributors
=======
* Copyright(c) 2010 - 2025 Digitalknob Team, and contributors
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
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

//WARNING_DISABLE
#include <tchar.h>
#include <Commctrl.h>
//WARNING_ENABLE

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

bool DKHandles::Init() {
	DKDEBUGFUNC();
	DKClass::DKCreate("DKHandlesJS");
	DKClass::DKCreate("DKHandlesV8");
	highlight = false;
	rectanglePen = CreatePen(PS_SOLID, 3, RGB(0, 0, 255));
	if(!rectanglePen)
		return DKERROR("g_hRectanglePen invalide\n");
	return true;
}

bool DKHandles::End() {
	DKDEBUGFUNC();
	DKClass::DKClose("DKHandlesJS");
	DKClass::DKClose("DKHandlesV8");
	return true;
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::Click(HWND handle) {
=======
bool DKHandles::Click(HWND handle){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(handle);
	SendMessage(handle, BM_CLICK, 0, 0);
	return true;
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::DoMouseMove() {
=======
bool DKHandles::DoMouseMove(){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC();
	POINT screenpoint;
	HWND new_hwndFoundWindow = NULL;
	GetCursorPos(&screenpoint); //Must use GetCursorPos() instead of calculating from "lParam".
	// Determine the window that lies underneath the mouse cursor.
	new_hwndFoundWindow = WindowFromPoint(screenpoint);
	//new_hwndFoundWindow = RealChildWindowFromPoint(hwnd, screenpoint);
	if(!new_hwndFoundWindow)
		return DKERROR("new_hwndFoundWindow invalid\n");
	//DKINFO("DKHandles::DoMouseMove(): x = "+toString(screenpoint.x)+"\n");
	//DKINFO("DKHandles::DoMouseMove(): y = "+toString(screenpoint.y)+"\n");

	if(hwndFoundWindow != new_hwndFoundWindow){
		//DKINFO("DKHandles::DoMouseMove(): x = "+toString(screenpoint.x)+"\n");
		//DKINFO("DKHandles::DoMouseMove(): y = "+toString(screenpoint.y)+"\n");
		//Display some information on this found window.
		//DisplayInfoOnFoundWindow(new_hwndFoundWindow);

		// If there was a previously found window, we must instruct it to refresh itself. 
		// This is done to remove any highlighting effects drawn by us.
		if(hwndFoundWindow)
			RefreshWindow(hwndFoundWindow);
		hwndFoundWindow = new_hwndFoundWindow;
		//HighlightFoundWindow(hwndFoundWindow);
		HighlightFoundWindow(hwndFoundWindow);
	}
	return true;
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::DoMouseUp() {
=======
bool DKHandles::DoMouseUp(){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC();
	// If we had a previous cursor, set the screen cursor to the previous one.
	// The cursor is to stay exactly where it is currently located when the 
	// left mouse button is lifted.
	//if(g_hCursorPrevious)
	//	SetCursor (g_hCursorPrevious);

	// If there was a found window, refresh it so that its highlighting is erased. 
	if(hwndFoundWindow)
		RefreshWindow(hwndFoundWindow);
	// Set the bitmap on the Finder Tool icon to be the bitmap with the bullseye bitmap.
	//SetFinderToolImage(hwndDialog, TRUE);
	ReleaseCapture();
	//Bring back the main window
	HWND hwnd = NULL;
	//DKWindow::GetHandle((void*&)hwnd);
	if(DKClass::HasFunc("DKCEFWindow::GetHandle"))
		DKClass::CallFunc("DKCEFWindow::GetHandle", NULL, &hwnd);
	if(DKClass::HasFunc("DKSDLWindow::GetHandle"))
		DKClass::CallFunc("DKSDLWindow::GetHandle", NULL, &hwnd);
	if(!hwnd)
		return DKERROR("hwnd is NULL\n");
	::ShowWindow(hwnd, SW_SHOWNORMAL);
	PopulateHandles();
	std::map<HWND,HWND>::iterator it;
	for(it=handles.begin(); it!=handles.end(); it++){
		if(it->first == hwndFoundWindow){
			currentHandle = it->first;
			DKEvents::SendEvent("window", "DKHandles_WindowChanged", toString(it->first));
		}
	}
	return true;
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::GetBottom(HWND handle, int& bottom) {
=======
bool DKHandles::GetBottom(HWND handle, int& bottom){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(handle, bottom);
	RECT rect;
	GetWindowRect(handle, &rect);
	bottom = rect.bottom;
	DKINFO("bottom = "+toString(bottom)+"\n");
	return true;
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::GetClass(HWND handle, DKString& clas) {
=======
bool DKHandles::GetClass(HWND handle, DKString& clas){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(handle, clas);
	char _classname[256];
	if(!GetClassName(handle, _classname, 256))
		return DKERROR("GetClassName failed\n");
	clas = _classname;
	return true;
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::GetIndex(HWND handle, int& index) {
=======
bool DKHandles::GetIndex(HWND handle, int& index){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(handle, index);
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

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::GetLeft(HWND handle, int& left) {
=======
bool DKHandles::GetLeft(HWND handle, int& left){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(handle, left);
	RECT rect;
	GetWindowRect(handle, &rect);
	left = rect.left;
	DKINFO("left = "+toString(left)+"\n");
	return true;
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::GetParent(HWND handle, DKString& parent) {
=======
bool DKHandles::GetParent(HWND handle, DKString& parent){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(handle, parent);
	HWND par = ::GetAncestor(handle, GA_PARENT);
	if(!par){
		DKString error;
		DKWindows::GetLastError(error);
		DKWARN(error+"\n");
		return false; 
	}
	parent = toString(par);
	return true;
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::GetRight(HWND handle, int& right) {
=======
bool DKHandles::GetRight(HWND handle, int& right){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(handle, right);
	RECT rect;
	GetWindowRect(handle, &rect);
	right = rect.right;
	DKINFO("right = "+toString(right)+"\n");
	return true;
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::GetString(HWND handle, DKString& text) {
=======
bool DKHandles::GetString(HWND handle, DKString& text){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(handle, text);
	int len = SendMessage(handle, WM_GETTEXTLENGTH, 0, 0);
	char* buffer = new char[len];
	SendMessage(handle, WM_GETTEXT, (WPARAM)len+1, (LPARAM)buffer);
	text = buffer;
	return true;
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::GetTop(HWND handle, int& top) {
=======
bool DKHandles::GetTop(HWND handle, int& top){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(handle, top);
	RECT rect;
	GetWindowRect(handle, &rect);
	top = rect.top;
	DKINFO("top = "+toString(top)+"\n");
	return true;
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::GetWindow(HWND handle, HWND& window) {
=======
bool DKHandles::GetWindow(HWND handle, HWND& window){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(handle, window);
	HWND win = handle;
	static TCHAR buffer[50]; 
	while(!GetWindowText(win, buffer, 50) && win != ::GetDesktopWindow()){
		win = ::GetAncestor(win, GA_PARENT);
	}
	window = win;
	return true;
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::GetWindowIndex(HWND handle, int& index) {
=======
bool DKHandles::GetWindowIndex(HWND handle, int& index){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(handle, index);
	HWND window;
	if(!GetWindow(handle, window))
		return false;
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

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::GetWindows(DKStringArray& windows) {
=======
bool DKHandles::GetWindows(DKStringArray& windows){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(windows);
	PopulateHandles();
	_windows.clear();
	bool rval = (EnumChildWindows(::GetDesktopWindow(), GetWindows, NULL) != 0);
	windows = _windows;
	return rval;
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::HighlightFoundWindow(HWND hwnd) {
=======
bool DKHandles::HighlightFoundWindow(HWND hwnd){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(hwnd);
	HDC hWindowDC = NULL;  // The DC of the found window.
	HGDIOBJ	hPrevPen = NULL;   // Handle of the existing pen in the DC of the found window.
	HGDIOBJ	hPrevBrush = NULL; // Handle of the existing brush in the DC of the found window.
	RECT rect;              // Rectangle area of the found window.
	//long lRet = 0;

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

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::HighlightWindow(HWND handle) {
=======
bool DKHandles::HighlightWindow(HWND handle){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(handle);
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

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::NextHandle(HWND hwnd, HWND& next) {
=======
bool DKHandles::NextHandle(HWND hwnd, HWND& next){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(hwnd, next);
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

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::PopulateHandles() {
=======
bool DKHandles::PopulateHandles(){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC();
	//TODO - get a hierarchy of all window handles
	//std::map<HWND,HWND> DKHandles::handles;
	handles.clear();
	handles.insert(std::pair<HWND,HWND>(::GetDesktopWindow(), NULL));
	EnumChildWindows(::GetDesktopWindow(), EnumChildProc, 0);
	DKINFO("hande size: "+toString(handles.size())+"\n");
	/*
	//std::map<HWND,HWND>::iterator it;
	for(it=handles.begin(); it!=handles.end(); it++){
		char class_name[80];
		char title[80];
		GetClassName(it->first, class_name, sizeof(class_name));
		GetWindowText(it->first, title, sizeof(title));
		if(!same("",title)){
			DKINFO("Window: "+title+"\n");
			DKINFO(" Class: "+class_name+"\n");
		}
	}
	*/
	return true;
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::PrevHandle(HWND hwnd, HWND& prev) {
=======
bool DKHandles::PrevHandle(HWND hwnd, HWND& prev){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(hwnd, prev);
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

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::RefreshWindow(HWND hwnd) {
=======
bool DKHandles::RefreshWindow(HWND hwnd){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(hwnd);
	InvalidateRect(hwnd, NULL, TRUE);
	UpdateWindow(hwnd);
	RedrawWindow(hwnd, NULL, NULL, RDW_FRAME | RDW_INVALIDATE | RDW_UPDATENOW | RDW_ALLCHILDREN);
	return true;
}

/*
<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::SendHook(const DKString& window, const DKString& handle, const DKString& data) {
=======
bool DKHandles::SendHook(const DKString& window, const DKString& handle, const DKString& data){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(window, handle, data);
	if(!SetWindowHandle(window, 1)){ return false; }
	if(!SetHandle(toInt(handle), 1)){ return false; }
	DKStringArray arry;
	toStringArray(arry, data, ",");
	if(same(arry[0], "click"))
		Click();
	if(same(arry[0], "GetValue")){
		DKString value;
		GetString(value);
		DKINFO("Hook GetValue returned: "+value+"\n");
	}
	if(same(arry[0], "SetValue"))
		SetString(arry[1]);
	return true;
}
*/

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::SetHandle(const DKString& clas, const DKString& value, unsigned int timeout) {
=======
bool DKHandles::SetHandle(const DKString& clas, const DKString& value, unsigned int timeout){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(clas, value, timeout);
	unsigned int t = 0;
	//unsigned int h = 0;
	char _classname[256];

	while(t < timeout){
		PopulateHandles();
		std::map<HWND,HWND>::iterator it;
		for(it=handles.begin(); it!=handles.end(); it++){
			int len = SendMessage(it->first, WM_GETTEXTLENGTH, 0, 0);
			char* buffer = new char[len];
			SendMessage(it->first, WM_GETTEXT, (WPARAM)len+1, (LPARAM)buffer);
			DKString text = buffer;
			//if(value.empty())
			//	int test = 0;
			if(text == value){
				if(!GetClassName(it->first, _classname, 256))
					return DKERROR("GetClassName failed\n");
				if(clas == (DKString)_classname){
					currentHandle = it->first;
					return true;
				}
			}
		}
		Sleep(1000); //FIXME
		++t;
	}
	DKWARN("timed out\n");
	return false;
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::SetHandle(const DKString& value, unsigned int timeout) {
=======
bool DKHandles::SetHandle(const DKString& value, unsigned int timeout){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(value, timeout);
	unsigned int t = 0;
	//unsigned int h = 0;
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
	DKWARN("timed out\n");
	return false;
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::SetHandle(unsigned int index, unsigned int timeout) {
=======
bool DKHandles::SetHandle(unsigned int index, unsigned int timeout){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(index, timeout);
	unsigned int t = 0;
	while(index > handles.size() && t < timeout){
		PopulateHandles();
		Sleep(1000); //FIXME
		++t;
	}
	if(index > handles.size()){
		DKWARN("DKHandles::SetHandle("+toString(index)+","+toString(timeout)+"): timed out\n");
		return false;
	}
	//currentHandle = index;
	return true;
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::SetString(HWND hwnd, const DKString& text) {
=======
bool DKHandles::SetString(HWND hwnd, const DKString& text){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(hwnd, text);
	SendMessage(hwnd, WM_SETTEXT, (WPARAM)text.size(), (LPARAM)text.c_str());
	return true;
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::SetWindowHandle(const DKString& title, const unsigned int timeout, HWND& hwnd) {
=======
bool DKHandles::SetWindowHandle(const DKString& title, const unsigned int timeout, HWND& hwnd){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(title, timeout, hwnd);
	HWNDname temp;
	temp.caption = title.c_str();
	unsigned int t = 0;
	while(EnumChildWindows(::GetDesktopWindow(), FindWindow, (LPARAM)&temp) && t < timeout, 0){
		Sleep(1000); //FIXME
		++t;
	}
	if(t >= timeout){
		DKWARN("timed out\n");
		return false;
	}
	hwnd = currentHandle;
	DKINFO("Selected Window: "+title+"\n");
	return true;
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::ShowWindow(HWND hwnd, unsigned int flag) {
=======
bool DKHandles::ShowWindow(HWND hwnd, unsigned int flag){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(hwnd, flag);
	::ShowWindow(hwnd, flag);
	return true;
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::StartSearch() {
=======
bool DKHandles::StartSearch(){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC();
	HWND hwnd = NULL;
	//DKWindow::GetHandle((void*&)hwnd);
	if(DKClass::HasFunc("DKCEFWindow::GetHandle"))
		DKClass::CallFunc("DKCEFWindow::GetHandle", NULL, &hwnd);
	if(DKClass::HasFunc("DKSDLWindow::GetHandle"))
		DKClass::CallFunc("DKSDLWindow::GetHandle", NULL, &hwnd);
	if(!hwnd)
		return DKERROR("hwnd is NULL\n");
	hMouseHook = SetWindowsHookEx(WH_MOUSE_LL, &SearchProc, DKWindows::hInstance, NULL);
	searching = TRUE;
	//TODO - MoveCursorPositionToBullsEye
	//TODO - Set the screen cursor to the BullsEye cursor.
	SetCapture(hwnd);
	// Hide the main window.
	::ShowWindow(hwnd, SW_HIDE);
	return true;
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::ToggleHighlight() {
=======
bool DKHandles::ToggleHighlight(){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC();
	if(highlight){
		highlight = false;
		return true;
	}
	highlight = true;
	return true;
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::WaitForHandle(const DKString& clas, const DKString& value, int timeout) {
=======
bool DKHandles::WaitForHandle(const DKString& clas, const DKString& value, int timeout){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(clas, value, timeout);
	int i = 0;
	//DKString text;
	char _classname[256];
	
<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
	while(/*text != value && */clas != (DKString)_classname && i < timeout) {
=======
	while(/*text != value && */clas != (DKString)_classname && i < timeout){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
		PopulateHandles();
		std::map<HWND,HWND>::iterator it;
		for(it=handles.begin(); it!=handles.end(); it++){
			int len = SendMessage(it->first, WM_GETTEXTLENGTH, 0, 0);
			char* buffer = new char[len];
			SendMessage(it->first, WM_GETTEXT, (WPARAM)len+1, (LPARAM)buffer);
			DKString text = buffer;
			if(text == value){
				if(!GetClassName(it->first, _classname, 256))
					return DKERROR("GetClassName() failed\n");
			}
		}
		Sleep(1000); //FIXME
		++i;
	}
	if(i >= timeout)
		return DKERROR("timed out\n");
	return true;
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::WaitForHandle(const DKString& value, int timeout) {
=======
bool DKHandles::WaitForHandle(const DKString& value, int timeout){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(value, timeout);
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
		DKWARN("DKHandles::WaitForHandle("+value+","+toString(timeout)+"): timed out\n");
		return false;
	}
	return true;
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::WaitForHandle(unsigned int index, int timeout) {
=======
bool DKHandles::WaitForHandle(unsigned int index, int timeout){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(index, timeout);
	int i = 0;
	while(index > handles.size() && i < timeout){
		PopulateHandles();
		Sleep(1000); //FIXME
		++i;
	}
	if(i >= timeout){
		DKWARN("DKHandles::WaitForHandle("+toString(index)+","+toString(timeout)+"): timed out\n");
		return false;
	}
	//currentHandle = index;
	return true;
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::WaitForWindow(const DKString& title, int timeout) {
=======
bool DKHandles::WaitForWindow(const DKString& title, int timeout){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(title, timeout);
	//FIXME - this is blocking,  thread this out
	int i = 0;
	while(!WindowExists(title) && i < timeout){
		Sleep(1000); //FIXME
		++i;
	}
	if(i >= timeout){
		DKWARN("DKHandles::WaitForWindow("+title+","+toString(timeout)+"): timed out\n");
		return false;
	}
	return true;
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
bool DKHandles::WindowExists(const DKString& title) {
=======
bool DKHandles::WindowExists(const DKString& title){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(title);
	HWNDname temp;
	temp.caption = title.c_str();
	if (EnumChildWindows(::GetDesktopWindow(), FindWindowPartial, (LPARAM)&temp)) 
		return false; //TODO: GetLastError
	return true;
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
BOOL CALLBACK DKHandles::EnumChildProc(HWND hwnd, LPARAM lParam) {
=======
BOOL CALLBACK DKHandles::EnumChildProc(HWND hwnd, LPARAM lParam){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(hwnd, lParam);
	handles.insert(std::pair<HWND,HWND>(hwnd, ::GetParent(hwnd)));
	return TRUE;
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
BOOL CALLBACK DKHandles::EnumChildProcTemp(HWND hwnd, LPARAM lParam) {
=======
BOOL CALLBACK DKHandles::EnumChildProcTemp(HWND hwnd, LPARAM lParam){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(hwnd, lParam);
	winhandles.push_back(hwnd);
	return TRUE;
}

/*
<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
BOOL CALLBACK DKHandles::EnumWindowsProc(HWND hwnd, LPARAM lParam) {
=======
BOOL CALLBACK DKHandles::EnumWindowsProc(HWND hwnd, LPARAM lParam){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(hwnd, lParam);
	char class_name[80];
	char title[80];
	GetClassName(hwnd,class_name, sizeof(class_name));
	GetWindowText(hwnd,title,sizeof(title));
	//if(!same("",title)){
	//DKINFO("Window: "+title+"\n");
	//DKINFO(" Class: "+class_name+"\n");
	//}
	return TRUE;
}
*/

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
BOOL CALLBACK DKHandles::FindWindow(HWND hwnd, LPARAM lparam) {   
=======
BOOL CALLBACK DKHandles::FindWindow(HWND hwnd, LPARAM lparam){   
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(hwnd, lparam);
	HWNDname *temp = (HWNDname*)lparam;
	static TCHAR buffer[50];      
	GetWindowText(hwnd, buffer, 50);     
	if(strcmp(buffer, temp->caption) == 0){
		currentHandle = hwnd;
		return FALSE;     
	} 
	return TRUE; 
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
BOOL CALLBACK DKHandles::FindWindowPartial(HWND hwnd, LPARAM lparam) {
=======
BOOL CALLBACK DKHandles::FindWindowPartial(HWND hwnd, LPARAM lparam){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(hwnd, lparam);
	HWNDname *temp = (HWNDname*)lparam;
	static TCHAR buffer[50];      
	GetWindowText(hwnd, buffer, 50);     
	if(_tcsstr(buffer, temp->caption)){ 
		currentHandle = hwnd;
		return FALSE;     
	}      
	return TRUE; 
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
BOOL CALLBACK DKHandles::GetWindows(HWND hwnd, LPARAM lparam) {
=======
BOOL CALLBACK DKHandles::GetWindows(HWND hwnd, LPARAM lparam){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(hwnd, lparam);
	static TCHAR buffer[50];      
	GetWindowText(hwnd, buffer, 50);
	DKString title = buffer;
	if(!title.empty())
		_windows.push_back(title);
	return true; 
}

<<<<<<< HEAD:DKPlugins/DKHandles/DKHandles.cpp
LRESULT CALLBACK DKHandles::SearchProc(int code, WPARAM wParam, LPARAM lParam) {
=======
LRESULT CALLBACK DKHandles::SearchProc(int code, WPARAM wParam, LPARAM lParam){
>>>>>>> Development:DKCpp/plugins/DKHandles/DKHandles.cpp
	DKDEBUGFUNC(code, wParam, lParam);
	if(wParam == WM_MOUSEMOVE){
		if(searching)
			DoMouseMove();
	}
	if(wParam == WM_LBUTTONUP){
		if(searching){
			DoMouseUp();
			searching = false;
		}
	}
	return CallNextHookEx(hMouseHook, code, wParam, lParam);
}

#endif //WIN