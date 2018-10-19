#ifdef USE_DKCef
#include "DK/DKApp.h"
#include "DKWindow/DKWindow.h"
#include "DKWindow/DKWindowV8.h"

///////////////////////
bool DKWindowV8::Init()
{
	DKDebug();

	DKV8::AttachFunction("DKWindow_TestInt", DKWindowV8::TestInt);
	DKV8::AttachFunction("DKWindow_TestString", DKWindowV8::TestString);
	DKV8::AttachFunction("DKWindow_TestReturnInt", DKWindowV8::TestReturnInt);
	DKV8::AttachFunction("DKWindow_TestReturnString", DKWindowV8::TestReturnString);

	DKV8::AttachFunction("DKWindow_Create", DKWindowV8::Create);
	DKV8::AttachFunction("DKWindow_Fullscreen", DKWindowV8::Fullscreen);
	DKV8::AttachFunction("DKWindow_GetHeight", DKWindowV8::GetHeight);
	DKV8::AttachFunction("DKWindow_GetMouseX", DKWindowV8::GetMouseX);
	DKV8::AttachFunction("DKWindow_GetMouseY", DKWindowV8::GetMouseY);
	DKV8::AttachFunction("DKWindow_GetPixelRatio", DKWindowV8::GetPixelRatio);
	DKV8::AttachFunction("DKWindow_GetWidth", DKWindowV8::GetWidth);
	DKV8::AttachFunction("DKWindow_GetX", DKWindowV8::GetX);
	DKV8::AttachFunction("DKWindow_GetY", DKWindowV8::GetY);
	DKV8::AttachFunction("DKWindow_Hide", DKWindowV8::Hide);
	DKV8::AttachFunction("DKWindow_IsFullscreen", DKWindowV8::IsFullscreen);
	DKV8::AttachFunction("DKWindow_IsVisible", DKWindowV8::IsVisible);
	DKV8::AttachFunction("DKWindow_Maximize", DKWindowV8::Maximize);
	DKV8::AttachFunction("DKWindow_MessageBox", DKWindowV8::MessageBox);
	DKV8::AttachFunction("DKWindow_Minimize", DKWindowV8::Minimize);
	DKV8::AttachFunction("DKWindow_Restore", DKWindowV8::Restore);
	DKV8::AttachFunction("DKWindow_SetHeight", DKWindowV8::SetHeight);
	DKV8::AttachFunction("DKWindow_SetIcon", DKWindowV8::SetIcon);
	DKV8::AttachFunction("DKWindow_SetTitle", DKWindowV8::SetTitle);
	DKV8::AttachFunction("DKWindow_SetWidth", DKWindowV8::SetWidth);
	DKV8::AttachFunction("DKWindow_SetX", DKWindowV8::SetX);
	DKV8::AttachFunction("DKWindow_SetY", DKWindowV8::SetY);
	DKV8::AttachFunction("DKWindow_Show", DKWindowV8::Show);
	DKV8::AttachFunction("DKWindow_Windowed", DKWindowV8::Windowed);
	return true;
}

//////////////////////
bool DKWindowV8::End()
{
	DKDebug();
	return true;
}


////////////////////////////////////////////////////////
bool DKWindowV8::TestInt(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	int data = args->GetInt(0);
	int result = data;
	if(!retval->SetInt(0, result)){ return false; }
	return true;
}

///////////////////////////////////////////////////////////
bool DKWindowV8::TestString(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	DKString data = args->GetString(0);
	DKString result = data;
	if(!retval->SetString(0, result)){ return false; }
	return true;
}

//////////////////////////////////////////////////////////////
bool DKWindowV8::TestReturnInt(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	int result = 12345;
	if(!retval->SetInt(0, result)){ return false; }
	return true;
}

/////////////////////////////////////////////////////////////////
bool DKWindowV8::TestReturnString(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	DKString result = "test string";
	if(!retval->SetString(0, result)){ return false; }
	return true;
}

///////////////////////////////////////////////////////
bool DKWindowV8::Create(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	if(!DKWindow::Create()){ return false; }
	return true;
}

///////////////////////////////////////////////////////////
bool DKWindowV8::Fullscreen(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	if(!DKWindow::Fullscreen()){ return false; }
	return true;
}

//////////////////////////////////////////////////////////
bool DKWindowV8::GetHeight(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	int height;
	if(!DKWindow::GetHeight(height)){ return false; }
	if(!retval->SetInt(0, height)){	return false; }
	return true;
}

