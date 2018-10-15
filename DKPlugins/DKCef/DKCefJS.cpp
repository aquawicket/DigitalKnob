#ifdef USE_DKDuktape 
#include "DKCef/DKCef.h"
#include "DKCef/DKCefJS.h"


////////////////////
bool DKCefJS::Init()
{
	DKDuktape::AttachFunction("DKCef_CloseBrowser", DKCefJS::CloseBrowser);
	DKDuktape::AttachFunction("DKCef_CloseDevTools", DKCefJS::CloseDevTools);
	DKDuktape::AttachFunction("DKCef_Copy", DKCefJS::Copy);
	DKDuktape::AttachFunction("DKCef_CopyImage", DKCefJS::CopyImage);
	DKDuktape::AttachFunction("DKCef_Cut", DKCefJS::Cut);
	DKDuktape::AttachFunction("DKCef_DownloadUrl", DKCefJS::DownloadUrl);
	DKDuktape::AttachFunction("DKCef_Find", DKCefJS::Find);
	DKDuktape::AttachFunction("DKCef_Focused", DKCefJS::Focused);
	DKDuktape::AttachFunction("DKCef_GetBrowsers", DKCefJS::GetBrowsers);
	DKDuktape::AttachFunction("DKCef_GetCurrentBrowser", DKCefJS::GetCurrentBrowser);
	DKDuktape::AttachFunction("DKCef_GetPageSource", DKCefJS::GetPageSource);
	DKDuktape::AttachFunction("DKCef_GetUrl", DKCefJS::GetUrl);
	DKDuktape::AttachFunction("DKCef_GoBack", DKCefJS::GoBack);
	DKDuktape::AttachFunction("DKCef_GoForward", DKCefJS::GoForward);
	DKDuktape::AttachFunction("DKCef_NewBrowser", DKCefJS::NewBrowser);
	DKDuktape::AttachFunction("DKCef_Paste", DKCefJS::Paste);
	DKDuktape::AttachFunction("DKCef_Popup", DKCefJS::Popup);
	DKDuktape::AttachFunction("DKCef_Print", DKCefJS::Print);
	DKDuktape::AttachFunction("DKCef_Reload", DKCefJS::Reload);
	DKDuktape::AttachFunction("DKCef_RemoveFocus", DKCefJS::RemoveFocus);
	DKDuktape::AttachFunction("DKCef_RunJavascript", DKCefJS::RunJavascript);
	DKDuktape::AttachFunction("DKCef_SelectBrowser", DKCefJS::SelectBrowser);
	DKDuktape::AttachFunction("DKCef_SetFocus", DKCefJS::SetFocus);
	DKDuktape::AttachFunction("DKCef_SetUrl", DKCefJS::SetUrl);
	DKDuktape::AttachFunction("DKCef_ShowDevTools", DKCefJS::ShowDevTools);
	DKDuktape::AttachFunction("DKCef_Stop", DKCefJS::Stop);
	DKDuktape::AttachFunction("DKCef_ViewPageSource", DKCefJS::ViewPageSource);
	return true;
}

///////////////////////////////////////////
int DKCefJS::CloseBrowser(duk_context* ctx)
{
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::CloseBrowser(browser)){ return 0; }
	return 1;
}

////////////////////////////////////////////
int DKCefJS::CloseDevTools(duk_context* ctx)
{
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::CloseDevTools(browser)){ return 0; }
	return 1;
}

///////////////////////////////////
int DKCefJS::Copy(duk_context* ctx)
{
	if(!DKCef::Copy()){ return 0; }
	return 1;
}

////////////////////////////////////////
int DKCefJS::CopyImage(duk_context* ctx)
{
	DKString url = duk_require_string(ctx, 0);
	if(!DKCef::CopyImage(url)){ return 0; }
	return 1;
}

//////////////////////////////////
int DKCefJS::Cut(duk_context* ctx)
{
	if(!DKCef::Cut()){ return 0; }
	return 1;
}

//////////////////////////////////////////
int DKCefJS::DownloadUrl(duk_context* ctx)
{
	DKString url = duk_require_string(ctx, 0);
	if(!DKCef::DownloadUrl(url)){ return 0; }
	return 1;
}

///////////////////////////////////
int DKCefJS::Find(duk_context* ctx)
{
	int browser = duk_require_int(ctx, 0);
	DKString text = duk_require_string(ctx, 1);
	if(!DKCef::Find(browser, text)){ return 0; }
	return 1;
}

//////////////////////////////////////
int DKCefJS::Focused(duk_context* ctx)
{
	bool focused = DKCef::inFocus;
	if(!focused){ return 0; }
	duk_push_true(ctx);
	return 1;
}

