#ifdef WIN32
#ifdef USE_DKDuktape 
#include "DKHandles.h"
#include "DKHandlesJS.h"


////////////////////////
bool DKHandlesJS::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKCPP_DKHandles_Click", DKHandlesJS::Click);
	DKDuktape::AttachFunction("DKCPP_DKHandles_CurrentHandle", DKHandlesJS::CurrentHandle);
	DKDuktape::AttachFunction("DKCPP_DKHandles_GetBottom", DKHandlesJS::GetBottom);
	DKDuktape::AttachFunction("DKCPP_DKHandles_GetClass", DKHandlesJS::GetClass);
	DKDuktape::AttachFunction("DKCPP_DKHandles_GetIndex", DKHandlesJS::GetIndex);
	DKDuktape::AttachFunction("DKCPP_DKHandles_GetLeft", DKHandlesJS::GetLeft);
	DKDuktape::AttachFunction("DKCPP_DKHandles_GetParent", DKHandlesJS::GetParent);
	DKDuktape::AttachFunction("DKCPP_DKHandles_GetRight", DKHandlesJS::GetRight);
	DKDuktape::AttachFunction("DKCPP_DKHandles_GetTop", DKHandlesJS::GetTop);
	DKDuktape::AttachFunction("DKCPP_DKHandles_GetValue", DKHandlesJS::GetValue);
	DKDuktape::AttachFunction("DKCPP_DKHandles_GetWindow", DKHandlesJS::GetWindow);
	DKDuktape::AttachFunction("DKCPP_DKHandles_GetWindowIndex", DKHandlesJS::GetWindowIndex);
	DKDuktape::AttachFunction("DKCPP_DKHandles_GetWindows", DKHandlesJS::GetWindows);
	DKDuktape::AttachFunction("DKCPP_DKHandles_NextHandle", DKHandlesJS::NextHandle);
	DKDuktape::AttachFunction("DKCPP_DKHandles_PrevHandle", DKHandlesJS::PrevHandle);
	//DKDuktape::AttachFunction("DKCPP_DKHandles_SendHook", DKHandlesJS::SendHook);
	DKDuktape::AttachFunction("DKCPP_DKHandles_SetHandle", DKHandlesJS::SetHandle);
	DKDuktape::AttachFunction("DKCPP_DKHandles_SetValue", DKHandlesJS::SetValue);
	DKDuktape::AttachFunction("DKCPP_DKHandles_SetWindowHandle", DKHandlesJS::SetWindowHandle);
	DKDuktape::AttachFunction("DKCPP_DKHandles_ShowWindow", DKHandlesJS::ShowWindow);
	DKDuktape::AttachFunction("DKCPP_DKHandles_StartSearch", DKHandlesJS::StartSearch);
	DKDuktape::AttachFunction("DKCPP_DKHandles_ToggleHighlight", DKHandlesJS::ToggleHighlight);
	DKDuktape::AttachFunction("DKCPP_DKHandles_WaitForHandle", DKHandlesJS::WaitForHandle);
	DKDuktape::AttachFunction("DKCPP_DKHandles_WaitForWindow", DKHandlesJS::WaitForWindow);
	DKDuktape::AttachFunction("DKCPP_DKHandles_WindowExists", DKHandlesJS::WindowExists);
	return true;
}



////////////////////////////////////////
int DKHandlesJS::Click(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString handle = duk_require_string(ctx, 0);
	if(!DKHandles::Click(toHWND(handle))){
		return 0;
	}
	return 1;
}

////////////////////////////////////////////////
int DKHandlesJS::CurrentHandle(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString handle = toString(DKHandles::currentHandle);
	duk_push_string(ctx, handle.c_str());
	return 1;
}

////////////////////////////////////////////
int DKHandlesJS::GetBottom(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
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
	DKDEBUGFUNC(ctx);
	DKString handle = duk_require_string(ctx, 0);
	DKString clas;
	if(!DKHandles::GetClass(toHWND(handle), clas)){ return 0; }
	duk_push_string(ctx, clas.c_str());
	return 1;
}

///////////////////////////////////////////
int DKHandlesJS::GetIndex(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString handle = duk_require_string(ctx, 0);
	int index;
	if(!DKHandles::GetIndex(toHWND(handle), index)){ return 0; }
	duk_push_int(ctx, index);
	return 1;
}

//////////////////////////////////////////
int DKHandlesJS::GetLeft(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
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
	DKDEBUGFUNC(ctx);
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
	DKDEBUGFUNC(ctx);
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
	DKDEBUGFUNC(ctx);
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
	DKDEBUGFUNC(ctx);
	DKString handle = duk_require_string(ctx, 0);
	DKString value;
	if(!DKHandles::GetString(toHWND(handle), value)){ return 0; }
	duk_push_string(ctx, value.c_str());
	return 1;
}

////////////////////////////////////////////
int DKHandlesJS::GetWindow(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString handle = duk_require_string(ctx, 0);
	HWND window;
	if(!DKHandles::GetWindow(toHWND(handle), window)){
		duk_push_boolean(ctx, false);
		return 0;
	}
	duk_push_string(ctx, toString(window).c_str());
	return 1;
}

