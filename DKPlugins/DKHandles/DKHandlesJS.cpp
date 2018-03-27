#ifdef WIN32
#ifdef USE_DKDuktape 
#include "DKHandles.h"
#include "DKHandlesJS.h"


////////////////////////
bool DKHandlesJS::Init()
{
	DKDuktape::AttachFunction("DKHandles_Click", DKHandlesJS::Click);
	DKDuktape::AttachFunction("DKHandles_CurrentHandle", DKHandlesJS::CurrentHandle);
	DKDuktape::AttachFunction("DKHandles_GetValue", DKHandlesJS::GetValue);
	DKDuktape::AttachFunction("DKHandles_GetWindows", DKHandlesJS::GetWindows);
	DKDuktape::AttachFunction("DKHandles_NextHandle", DKHandlesJS::NextHandle);
	DKDuktape::AttachFunction("DKHandles_PrevHandle", DKHandlesJS::PrevHandle);
	DKDuktape::AttachFunction("DKHandles_SendHook", DKHandlesJS::SendHook);
	DKDuktape::AttachFunction("DKHandles_SetValue", DKHandlesJS::SetValue);
	DKDuktape::AttachFunction("DKHandles_SetWindowHandle", DKHandlesJS::SetWindowHandle);
	DKDuktape::AttachFunction("DKHandles_ToggleHighlight", DKHandlesJS::ToggleHighlight);
	DKDuktape::AttachFunction("DKHandles_WaitForWindow", DKHandlesJS::WaitForWindow);
	DKDuktape::AttachFunction("DKHandles_WindowExists", DKHandlesJS::WindowExists);
	return true;
}



////////////////////////////////////////
int DKHandlesJS::Click(duk_context* ctx)
{
	if(!DKHandles::Instance("DKHandles")->Click()){
		return 0;
	}
	return 1;
}

////////////////////////////////////////////////
int DKHandlesJS::CurrentHandle(duk_context* ctx)
{
	DKString handle = toString(DKHandles::Instance("DKHandles")->currentHandle);
	duk_push_string(ctx, handle.c_str());
	return 1;
}

///////////////////////////////////////////
int DKHandlesJS::GetValue(duk_context* ctx)
{
	DKString value;
	if(!DKHandles::Instance("DKHandles")->GetString(value)){
		return 0;
	}
	duk_push_string(ctx, value.c_str());
	return 1;
}

/////////////////////////////////////////////
int DKHandlesJS::GetWindows(duk_context* ctx)
{
	DKStringArray windows;
	if (!DKHandles::Instance("DKHandles")->GetWindows(windows)) {
		return 0;
	}
	DKString list = toString(windows, ",");
	duk_push_string(ctx, list.c_str());
	return 1;
}

/////////////////////////////////////////////
int DKHandlesJS::NextHandle(duk_context* ctx)
{
	if(!DKHandles::Instance("DKHandles")->NextHandle()){
		return 0;
	}
	return 1;
}

/////////////////////////////////////////////
int DKHandlesJS::PrevHandle(duk_context* ctx)
{
	if(!DKHandles::Instance("DKHandles")->PrevHandle()){
		return 0;
	}
	return 1;
}

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

///////////////////////////////////////////
int DKHandlesJS::SetValue(duk_context* ctx)
{
	DKString value = duk_require_string(ctx, 0);
	if(!DKHandles::Instance("DKHandles")->SetString(value)){
		return 0;
	}
	return 1;
}

//////////////////////////////////////////////////
int DKHandlesJS::SetWindowHandle(duk_context* ctx)
{
	DKString window = duk_require_string(ctx, 0);
	if(!DKHandles::Instance("DKHandles")->SetWindowHandle(window, 1)){
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