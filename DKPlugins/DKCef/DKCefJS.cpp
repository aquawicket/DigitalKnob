#ifdef USE_DKDuktape 
#include "DKCef/DKCef.h"
#include "DKCef/DKCefJS.h"


////////////////////
bool DKCefJS::Init()
{
	DKDuktape::AttachFunction("DKCef_CloseBrowser", DKCefJS::CloseBrowser);
	DKDuktape::AttachFunction("DKCef_DownloadUrl", DKCefJS::DownloadUrl);
	DKDuktape::AttachFunction("DKCef_Find", DKCefJS::Find);
	DKDuktape::AttachFunction("DKCef_Focused", DKCefJS::Focused);
	DKDuktape::AttachFunction("DKCef_GetBrowsers", DKCefJS::GetBrowsers);
	DKDuktape::AttachFunction("DKCef_GetCurrentBrowser", DKCefJS::GetCurrentBrowser);
	DKDuktape::AttachFunction("DKCef_GetUrl", DKCefJS::GetUrl);
	DKDuktape::AttachFunction("DKCef_GoBack", DKCefJS::GoBack);
	DKDuktape::AttachFunction("DKCef_GoForward", DKCefJS::GoForward);
	DKDuktape::AttachFunction("DKCef_NewBrowser", DKCefJS::NewBrowser);
	DKDuktape::AttachFunction("DKCef_Paste", DKCefJS::Paste);
	DKDuktape::AttachFunction("DKCef_Print", DKCefJS::Print);
	DKDuktape::AttachFunction("DKCef_Reload", DKCefJS::Reload);
	DKDuktape::AttachFunction("DKCef_RemoveFocus", DKCefJS::RemoveFocus);
	DKDuktape::AttachFunction("DKCef_RunJavascript", DKCefJS::RunJavascript);
	DKDuktape::AttachFunction("DKCef_SelectBrowser", DKCefJS::SelectBrowser);
	DKDuktape::AttachFunction("DKCef_SetFocus", DKCefJS::SetFocus);
	DKDuktape::AttachFunction("DKCef_SetUrl", DKCefJS::SetUrl);
	DKDuktape::AttachFunction("DKCef_ShowDevTools", DKCefJS::ShowDevTools);
	DKDuktape::AttachFunction("DKCef_Stop", DKCefJS::Stop);
	return true;
}

///////////////////////////////////////////
int DKCefJS::CloseBrowser(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	int num = duk_require_int(ctx, 1);
	DKCef::Get(id)->CloseBrowser(num);
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

///////////////////////////////////
int DKCefJS::Find(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	DKString text = duk_require_string(ctx, 1);
	DKCef::Get(id)->Find(text);
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
	int num;
	DKCef::Get(id)->GetBrowsers(num);
	duk_push_int(ctx, num);
	return 1;
}

////////////////////////////////////////////////
int DKCefJS::GetCurrentBrowser(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	int num;
	DKCef::Get(id)->GetCurrentBrowser(num);
	duk_push_int(ctx, num);
	return 1;
}

/////////////////////////////////////
int DKCefJS::GetUrl(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	int num = duk_require_int(ctx, 1);
	DKString url;
	DKCef::Get(id)->GetUrl(num, url);
	if(url.empty()){ return 0; }
	duk_push_string(ctx, url.c_str());
	return 1;
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

/////////////////////////////////////////
int DKCefJS::NewBrowser(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	DKCef::Get(id)->NewBrowser();
	return 1;
}

////////////////////////////////////
int DKCefJS::Paste(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	DKCef::Get(id)->Paste();
	return 1;
}

////////////////////////////////////
int DKCefJS::Print(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	int num = duk_require_int(ctx, 1);
	DKCef::Get(id)->Print(num);
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
int DKCefJS::RemoveFocus(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	DKCef::Get(id)->current_browser->GetHost()->SendFocusEvent(false);
	DKCef::Get(id)->inFocus = false;
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

////////////////////////////////////////////
int DKCefJS::SelectBrowser(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	int num = duk_require_int(ctx, 1);
	DKCef::Get(id)->SelectBrowser(num);
	return 1;
}

///////////////////////////////////////
int DKCefJS::SetFocus(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	if(!DKCef::Valid(id)){ return 0; }
	if(!DKCef::Get(id)->current_browser){ return 0; }
	if(!DKCef::Get(id)->current_browser->GetHost()){ return 0; }
	DKCef::Get(id)->current_browser->GetHost()->SendFocusEvent(true);
	DKCef::Get(id)->inFocus = true;
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

///////////////////////////////////////////
int DKCefJS::ShowDevTools(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	int num = duk_require_int(ctx, 1);
	DKCef::Get(id)->ShowDevTools(num);
	return 1;
}

///////////////////////////////////
int DKCefJS::Stop(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	int num = duk_require_int(ctx, 1);
	DKCef::Get(id)->Stop(num);
	return 1;
}

#endif //USE_DKDuktape