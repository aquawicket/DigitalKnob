#ifdef USE_DKDuktape 
#include "DKWindowJS.h"
#include "DKWindow.h"


///////////////////////
void DKWindowJS::Init()
{
	DKLog("DKWindowJS::Init()\n", DKDEBUG);

	DKDuktape::AttachFunction("DKWindow_TestInt", DKWindowJS::TestInt, 1);
	DKDuktape::AttachFunction("DKWindow_TestString", DKWindowJS::TestString, 1);

	DKDuktape::AttachFunction("DKWindow_Fullscreen", DKWindowJS::Fullscreen, 0);
	DKDuktape::AttachFunction("DKWindow_GetHeight", DKWindowJS::GetHeight, 0);
	DKDuktape::AttachFunction("DKWindow_GetMouseX", DKWindowJS::GetMouseX, 0);
	DKDuktape::AttachFunction("DKWindow_GetMouseY", DKWindowJS::GetMouseY, 0);
	DKDuktape::AttachFunction("DKWindow_GetPixelRatio", DKWindowJS::GetPixelRatio, 1);
	DKDuktape::AttachFunction("DKWindow_GetWidth", DKWindowJS::GetWidth, 0);
	DKDuktape::AttachFunction("DKWindow_GetX", DKWindowJS::GetX, 0);
	DKDuktape::AttachFunction("DKWindow_GetY", DKWindowJS::GetY, 0);
	DKDuktape::AttachFunction("DKWindow_Hide", DKWindowJS::Hide, 0);
	DKDuktape::AttachFunction("DKWindow_IsFullscreen", DKWindowJS::IsFullscreen, 0);
	DKDuktape::AttachFunction("DKWindow_IsVisible", DKWindowJS::IsVisible, 0);
	DKDuktape::AttachFunction("DKWindow_Minimize", DKWindowJS::Minimize, 0);
	DKDuktape::AttachFunction("DKWindow_Restore", DKWindowJS::Restore, 0);
	DKDuktape::AttachFunction("DKWindow_SetHeight", DKWindowJS::SetHeight, 1);
	DKDuktape::AttachFunction("DKWindow_SetWidth", DKWindowJS::SetWidth, 1);
	DKDuktape::AttachFunction("DKWindow_SetX", DKWindowJS::SetX, 1);
	DKDuktape::AttachFunction("DKWindow_SetY", DKWindowJS::SetY, 1);
	DKDuktape::AttachFunction("DKWindow_Show", DKWindowJS::Show, 0);
	DKDuktape::AttachFunction("DKWindow_Windowed", DKWindowJS::Windowed, 0);
}





/////////////////////////////////////////
int DKWindowJS::TestInt(duk_context* ctx)
{
	int input = duk_require_int(ctx, 0);
	int output = DKWindow::TestInt(input);
	duk_push_int(ctx, output);
	return 1;
}

////////////////////////////////////////////
int DKWindowJS::TestString(duk_context* ctx)
{
	DKString input = duk_require_string(ctx, 0);
	DKString output = DKWindow::TestString(input);
	duk_push_string(ctx, output.c_str());
	return 1;
}





//////////////////////////////////////
int DKWindowJS::GetX(duk_context* ctx)
{
	duk_push_int(ctx, DKWindow::GetX());
	return 1;
}

//////////////////////////////////////
int DKWindowJS::GetY(duk_context* ctx)
{
	duk_push_int(ctx, DKWindow::GetY());
	return 1;
}

//////////////////////////////////////////
int DKWindowJS::GetWidth(duk_context* ctx)
{
	duk_push_int(ctx, DKWindow::GetWidth());
	return 1;
}

///////////////////////////////////////////
int DKWindowJS::GetHeight(duk_context* ctx)
{
	duk_push_int(ctx, DKWindow::GetHeight());
	return 1;
}

//////////////////////////////////////
int DKWindowJS::SetX(duk_context* ctx)
{
	DKString data = duk_require_string(ctx, 0);
	DKWindow::SetX(toInt(data));
	return 1;
}

//////////////////////////////////////
int DKWindowJS::SetY(duk_context* ctx)
{
	DKString data = duk_require_string(ctx, 0);
	DKWindow::SetY(toInt(data));
	return 1;
}

//////////////////////////////////////////
int DKWindowJS::SetWidth(duk_context* ctx)
{
	DKString data = duk_require_string(ctx, 0);
	DKWindow::SetWidth(toInt(data));
	return 1;
}

///////////////////////////////////////////
int DKWindowJS::SetHeight(duk_context* ctx)
{
	DKString data = duk_require_string(ctx, 0);
	DKWindow::SetHeight(toInt(data));
	return 1;
}

///////////////////////////////////////////////
int DKWindowJS::GetPixelRatio(duk_context* ctx)
{
	duk_push_number(ctx, DKWindow::GetPixelRatio());
	return 1;
}

//////////////////////////////////////////////
int DKWindowJS::IsFullscreen(duk_context* ctx)
{
	bool isFullscreen = DKWindow::IsFullscreen();
	if(!isFullscreen){ 
		return 0;
	}
	duk_push_int(ctx, isFullscreen);
	return 1;
}

////////////////////////////////////////////
int DKWindowJS::Fullscreen(duk_context* ctx)
{
	DKWindow::Fullscreen();
	return 1;
}

//////////////////////////////////////////
int DKWindowJS::Windowed(duk_context* ctx)
{
	DKWindow::Windowed();
	return 1;
}

//////////////////////////////////////////
int DKWindowJS::Minimize(duk_context* ctx)
{
	DKWindow::Minimize();
	return 1;
}

/////////////////////////////////////////
int DKWindowJS::Restore(duk_context* ctx)
{
	DKWindow::Restore();
	return 1;
}

///////////////////////////////////////////
int DKWindowJS::IsVisible(duk_context* ctx)
{
	bool isVisible = DKWindow::IsVisible(); 
	if(!isVisible){ 
		return 0;
	}
	duk_push_int(ctx, isVisible);
	return 1;
}

//////////////////////////////////////
int DKWindowJS::Hide(duk_context* ctx)
{
	DKWindow::Hide();
	return 1;
}

//////////////////////////////////////
int DKWindowJS::Show(duk_context* ctx)
{
	DKWindow::Show();
	return 1;
}

///////////////////////////////////////////
int DKWindowJS::GetMouseX(duk_context* ctx)
{
	int mouseX = DKWindow::GetMouseX();
	duk_push_int(ctx, mouseX);
	return 1;
}

///////////////////////////////////////////
int DKWindowJS::GetMouseY(duk_context* ctx)
{
	int mouseY = DKWindow::GetMouseY();
	duk_push_int(ctx, mouseY);
	return 1;
}

#endif //USE_DKDuktape