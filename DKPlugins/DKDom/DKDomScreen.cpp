//https://developer.mozilla.org/en-US/docs/Web/API/Screen

#include "DK/DKApp.h"
#include "DKDom/DKDomScreen.h"


////////////////////////
bool DKDomScreen::Init()
{
	DKDEBUGFUNC();

	//Properties
	DKDuktape::AttachFunction("CPP_DKDomScreen_availTop", DKDomScreen::availTop);
	DKDuktape::AttachFunction("CPP_DKDomScreen_availLeft", DKDomScreen::availLeft);
	DKDuktape::AttachFunction("CPP_DKDomScreen_availHeight", DKDomScreen::availHeight);
	DKDuktape::AttachFunction("CPP_DKDomScreen_availWidth", DKDomScreen::availWidth);
	DKDuktape::AttachFunction("CPP_DKDomScreen_colorDepth", DKDomScreen::colorDepth);
	DKDuktape::AttachFunction("CPP_DKDomScreen_height", DKDomScreen::height);
	DKDuktape::AttachFunction("CPP_DKDomScreen_left", DKDomScreen::left);
	DKDuktape::AttachFunction("CPP_DKDomScreen_orientation", DKDomScreen::orientation);
	DKDuktape::AttachFunction("CPP_DKDomScreen_pixelDepth", DKDomScreen::pixelDepth);
	DKDuktape::AttachFunction("CPP_DKDomScreen_top", DKDomScreen::top);
	DKDuktape::AttachFunction("CPP_DKDomScreen_width", DKDomScreen::width);
	DKDuktape::AttachFunction("CPP_DKDomScreen_mozEnabled", DKDomScreen::mozEnabled);
	DKDuktape::AttachFunction("CPP_DKDomScreen_mozBrightness", DKDomScreen::mozBrightness);

	//Methods
	DKDuktape::AttachFunction("CPP_DKDomScreen_lockOrientation", DKDomScreen::lockOrientation);
	DKDuktape::AttachFunction("CPP_DKDomScreen_unlockOrientations", DKDomScreen::unlockOrientation);

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
	return true;
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
	return true;
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