#ifdef WIN32
#ifdef USE_DKDuktape 
#include "DKHook.h"
#include "DKHookJS.h"


/////////////////////
void DKHookJS::Init()
{
	DKDuktape::AttachFunction("DKHook_Click", DKHookJS::Click);
	DKDuktape::AttachFunction("DKHook_CurrentHandle", DKHookJS::CurrentHandle);
	DKDuktape::AttachFunction("DKHook_GetValue", DKHookJS::GetValue);
	DKDuktape::AttachFunction("DKHook_GetWindows", DKHookJS::GetWindows);
	DKDuktape::AttachFunction("DKHook_NextHandle", DKHookJS::NextHandle);
	DKDuktape::AttachFunction("DKHook_PrevHandle", DKHookJS::PrevHandle);
	DKDuktape::AttachFunction("DKHook_SendHook", DKHookJS::SendHook);
	DKDuktape::AttachFunction("DKHook_SetValue", DKHookJS::SetValue);
	DKDuktape::AttachFunction("DKHook_SetWindowHandle", DKHookJS::SetWindowHandle);
	DKDuktape::AttachFunction("DKHook_ToggleHighlight", DKHookJS::ToggleHighlight);
	DKDuktape::AttachFunction("DKHook_WaitForWindow", DKHookJS::WaitForWindow);
	DKDuktape::AttachFunction("DKHook_WindowExists", DKHookJS::WindowExists);
}

////////////////////////////////////////
int DKHookJS::SendHook(duk_context* ctx)
{
	DKString window = duk_require_string(ctx, 0);
	DKString handle = duk_require_string(ctx, 1);
	DKString data = duk_require_string(ctx, 2);

	if(!DKHook::Instance("DKHook")->SendHook(window, handle, data)){
		return 0;
	}
	return 1;
}

////////////////////////////////////////
int DKHookJS::GetValue(duk_context* ctx)
{
	DKString value;
	if(!DKHook::Instance("DKHook")->GetString(value)){
		return 0;
	}
	duk_push_string(ctx, value.c_str());
	return 1;
}

////////////////////////////////////////
int DKHookJS::SetValue(duk_context* ctx)
{
	DKString value = duk_require_string(ctx, 0);
	if(!DKHook::Instance("DKHook")->SetString(value)){
		return 0;
	}
	return 1;
}

/////////////////////////////////////
int DKHookJS::Click(duk_context* ctx)
{
	if(!DKHook::Instance("DKHook")->Click()){
		return 0;
	}
	return 1;
}

//////////////////////////////////////////
int DKHookJS::PrevHandle(duk_context* ctx)
{
	if(!DKHook::Instance("DKHook")->PrevHandle()){
		return 0;
	}
	return 1;
}

//////////////////////////////////////////
int DKHookJS::NextHandle(duk_context* ctx)
{
	if(!DKHook::Instance("DKHook")->NextHandle()){
		return 0;
	}
	return 1;
}

///////////////////////////////////////////////
int DKHookJS::ToggleHighlight(duk_context* ctx)
{
	DKHook::Instance("DKHook")->ToggleHighlight();
	return 1;
}

///////////////////////////////////////////////
int DKHookJS::SetWindowHandle(duk_context* ctx)
{
	DKString window = duk_require_string(ctx, 0);
	if(!DKHook::Instance("DKHook")->SetWindowHandle(window)){
		return 0;
	}
	return 1;
}

//////////////////////////////////////////
int DKHookJS::GetWindows(duk_context* ctx)
{
	DKStringArray arry = DKHook::Instance("DKHook")->GetWindows();
	DKString list = toString(arry, ",");
	duk_push_string(ctx, list.c_str());
	return 1;
}

//////////////////////////////////////
int DKHookJS::CurrentHandle(duk_context* ctx)
{
	DKString handle = toString(DKHook::Instance("DKHook")->currentHandle);
	duk_push_string(ctx, handle.c_str());
	return 1;
}

////////////////////////////////////////////
int DKHookJS::WindowExists(duk_context* ctx)
{
	DKString window = duk_require_string(ctx, 0);
	if(!DKHook::Instance("DKHook")->WindowExists(window)){
		return 0;
	}
	duk_push_true(ctx);
	return 1;
}

/////////////////////////////////////////////
int DKHookJS::WaitForWindow(duk_context* ctx)
{
	DKString window = duk_require_string(ctx, 0);
	int timeout = duk_require_int(ctx, 1);
	if(!DKHook::Instance("DKHook")->WaitForWindow(window, timeout)){
		return 0;
	}
	duk_push_true(ctx);
	return 1;
}

#endif //USE_DKDuktape
#endif //WIN32