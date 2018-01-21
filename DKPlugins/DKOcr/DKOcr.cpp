#include "DK/stdafx.h"
#include "DKOcr/DKOcr.h"
#include "DK/DKFile.h"
#include "src/allheaders.h"

tesseract::TessBaseAPI* DKOcr::api;

//////////////////
void DKOcr::Init()
{
	DKCreate("DKMidiJS");
	DKCreate("DKMidiV8");
	
	api = new tesseract::TessBaseAPI();
	DKString datapath = DKFile::local_assets+"DKOcr";
	if (api->Init(datapath.c_str(), "eng")){ // Initialize tesseract-ocr with English
		DKLog("Could not initialize tesseract.\n", DKERROR);
		return;
	}
}

/////////////////
void DKOcr::End()
{
	api->End();
}

///////////////////////////////////////////////////////
bool DKOcr::ImageToText(DKString& file, DKString& text)
{
	char* outText;
	Pix *image = pixRead(file.c_str());
	api->SetImage(image);
	outText = api->GetUTF8Text();
	text = outText;
	DKLog("OCR output:\n"+text+"\n", DKINFO);
	delete [] outText;
	pixDestroy(&image);
	return true;
}