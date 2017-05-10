#include "stdafx.h"
#include "DKCefHandler.h"

/////////////////////////////////////////////////////////
bool DKCefHandler::DoClose(CefRefPtr<CefBrowser> browser)
{
	CEF_REQUIRE_UI_THREAD();
	if(browser->IsPopup()){ return false; }
	DKApp::Exit();
	return false;
}