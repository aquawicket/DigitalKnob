#include "stdafx.h"
#include "DKWindow.h"

/////////////////////
void DKWindow::Init()
{
	DKCreate("DKWindowJS");
	//Create DKSDLWindow or DKOSGWindow
	if(DKAvailable("DKSDLWindow")){
		DKCreate("DKSDLWindow");
	}
	else if(DKAvailable("DKOSGWindow")){
		DKCreate("DKOSGWindow");
	}
	else{
		DKLog("DKWindow::Init(): No window system available \n", DKERROR);
	}
}

////////////////////
void DKWindow::End()
{

}

////////////////////
int DKWindow::GetX()
{
	int* ptr = NULL;
	if(DKClass::HasFunc("DKSDLWindow::GetX")){
		ptr = static_cast<int*>(DKClass::CallFunc("DKSDLWindow::GetX"));
	}
	else if(DKClass::HasFunc("DKOSGWindow::GetX")){
		ptr = static_cast<int*>(DKClass::CallFunc("DKOSGWindow::GetX"));
	}
	else{
		DKLog("DKWindow::GetX(): No function available \n", DKERROR);
		return NULL;
	}
	return *ptr;
}

////////////////////
int DKWindow::GetY()
{
	int* ptr = NULL;
	if(DKClass::HasFunc("DKSDLWindow::GetY")){
		ptr = static_cast<int*>(DKClass::CallFunc("DKSDLWindow::GetY"));
	}
	else if(DKClass::HasFunc("DKOSGWindow::GetY")){
		ptr = static_cast<int*>(DKClass::CallFunc("DKOSGWindow::GetY"));
	}
	else{
		DKLog("DKWindow::GetY(): No function available \n", DKERROR);
		return NULL;
	}
	return *ptr;
}

////////////////////////
int DKWindow::GetWidth()
{
	int* ptr = NULL;
	if(DKClass::HasFunc("DKSDLWindow::GetWidth")){
		ptr = static_cast<int*>(DKClass::CallFunc("DKSDLWindow::GetWidth"));
	}
	else if(DKClass::HasFunc("DKOSGWindow::GetWidth")){
		ptr = static_cast<int*>(DKClass::CallFunc("DKOSGWindow::GetWidth"));
	}
	else{
		DKLog("DKWindow::GetWidth(): No function available \n", DKERROR);
		return NULL;
	}
	return *ptr;
}

/////////////////////////
int DKWindow::GetHeight()
{
	int* ptr = NULL;
	if(DKClass::HasFunc("DKSDLWindow::GetHeight")){
		ptr = static_cast<int*>(DKClass::CallFunc("DKSDLWindow::GetHeight"));
	}
	else if(DKClass::HasFunc("DKOSGWindow::GetHeight")){
		ptr = static_cast<int*>(DKClass::CallFunc("DKOSGWindow::GetHeight"));
	}
	else{
		DKLog("DKWindow::GetHeight(): No function available \n", DKERROR);
		return NULL;
	}
	return *ptr;
}

//////////////////////////
void DKWindow::SetX(int x)
{
	if(DKClass::HasFunc("DKSDLWindow::SetX")){
		DKClass::CallFunc("DKSDLWindow::SetX", static_cast<void*>(&x));
	}
	else if(DKClass::HasFunc("DKOSGWindow::SetX")){
		DKClass::CallFunc("DKOSGWindow::SetX", static_cast<void*>(&x));
	}
	else{
		DKLog("DKWindow::SetX(): No function available \n", DKERROR);
	}
}

//////////////////////////
void DKWindow::SetY(int y)
{
	if(DKClass::HasFunc("DKSDLWindow::SetY")){
		DKClass::CallFunc("DKSDLWindow::SetY", static_cast<void*>(&y));
	}
	else if(DKClass::HasFunc("DKOSGWindow::SetY")){
		DKClass::CallFunc("DKOSGWindow::SetY", static_cast<void*>(&y));
	}
	else{
		DKLog("DKWindow::SetY(): No function available \n", DKERROR);
	}
}

//////////////////////////////
void DKWindow::SetWidth(int w)
{
	if(DKClass::HasFunc("DKSDLWindow::SetWidth")){
		DKClass::CallFunc("DKSDLWindow::SetWidth", static_cast<void*>(&w));
	}
	else if(DKClass::HasFunc("DKOSGWindow::SetWidth")){
		DKClass::CallFunc("DKOSGWindow::SetWidth", static_cast<void*>(&w));
	}
	else{
		DKLog("DKWindow::SetWidth(): No function available \n", DKERROR);
	}
}

