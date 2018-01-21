#include "DK/stdafx.h"
#include "DKOcr/DKOcr.h"
#include "DK/DKFile.h"
#include "api/baseapi.h"
#include "src/allheaders.h"

//////////////////
void DKOcr::Init()
{
	char* outText;
	tesseract::TessBaseAPI *api = new tesseract::TessBaseAPI();
	DKString datapath = DKFile::local_assets+"DKOcr";
	if (api->Init(datapath.c_str(), "eng")){ // Initialize tesseract-ocr with English
		DKLog("Could not initialize tesseract.\n", DKERROR);
		return;
	}

	// Open input image with leptonica library
	DKString file = DKFile::local_assets+"DKOcr/test.tif";
	Pix *image = pixRead(file.c_str());
	api->SetImage(image);
	// Get OCR result
	outText = api->GetUTF8Text();
	DKLog("OCR output:\n"+toString(outText)+"\n", DKINFO);

	// Destroy used object and release memory
	api->End();
	delete [] outText;
	pixDestroy(&image);
}

/////////////////
void DKOcr::End()
{

}