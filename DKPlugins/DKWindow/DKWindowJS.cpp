#ifdef USE_DKDuktape 
#include "DKWindowJS.h"
#include "DKWindow.h"


///////////////////////
void DKWindowJS::Init()
{
	//DKLog("DKWindowJS::Init() \n", DKDEBUG);

	DKDuktape::AttachFunction("DKWindow_GetX", DKWindowJS::GetX, 0);
	DKDuktape::AttachFunction("DKWindow_GetY", DKWindowJS::GetY, 0);
	DKDuktape::AttachFunction("DKWindow_GetWidth", DKWindowJS::GetWidth, 0);
	DKDuktape::AttachFunction("DKWindow_GetHeight", DKWindowJS::GetHeight, 0);
	DKDuktape::AttachFunction("DKWindow_SetX", DKWindowJS::SetX, 1);
	DKDuktape::AttachFunction("DKWindow_SetY", DKWindowJS::SetY, 1);
	DKDuktape::AttachFunction("DKWindow_SetWidth", DKWindowJS::SetWidth, 1);
	DKDuktape::AttachFunction("DKWindow_SetHeight", DKWindowJS::SetHeight, 1);
	DKDuktape::AttachFunction("DKWindow_IsFullscreen", DKWindowJS::IsFullscreen, 0);
	DKDuktape::AttachFunction("DKWindow_Fullscreen", DKWindowJS::Fullscreen, 0);
	DKDuktape::AttachFunction("DKWindow_Windowed", DKWindowJS::Windowed, 0);
	DKDuktape::AttachFunction("DKWindow_Minimize", DKWindowJS::Minimize, 0);
	DKDuktape::AttachFunction("DKWindow_Restore", DKWindowJS::Minimize, 0);
	DKDuktape::AttachFunction("DKWindow_GetMouseX", DKWindowJS::GetMouseX, 0);
	DKDuktape::AttachFunction("DKWindow_GetMouseY", DKWindowJS::GetMouseY, 0);
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