//https://developer.mozilla.org/en-US/docs/Web/API/HTMLSpanElement

#pragma once
#ifndef DKDomHTMLSpanElement_H
#define DKDomHTMLSpanElement_H

#include "DKDuktape/DKDuktape.h"


class DKDomHTMLSpanElement : public DKObjectT<DKDomHTMLSpanElement>
{
public:
	bool Init();
};

REGISTER_OBJECT(DKDomHTMLSpanElement, true)

#endif //DKDomHTMLSpanElement_H