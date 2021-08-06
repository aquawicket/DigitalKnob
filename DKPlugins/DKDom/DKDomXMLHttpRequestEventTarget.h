#pragma once
#ifndef DKDomXMLHttpRequestEventTarget_H
#define DKDomXMLHttpRequestEventTarget_H

#include "DKDuktape/DKDuktape.h"

class DKDomXMLHttpRequestEventTarget : public DKObjectT<DKDomXMLHttpRequestEventTarget>
{
public:
	bool Init();

};


REGISTER_OBJECT(DKDomXMLHttpRequestEventTarget, true)

#endif //DKDomXMLHttpRequestEventTarget_H