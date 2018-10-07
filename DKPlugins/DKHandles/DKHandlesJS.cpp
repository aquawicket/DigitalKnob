#ifdef WIN32
#ifdef USE_DKDuktape 
#include "DKHandles.h"
#include "DKHandlesJS.h"


////////////////////////
bool DKHandlesJS::Init()
{
	DKDuktape::AttachFunction("DKHandles_Click", DKHandlesJS::Click);
	DKDuktape::AttachFunction("DKHandles_CurrentHandle", DKHandlesJS::CurrentHandle);
	DKDuktape::AttachFunction("DKHandles_GetBottom", DKHandlesJS::GetBottom);
	DKDuktape::AttachFunction("DKHandles_GetClass", DKHandlesJS::GetClass);
	DKDuktape::AttachFunction("DKHandles_GetIndex", DKHandlesJS::GetIndex);
	DKDuktape::AttachFunction("DKHandles_GetLeft", DKHandlesJS::GetLeft);
	DKDuktape::AttachFunction("DKHandles_GetParent", DKHandlesJS::GetParent);
	DKDuktape::AttachFunction("DKHandles_GetTop", DKHandlesJS::GetTop);
	DKDuktape::AttachFunction("DKHandles_GetValue", DKHandlesJS::GetValue);
	DKDuktape::AttachFunction("DKHandles_GetWindows", DKHandlesJS::GetWindows);
	DKDuktape::AttachFunction("DKHandles_NextHandle", DKHandlesJS::NextHandle);
	DKDuktape::AttachFunction("DKHandles_PrevHandle", DKHandlesJS::PrevHandle);
	//DKDuktape::AttachFunction("DKHandles_SendHook", DKHandlesJS::SendHook);
	DKDuktape::AttachFunction("DKHandles_SetValue", DKHandlesJS::SetValue);
	DKDuktape::AttachFunction("DKHandles_SetWindowHandle", DKHandlesJS::SetWindowHandle);
	DKDuktape::AttachFunction("DKHandles_StartSearch", DKHandlesJS::StartSearch);
	DKDuktape::AttachFunction("DKHandles_ToggleHighlight", DKHandlesJS::ToggleHighlight);
	DKDuktape::AttachFunction("DKHandles_WaitForWindow", DKHandlesJS::WaitForWindow);
	DKDuktape::AttachFunction("DKHandles_WindowExists", DKHandlesJS::WindowExists);
	return true;
}



////////////////////////////////////////
int DKHandlesJS::Click(duk_context* ctx)
{
	DKString handle = duk_require_string(ctx, 0);
	if(!DKHandles::Click(toHWND(handle))){
		return 0;
	}
	return 1;
}

////////////////////////////////////////////////
int DKHandlesJS::CurrentHandle(duk_context* ctx)
{
	DKString handle = toString(DKHandles::currentHandle);
	duk_push_string(ctx, handle.c_str());
	return 1;
}

////////////////////////////////////////////
int DKHandlesJS::GetBottom(duk_context* ctx)
{
	DKString handle = duk_require_string(ctx, 0);
	int bottom;
	if(!DKHandles::GetBottom(toHWND(handle), bottom)){
		duk_push_boolean(ctx, false);
		return false;
	}
	duk_push_int(0, bottom);
	return true;
}

///////////////////////////////////////////
int DKHandlesJS::GetClass(duk_context* ctx)
{
	DKString handle = duk_require_string(ctx, 0);
	DKString clas;
	if(!DKHandles::GetClass(toHWND(handle), clas)){ return 0; }
	duk_push_string(ctx, clas.c_str());
	return 1;
}

///////////////////////////////////////////
int DKHandlesJS::GetIndex(duk_context* ctx)
{
	DKString handle = duk_require_string(ctx, 0);
	int index;
	if(!DKHandles::GetIndex(toHWND(handle), index)){ return 0; }
	duk_push_int(ctx, index);
	return 1;
}

//////////////////////////////////////////
int DKHandlesJS::GetLeft(duk_context* ctx)
{
	DKString handle = duk_require_string(ctx, 0);
	int left;
	if(!DKHandles::GetLeft(toHWND(handle), left)){
		duk_push_boolean(ctx, false);
		return false;
	}
	duk_push_int(0, left);
	return true;
}

////////////////////////////////////////////
int DKHandlesJS::GetParent(duk_context* ctx)
{
	DKString handle = duk_require_string(ctx, 0);
	DKString parent;
	if(!DKHandles::GetParent(toHWND(handle), parent)){
		duk_push_boolean(ctx, false);
		return false;
	}
	duk_push_string(ctx, parent.c_str());
	return true;
}

