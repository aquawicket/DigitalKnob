/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

#if HAVE_DKDuktape 
#include "DKCef/DKCef.h"
#include "DKCef/DKCefJS.h"


bool DKCefJS::Init(){
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("CPP_DKCef_CloseBrowser", DKCefJS::CloseBrowser);
	DKDuktape::AttachFunction("CPP_DKCef_CloseDevTools", DKCefJS::CloseDevTools);
	DKDuktape::AttachFunction("CPP_DKCef_Copy", DKCefJS::Copy);
	DKDuktape::AttachFunction("CPP_DKCef_CopyImage", DKCefJS::CopyImage);
	DKDuktape::AttachFunction("CPP_DKCef_Cut", DKCefJS::Cut);
	DKDuktape::AttachFunction("CPP_DKCef_DownloadUrl", DKCefJS::DownloadUrl);
	DKDuktape::AttachFunction("CPP_DKCef_Find", DKCefJS::Find);
	DKDuktape::AttachFunction("CPP_DKCef_GetBrowserId", DKCefJS::GetBrowserId);
	DKDuktape::AttachFunction("CPP_DKCef_GetBrowsers", DKCefJS::GetBrowsers);
	DKDuktape::AttachFunction("CPP_DKCef_GetCurrentBrowser", DKCefJS::GetCurrentBrowser);
	DKDuktape::AttachFunction("CPP_DKCef_GetPageSource", DKCefJS::GetPageSource);
	DKDuktape::AttachFunction("CPP_DKCef_GetUrl", DKCefJS::GetUrl);
	DKDuktape::AttachFunction("CPP_DKCef_GoBack", DKCefJS::GoBack);
	DKDuktape::AttachFunction("CPP_DKCef_GoForward", DKCefJS::GoForward);
	DKDuktape::AttachFunction("CPP_DKCef_NewBrowser", DKCefJS::NewBrowser);
	DKDuktape::AttachFunction("CPP_DKCef_Paste", DKCefJS::Paste);
	DKDuktape::AttachFunction("CPP_DKCef_Popup", DKCefJS::Popup);
	DKDuktape::AttachFunction("CPP_DKCef_Print", DKCefJS::Print);
	DKDuktape::AttachFunction("CPP_DKCef_Reload", DKCefJS::Reload);
	DKDuktape::AttachFunction("CPP_DKCef_RemoveFocus", DKCefJS::RemoveFocus);
	DKDuktape::AttachFunction("CPP_DKCef_RunJavascript", DKCefJS::RunJavascript);
	DKDuktape::AttachFunction("CPP_DKCef_SetFocus", DKCefJS::SetFocus);
	DKDuktape::AttachFunction("CPP_DKCef_SetKeyboardFocus", DKCefJS::SetKeyboardFocus);
	DKDuktape::AttachFunction("CPP_DKCef_SetUrl", DKCefJS::SetUrl);
	DKDuktape::AttachFunction("CPP_DKCef_ShowDevTools", DKCefJS::ShowDevTools);
	DKDuktape::AttachFunction("CPP_DKCef_Stop", DKCefJS::Stop);
	DKDuktape::AttachFunction("CPP_DKCef_ViewPageSource", DKCefJS::ViewPageSource);
	return true;
}

int DKCefJS::CloseBrowser(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::Get()->CloseBrowser(browser))
		return 0;
	return 1;
}

int DKCefJS::CloseDevTools(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::Get()->CloseDevTools(browser))
		return 0;
	return 1;
}


int DKCefJS::Copy(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	if(!DKCef::Get()->Copy())
		return 0;
	return 1;
}

int DKCefJS::CopyImage(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString url = duk_require_string(ctx, 0);
	if(!DKCef::Get()->CopyImage(url))
		return 0;
	return 1;
}

int DKCefJS::Cut(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	if(!DKCef::Get()->Cut())
		return 0;
	return 1;
}

int DKCefJS::DownloadUrl(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString url = duk_require_string(ctx, 0);
	if(!DKCef::Get()->DownloadUrl(url))
		return 0;
	return 1;
}

