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

	DKClass::RegisterFunc("DKWindow::MessageBox", &DKWindow::MessageBox, this);
	DKCreate("DKWindowJS");
}

////////////////////
void DKWindow::End()
{
	DKClass::UnregisterFunc("DKWindow::MessageBox");
}



////////////////////////////////
int DKWindow::TestInt(int input)
{
	int output;
	DKClass::CallFunc("DKSDLWindow::TestInt", &input, &output);
	return output;
}

/////////////////////////////////////////////
DKString DKWindow::TestString(DKString input)
{
	DKString output;;
	DKClass::CallFunc("DKSDLWindow::TestString", &input, &output);
	return output;
}

/////////////////////////////
int DKWindow::TestReturnInt()
{
	int output;
	DKClass::CallFunc("DKSDLWindow::TestReturnInt", NULL, &output);
	return output;
}

/////////////////////////////////////
DKString DKWindow::TestReturnString()
{
	DKString output;
	DKClass::CallFunc("DKSDLWindow::TestReturnString", NULL, &output);
	return output;
}



////////////////////
int DKWindow::GetX()
{
	int output;
	if(DKClass::HasFunc("DKSDLWindow::GetX")){
		DKClass::CallFunc("DKSDLWindow::GetX", NULL, &output);
	}
	else if(DKClass::HasFunc("DKOSGWindow::GetX")){
		DKClass::CallFunc("DKOSGWindow::GetX", NULL, &output);
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
	if(DKClass::HasFunc("DKSDLWindow::GetY")){
		DKClass::CallFunc("DKSDLWindow::GetY", NULL, &output);
	}
	else if(DKClass::HasFunc("DKOSGWindow::GetY")){
		DKClass::CallFunc("DKOSGWindow::GetY", NULL, &output);
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
	if(DKClass::HasFunc("DKSDLWindow::GetWidth")){
		DKClass::CallFunc("DKSDLWindow::GetWidth", NULL, &output);
	}
	else if(DKClass::HasFunc("DKOSGWindow::GetWidth")){
		DKClass::CallFunc("DKOSGWindow::GetWidth", NULL, &output);
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
	if(DKClass::HasFunc("DKSDLWindow::GetHeight")){
		DKClass::CallFunc("DKSDLWindow::GetHeight", NULL, &output);
	}
	else if(DKClass::HasFunc("DKOSGWindow::GetHeight")){
		DKClass::CallFunc("DKOSGWindow::GetHeight", NULL, &output);
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
	if(DKClass::HasFunc("DKSDLWindow::SetX")){
		DKClass::CallFunc("DKSDLWindow::SetX", &x, NULL);
	}
	else if(DKClass::HasFunc("DKOSGWindow::SetX")){
		DKClass::CallFunc("DKOSGWindow::SetX", &x, NULL);
	}
	else{
		DKLog("DKWindow::SetX(): No function available \n", DKERROR);
	}
}

//////////////////////////
void DKWindow::SetY(int y)
{
	if(DKClass::HasFunc("DKSDLWindow::SetY")){
		DKClass::CallFunc("DKSDLWindow::SetY", &y, NULL);
	}
	else if(DKClass::HasFunc("DKOSGWindow::SetY")){
		DKClass::CallFunc("DKOSGWindow::SetY", &y, NULL);
	}
	else{
		DKLog("DKWindow::SetY(): No function available \n", DKERROR);
	}
}

//////////////////////////////
void DKWindow::SetWidth(int w)
{
	if(DKClass::HasFunc("DKSDLWindow::SetWidth")){
		DKClass::CallFunc("DKSDLWindow::SetWidth", &w, NULL);
	}
	else if(DKClass::HasFunc("DKOSGWindow::SetWidth")){
		DKClass::CallFunc("DKOSGWindow::SetWidth", &w, NULL);
	}
	else{
		DKLog("DKWindow::SetWidth(): No function available \n", DKERROR);
	}
}

///////////////////////////////
void DKWindow::SetHeight(int h)
{
	if(DKClass::HasFunc("DKSDLWindow::SetHeight")){
		DKClass::CallFunc("DKSDLWindow::SetHeight", &h, NULL);
	}
	else if(DKClass::HasFunc("DKOSGWindow::SetHeight")){
		DKClass::CallFunc("DKOSGWindow::SetHeight", &h, NULL);
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
	if(DKClass::HasFunc("DKSDLWindow::IsFullscreen")){
		DKClass::CallFunc("DKSDLWindow::IsFullscreen", NULL, &output);
	}
	else if(DKClass::HasFunc("DKOSGWindow::IsFullscreen")){
		DKClass::CallFunc("DKOSGWindow::IsFullscreen", NULL, &output);
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
	if(DKClass::HasFunc("DKSDLWindow::Fullscreen")){
		DKClass::CallFunc("DKSDLWindow::Fullscreen", NULL, NULL);
	}
	else if(DKClass::HasFunc("DKOSGWindow::Fullscreen")){
		DKClass::CallFunc("DKOSGWindow::Fullscreen", NULL, NULL);
	}
	else{
		DKLog("DKWindow::Fullscreen(): No function available \n", DKERROR);
	}
}

/////////////////////////
void DKWindow::Windowed()
{
	if(DKClass::HasFunc("DKSDLWindow::Windowed")){
		DKClass::CallFunc("DKSDLWindow::Windowed", NULL, NULL);
	}
	else if(DKClass::HasFunc("DKOSGWindow::Windowed")){
		DKClass::CallFunc("DKOSGWindow::Windowed", NULL, NULL);
	}
	else{
		DKLog("DKWindow::Windowed(): No function available \n", DKERROR);
	}
}

/////////////////////////
void DKWindow::Minimize()
{
	if(DKClass::HasFunc("DKSDLWindow::Minimize")){
		DKClass::CallFunc("DKSDLWindow::Minimize", NULL, NULL);
	}
	else if(DKClass::HasFunc("DKOSGWindow::Minimize")){
		DKClass::CallFunc("DKOSGWindow::Minimize", NULL, NULL);
	}
	else{
		DKLog("DKWindow::Minimize(): No function available \n", DKERROR);
	}
}

////////////////////////
void DKWindow::Restore()
{
	if(DKClass::HasFunc("DKSDLWindow::Restore")){
		DKClass::CallFunc("DKSDLWindow::Restore", NULL, NULL);
	}
	else if(DKClass::HasFunc("DKOSGWindow::Restore")){
		DKClass::CallFunc("DKOSGWindow::Restore", NULL, NULL);
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
	if(DKClass::HasFunc("DKSDLWindow::IsVisible")){
		DKClass::CallFunc("DKSDLWindow::IsVisible", NULL, &output);
	}
	else if(DKClass::HasFunc("DKOSGWindow::IsVisible")){
		DKClass::CallFunc("DKOSGWindow::IsVisible", NULL, &output);
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
	if(DKClass::HasFunc("DKSDLWindow::Hide")){
		DKClass::CallFunc("DKSDLWindow::Hide", NULL, NULL);
	}
	else if(DKClass::HasFunc("DKOSGWindow::Hide")){
		DKClass::CallFunc("DKOSGWindow::Hide", NULL, NULL);
	}
	else{
		DKLog("DKWindow::Hide(): No function available \n", DKERROR);
	}
}

/////////////////////
void DKWindow::Show()
{
	if(DKClass::HasFunc("DKSDLWindow::Show")){
		DKClass::CallFunc("DKSDLWindow::Show", NULL, NULL);
	}
	else if(DKClass::HasFunc("DKOSGWindow::Show")){
		DKClass::CallFunc("DKOSGWindow::Show", NULL, NULL);
	}
	else{
		DKLog("DKWindow::Show(): No function available \n", DKERROR);
	}
}

/////////////////////////
int DKWindow::GetMouseX()
{
	int output;
	if(DKClass::HasFunc("DKSDLWindow::GetMouseX")){
		DKClass::CallFunc("DKSDLWindow::GetMouseX", NULL, &output);
	}
	else if(DKClass::HasFunc("DKOSGWindow::GetMouseX")){
		DKClass::CallFunc("DKOSGWindow::GetMouseX", NULL, &output);
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
	if(DKClass::HasFunc("DKSDLWindow::GetMouseY")){
		DKClass::CallFunc("DKSDLWindow::GetMouseY", NULL, &output);
	}
	else if(DKClass::HasFunc("DKOSGWindow::GetMouseY")){
		DKClass::CallFunc("DKOSGWindow::GetMouseY", NULL, &output);
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
	if(DKClass::HasFunc("DKSDLWindow::GetHwnd")){
		DKClass::CallFunc("DKSDLWindow::GetHwnd", NULL, &output);
	}
	else if(DKClass::HasFunc("DKOSGWindow::GetHwnd")){
		DKClass::CallFunc("DKOSGWindow::GetHwnd", NULL, &output);
	}
	else{
		DKLog("DKWindow::GetHwnd(): No function available \n", DKERROR);
		return NULL;
	}
	return output;
}
#endif

////////////////////////////////////////////////////
bool DKWindow::MessageBox(void* input, void* output)
{
	DKString message = *(DKString*)input;

	if(DKClass::HasFunc("DKSDLWindow::MessageBox")){
		DKClass::CallFunc("DKSDLWindow::MessageBox", &message, NULL);
	}
	else if(DKClass::HasFunc("DKOSGWindow::MessageBox")){
		DKClass::CallFunc("DKOSGWindow::MessageBox", &message, NULL);
	}
	else{
		DKLog("DKWindow::MessageBox(): No function available \n", DKERROR);
	}

	return true;
}