#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKDuktape/DKConsole.h"


//////////////////////
bool DKConsole::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKConsole_availTop", DKConsole::availTop);
	DKDuktape::AttachFunction("DKConsole_availLeft", DKConsole::availTop);
	DKDuktape::AttachFunction("DKConsole_availHeight", DKConsole::availTop);
	DKDuktape::AttachFunction("DKConsole_availWidth", DKConsole::availTop);
	DKDuktape::AttachFunction("DKConsole_colorDepth", DKConsole::availTop);
	DKDuktape::AttachFunction("DKConsole_height", DKConsole::availTop);
	DKDuktape::AttachFunction("DKConsole_left", DKConsole::availTop);
	DKDuktape::AttachFunction("DKConsole_orientation", DKConsole::availTop);
	DKDuktape::AttachFunction("DKConsole_pixelDepth", DKConsole::availTop);
	DKDuktape::AttachFunction("DKConsole_top", DKConsole::availTop);
	DKDuktape::AttachFunction("DKConsole_width", DKConsole::availTop);
	DKDuktape::AttachFunction("DKConsole_mozEnabled", DKConsole::availTop);
	DKDuktape::AttachFunction("DKConsole_mozBrightness", DKConsole::availTop);

	DKClass::DKCreate("DKDuktape/DKConsole.js");
	return true;
}

int DKConsole::availTop(duk_context* ctx)
{
	//TODO
	return false;
}

int DKConsole::availLeft(duk_context* ctx)
{
	//TODO
	return false;
}

int DKConsole::availHeight(duk_context* ctx)
{
	//TODO
	return false;
}

int DKConsole::availWidth(duk_context* ctx)
{
	//TODO
	return false;
}

int DKConsole::colorDepth(duk_context* ctx)
{
	//TODO
	return false;
}

int DKConsole::height(duk_context* ctx)
{
	//TODO
	return false;
}

int DKConsole::left(duk_context* ctx)
{
	//TODO
	return false;
}

int DKConsole::orientation(duk_context* ctx)
{
	//TODO
	return false;
}

int DKConsole::pixelDepth(duk_context* ctx)
{
	//TODO
	return false;
}

int DKConsole::top(duk_context* ctx)
{
	//TODO
	return false;
}

int DKConsole::width(duk_context* ctx)
{
	//TODO
	return false;
}

int DKConsole::mozEnabled(duk_context* ctx)
{
	//TODO
	return false;
}

int DKConsole::mozBrightness(duk_context* ctx)
{
	//TODO
	return false;
}


#endif //USE_DKDuktape