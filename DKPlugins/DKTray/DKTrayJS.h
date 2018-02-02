#ifdef USE_DKDuktape 
#pragma once
#ifndef DKTrayJS_H
#define DKTrayJS_H

#include "DKDuktape/DKDuktape.h"

///////////////////////////////////////////
class DKTrayJS : public DKObjectT<DKTrayJS>
{
public:
	bool Init();
	
	static int AddItem(duk_context* ctx);
	static int GetIcon(duk_context* ctx);
	static int SetIcon(duk_context* ctx);
	static int SetTooltip(duk_context* ctx);
	static int ShowBalloon(duk_context* ctx);
	//static int Animate(duk_context* ctx); //TODO
	//static int GetMenuDefaultItem(duk_context* ctx); //TODO
	//static int GetTooltip(duk_context* ctx); // TODO
	//static int HideIcon(duk_context* ctx); //TODO
	//static int SetIconList(duk_context* ctx); //TODO
	//static int SetMenuDefaultItem(duk_context* ctx); //TODO
	//static int ShowIcon(duk_context* ctx); //TODO
	//static int StopAnimation(duk_context* ctx); //TODO
};

REGISTER_OBJECT(DKTrayJS, true)

#endif //DKTrayJS_H
#endif //USE_DKDuktape