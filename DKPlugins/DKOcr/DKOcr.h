#pragma once
#ifndef DKOcr_H
#define DKOcr_H

#include "api/baseapi.h"  //tesseract
#include "podofo.h"       //podofo
#include "DK/DK.h"

//////////////////////////////////////
class DKOcr : public DKObjectT<DKOcr>
{
public:
	bool Init();
	bool End();
	static bool ImageToText(DKString& file, DKString& text);

	static bool PdfToText(DKString& file, DKString& text);
	static void ExtractPdfText(PoDoFo::PdfMemDocument* pDocument, PoDoFo::PdfPage* pPage);
	static void AddTextElement(double dCurPosX, double dCurPosY, PoDoFo::PdfFont* pCurFont, const PoDoFo::PdfString & rString);

	static tesseract::TessBaseAPI* api;
};


REGISTER_OBJECT(DKOcr, true);

#endif //DKOcr_H

