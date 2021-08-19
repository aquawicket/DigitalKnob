//https://developer.mozilla.org/en-US/docs/Web/API/Screen

#ifdef USE_DKDuktape 
#include "DK/DKApp.h"
#include "DKDuktape/DKScreen.h"


bool DKScreen::Init(){
	DKDEBUGFUNC();

	//Properties
	DKDuktape::AttachFunction("CPP_DKScreen_availTop", DKScreen::availTop);
	DKDuktape::AttachFunction("CPP_DKScreen_availLeft", DKScreen::availLeft);
	DKDuktape::AttachFunction("CPP_DKScreen_availHeight", DKScreen::availHeight);
	DKDuktape::AttachFunction("CPP_DKScreen_availWidth", DKScreen::availWidth);
	DKDuktape::AttachFunction("CPP_DKScreen_colorDepth", DKScreen::colorDepth);
	DKDuktape::AttachFunction("CPP_DKScreen_height", DKScreen::height);
	DKDuktape::AttachFunction("CPP_DKScreen_left", DKScreen::left);
	DKDuktape::AttachFunction("CPP_DKScreen_orientation", DKScreen::orientation);
	DKDuktape::AttachFunction("CPP_DKScreen_pixelDepth", DKScreen::pixelDepth);
	DKDuktape::AttachFunction("CPP_DKScreen_top", DKScreen::top);
	DKDuktape::AttachFunction("CPP_DKScreen_width", DKScreen::width);
	DKDuktape::AttachFunction("CPP_DKScreen_mozEnabled", DKScreen::mozEnabled);
	DKDuktape::AttachFunction("CPP_DKScreen_mozBrightness", DKScreen::mozBrightness);

	//Methods
	DKDuktape::AttachFunction("CPP_DKScreen_lockOrientation", DKScreen::lockOrientation);
	DKDuktape::AttachFunction("CPP_DKScreen_unlockOrientations", DKScreen::unlockOrientation);

	DKClass::DKCreate("DKDuktape/DKScreen.js");
	return true;
}


//Properties
int DKScreen::availTop(duk_context* ctx){
	//TODO
	return false;
}

int DKScreen::availLeft(duk_context* ctx){
	//TODO
	return false;
}

int DKScreen::availHeight(duk_context* ctx){
	//TODO
	return false;
}

int DKScreen::availWidth(duk_context* ctx){
	//TODO
	return false;
}

int DKScreen::colorDepth(duk_context* ctx){
	//TODO
	return false;
}

int DKScreen::height(duk_context* ctx){
	int height;
	if(!DKUtil::GetScreenHeight(height)){ return 0; }
	duk_push_number(ctx, height);
	return 1;
}

int DKScreen::left(duk_context* ctx){
	//TODO
	return false;
}

int DKScreen::orientation(duk_context* ctx){
	//TODO
	return false;
}

int DKScreen::pixelDepth(duk_context* ctx){
	//TODO
	return false;
}

int DKScreen::top(duk_context* ctx){
	//TODO
	return false;
}

int DKScreen::width(duk_context* ctx){
	int width;
	if(!DKUtil::GetScreenWidth(width)) { return 0; }
	duk_push_number(ctx, width);
	return 1;
}

int DKScreen::mozEnabled(duk_context* ctx){
	//TODO
	return false;
}

int DKScreen::mozBrightness(duk_context* ctx){
	//TODO
	return false;
}



//Methods
int DKScreen::lockOrientation(duk_context* ctx) {
	//TODO - https://developer.mozilla.org/en-US/docs/Web/API/Screen/lockOrientation
	DKString orientation = duk_require_string(ctx, 0);
	return false;
}

int DKScreen::unlockOrientation(duk_context* ctx){
	//TODO - https://developer.mozilla.org/en-US/docs/Web/API/Screen/unlockOrientation
	return false;
}

#endif //USE_DKDuktape