int DKCefJS::Find(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int browser = duk_require_int(ctx, 0);
	DKString text = duk_require_string(ctx, 1);
	if(!DKCef::Get()->Find(browser, text))
		return 0;
	return 1;
}

int DKCefJS::GetBrowserId(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int browser = duk_require_int(ctx, 0);
	DKString id;
	if(!DKCef::Get()->GetBrowserId(browser, id))
		return 0;
	if(!id.empty())
		duk_push_string(ctx, id.c_str());
	return 1;
}

int DKCefJS::GetBrowsers(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int num;
	if(!DKCef::Get()->GetBrowsers(num))
		return 0;
	duk_push_int(ctx, num);
	return 1;
}

int DKCefJS::GetCurrentBrowser(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int browser;
	if(!DKCef::Get()->GetCurrentBrowser(browser))
		return 0;
	duk_push_int(ctx, browser);
	return 1;
}

int DKCefJS::GetPageSource(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int browser = duk_require_int(ctx, 0);
	DKString source;
	if(!DKCef::Get()->GetPageSource(browser, source))
		return 0;
	if(!source.empty())
		duk_push_string(ctx, source.c_str());
	return 1;
}

int DKCefJS::GetUrl(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int browser = duk_require_int(ctx, 0);
	DKString url;
	if(!DKCef::Get()->GetUrl(browser, url))
		return 0;
	if(!url.empty())
		duk_push_string(ctx, url.c_str());
	return 1;
}

int DKCefJS::GoBack(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::Get()->GoBack(browser))
		return 0;
	return 1;
}

int DKCefJS::GoForward(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::Get()->GoForward(browser))
		return 0;
	return 1;
}

int DKCefJS::NewBrowser(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString id = duk_require_string(ctx, 0);
	int top = duk_require_int(ctx, 1);
	int left = duk_require_int(ctx, 2);
	int width = duk_require_int(ctx, 3);
	int height = duk_require_int(ctx, 4);
	DKString url = duk_require_string(ctx, 5);
	if(!DKCef::Get()->NewBrowser(id, top, left, width, height, url))
		return DKERROR("DKCef::Get()->NewBrowser(id, top, left, width, height, url) failed");
	return true;
}

int DKCefJS::Paste(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	if(!DKCef::Get()->Paste())
		return 0;
	return 1;
}

int DKCefJS::Popup(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString url = duk_require_string(ctx, 0);
	if(!DKCef::Get()->Popup(url))
		return 0;
	return 1;
}

int DKCefJS::Print(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::Get()->Print(browser))
		return 0;
	return 1;
}

int DKCefJS::Reload(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::Get()->Reload(browser))
		return 0;
	return 1;
}

int DKCefJS::RemoveFocus(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::Get()->RemoveFocus(browser))
		return 0;
	return 1;
}

int DKCefJS::RunJavascript(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	DKString string = duk_require_string(ctx, 0);
	int browser = duk_require_int(ctx, 1);
	if(!DKCef::Get()->RunJavascript(browser, string))
		return 0;
	return 1;
}

int DKCefJS::SetFocus(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::Get()->SetFocus(browser))
		return 0;
	return 1;
}

int DKCefJS::SetKeyboardFocus(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::Get()->SetKeyboardFocus(browser))
		return 0;
	return 1;
}

int DKCefJS::SetUrl(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int browser = duk_require_int(ctx, 0);
	DKString url = duk_require_string(ctx, 1);
	if(!DKCef::Get()->SetUrl(browser, url))
		return 0;
	return 1;
}

int DKCefJS::ShowDevTools(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::Get()->ShowDevTools(browser))
		return 0;
	return 1;
}

int DKCefJS::Stop(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::Get()->Stop(browser))
		return 0;
	return 1;
}

int DKCefJS::ViewPageSource(duk_context* ctx){
	DKDEBUGFUNC(ctx);
	int browser = duk_require_int(ctx, 0);
	if(!DKCef::Get()->ViewPageSource(browser))
		return 0;
	return 1;
}

#endif //HAVE_DKDuktape