#include "stdafx.h"
#include "DKCefHandler.h"

/////////////////////////////////////////////////////////
bool DKCefHandler::DoClose(CefRefPtr<CefBrowser> browser)
{
	CEF_REQUIRE_UI_THREAD();
	DKApp::Exit(); //FIXME - DKApp class is not available
	return false;
}