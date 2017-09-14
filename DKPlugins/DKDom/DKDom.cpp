#include "DK/stdafx.h"
#include "DKDom/DKDom.h"
#include "DKDuktape/DKDuktape.h"

DKString ElementObject::property;

///////////////////
void DKDom::Init()
{
	
}

/////////////////
void DKDom::End()
{

}

ElementObject::ElementObject()
{
	duk_push_string(DKDuktape::ctx, "Property");
	duk_push_c_function(DKDuktape::ctx, ElementObject::duk_getter, 0 /*nargs*/);
	duk_push_c_function(DKDuktape::ctx, ElementObject::duk_setter, 1 /*nargs*/);
	duk_def_prop(DKDuktape::ctx, -4, DUK_DEFPROP_HAVE_GETTER | DUK_DEFPROP_HAVE_SETTER);
	duk_push_c_function(DKDuktape::ctx, ElementObject::duk_method, 0 /*nargs*/);
	duk_put_prop_string(DKDuktape::ctx, -2, "Method");
}

int ElementObject::duk_method(duk_context *ctx) {
	//MethodToBind();
	return 0; //no args and no return value, no need to act on JS stack
}

int ElementObject::duk_setter(duk_context *ctx) {
	property = toString(duk_get_string(ctx, 0)); //first arg to String
	return 0;
}

duk_ret_t ElementObject::duk_getter(duk_context *ctx) {
	duk_push_string(ctx, property.c_str());
	return 1; //we pushed one return value
}
