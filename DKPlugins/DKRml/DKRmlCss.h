#pragma once
#ifndef DKRmlCss_H
#define DKRmlCss_H
#include "DK/DK.h"
#include "DKRml/DKRml.h"

class DKRmlCss : public DKObjectT<DKRmlCss>
{
public:
	bool Init();
	bool End();
	static DKRml* dkRml;
};

REGISTER_OBJECT(DKRmlCss, false)
#endif //DKRmlCss_H
