#ifdef USE_DKDuktape 
#pragma once
#ifndef DKCefJS_H
#define DKCefJS_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////
class DKCefJS : public DKObjectT<DKCefJS>
{
public:
	bool Init();
	
	//Cef js functions
	static int CloseBrowser(duk_context* ctx);
	static int CloseDevTools(duk_context* ctx);
	static int Copy(duk_context* ctx);
	static int CopyImage(duk_context* ctx);
	static int Cut(duk_context* ctx);
	static int DownloadUrl(duk_context* ctx);
	static int Find(duk_context* ctx);
	static int Focused(duk_context* ctx);
	static int GetBrowserId(duk_context* ctx);
	static int GetBrowsers(duk_context* ctx);
	static int GetCurrentBrowser(duk_context* ctx);
	static int GetPageSource(duk_context* ctx);
	static int GetUrl(duk_context* ctx);
	static int GoBack(duk_context* ctx);
	static int GoForward(duk_context* ctx);
	static int NewBrowser(duk_context* ctx);
	static int Paste(duk_context* ctx);
	static int Popup(duk_context* ctx);
	static int Print(duk_context* ctx);
	static int Reload(duk_context* ctx);
	static int RemoveFocus(duk_context* ctx);
	static int RunJavascript(duk_context* ctx);
	static int SelectBrowser(duk_context* ctx);
	static int SetFocus(duk_context* ctx);
	static int SetUrl(duk_context* ctx);
	static int ShowDevTools(duk_context* ctx);
	static int Stop(duk_context* ctx);
	static int ViewPageSource(duk_context* ctx);
};

REGISTER_OBJECT(DKCefJS, true)

#endif //DKCefJS_H
#endif //USE_DKDuktape
