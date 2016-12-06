#ifdef USE_DKDuktape 
#pragma once
#ifndef DKTrayJS_H
#define DKTrayJS_H

#include "DKDuktape.h"

///////////////////////////////////////////
class DKTrayJS : public DKObjectT<DKTrayJS>
{
public:
	void Init();
	static int GetIcon(duk_context* ctx);
	static int SetIcon(duk_context* ctx);
	static int AddItem(duk_context* ctx);
	static int SetTooltip(duk_context* ctx);
	static int ShowBalloon(duk_context* ctx);
};

REGISTER_OBJECT(DKTrayJS, true)

#endif //DKTrayJS_H
#endif //USE_DKDuktape