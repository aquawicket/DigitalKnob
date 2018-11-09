#ifdef USE_DKDuktape 
#pragma once
#ifndef DKNode_H
#define DKNode_H

#include "DKDuktape/DKDuktape.h"

///////////////////////////////////////
class DKNode : public DKObjectT<DKNode>
{
public:
	bool Init();
	
	static int appendChild(duk_context* ctx);
	static int childNodes(duk_context* ctx);
	static int removeChild(duk_context* ctx);
};


REGISTER_OBJECT(DKNode, true)

#endif //DKNode_H
#endif //USE_DKDuktape