//////////////////////////////////////////
int DKCefJS::GetBrowsers(duk_context* ctx)
{
	int num;
	if(!DKCef::GetBrowsers(num)){ return 0; }
	duk_push_int(ctx, num);
	return 1;
}

////////////////////////////////////////////////
int DKCefJS::GetCurrentBrowser(duk_context* ctx)
{
	int browser;
	if(!DKCef::GetCurrentBrowser(browser)){ return 0; }
	duk_push_int(ctx, browser);
	return 1;
}

////////////////////////////////////////////
int DKCefJS::GetPageSource(duk_context* ctx)
{
	//DKLog("DKCefJS::GetPageSource()\n", DKDEBUG);
	int browser = duk_require_int(ctx, 0);
	DKString source;
	if(!DKCef::GetPageSource(browser, source)){ return 0; }
	if(!source.empty()){
		duk_push_string(ctx, source.c_str());
	}
	return 1;
}

/////////////////////////////////////
int DKCefJS::GetUrl(duk_context* ctx)
{
	//DKLog("DKCefJS::GetUrl()\n", DKDEBUG);
	int browser = duk_require_int(ctx, 0);
	DKString url;
	if(!DKCef::GetUrl(browser, url)){ return 0; }
	if(!url.empty()){
		duk_push_string(ctx, url.c_str());
	}
	return 1;
}

/////////////////////////////////////
int DKCefJS::GoBack(duk_context* ctx)
{
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::GoBack(browser)){ return 0; }
	return 1;
}

////////////////////////////////////////
int DKCefJS::GoForward(duk_context* ctx)
{
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::GoForward(browser)){ return 0; }
	return 1;
}

/////////////////////////////////////////
int DKCefJS::NewBrowser(duk_context* ctx)
{
	if(!DKCef::NewBrowser()){ return 0; }
	return 1;
}

////////////////////////////////////
int DKCefJS::Paste(duk_context* ctx)
{
	if(!DKCef::Paste()){ return 0; }
	return 1;
}

////////////////////////////////////
int DKCefJS::Popup(duk_context* ctx)
{
	DKString url = duk_require_string(ctx, 0);
	if(!DKCef::Popup(url)){ return 0; }
	return 1;
}

////////////////////////////////////
int DKCefJS::Print(duk_context* ctx)
{
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::Print(browser)){ return 0; }
	return 1;
}

/////////////////////////////////////
int DKCefJS::Reload(duk_context* ctx)
{
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::Reload(browser)){ return 0; }
	return 1;
}

//////////////////////////////////////////
int DKCefJS::RemoveFocus(duk_context* ctx)
{
	DKCef::current_browser->GetHost()->SendFocusEvent(false);
	DKCef::inFocus = false;
	return 1;
}

////////////////////////////////////////////
int DKCefJS::RunJavascript(duk_context* ctx)
{
	DKString string = duk_require_string(ctx, 0);
	int browser = duk_require_int(ctx, 2);
	if(!DKCef::RunJavascript(browser, string)){ return 0; }
	return 1;
}

////////////////////////////////////////////
int DKCefJS::SelectBrowser(duk_context* ctx)
{
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::SelectBrowser(browser)){ return 0; }
	return 1;
}

///////////////////////////////////////
int DKCefJS::SetFocus(duk_context* ctx)
{
	//if(!DKCef::Valid("")){ return 0; }
	if(!DKCef::current_browser){ return 0; }
	if(!DKCef::current_browser->GetHost()){ return 0; }
	DKCef::current_browser->GetHost()->SendFocusEvent(true);
	DKCef::inFocus = true;
	return 1;
}

/////////////////////////////////////
int DKCefJS::SetUrl(duk_context* ctx)
{
	int browser = duk_require_int(ctx, 0);
	DKString url = duk_require_string(ctx, 1);
	if(!DKCef::SetUrl(browser, url)){ return 0; }
	return 1;
}

///////////////////////////////////////////
int DKCefJS::ShowDevTools(duk_context* ctx)
{
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::ShowDevTools(browser)){ return 0; }
	return 1;
}

///////////////////////////////////
int DKCefJS::Stop(duk_context* ctx)
{
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::Stop(browser)){ return 0; }
	return 1;
}

/////////////////////////////////////////////
int DKCefJS::ViewPageSource(duk_context* ctx)
{
	//DKLog("DKCefJS::ViewPageSource()\n", DKDEBUG);
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::ViewPageSource(browser)){ return 0; }
	return 1;
}

#endif //USE_DKDuktape