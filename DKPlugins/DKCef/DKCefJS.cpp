#ifdef USE_DKDuktape 
#include "DKCef/DKCef.h"
#include "DKCef/DKCefJS.h"


////////////////////
bool DKCefJS::Init()
{
	DKDuktape::AttachFunction("CPP_DKCef_CloseBrowser", DKCefJS::CloseBrowser);
	DKDuktape::AttachFunction("CPP_DKCef_CloseDevTools", CPP_DKCefJS::CloseDevTools);
	DKDuktape::AttachFunction("CPP_DKCef_Copy", CPP_DKCefJS::Copy);
	DKDuktape::AttachFunction("CPP_DKCef_CopyImage", CPP_DKCefJS::CopyImage);
	DKDuktape::AttachFunction("CPP_DKCef_Cut", CPP_DKCefJS::Cut);
	DKDuktape::AttachFunction("CPP_DKCef_DownloadUrl", CPP_DKCefJS::DownloadUrl);
	DKDuktape::AttachFunction("CPP_DKCef_Find", CPP_DKCefJS::Find);
	DKDuktape::AttachFunction("CPP_DKCef_GetBrowserId", CPP_DKCefJS::GetBrowserId);
	DKDuktape::AttachFunction("CPP_DKCef_GetBrowsers", CPP_DKCefJS::GetBrowsers);
	DKDuktape::AttachFunction("CPP_DKCef_GetCurrentBrowser", CPP_DKCefJS::GetCurrentBrowser);
	DKDuktape::AttachFunction("CPP_DKCef_GetPageSource", CPP_DKCefJS::GetPageSource);
	DKDuktape::AttachFunction("CPP_DKCef_GetUrl", CPP_DKCefJS::GetUrl);
	DKDuktape::AttachFunction("CPP_DKCef_GoBack", CPP_DKCefJS::GoBack);
	DKDuktape::AttachFunction("CPP_DKCef_GoForward", CPP_DKCefJS::GoForward);
	DKDuktape::AttachFunction("CPP_DKCef_NewBrowser", CPP_DKCefJS::NewBrowser);
	DKDuktape::AttachFunction("CPP_DKCef_Paste", CPP_DKCefJS::Paste);
	DKDuktape::AttachFunction("CPP_DKCef_Popup", CPP_DKCefJS::Popup);
	DKDuktape::AttachFunction("CPP_DKCef_Print", CPP_DKCefJS::Print);
	DKDuktape::AttachFunction("CPP_DKCef_Reload", CPP_DKCefJS::Reload);
	DKDuktape::AttachFunction("CPP_DKCef_RemoveFocus", CPP_DKCefJS::RemoveFocus);
	DKDuktape::AttachFunction("CPP_DKCef_RunJavascript", CPP_DKCefJS::RunJavascript);
	DKDuktape::AttachFunction("CPP_DKCef_SetFocus", CPP_DKCefJS::SetFocus);
	DKDuktape::AttachFunction("CPP_DKCef_SetKeyboardFocus", CPP_DKCefJS::SetKeyboardFocus);
	DKDuktape::AttachFunction("CPP_DKCef_SetUrl", CPP_DKCefJS::SetUrl);
	DKDuktape::AttachFunction("CPP_DKCef_ShowDevTools", CPP_DKCefJS::ShowDevTools);
	DKDuktape::AttachFunction("CPP_DKCef_Stop", CPP_DKCefJS::Stop);
	DKDuktape::AttachFunction("CPP_DKCef_ViewPageSource", DKCefJS::ViewPageSource);
	return true;
}

///////////////////////////////////////////
int DKCefJS::CloseBrowser(duk_context* ctx)
{
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::Get()->CloseBrowser(browser)){ return 0; }
	return 1;
}

////////////////////////////////////////////
int DKCefJS::CloseDevTools(duk_context* ctx)
{
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::Get()->CloseDevTools(browser)){ return 0; }
	return 1;
}

///////////////////////////////////
int DKCefJS::Copy(duk_context* ctx)
{
	if(!DKCef::Get()->Copy()){ return 0; }
	return 1;
}

////////////////////////////////////////
int DKCefJS::CopyImage(duk_context* ctx)
{
	DKString url = duk_require_string(ctx, 0);
	if(!DKCef::Get()->CopyImage(url)){ return 0; }
	return 1;
}

//////////////////////////////////
int DKCefJS::Cut(duk_context* ctx)
{
	if(!DKCef::Get()->Cut()){ return 0; }
	return 1;
}

//////////////////////////////////////////
int DKCefJS::DownloadUrl(duk_context* ctx)
{
	DKString url = duk_require_string(ctx, 0);
	if(!DKCef::Get()->DownloadUrl(url)){ return 0; }
	return 1;
}

///////////////////////////////////
int DKCefJS::Find(duk_context* ctx)
{
	int browser = duk_require_int(ctx, 0);
	DKString text = duk_require_string(ctx, 1);
	if(!DKCef::Get()->Find(browser, text)){ return 0; }
	return 1;
}

