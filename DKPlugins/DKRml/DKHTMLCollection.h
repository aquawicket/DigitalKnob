#ifdef USE_DKDuktape 
#pragma once
#ifndef DKHTMLCollection_H
#define DKHTMLCollection_H

#include "DKDuktape/DKDuktape.h"

///////////////////////////////////////////////////////////
class DKHTMLCollection : public DKObjectT<DKHTMLCollection>
{
public:
	bool Init();
	
};


REGISTER_OBJECT(DKHTMLCollection, true)

#endif //DKHTMLCollection_H
#endif //USE_DKDuktape