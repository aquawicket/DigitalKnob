#include "DK/stdafx.h"
#include "DKDom/DKDom.h"
#include "DKDuktape/DKDuktape.h"

#include "DKRocket/DKRocket.h"

DKString ElementObject::property;

//////////////////
bool DKDom::Init()
{
	DKClass::DKCreate("DKDomJS");
	return true;
}

/////////////////
bool DKDom::End()
{
	return true;
}

//////////////////
bool DKDom::Test()
{
	DKDebug();
	//TODO
	DKRocket::Get(); //access to rocket
	DKString code;
	code = "var target = { foo: 'bar' };"; // Underlying plain object.
	// Handler table, provides traps for interaction (can be modified on-the-fly).
	code += "var handler = {";
	code += "has: function (targ, key) {";
	code += "DKLog('has called for key=' + key);";
	code += "return key in targ;";  // return unmodified existence status
	code += "},";
	code += "get: function (targ, key, recv) {";
	code += "DKLog('get called for key=' + key);";
	code += "return targ[key];";  // return unmodified value
	code += "},";
	code += "set: function (targ, key, val, recv) {";
	code += "DKLog('set called for key=' + key + ', val=' + val);";
	code += "targ[key] = val;";  // must perform write to target manually if 'set' defined
	code += "return true;";     // true: indicate that property write was allowed
	code += "},";
	code += "deleteProperty: function (targ, key) {";
	code += "DKLog('deleteProperty called for key=' + key);";
	code += "delete targ[key];";  // must perform delete to target manually if 'deleteProperty' defined
	code += "return true;";       // true: indicate that property delete was allowed
	code += "}";
	code += "};";

	code += "var proxy = new Proxy(target, handler);"; // Create proxy object.

	// Proxy object is then accessed normally.
	code += "DKLog('foo' in proxy);";
	//code += "proxy.foo = 321;";
	//code += "DKLog(proxy.foo);";
	//code += "delete proxy.foo;";

	DKDuktape::Get()->RunDuktape(code);

	return false;
}

//////////////////////////////
ElementObject::ElementObject()
{
	duk_push_string(DKDuktape::ctx, "Property");
	duk_push_c_function(DKDuktape::ctx, ElementObject::duk_getter, 0 /*nargs*/);
	duk_push_c_function(DKDuktape::ctx, ElementObject::duk_setter, 1 /*nargs*/);
	duk_def_prop(DKDuktape::ctx, -4, DUK_DEFPROP_HAVE_GETTER | DUK_DEFPROP_HAVE_SETTER);
	duk_push_c_function(DKDuktape::ctx, ElementObject::duk_method, 0 /*nargs*/);
	duk_put_prop_string(DKDuktape::ctx, -2, "Method");
}

///////////////////////////////////////////////
int ElementObject::duk_method(duk_context *ctx)
{
	//MethodToBind();
	return 0; //no args and no return value, no need to act on JS stack
}

///////////////////////////////////////////////
int ElementObject::duk_setter(duk_context *ctx)
{
	property = toString(duk_get_string(ctx, 0)); //first arg to String
	return 0;
}

/////////////////////////////////////////////////////
duk_ret_t ElementObject::duk_getter(duk_context *ctx)
{
	duk_push_string(ctx, property.c_str());
	return 1; //we pushed one return value
}