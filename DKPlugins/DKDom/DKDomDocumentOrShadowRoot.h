// https://developer.mozilla.org/en-US/docs/Web/API/DocumentOrShadowRoot
// https://javascript.info/mixins

#pragma once
#ifndef DKDomDocumentOrShadowRootOrShadowRoot_H
#define DKDomDocumentOrShadowRoot_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////////////////////////////////////////
class DKDomDocumentOrShadowRoot : public DKObjectT<DKDomDocumentOrShadowRoot>
{
public:
	bool Init();
	
	// Properties
	static int activeElement(duk_context* ctx);
	static int fullscreenElement(duk_context* ctx);
	static int pictureInPictureElement(duk_context* ctx);
	static int pointerLockElement(duk_context* ctx);
	static int styleSheets(duk_context* ctx);
	
	// Methods
	static int caretPositionFromPoint(duk_context* ctx);
	static int elementFromPoint(duk_context* ctx);
	static int elementsFromPoint(duk_context* ctx);
	static int getSelection(duk_context* ctx);
	static int nodeFromPoint(duk_context* ctx);
	static int nodesFromPoint(duk_context* ctx);
};


REGISTER_OBJECT(DKDomDocumentOrShadowRoot, true)

#endif //DKDomDocumentOrShadowRoot_H