//////////////////////////////////////////////////////////
bool DKWindowV8::GetMouseX(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	int mouseX;
	if(!DKWindow::GetMouseX(mouseX)){ return false; }
	if(!retval->SetInt(0, mouseX)){ return false; }
	return true;
}

//////////////////////////////////////////////////////////
bool DKWindowV8::GetMouseY(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	int mouseY;
	if(!DKWindow::GetMouseY(mouseY)){ return false; }
	if(!retval->SetInt(0, mouseY)){ return false; }
	return true;
}

//////////////////////////////////////////////////////////////
bool DKWindowV8::GetPixelRatio(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	float ratio;
	if(!DKWindow::GetPixelRatio(ratio)){ return false; }
	if(!retval->SetDouble(0, ratio)){ return false; }
	return true;
}

/////////////////////////////////////////////////////////
bool DKWindowV8::GetWidth(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	int width;
	if(!DKWindow::GetWidth(width)){	return false; }
	if(!retval->SetInt(0, width)){ return false; }
	return true;
}

/////////////////////////////////////////////////////
bool DKWindowV8::GetX(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	int x;
	if(!DKWindow::GetX(x)){ return false; }
	if(!retval->SetInt(0, x)){ return false; }
	return true;
}

/////////////////////////////////////////////////////
bool DKWindowV8::GetY(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	int y;
	if(!DKWindow::GetY(y)){ return false; }
	if(!retval->SetInt(0, y)){ return false; }
	return true;
}

/////////////////////////////////////////////////////
bool DKWindowV8::Hide(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	if(!DKWindow::Hide()){ return false; }
	return true;
}

/////////////////////////////////////////////////////////////
bool DKWindowV8::IsFullscreen(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	bool fullscreen;
	if(!DKWindow::IsFullscreen(fullscreen)){ return false; }
	if(!retval->SetInt(0, fullscreen)){ return false; }
	return true;
}

//////////////////////////////////////////////////////////
bool DKWindowV8::IsVisible(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	bool visible;
	if(!DKWindow::IsVisible(visible)){ return false; } 
	if(!retval->SetInt(0, visible)){ return false; }
	return true;
}

/////////////////////////////////////////////////////////
bool DKWindowV8::Maximize(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	if(!DKWindow::Maximize()){ return false; }
	return true;
}

///////////////////////////////////////////////////////////
bool DKWindowV8::MessageBox(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	DKString msg = args->GetString(0);
	if(!DKWindow::MessageBox(msg)){ return false; }
	return true;
}

/////////////////////////////////////////////////////////
bool DKWindowV8::Minimize(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	if(!DKWindow::Minimize()){ return false; }
	return true;
}

////////////////////////////////////////////////////////
bool DKWindowV8::Restore(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	if(!DKWindow::Restore()){ return false; }
	return true;
}

//////////////////////////////////////////////////////////
bool DKWindowV8::SetHeight(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	int height = args->GetInt(0);
	if(!DKWindow::SetHeight(height)){ return false; }
	return true;
}

////////////////////////////////////////////////////////
bool DKWindowV8::SetIcon(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	DKString file = args->GetString(0);
	if(!DKWindow::SetIcon(file)){ return false; }
	return true;
}

/////////////////////////////////////////////////////////
bool DKWindowV8::SetTitle(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	DKString string = args->GetString(0);
	if(!DKWindow::SetTitle(string)){ return false; }
	return true;
}

/////////////////////////////////////////////////////////
bool DKWindowV8::SetWidth(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	int width = args->GetInt(0);
	if(!DKWindow::SetWidth(width)){ return false; }
	return true;
}

/////////////////////////////////////////////////////
bool DKWindowV8::SetX(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	int x = args->GetInt(0);
	if(!DKWindow::SetX(x)){ return false; }
	return true;
}

/////////////////////////////////////////////////////
bool DKWindowV8::SetY(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	int y = args->GetInt(0);
	if(!DKWindow::SetY(y)){ return false; }
	return true;
}

/////////////////////////////////////////////////////
bool DKWindowV8::Show(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	if(!DKWindow::Show()){ return false; }
	return true;
}

/////////////////////////////////////////////////////////
bool DKWindowV8::Windowed(CefArgs args, CefReturn retval)
{
	DKDebug(args, retval);
	if(!DKWindow::Windowed()){ return false; }
	return true;
}

#endif //USE_DKCef