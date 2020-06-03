#ifdef USE_DKDuktape 
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
	static int parentNode(duk_context* ctx);
	static int removeChild(duk_context* ctx);
};


REGISTER_OBJECT(DKDomNode, true)

#endif //DKDomNode_H
#endif //USE_DKDuktape