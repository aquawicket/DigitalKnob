#ifdef USE_DKDuktape 
#pragma once
#ifndef DKDomHTMLElement_H
#define DKDomHTMLElement_H

#include "DKDuktape/DKDuktape.h"

///////////////////////////////////////////////////////////
class DKDomHTMLElement : public DKObjectT<DKDomHTMLElement>
{
public:
	bool Init();
};


REGISTER_OBJECT(DKDomHTMLElement, true)

#endif //DKDomHTMLElement_H
#endif //USE_DKDuktape