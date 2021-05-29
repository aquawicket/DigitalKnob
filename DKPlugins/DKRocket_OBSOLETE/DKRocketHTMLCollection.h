#ifdef USE_DKDuktape 
#pragma once
#ifndef DKRocketHTMLCollection_H
#define DKRocketHTMLCollection_H

#include "DKDuktape/DKDuktape.h"

///////////////////////////////////////////////////////////////////////
class DKRocketHTMLCollection : public DKObjectT<DKRocketHTMLCollection>
{
public:
	bool Init();
	
};


REGISTER_OBJECT(DKRocketHTMLCollection, true)

#endif //DKRocketHTMLCollection_H
#endif //USE_DKDuktape