///////////////////////////////////////////
int DKHandlesJS::GetRight(duk_context* ctx)
{
	DKString handle = duk_require_string(ctx, 0);
	int right;
	if(!DKHandles::GetRight(toHWND(handle), right)){
		duk_push_boolean(ctx, false);
		return false;
	}
	duk_push_int(0, right);
	return true;
}

/////////////////////////////////////////
int DKHandlesJS::GetTop(duk_context* ctx)
{
	DKString handle = duk_require_string(ctx, 0);
	int top;
	if(!DKHandles::GetTop(toHWND(handle), top)){
		duk_push_boolean(ctx, false);
		return false;
	}
	duk_push_int(0, top);
	return true;
}

///////////////////////////////////////////
int DKHandlesJS::GetValue(duk_context* ctx)
{
	DKString handle = duk_require_string(ctx, 0);
	DKString value;
	if(!DKHandles::GetString(toHWND(handle), value)){ return 0; }
	duk_push_string(ctx, value.c_str());
	return 1;
}

/////////////////////////////////////////////
int DKHandlesJS::GetWindows(duk_context* ctx)
{
	DKStringArray windows;
	if(!DKHandles::GetWindows(windows)){ return 0; }
	DKString list = toString(windows, ",");
	duk_push_string(ctx, list.c_str());
	return 1;
}

/////////////////////////////////////////////
int DKHandlesJS::NextHandle(duk_context* ctx)
{
	DKString handle = duk_require_string(ctx, 0);
	HWND next;
	if(!DKHandles::NextHandle(toHWND(handle), next)){ return 0; }
	duk_push_string(ctx, toString(next).c_str());
	return 1;
}

/////////////////////////////////////////////
int DKHandlesJS::PrevHandle(duk_context* ctx)
{
	DKString handle = duk_require_string(ctx, 0);
	HWND prev;
	if(!DKHandles::PrevHandle(toHWND(handle), prev)){ return 0;}
	duk_push_string(ctx, toString(prev).c_str());
	return 1;
}

/*
///////////////////////////////////////////
int DKHandlesJS::SendHook(duk_context* ctx)
{
	DKString window = duk_require_string(ctx, 0);
	DKString handle = duk_require_string(ctx, 1);
	DKString data = duk_require_string(ctx, 2);

	if(!DKHandles::Instance("DKHandles")->SendHook(window, handle, data)){
		return 0;
	}
	return 1;
}
*/

///////////////////////////////////////////
int DKHandlesJS::SetValue(duk_context* ctx)
{
	DKString handle = duk_require_string(ctx, 0);
	DKString value = duk_require_string(ctx, 1);
	if(!DKHandles::SetString(toHWND(handle), value)){ return 0; }
	return 1;
}

//////////////////////////////////////////////////
int DKHandlesJS::SetWindowHandle(duk_context* ctx)
{
	DKString window = duk_require_string(ctx, 0);
	HWND hwnd;
	if(!DKHandles::SetWindowHandle(window, 1, hwnd)){ return 0; }
	std::stringstream ss;
	ss << "0x" << hwnd;
	DKString sval = ss.str();
	DKLog("DKHandlesJS::SetWindowHandle() = "+ss.str()+"\n", DKINFO);
	duk_push_string(ctx, sval.c_str());
	return 1;
}

//////////////////////////////////////////////
int DKHandlesJS::StartSearch(duk_context* ctx)
{
	if(!DKHandles::Instance("DKHandles")->StartSearch()){
		return 0;
	}
	return 1;
}

//////////////////////////////////////////////////
int DKHandlesJS::ToggleHighlight(duk_context* ctx)
{
	DKHandles::Instance("DKHandles")->ToggleHighlight();
	return 1;
}

////////////////////////////////////////////////
int DKHandlesJS::WaitForWindow(duk_context* ctx)
{
	DKString window = duk_require_string(ctx, 0);
	int timeout = duk_require_int(ctx, 1);
	if(!DKHandles::Instance("DKHandles")->WaitForWindow(window, timeout)){
		return 0;
	}
	duk_push_true(ctx);
	return 1;
}

///////////////////////////////////////////////
int DKHandlesJS::WindowExists(duk_context* ctx)
{
	DKString window = duk_require_string(ctx, 0);
	if(!DKHandles::Instance("DKHandles")->WindowExists(window)){
		return 0;
	}
	duk_push_true(ctx);
	return 1;
}

#endif //USE_DKDuktape
#endif //WIN32