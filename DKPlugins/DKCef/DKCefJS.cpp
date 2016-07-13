#ifdef USE_DKDuktape 
#include "DKCef.h"
#include "DKCefJS.h"


////////////////////
void DKCefJS::Init()
{
	DKDuktape::AttachFunction("DKCef_GetUrl", DKCefJS::GetUrl, 1);
	DKDuktape::AttachFunction("DKCef_SetUrl", DKCefJS::SetUrl, 2);
	DKDuktape::AttachFunction("DKCef_GoBack", DKCefJS::GoBack, 1);
	DKDuktape::AttachFunction("DKCef_GoForward", DKCefJS::GoForward, 1);
	DKDuktape::AttachFunction("DKCef_Stop", DKCefJS::Stop, 1);
	DKDuktape::AttachFunction("DKCef_Reload", DKCefJS::Reload, 1);
	DKDuktape::AttachFunction("DKCef_DownloadUrl", DKCefJS::DownloadUrl, 1);
	DKDuktape::AttachFunction("DKCef_Paste", DKCefJS::Paste, 0);
	DKDuktape::AttachFunction("DKCef_NewBrowser", DKCefJS::NewBrowser, 0);
	DKDuktape::AttachFunction("DKCef_SelectBrowser", DKCefJS::SelectBrowser, 1);
	DKDuktape::AttachFunction("DKCef_CloseBrowser", DKCefJS::CloseBrowser, 1);
	DKDuktape::AttachFunction("DKCef_SetFocus", DKCefJS::SetFocus, 0);
	DKDuktape::AttachFunction("DKCef_RemoveFocus", DKCefJS::RemoveFocus, 0);
	DKDuktape::AttachFunction("DKCef_Focused", DKCefJS::Focused, 0);
	DKDuktape::AttachFunction("DKCef_GetBrowsers", DKCefJS::GetBrowsers, 0);
	DKDuktape::AttachFunction("DKCef_GetCurrentBrowser", DKCefJS::GetCurrentBrowser, 0);
}

/////////////////////////////////////
int DKCefJS::GetUrl(duk_context* ctx)
{
	int num = duk_require_int(ctx, 0);
	DKString url = DKCef::Get("DKCefFrame")->GetUrl(num);
	if (url.empty()){ return 0; }
	duk_push_string(ctx, url.c_str());
	return 1;
}

/////////////////////////////////////
int DKCefJS::SetUrl(duk_context* ctx)
{
	DKString url = duk_require_string(ctx, 0);
	int num = duk_require_int(ctx, 1);
	if(DKCef::Get("DKCefFrame")->SetUrl(url, num)){
		return 1;
	}
	return 0;
}

/////////////////////////////////////
int DKCefJS::GoBack(duk_context* ctx)
{
	int num = duk_require_int(ctx, 0);
	if (DKCef::Get("DKCefFrame")->GoBack(num)){
		return 1;
	}
	return 0;
}

////////////////////////////////////////
int DKCefJS::GoForward(duk_context* ctx)
{
	int num = duk_require_int(ctx, 0);
	if (DKCef::Get("DKCefFrame")->GoForward(num)){
		return 1;
	}
	return 0;
}

///////////////////////////////////
int DKCefJS::Stop(duk_context* ctx)
{
	int num = duk_require_int(ctx, 0);
	DKCef::Get("DKCefFrame")->Stop(num);
	return 1;
}

/////////////////////////////////////
int DKCefJS::Reload(duk_context* ctx)
{
	int num = duk_require_int(ctx, 0);
	DKCef::Get("DKCefFrame")->Reload(num);
	return 1;
}

//////////////////////////////////////////
int DKCefJS::DownloadUrl(duk_context* ctx)
{
	DKString url = duk_require_string(ctx, 0);
	if (DKCef::Get("DKCefFrame")->DownloadUrl(url)){
		return 1;
	}
	return 0;
}

////////////////////////////////////
int DKCefJS::Paste(duk_context* ctx)
{
	DKCef::Get("DKCefFrame")->Paste();
	return 1;
}

/////////////////////////////////////////
int DKCefJS::NewBrowser(duk_context* ctx)
{
	DKCef::Get("DKCefFrame")->NewBrowser();
	return 1;
}

////////////////////////////////////////////
int DKCefJS::SelectBrowser(duk_context* ctx)
{
	int num = duk_require_int(ctx, 0);
	DKCef::Get("DKCefFrame")->SelectBrowser(num);
	return 1;
}

///////////////////////////////////////////
int DKCefJS::CloseBrowser(duk_context* ctx)
{
	int num = duk_require_int(ctx, 0);
	DKCef::Get("DKCefFrame")->CloseBrowser(num);
	return 1;
}

///////////////////////////////////////
int DKCefJS::SetFocus(duk_context* ctx)
{
	DKCef::Get("DKCefFrame")->current_browser->GetHost()->SendFocusEvent(true);
	DKCef::Get("DKCefFrame")->inFocus = true;
	return 1;
}

//////////////////////////////////////////
int DKCefJS::RemoveFocus(duk_context* ctx)
{
	DKCef::Get("DKCefFrame")->current_browser->GetHost()->SendFocusEvent(false);
	DKCef::Get("DKCefFrame")->inFocus = false;
	return 1;
}

//////////////////////////////////////
int DKCefJS::Focused(duk_context* ctx)
{
	bool focused = DKCef::Get("DKCefFrame")->inFocus;
	if(focused){
		duk_push_true(ctx);
		return 1;
	}
	return 0;
}

//////////////////////////////////////////
int DKCefJS::GetBrowsers(duk_context* ctx)
{
	int num = DKCef::Get("DKCefFrame")->GetBrowsers();
	duk_push_int(ctx, num);
	return 1;
}

////////////////////////////////////////////////
int DKCefJS::GetCurrentBrowser(duk_context* ctx)
{
	int num = DKCef::Get("DKCefFrame")->GetCurrentBrowser();
	duk_push_int(ctx, num);
	return 1;
}

#endif //USE_DKDuktape
