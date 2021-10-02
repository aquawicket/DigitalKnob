//https://developer.mozilla.org/en-US/docs/Web/API/HTMLImageElement

#pragma once
#ifndef DKDomHTMLImageElement_H
#define DKDomHTMLImageElement_H

#include "DKDuktape/DKDuktape.h"


class DKDomHTMLImageElement : public DKObjectT<DKDomHTMLImageElement>
{
public:
	bool Init();
};

REGISTER_OBJECT(DKDomHTMLImageElement, true)

#endif //DKDomHTMLImageElement_H