#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKDuktape/DKScreen.h"


/////////////////////
bool DKScreen::Init()
{
	DKDEBUGFUNC();
	DKDuktape::AttachFunction("DKScreen_availTop", DKScreen::availTop);
	DKDuktape::AttachFunction("DKScreen_availLeft", DKScreen::availTop);
	DKDuktape::AttachFunction("DKScreen_availHeight", DKScreen::availTop);
	DKDuktape::AttachFunction("DKScreen_availWidth", DKScreen::availTop);
	DKDuktape::AttachFunction("DKScreen_colorDepth", DKScreen::availTop);
	DKDuktape::AttachFunction("DKScreen_height", DKScreen::availTop);
	DKDuktape::AttachFunction("DKScreen_left", DKScreen::availTop);
	DKDuktape::AttachFunction("DKScreen_orientation", DKScreen::availTop);
	DKDuktape::AttachFunction("DKScreen_pixelDepth", DKScreen::availTop);
	DKDuktape::AttachFunction("DKScreen_top", DKScreen::availTop);
	DKDuktape::AttachFunction("DKScreen_width", DKScreen::availTop);
	DKDuktape::AttachFunction("DKScreen_mozEnabled", DKScreen::availTop);
	DKDuktape::AttachFunction("DKScreen_mozBrightness", DKScreen::availTop);
	return true;
}

int DKScreen::availTop(duk_context* ctx)
{
	//TODO
	return false;
}

int DKScreen::availLeft(duk_context* ctx)
{
	//TODO
	return false;
}

int DKScreen::availHeight(duk_context* ctx)
{
	//TODO
	return false;
}

int DKScreen::availWidth(duk_context* ctx)
{
	//TODO
	return false;
}

int DKScreen::colorDepth(duk_context* ctx)
{
	//TODO
	return false;
}

int DKScreen::height(duk_context* ctx)
{
	//TODO
	return false;
}

int DKScreen::left(duk_context* ctx)
{
	//TODO
	return false;
}

int DKScreen::orientation(duk_context* ctx)
{
	//TODO
	return false;
}

int DKScreen::pixelDepth(duk_context* ctx)
{
	//TODO
	return false;
}

int DKScreen::top(duk_context* ctx)
{
	//TODO
	return false;
}

int DKScreen::width(duk_context* ctx)
{
	//TODO
	return false;
}

int DKScreen::mozEnabled(duk_context* ctx)
{
	//TODO
	return false;
}

int DKScreen::mozBrightness(duk_context* ctx)
{
	//TODO
	return false;
}


#endif //USE_DKDuktape