///////////////////////////////////////////
int DKCefJS::GetBrowserId(duk_context* ctx)
{
	int browser = duk_require_int(ctx, 0);
	DKString id;
	if(!DKCef::Get()->GetBrowserId(browser, id)){ return 0; }
	if(!id.empty()){
		duk_push_string(ctx, id.c_str());
	}
	return 1;
}

//////////////////////////////////////////
int DKCefJS::GetBrowsers(duk_context* ctx)
{
	int num;
	if(!DKCef::Get()->GetBrowsers(num)){ return 0; }
	duk_push_int(ctx, num);
	return 1;
}

////////////////////////////////////////////////
int DKCefJS::GetCurrentBrowser(duk_context* ctx)
{
	int browser;
	if(!DKCef::Get()->GetCurrentBrowser(browser)){ return 0; }
	duk_push_int(ctx, browser);
	return 1;
}

////////////////////////////////////////////
int DKCefJS::GetPageSource(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	int browser = duk_require_int(ctx, 0);
	DKString source;
	if(!DKCef::Get()->GetPageSource(browser, source)){ return 0; }
	if(!source.empty()){
		duk_push_string(ctx, source.c_str());
	}
	return 1;
}

/////////////////////////////////////
int DKCefJS::GetUrl(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	int browser = duk_require_int(ctx, 0);
	DKString url;
	if(!DKCef::Get()->GetUrl(browser, url)){ return 0; }
	if(!url.empty()){
		duk_push_string(ctx, url.c_str());
	}
	return 1;
}

/////////////////////////////////////
int DKCefJS::GoBack(duk_context* ctx)
{
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::Get()->GoBack(browser)){ return 0; }
	return 1;
}

////////////////////////////////////////
int DKCefJS::GoForward(duk_context* ctx)
{
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::Get()->GoForward(browser)){ return 0; }
	return 1;
}

/////////////////////////////////////////
int DKCefJS::NewBrowser(duk_context* ctx)
{
	DKString id = duk_require_string(ctx, 0);
	int top = duk_require_int(ctx, 1);
	int left = duk_require_int(ctx, 2);
	int width = duk_require_int(ctx, 3);
	int height = duk_require_int(ctx, 4);
	DKString url = duk_require_string(ctx, 5);
	if(!DKCef::Get()->NewBrowser(id, top, left, width, height, url)){ return 0; }
	return 1;
}

////////////////////////////////////
int DKCefJS::Paste(duk_context* ctx)
{
	if(!DKCef::Get()->Paste()){ return 0; }
	return 1;
}

////////////////////////////////////
int DKCefJS::Popup(duk_context* ctx)
{
	DKString url = duk_require_string(ctx, 0);
	if(!DKCef::Get()->Popup(url)){ return 0; }
	return 1;
}

////////////////////////////////////
int DKCefJS::Print(duk_context* ctx)
{
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::Get()->Print(browser)){ return 0; }
	return 1;
}

/////////////////////////////////////
int DKCefJS::Reload(duk_context* ctx)
{
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::Get()->Reload(browser)){ return 0; }
	return 1;
}

//////////////////////////////////////////
int DKCefJS::RemoveFocus(duk_context* ctx)
{
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::Get()->RemoveFocus(browser)){ return 0; }
	return 1;
}

////////////////////////////////////////////
int DKCefJS::RunJavascript(duk_context* ctx)
{
	DKString string = duk_require_string(ctx, 0);
	int browser = duk_require_int(ctx, 1);
	if(!DKCef::Get()->RunJavascript(browser, string)){ return 0; }
	return 1;
}

///////////////////////////////////////
int DKCefJS::SetFocus(duk_context* ctx)
{
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::Get()->SetFocus(browser)){ return 0; }
	return 1;
}

///////////////////////////////////////////////
int DKCefJS::SetKeyboardFocus(duk_context* ctx)
{
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::Get()->SetKeyboardFocus(browser)){ return 0; }
	return 1;
}

/////////////////////////////////////
int DKCefJS::SetUrl(duk_context* ctx)
{
	int browser = duk_require_int(ctx, 0);
	DKString url = duk_require_string(ctx, 1);
	if(!DKCef::Get()->SetUrl(browser, url)){ return 0; }
	return 1;
}

///////////////////////////////////////////
int DKCefJS::ShowDevTools(duk_context* ctx)
{
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::Get()->ShowDevTools(browser)){ return 0; }
	return 1;
}

///////////////////////////////////
int DKCefJS::Stop(duk_context* ctx)
{
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::Get()->Stop(browser)){ return 0; }
	return 1;
}

/////////////////////////////////////////////
int DKCefJS::ViewPageSource(duk_context* ctx)
{
	DKDEBUGFUNC(ctx);
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::Get()->ViewPageSource(browser)){ return 0; }
	return 1;
}

#endif //USE_DKDuktape