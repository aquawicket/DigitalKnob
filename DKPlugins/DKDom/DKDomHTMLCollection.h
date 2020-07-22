//https://developer.mozilla.org/en-US/docs/Web/API/HTMLCollection

#pragma once
#ifndef DKDomHTMLCollection_H
#define DKDomHTMLCollection_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////////////////////////////
class DKDomHTMLCollection : public DKObjectT<DKDomHTMLCollection>
{
public:
	bool Init();
	
};


REGISTER_OBJECT(DKDomHTMLCollection, true)

#endif //DKDomHTMLCollection_H