#ifdef USE_DKDuktape 
#include "DKCef.h"
#include "DKCefJS.h"


////////////////////
void DKCefJS::Init()
{
	DKDuktape::AttachFunction("DKCef_GetUrl", DKCefJS::GetUrl, 2);
	DKDuktape::AttachFunction("DKCef_SetUrl", DKCefJS::SetUrl, 3);
	DKDuktape::AttachFunction("DKCef_GoBack", DKCefJS::GoBack, 2);
	DKDuktape::AttachFunction("DKCef_GoForward", DKCefJS::GoForward, 2);
	DKDuktape::AttachFunction("DKCef_Stop", DKCefJS::Stop, 2);
	DKDuktape::AttachFunction("DKCef_Reload", DKCefJS::Reload, 2);
	DKDuktape::AttachFunction("DKCef_DownloadUrl", DKCefJS::DownloadUrl, 2);
	DKDuktape::AttachFunction("DKCef_Paste", DKCefJS::Paste, 1);
	DKDuktape::AttachFunction("DKCef_NewBrowser", DKCefJS::NewBrowser, 1);
	DKDuktape::AttachFunction("DKCef_SelectBrowser", DKCefJS::SelectBrowser, 2);
	DKDuktape::AttachFunction("DKCef_CloseBrowser", DKCefJS::CloseBrowser, 2);
	DKDuktape::AttachFunction("DKCef_SetFocus", DKCefJS::SetFocus, 1);
	DKDuktape::AttachFunction("DKCef_RemoveFocus", DKCefJS::RemoveFocus, 1);
	DKDuktape::AttachFunction("DKCef_Focused", DKCefJS::Focused, 1);
	DKDuktape::AttachFunction("DKCef_GetBrowsers", DKCefJS::GetBrowsers, 1);
	DKDuktape::AttachFunction("DKCef_GetCurrentBrowser", DKCefJS::GetCurrentBrowser, 1);
	DKDuktape::AttachFunction("DKCef_ShowDevTools", DKCefJS::ShowDevTools, 2);
	DKDuktape::AttachFunction("DKCef_RunJavascript", DKCefJS::RunJavascript, 2);
}

/////////////////////////////////////
int DKCefJS::GetUrl(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	int num = duk_require_int(ctx, 1);
	DKString url = DKCef::Get(id)->GetUrl(num);
	if (url.empty()){ return 0; }
	duk_push_string(ctx, url.c_str());
	return 1;
}

/////////////////////////////////////
int DKCefJS::SetUrl(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	DKString url = duk_require_string(ctx, 1);
	int num = duk_require_int(ctx, 2);
	if(DKCef::Get(id)->SetUrl(url, num)){
		return 1;
	}
	return 0;
}

/////////////////////////////////////
int DKCefJS::GoBack(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	int num = duk_require_int(ctx, 1);
	if (DKCef::Get(id)->GoBack(num)){
		return 1;
	}
	return 0;
}

////////////////////////////////////////
int DKCefJS::GoForward(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	int num = duk_require_int(ctx, 1);
	if (DKCef::Get(id)->GoForward(num)){
		return 1;
	}
	return 0;
}

///////////////////////////////////
int DKCefJS::Stop(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	int num = duk_require_int(ctx, 1);
	DKCef::Get(id)->Stop(num);
	return 1;
}

/////////////////////////////////////
int DKCefJS::Reload(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	int num = duk_require_int(ctx, 1);
	DKCef::Get(id)->Reload(num);
	return 1;
}

//////////////////////////////////////////
int DKCefJS::DownloadUrl(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	DKString url = duk_require_string(ctx, 1);
	if (DKCef::Get(id)->DownloadUrl(url)){
		return 1;
	}
	return 0;
}

////////////////////////////////////
int DKCefJS::Paste(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	DKCef::Get(id)->Paste();
	return 1;
}

/////////////////////////////////////////
int DKCefJS::NewBrowser(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	DKCef::Get(id)->NewBrowser();
	return 1;
}

////////////////////////////////////////////
int DKCefJS::SelectBrowser(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	int num = duk_require_int(ctx, 1);
	DKCef::Get(id)->SelectBrowser(num);
	return 1;
}

///////////////////////////////////////////
int DKCefJS::CloseBrowser(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	int num = duk_require_int(ctx, 1);
	DKCef::Get(id)->CloseBrowser(num);
	return 1;
}

///////////////////////////////////////
int DKCefJS::SetFocus(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	DKCef::Get(id)->current_browser->GetHost()->SendFocusEvent(true);
	DKCef::Get(id)->inFocus = true;
	return 1;
}

//////////////////////////////////////////
int DKCefJS::RemoveFocus(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	DKCef::Get(id)->current_browser->GetHost()->SendFocusEvent(false);
	DKCef::Get(id)->inFocus = false;
	return 1;
}

//////////////////////////////////////
int DKCefJS::Focused(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	bool focused = DKCef::Get(id)->inFocus;
	if(focused){
		duk_push_true(ctx);
		return 1;
	}
	return 0;
}

//////////////////////////////////////////
int DKCefJS::GetBrowsers(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	int num = DKCef::Get(id)->GetBrowsers();
	duk_push_int(ctx, num);
	return 1;
}

////////////////////////////////////////////////
int DKCefJS::GetCurrentBrowser(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	int num = DKCef::Get(id)->GetCurrentBrowser();
	duk_push_int(ctx, num);
	return 1;
}

///////////////////////////////////////////
int DKCefJS::ShowDevTools(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	int num = duk_require_int(ctx, 1);
	DKCef::Get(id)->ShowDevTools(num);
	return 1;
}

////////////////////////////////////////////
int DKCefJS::RunJavascript(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	DKString string = duk_require_string(ctx, 1);
	DKCef::Get(id)->RunJavascript(string);
	return 1;
}

#endif //USE_DKDuktape
