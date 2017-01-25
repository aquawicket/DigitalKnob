#include "stdafx.h"
#include "DKWindow.h"
#include "DKAndroid.h"

/////////////////////
void DKWindow::Init()
{
	DKLog("DKWindow::Init()\n", DKDEBUG);

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

	DKCreate("DKWindowJS");
}

////////////////////
void DKWindow::End()
{

}



////////////////////////////////
int DKWindow::TestInt(int input)
{
	int output;
	DKClass::CallFunc2("DKSDLWindow::TestInt", &input, &output);
	return output;
}

/////////////////////////////////////////////
DKString DKWindow::TestString(DKString input)
{
	DKString output;;
	DKClass::CallFunc2("DKSDLWindow::TestString", &input, &output);
	return output;
}

/////////////////////////////
int DKWindow::TestReturnInt()
{
	int output;
	DKClass::CallFunc2("DKSDLWindow::TestReturnInt", NULL, &output);
	return output;
}

/////////////////////////////////////
DKString DKWindow::TestReturnString()
{
	DKString output;
	DKClass::CallFunc2("DKSDLWindow::TestReturnString", NULL, &output);
	return output;
}



////////////////////
int DKWindow::GetX()
{
	int output;
	if(DKClass::HasFunc2("DKSDLWindow::GetX")){
		DKClass::CallFunc2("DKSDLWindow::GetX", NULL, &output);
	}
	else if(DKClass::HasFunc2("DKOSGWindow::GetX")){
		DKClass::CallFunc2("DKOSGWindow::GetX", NULL, &output);
	}
	else{
		DKLog("DKWindow::GetX(): No function available \n", DKERROR);
		return NULL;
	}
	return output;
}

////////////////////
int DKWindow::GetY()
{
	int output;
	if(DKClass::HasFunc2("DKSDLWindow::GetY")){
		DKClass::CallFunc2("DKSDLWindow::GetY", NULL, &output);
	}
	else if(DKClass::HasFunc2("DKOSGWindow::GetY")){
		DKClass::CallFunc2("DKOSGWindow::GetY", NULL, &output);
	}
	else{
		DKLog("DKWindow::GetY(): No function available \n", DKERROR);
		return NULL;
	}
	return output;
}

////////////////////////
int DKWindow::GetWidth()
{
	int output;
	if(DKClass::HasFunc2("DKSDLWindow::GetWidth")){
		DKClass::CallFunc2("DKSDLWindow::GetWidth", NULL, &output);
	}
	else if(DKClass::HasFunc2("DKOSGWindow::GetWidth")){
		DKClass::CallFunc2("DKOSGWindow::GetWidth", NULL, &output);
	}
	else{
		DKLog("DKWindow::GetWidth(): No function available \n", DKERROR);
		return NULL;
	}
	return output;
}

/////////////////////////
int DKWindow::GetHeight()
{
	int output;
	if(DKClass::HasFunc2("DKSDLWindow::GetHeight")){
		DKClass::CallFunc2("DKSDLWindow::GetHeight", NULL, &output);
	}
	else if(DKClass::HasFunc2("DKOSGWindow::GetHeight")){
		DKClass::CallFunc2("DKOSGWindow::GetHeight", NULL, &output);
	}
	else{
		DKLog("DKWindow::GetHeight(): No function available \n", DKERROR);
		return NULL;
	}
	return output;
}

//////////////////////////
void DKWindow::SetX(int x)
{
	if(DKClass::HasFunc2("DKSDLWindow::SetX")){
		DKClass::CallFunc2("DKSDLWindow::SetX", &x, NULL);
	}
	else if(DKClass::HasFunc2("DKOSGWindow::SetX")){
		DKClass::CallFunc2("DKOSGWindow::SetX", &x, NULL);
	}
	else{
		DKLog("DKWindow::SetX(): No function available \n", DKERROR);
	}
}

