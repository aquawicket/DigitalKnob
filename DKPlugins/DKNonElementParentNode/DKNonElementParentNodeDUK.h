// [IDL] https://dom.spec.whatwg.org/#interface-nonelementparentnode
#if HAVE_DKDuktape

#pragma once
#ifndef DKNonElementParentNodeDUK_H
#define DKNonElementParentNodeDUK_H

#include "DKDuktape/DKDuktape.h"

// Source: DOM Standard (https://dom.spec.whatwg.org/)
// interface mixin NonElementParentNode {
class DKNonElementParentNodeDUK : public DKObjectT<DKNonElementParentNodeDUK>
{
public:
	bool Init(){
		
		// TODO
		
		DKClass::DKCreate("DKNonElementParentNode/DKNonElementParentNodeDUK.js");
		
		return true;
	}
};
REGISTER_OBJECT(DKNonElementParentNodeDUK, true)

#endif //DKNonElementParentNodeDUK_H
#endif //HAVE_DKDuktape