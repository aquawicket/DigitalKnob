#include "DK/stdafx.h"
#include "DKSDLCef/DKSDLCefHandler.h"

///////////////////////////////
void DKSDLCefHandler::DoFrame()
{ 
	//FIXME: this breaks SDL keyboard events for Mac OSX
	CefDoMessageLoopWork(); 
}