#ifdef USE_DKDuktape 
#pragma once
#ifndef DKRocketHTMLElement_H
#define DKRocketHTMLElement_H

#include "DKDuktape/DKDuktape.h"

/////////////////////////////////////////////////////////////////
class DKRocketHTMLElement : public DKObjectT<DKRocketHTMLElement>
{
public:
	bool Init();
	
};


REGISTER_OBJECT(DKRocketHTMLElement, true)

#endif //DKRocketHTMLElement_H
#endif //USE_DKDuktape