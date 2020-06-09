#ifdef USE_DKDuktape 
#pragma once
#ifndef DKDomDocumentOrShadowRootOrShadowRoot_H
#define DKDomDocumentOrShadowRoot_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////////////////////////////////////////
class DKDomDocumentOrShadowRoot : public DKObjectT<DKDomDocumentOrShadowRoot>
{
public:
	bool Init();
	
	static int activeElement(duk_context* ctx);
	static int caretPositionFromPoint(duk_context* ctx);
	static int elementFromPoint(duk_context* ctx);
};


REGISTER_OBJECT(DKDomDocumentOrShadowRoot, true)

#endif //DKDomDocumentOrShadowRoot_H
#endif //USE_DKDuktape