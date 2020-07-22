//https://developer.mozilla.org/en-US/docs/Web/API/Node

#pragma once
#ifndef DKDomNode_H
#define DKDomNode_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////////
class DKDomNode : public DKObjectT<DKDomNode>
{
public:
	bool Init();
	
	static int appendChild(duk_context* ctx);
	static int childNodes(duk_context* ctx);
	static int firstChild(duk_context* ctx);
	static int lastChild(duk_context* ctx);
	static int parentNode(duk_context* ctx);
	static int removeChild(duk_context* ctx);
};


REGISTER_OBJECT(DKDomNode, true)

#endif //DKDomNode_H