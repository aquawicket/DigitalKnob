#pragma once
#ifndef DKImageMagick_H
#define DKImageMagick_H

#include "DK/DK.h"

/////////////////////////////////////////////////////
class DKImageMagick : public DKObjectT<DKImageMagick>
{
public:
	bool Init();
	bool End();
	
	static bool PdfToBmp(DKString& filein, DKString& fileout);
	static bool PdfToPng(DKString& filein, DKString& fileout);
};


REGISTER_OBJECT(DKImageMagick, true);

#endif //DKImageMagick_H