///////////////////////////////
void DKWindow::SetHeight(int h)
{
	if(DKClass::HasFunc("DKSDLWindow::SetHeight")){
		DKClass::CallFunc("DKSDLWindow::SetHeight", static_cast<void*>(&h));
	}
	else if(DKClass::HasFunc("DKOSGWindow::SetHeight")){
		DKClass::CallFunc("DKOSGWindow::SetHeight", static_cast<void*>(&h));
	}
	else{
		DKLog("DKWindow::SetHeight(): No function available \n", DKERROR);
	}
}

/////////////////////////////
bool DKWindow::IsFullscreen()
{
	bool* ptr = NULL;
	if(DKClass::HasFunc("DKSDLWindow::IsFullscreen")){
		ptr = static_cast<bool*>(DKClass::CallFunc("DKSDLWindow::IsFullscreen"));
	}
	else if(DKClass::HasFunc("DKOSGWindow::IsFullscreen")){
		ptr = static_cast<bool*>(DKClass::CallFunc("DKOSGWindow::IsFullscreen"));
	}
	else{
		DKLog("DKWindow::IsFullscreen(): No function available \n", DKERROR);
		return NULL;
	}
	return *ptr;
}

///////////////////////////
void DKWindow::Fullscreen()
{
	if(DKClass::HasFunc("DKSDLWindow::Fullscreen")){
		DKClass::CallFunc("DKSDLWindow::Fullscreen");
	}
	else if(DKClass::HasFunc("DKOSGWindow::Fullscreen")){
		DKClass::CallFunc("DKOSGWindow::Fullscreen");
	}
	else{
		DKLog("DKWindow::Fullscreen(): No function available \n", DKERROR);
	}
}

/////////////////////////
void DKWindow::Windowed()
{
	if(DKClass::HasFunc("DKSDLWindow::Windowed")){
		DKClass::CallFunc("DKSDLWindow::Windowed");
	}
	else if(DKClass::HasFunc("DKOSGWindow::Windowed")){
		DKClass::CallFunc("DKOSGWindow::Windowed");
	}
	else{
		DKLog("DKWindow::Windowed(): No function available \n", DKERROR);
	}
}

/////////////////////////
void DKWindow::Minimize()
{
	if(DKClass::HasFunc("DKSDLWindow::Minimize")){
		DKClass::CallFunc("DKSDLWindow::Minimize");
	}
	else if(DKClass::HasFunc("DKOSGWindow::Minimize")){
		DKClass::CallFunc("DKOSGWindow::Minimize");
	}
	else{
		DKLog("DKWindow::Minimize(): No function available \n", DKERROR);
	}
}

////////////////////////
void DKWindow::Restore()
{
	if(DKClass::HasFunc("DKSDLWindow::Restore")){
		DKClass::CallFunc("DKSDLWindow::Restore");
	}
	else if(DKClass::HasFunc("DKOSGWindow::Restore")){
		DKClass::CallFunc("DKOSGWindow::Restore");
	}
	else{
		DKLog("DKWindow::Restore(): No function available \n", DKERROR);
	}
}

/////////////////////////
int DKWindow::GetMouseX()
{
	int* ptr = NULL;
	if(DKClass::HasFunc("DKSDLWindow::GetMouseX")){
		ptr = static_cast<int*>(DKClass::CallFunc("DKSDLWindow::GetMouseX"));
	}
	else if(DKClass::HasFunc("DKOSGWindow::GetMouseX")){
		ptr = static_cast<int*>(DKClass::CallFunc("DKOSGWindow::GetMouseX"));
	}
	else{
		DKLog("DKWindow::GetMouseX(): No function available \n", DKERROR);
		return NULL;
	}
	return *ptr;
}

/////////////////////////
int DKWindow::GetMouseY()
{
	int* ptr = NULL;
	if(DKClass::HasFunc("DKSDLWindow::GetMouseY")){
		ptr = static_cast<int*>(DKClass::CallFunc("DKSDLWindow::GetMouseY"));
	}
	else if(DKClass::HasFunc("DKOSGWindow::GetMouseY")){
		ptr = static_cast<int*>(DKClass::CallFunc("DKOSGWindow::GetMouseY"));
	}
	else{
		DKLog("DKWindow::GetMouseY(): No function available \n", DKERROR);
		return NULL;
	}
	return *ptr;
}

#ifdef WIN32
////////////////////////
HWND DKWindow::GetHwnd()
{
	HWND* ptr = NULL;
	if(DKClass::HasFunc("DKSDLWindow::GetHwnd")){
		ptr = static_cast<HWND*>(DKClass::CallFunc("DKSDLWindow::GetHwnd"));
	}
	else if(DKClass::HasFunc("DKOSGWindow::GetHwnd")){
		ptr = static_cast<HWND*>(DKClass::CallFunc("DKOSGWindow::GetHwnd"));
	}
	else{
		DKLog("DKWindow::GetHwnd(): No function available \n", DKERROR);
		return NULL;
	}
	return *ptr;
}
#endif