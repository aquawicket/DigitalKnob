#ifdef USE_DKDuktape 
#pragma once
#ifndef DKHTMLElement_H
#define DKHTMLElement_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////////////////
class DKHTMLElement : public DKObjectT<DKHTMLElement>
{
public:
	bool Init();
	
};


REGISTER_OBJECT(DKHTMLElement, true)

#endif //DKHTMLElement_H
#endif //USE_DKDuktape