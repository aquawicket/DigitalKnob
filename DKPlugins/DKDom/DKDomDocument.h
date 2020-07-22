// https://developer.mozilla.org/en-US/docs/Web/API/Document

#pragma once
#ifndef DKDomDocument_H
#define DKDomDocument_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////////////////
class DKDomDocument : public DKObjectT<DKDomDocument>
{
public:
	bool Init();
	
	static int body(duk_context* ctx);
	static int createElement(duk_context* ctx);
	static int documentElement(duk_context* ctx);
	static int getElementById(duk_context* ctx);
	static int getElementsByTagName(duk_context* ctx);
};


REGISTER_OBJECT(DKDomDocument, true)

#endif //DKDomDocument_H