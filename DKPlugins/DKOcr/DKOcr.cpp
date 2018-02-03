#include "DK/stdafx.h"
#include "DKOcr/DKOcr.h"
#include "DK/DKFile.h"
#include "src/allheaders.h"

tesseract::TessBaseAPI* DKOcr::api;

//////////////////
bool DKOcr::Init()
{
	DKCreate("DKOcrJS");
	DKCreate("DKOcrV8");
	
	api = new tesseract::TessBaseAPI();
	DKString datapath = DKFile::local_assets+"DKOcr";
	if (api->Init(datapath.c_str(), "eng")){ // Initialize tesseract-ocr with English
		DKLog("Could not initialize tesseract.\n", DKERROR);
		return false;
	}
	return true;
}

/////////////////
bool DKOcr::End()
{
	api->End();
	return true;
}

///////////////////////////////////////////////////////
bool DKOcr::ImageToText(DKString& file, DKString& text)
{
	if(!DKFile::PathExists(file)){ return false; }
	char* outText;
	Pix *image = pixRead(file.c_str());
	api->SetImage(image);
	outText = api->GetUTF8Text();
	if(!outText){ 
		DKLog("DKOcr::ImageToText(): outText invalid.\n",DKERROR);	
		return false; 
	}
	text = outText;
	DKLog("OCR output:\n"+text+"\n", DKINFO);
	delete [] outText;
	pixDestroy(&image);
	return true;
}