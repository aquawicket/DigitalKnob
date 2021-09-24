#pragma once
#ifndef DKCss_H
#define DKCss_H
#include "DK/DK.h"
#include "DKRml/DKRml.h"

class DKCss : public DKObjectT<DKCss>
{
public:
	bool Init();
	bool End();

	static DKRml* dkRml;
};


REGISTER_OBJECT(DKCss, false);

#endif //DKCss_H
