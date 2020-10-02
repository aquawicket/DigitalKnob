#ifdef USE_DKDuktape 
#include "DKCef/DKCef.h"
#include "DKCef/DKCefJS.h"


////////////////////
bool DKCefJS::Init()
{
	DKDuktape::AttachFunction("DKCPP_DKCef_CloseBrowser", DKCefJS::CloseBrowser);
	DKDuktape::AttachFunction("DKCPP_DKCef_CloseDevTools", DKCPP_DKCefJS::CloseDevTools);
	DKDuktape::AttachFunction("DKCPP_DKCef_Copy", DKCPP_DKCefJS::Copy);
	DKDuktape::AttachFunction("DKCPP_DKCef_CopyImage", DKCPP_DKCefJS::CopyImage);
	DKDuktape::AttachFunction("DKCPP_DKCef_Cut", DKCPP_DKCefJS::Cut);
	DKDuktape::AttachFunction("DKCPP_DKCef_DownloadUrl", DKCPP_DKCefJS::DownloadUrl);
	DKDuktape::AttachFunction("DKCPP_DKCef_Find", DKCPP_DKCefJS::Find);
	DKDuktape::AttachFunction("DKCPP_DKCef_GetBrowserId", DKCPP_DKCefJS::GetBrowserId);
	DKDuktape::AttachFunction("DKCPP_DKCef_GetBrowsers", DKCPP_DKCefJS::GetBrowsers);
	DKDuktape::AttachFunction("DKCPP_DKCef_GetCurrentBrowser", DKCPP_DKCefJS::GetCurrentBrowser);
	DKDuktape::AttachFunction("DKCPP_DKCef_GetPageSource", DKCPP_DKCefJS::GetPageSource);
	DKDuktape::AttachFunction("DKCPP_DKCef_GetUrl", DKCPP_DKCefJS::GetUrl);
	DKDuktape::AttachFunction("DKCPP_DKCef_GoBack", DKCPP_DKCefJS::GoBack);
	DKDuktape::AttachFunction("DKCPP_DKCef_GoForward", DKCPP_DKCefJS::GoForward);
	DKDuktape::AttachFunction("DKCPP_DKCef_NewBrowser", DKCPP_DKCefJS::NewBrowser);
	DKDuktape::AttachFunction("DKCPP_DKCef_Paste", DKCPP_DKCefJS::Paste);
	DKDuktape::AttachFunction("DKCPP_DKCef_Popup", DKCPP_DKCefJS::Popup);
	DKDuktape::AttachFunction("DKCPP_DKCef_Print", DKCPP_DKCefJS::Print);
	DKDuktape::AttachFunction("DKCPP_DKCef_Reload", DKCPP_DKCefJS::Reload);
	DKDuktape::AttachFunction("DKCPP_DKCef_RemoveFocus", DKCPP_DKCefJS::RemoveFocus);
	DKDuktape::AttachFunction("DKCPP_DKCef_RunJavascript", DKCPP_DKCefJS::RunJavascript);
	DKDuktape::AttachFunction("DKCPP_DKCef_SetFocus", DKCPP_DKCefJS::SetFocus);
	DKDuktape::AttachFunction("DKCPP_DKCef_SetKeyboardFocus", DKCPP_DKCefJS::SetKeyboardFocus);
	DKDuktape::AttachFunction("DKCPP_DKCef_SetUrl", DKCPP_DKCefJS::SetUrl);
	DKDuktape::AttachFunction("DKCPP_DKCef_ShowDevTools", DKCPP_DKCefJS::ShowDevTools);
	DKDuktape::AttachFunction("DKCPP_DKCef_Stop", DKCPP_DKCefJS::Stop);
	DKDuktape::AttachFunction("DKCPP_DKCef_ViewPageSource", DKCefJS::ViewPageSource);
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