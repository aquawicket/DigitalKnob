#include "stdafx.h"
#include "DKCefHandler.h"

/////////////////////////////////////////////////////////
bool DKCefHandler::DoClose(CefRefPtr<CefBrowser> browser)
{
	DKApp::Exit(); //FIXME - DKApp class is not available
	return false;
}