/////////////////////////////////////////////////
int DKHandlesJS::GetWindowIndex(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString handle = duk_require_string(ctx, 0);
	int index;
	if(!DKHandles::GetWindowIndex(toHWND(handle), index)){
		duk_push_boolean(ctx, false);
		return 0;
	}
	duk_push_int(ctx, index);
	return 1;
}

/////////////////////////////////////////////
int DKHandlesJS::GetWindows(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKStringArray windows;
	if(!DKHandles::GetWindows(windows)){ return 0; }
	DKString list = toString(windows, ",");
	duk_push_string(ctx, list.c_str());
	return 1;
}

/////////////////////////////////////////////
int DKHandlesJS::NextHandle(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString handle = duk_require_string(ctx, 0);
	HWND next;
	if(!DKHandles::NextHandle(toHWND(handle), next)){ return 0; }
	duk_push_string(ctx, toString(next).c_str());
	return 1;
}

/////////////////////////////////////////////
int DKHandlesJS::PrevHandle(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
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
	DKDEBUGFUNC(ctx);
	DKString window = duk_require_string(ctx, 0);
	DKString handle = duk_require_string(ctx, 1);
	DKString data = duk_require_string(ctx, 2);

	if(!DKHandles::Instance("DKHandles")->SendHook(window, handle, data)){
		return 0;
	}
	return 1;
}
*/

////////////////////////////////////////////
int DKHandlesJS::SetHandle(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	int timeout = 1;
	if(duk_is_number(ctx, 0)){ //By handle number
		if(duk_is_number(ctx, 1)){ timeout = duk_require_int(ctx, 1); }
		if(!DKHandles::SetHandle(duk_require_int(ctx, 0), timeout)){
			duk_push_boolean(ctx, false);
			return false;
		}
	}
	else if(duk_is_string(ctx, 0) && duk_is_string(ctx, 1)){ //By handle class, value
		if(duk_is_number(ctx, 2)){ timeout = duk_require_int(ctx, 2); }
		if(!DKHandles::SetHandle(duk_require_string(ctx, 0), duk_require_string(ctx, 1), timeout)){
			duk_push_boolean(ctx, false);
			return false;
		}
	}
	else if(duk_is_string(ctx, 0)){ //By handle value
		if(duk_is_number(ctx, 1)){ timeout = duk_require_int(ctx, 1); }
		if(!DKHandles::SetHandle(duk_require_string(ctx, 0), timeout)){
			duk_push_boolean(ctx, false);
			return false;
		}
	}
	duk_push_boolean(ctx, true);
	return 1;
}

///////////////////////////////////////////
int DKHandlesJS::SetValue(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString handle = duk_require_string(ctx, 0);
	DKString value = duk_require_string(ctx, 1);
	if(!DKHandles::SetString(toHWND(handle), value)){ return 0; }
	return 1;
}

//////////////////////////////////////////////////
int DKHandlesJS::SetWindowHandle(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString window = duk_require_string(ctx, 0);
	HWND hwnd;
	if(!DKHandles::SetWindowHandle(window, 1, hwnd)){ return 0; }
	std::stringstream ss;
	ss << "0x" << hwnd;
	DKString sval = ss.str();
	DKINFO("DKHandlesJS::SetWindowHandle() = "+ss.str()+"\n");
	duk_push_string(ctx, sval.c_str());
	return 1;
}

/////////////////////////////////////////////
int DKHandlesJS::ShowWindow(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKString handle = duk_require_string(ctx, 0);
	bool flag = duk_require_boolean(ctx, 1);
	if(!DKHandles::ShowWindow(toHWND(handle), flag)){
		duk_push_boolean(ctx, false);
		return 0;
	}
	duk_push_boolean(ctx, true);
	return 1;
}

//////////////////////////////////////////////
int DKHandlesJS::StartSearch(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	if(!DKHandles::Instance("DKHandles")->StartSearch()){
		return 0;
	}
	return 1;
}

//////////////////////////////////////////////////
int DKHandlesJS::ToggleHighlight(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	DKHandles::Instance("DKHandles")->ToggleHighlight();
	return 1;
}

////////////////////////////////////////////////
int DKHandlesJS::WaitForHandle(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	if(duk_is_number(ctx, 0)){ //By handle number
		if(!DKHandles::WaitForHandle(duk_require_int(ctx, 0), duk_require_int(ctx, 1))){
			duk_push_boolean(ctx, false);
			return false;
		}
	}
	else if(duk_is_string(ctx, 0) && duk_is_string(ctx, 1)){ //By handle class, value
		if(!DKHandles::WaitForHandle(duk_require_string(ctx, 0), duk_require_string(ctx, 1), duk_require_int(ctx, 2))){
			duk_push_boolean(ctx, false);
			return false;
		}
	}
	else if(duk_require_string(ctx, 0)){ //By handle value
		if(!DKHandles::WaitForHandle(duk_require_string(ctx, 0), duk_require_int(ctx, 1))){
			duk_push_boolean(ctx, false);
			return false;
		}
	}
	duk_push_boolean(ctx, true);
	return 1;
}

////////////////////////////////////////////////
int DKHandlesJS::WaitForWindow(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
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
	DKDEBUGFUNC(ctx);
	DKString window = duk_require_string(ctx, 0);
	if(!DKHandles::Instance("DKHandles")->WindowExists(window)){
		return 0;
	}
	duk_push_true(ctx);
	return 1;
}

#endif //USE_DKDuktape
#endif //WIN32