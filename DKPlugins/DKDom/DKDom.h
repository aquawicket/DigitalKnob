#pragma once
#ifndef DKDom_H
#define DKDom_H

#include "DK/DK.h"
#include "duktape-1.5.0/src/duktape.h"

/////////////////////////////////////
class DKDom : public DKObjectT<DKDom>
{
public:
	void Init();
	void End();
};

///////////////////
class ElementObject
{
public:
	ElementObject();
	static DKString property;
	static int duk_getter(duk_context *ctx);
	static int duk_method(duk_context *ctx);
	static int duk_setter(duk_context *ctx);
};


REGISTER_OBJECT(DKDom, true);

#endif //DKDom_H