//////////////////////////
void DKWindow::SetY(int y)
{
	if(DKClass::HasFunc2("DKSDLWindow::SetY")){
		DKClass::CallFunc2("DKSDLWindow::SetY", &y, NULL);
	}
	else if(DKClass::HasFunc2("DKOSGWindow::SetY")){
		DKClass::CallFunc2("DKOSGWindow::SetY", &y, NULL);
	}
	else{
		DKLog("DKWindow::SetY(): No function available \n", DKERROR);
	}
}

//////////////////////////////
void DKWindow::SetWidth(int w)
{
	if(DKClass::HasFunc2("DKSDLWindow::SetWidth")){
		DKClass::CallFunc2("DKSDLWindow::SetWidth", &w, NULL);
	}
	else if(DKClass::HasFunc2("DKOSGWindow::SetWidth")){
		DKClass::CallFunc2("DKOSGWindow::SetWidth", &w, NULL);
	}
	else{
		DKLog("DKWindow::SetWidth(): No function available \n", DKERROR);
	}
}

///////////////////////////////
void DKWindow::SetHeight(int h)
{
	if(DKClass::HasFunc2("DKSDLWindow::SetHeight")){
		DKClass::CallFunc2("DKSDLWindow::SetHeight", &h, NULL);
	}
	else if(DKClass::HasFunc2("DKOSGWindow::SetHeight")){
		DKClass::CallFunc2("DKOSGWindow::SetHeight", &h, NULL);
	}
	else{
		DKLog("DKWindow::SetHeight(): No function available \n", DKERROR);
	}
}

///////////////////////////////
float DKWindow::GetPixelRatio()
{
	//TODO
	return 1.0f;
}

/////////////////////////////
bool DKWindow::IsFullscreen()
{
	bool output;
	if(DKClass::HasFunc2("DKSDLWindow::IsFullscreen")){
		DKClass::CallFunc2("DKSDLWindow::IsFullscreen", NULL, &output);
	}
	else if(DKClass::HasFunc2("DKOSGWindow::IsFullscreen")){
		DKClass::CallFunc2("DKOSGWindow::IsFullscreen", NULL, &output);
	}
	else{
		DKLog("DKWindow::IsFullscreen(): No function available \n", DKERROR);
		return NULL;
	}
	return output;
}

///////////////////////////
void DKWindow::Fullscreen()
{
	if(DKClass::HasFunc2("DKSDLWindow::Fullscreen")){
		DKClass::CallFunc2("DKSDLWindow::Fullscreen", NULL, NULL);
	}
	else if(DKClass::HasFunc2("DKOSGWindow::Fullscreen")){
		DKClass::CallFunc2("DKOSGWindow::Fullscreen", NULL, NULL);
	}
	else{
		DKLog("DKWindow::Fullscreen(): No function available \n", DKERROR);
	}
}

/////////////////////////
void DKWindow::Windowed()
{
	if(DKClass::HasFunc2("DKSDLWindow::Windowed")){
		DKClass::CallFunc2("DKSDLWindow::Windowed", NULL, NULL);
	}
	else if(DKClass::HasFunc2("DKOSGWindow::Windowed")){
		DKClass::CallFunc2("DKOSGWindow::Windowed", NULL, NULL);
	}
	else{
		DKLog("DKWindow::Windowed(): No function available \n", DKERROR);
	}
}

/////////////////////////
void DKWindow::Minimize()
{
	if(DKClass::HasFunc2("DKSDLWindow::Minimize")){
		DKClass::CallFunc2("DKSDLWindow::Minimize", NULL, NULL);
	}
	else if(DKClass::HasFunc2("DKOSGWindow::Minimize")){
		DKClass::CallFunc2("DKOSGWindow::Minimize", NULL, NULL);
	}
	else{
		DKLog("DKWindow::Minimize(): No function available \n", DKERROR);
	}
}

