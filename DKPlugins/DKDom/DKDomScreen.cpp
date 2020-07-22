//https://developer.mozilla.org/en-US/docs/Web/API/Screen

#include "DK/DKApp.h"
#include "DKDom/DKDomScreen.h"


////////////////////////
bool DKDomScreen::Init()
{
	DKDEBUGFUNC();

	//Properties
	DKDuktape::AttachFunction("DKDomScreen_availTop", DKDomScreen::availTop);
	DKDuktape::AttachFunction("DKDomScreen_availLeft", DKDomScreen::availLeft);
	DKDuktape::AttachFunction("DKDomScreen_availHeight", DKDomScreen::availHeight);
	DKDuktape::AttachFunction("DKDomScreen_availWidth", DKDomScreen::availWidth);
	DKDuktape::AttachFunction("DKDomScreen_colorDepth", DKDomScreen::colorDepth);
	DKDuktape::AttachFunction("DKDomScreen_height", DKDomScreen::height);
	DKDuktape::AttachFunction("DKDomScreen_left", DKDomScreen::left);
	DKDuktape::AttachFunction("DKDomScreen_orientation", DKDomScreen::orientation);
	DKDuktape::AttachFunction("DKDomScreen_pixelDepth", DKDomScreen::pixelDepth);
	DKDuktape::AttachFunction("DKDomScreen_top", DKDomScreen::top);
	DKDuktape::AttachFunction("DKDomScreen_width", DKDomScreen::width);
	DKDuktape::AttachFunction("DKDomScreen_mozEnabled", DKDomScreen::mozEnabled);
	DKDuktape::AttachFunction("DKDomScreen_mozBrightness", DKDomScreen::mozBrightness);

	//Methods
	DKDuktape::AttachFunction("DKDomScreen_lockOrientation", DKDomScreen::lockOrientation);
	DKDuktape::AttachFunction("DKDomScreen_unlockOrientations", DKDomScreen::unlockOrientation);

	DKClass::DKCreate("DKDom/DKDomScreen.js");
	return true;
}


//Properties
///////////////////////////////////////////
int DKDomScreen::availTop(duk_context* ctx)
{
	//TODO
	return false;
}

////////////////////////////////////////////
int DKDomScreen::availLeft(duk_context* ctx)
{
	//TODO
	return false;
}

//////////////////////////////////////////////
int DKDomScreen::availHeight(duk_context* ctx)
{
	//TODO
	return false;
}

/////////////////////////////////////////////
int DKDomScreen::availWidth(duk_context* ctx)
{
	//TODO
	return false;
}

/////////////////////////////////////////////
int DKDomScreen::colorDepth(duk_context* ctx)
{
	//TODO
	return false;
}

/////////////////////////////////////////
int DKDomScreen::height(duk_context* ctx)
{
	int height;
	if(!DKUtil::GetScreenHeight(height)){ return 0; }
	duk_push_number(ctx, height);
	return 1;
}

///////////////////////////////////////
int DKDomScreen::left(duk_context* ctx)
{
	//TODO
	return false;
}

//////////////////////////////////////////////
int DKDomScreen::orientation(duk_context* ctx)
{
	//TODO
	return false;
}

/////////////////////////////////////////////
int DKDomScreen::pixelDepth(duk_context* ctx)
{
	//TODO
	return false;
}

//////////////////////////////////////
int DKDomScreen::top(duk_context* ctx)
{
	//TODO
	return false;
}

////////////////////////////////////////
int DKDomScreen::width(duk_context* ctx)
{
	int width;
	if(!DKUtil::GetScreenWidth(width)) { return 0; }
	duk_push_number(ctx, width);
	return 1;
}

/////////////////////////////////////////////
int DKDomScreen::mozEnabled(duk_context* ctx)
{
	//TODO
	return false;
}

////////////////////////////////////////////////
int DKDomScreen::mozBrightness(duk_context* ctx)
{
	//TODO
	return false;
}



//Methods
//////////////////////////////////////////////////
int DKDomScreen::lockOrientation(duk_context* ctx) 
{
	//TODO - https://developer.mozilla.org/en-US/docs/Web/API/Screen/lockOrientation
	DKString orientation = duk_require_string(ctx, 0);
	return false;
}

////////////////////////////////////////////////////
int DKDomScreen::unlockOrientation(duk_context* ctx)
{
	//TODO - https://developer.mozilla.org/en-US/docs/Web/API/Screen/unlockOrientation
	return false;
}