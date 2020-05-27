#ifdef USE_DKDuktape 
#pragma once
#ifndef DKRocketNode_H
#define DKRocketNode_H

#include "DKDuktape/DKDuktape.h"

///////////////////////////////////////////////////
class DKRocketNode : public DKObjectT<DKRocketNode>
{
public:
	bool Init();
	
	static int appendChild(duk_context* ctx);
	static int childNodes(duk_context* ctx);
	static int parentNode(duk_context* ctx);
	static int removeChild(duk_context* ctx);
};


REGISTER_OBJECT(DKRocketNode, true)

#endif //DKRocketNode_H
#endif //USE_DKDuktape