////////////////////////
void DKWindow::Restore()
{
	if(DKClass::HasFunc2("DKSDLWindow::Restore")){
		DKClass::CallFunc2("DKSDLWindow::Restore", NULL, NULL);
	}
	else if(DKClass::HasFunc2("DKOSGWindow::Restore")){
		DKClass::CallFunc2("DKOSGWindow::Restore", NULL, NULL);
	}
	else{
		DKLog("DKWindow::Restore(): No function available \n", DKERROR);
	}
}

//TODO,   look at DKSDLWindow and DKOSGWindow 
//////////////////////////
bool DKWindow::IsVisible()
{
	//FIXME
	bool output;
	if(DKClass::HasFunc2("DKSDLWindow::IsVisible")){
		DKClass::CallFunc2("DKSDLWindow::IsVisible", NULL, &output);
	}
	else if(DKClass::HasFunc2("DKOSGWindow::IsVisible")){
		DKClass::CallFunc2("DKOSGWindow::IsVisible", NULL, &output);
	}
	else{
		DKLog("DKWindow::IsVisible(): No function available \n", DKERROR);
		return NULL;
	}
	return output;
}

/////////////////////
void DKWindow::Hide()
{
	if(DKClass::HasFunc2("DKSDLWindow::Hide")){
		DKClass::CallFunc2("DKSDLWindow::Hide", NULL, NULL);
	}
	else if(DKClass::HasFunc2("DKOSGWindow::Hide")){
		DKClass::CallFunc2("DKOSGWindow::Hide", NULL, NULL);
	}
	else{
		DKLog("DKWindow::Hide(): No function available \n", DKERROR);
	}
}

/////////////////////
void DKWindow::Show()
{
	if(DKClass::HasFunc2("DKSDLWindow::Show")){
		DKClass::CallFunc2("DKSDLWindow::Show", NULL, NULL);
	}
	else if(DKClass::HasFunc2("DKOSGWindow::Show")){
		DKClass::CallFunc2("DKOSGWindow::Show", NULL, NULL);
	}
	else{
		DKLog("DKWindow::Show(): No function available \n", DKERROR);
	}
}

/////////////////////////
int DKWindow::GetMouseX()
{
	int output;
	if(DKClass::HasFunc2("DKSDLWindow::GetMouseX")){
		DKClass::CallFunc2("DKSDLWindow::GetMouseX", NULL, &output);
	}
	else if(DKClass::HasFunc2("DKOSGWindow::GetMouseX")){
		DKClass::CallFunc2("DKOSGWindow::GetMouseX", NULL, &output);
	}
	else{
		DKLog("DKWindow::GetMouseX(): No function available \n", DKERROR);
		return NULL;
	}
	return output;
}

/////////////////////////
int DKWindow::GetMouseY()
{
	int output;
	if(DKClass::HasFunc2("DKSDLWindow::GetMouseY")){
		DKClass::CallFunc2("DKSDLWindow::GetMouseY", NULL, &output);
	}
	else if(DKClass::HasFunc2("DKOSGWindow::GetMouseY")){
		DKClass::CallFunc2("DKOSGWindow::GetMouseY", NULL, &output);
	}
	else{
		DKLog("DKWindow::GetMouseY(): No function available \n", DKERROR);
		return NULL;
	}
	return output;
}

#ifdef WIN32
////////////////////////
HWND DKWindow::GetHwnd()
{
	HWND output;
	if(DKClass::HasFunc2("DKSDLWindow::GetHwnd")){
		DKClass::CallFunc2("DKSDLWindow::GetHwnd", NULL, &output);
	}
	else if(DKClass::HasFunc2("DKOSGWindow::GetHwnd")){
		DKClass::CallFunc2("DKOSGWindow::GetHwnd", NULL, &output);
	}
	else{
		DKLog("DKWindow::GetHwnd(): No function available \n", DKERROR);
		return NULL;
	}
	return output;
}
#endif