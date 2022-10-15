/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2022 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright noticeand this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

#include "DK/stdafx.h"
#include "DKOcr/DKOcr.h"
#include "DK/DKFile.h"
#include "DKAssets/DKAssets.h"
#include "src/allheaders.h"

tesseract::TessBaseAPI* DKOcr::api;

bool DKOcr::Init(){
	DKDEBUGFUNC();
	DKClass::DKCreate("DKOcrJS");
	DKClass::DKCreate("DKOcrV8");
	api = new tesseract::TessBaseAPI();
	DKString datapath = DKFile::local_assets+"DKOcr";
	if (api->Init(datapath.c_str(), "eng")) // Initialize tesseract-ocr with English
		return DKERROR("Could not initialize tesseract\n");
	return true;
}

bool DKOcr::End(){
	DKDEBUGFUNC();
	//DKClass::DKCreate("DKOcrJS");
	//DKClass::DKCreate("DKOcrV8");
	api->End();
	return true;
}

/*
bool DKOcr::AddTextElement(double dCurPosX, double dCurPosY, PoDoFo::PdfFont* pCurFont, const PoDoFo::PdfString & rString){
	DKDEBUGFUNC(dCurPosX, dCurPosY, pCurFont, rString);
	if(!pCurFont){
		fprintf(stderr, "WARNING: Found text but do not have a current font: %s\n", rString.GetString());
		return false;
	}
	if(!pCurFont->GetEncoding()){
		fprintf(stderr, "WARNING: Found text but do not have a current encoding: %s\n", rString.GetString());
		return false;
	}
	// For now just write to console
	PoDoFo::PdfString unicode = pCurFont->GetEncoding()->ConvertToUnicode(rString, pCurFont);
	const char* pszData = unicode.GetStringUtf8().c_str();
	while(*pszData){
		//printf("%02x", static_cast<unsigned char>(*pszData) );
		++pszData;
	}
	printf("(%.3f,%.3f) %s \n", dCurPosX, dCurPosY, unicode.GetStringUtf8().c_str());
	return true;
}

bool DKOcr::ExtractPdfText(PoDoFo::PdfMemDocument* pDocument, PoDoFo::PdfPage* pPage){
	DKDEBUGFUNC(pDocument, pPage);
	const char* pszToken = NULL;
	PoDoFo::PdfVariant var;
	PoDoFo::EPdfContentsType eType;
	PoDoFo::PdfContentsTokenizer tokenizer(pPage);
	double dCurPosX = 0.0;
	double dCurPosY = 0.0;
	bool bTextBlock = false;
	PoDoFo::PdfFont* pCurFont = NULL;
	std::stack<PoDoFo::PdfVariant> stack;
	while(tokenizer.ReadNext(eType, pszToken, var)){
		if(eType == PoDoFo::ePdfContentsType_Keyword){
			// support 'l' and 'm' tokens
			if(strcmp(pszToken, "l") == 0 || strcmp(pszToken, "m") == 0){
				dCurPosX = stack.top().GetReal();
				stack.pop();
				dCurPosY = stack.top().GetReal();
				stack.pop();
			}
			else if(strcmp( pszToken, "BT") == 0 ){
				bTextBlock   = true;     
				//BT does not reset font
				//pCurFont     = NULL;
			}
			else if(strcmp( pszToken, "ET") == 0){
				if(!bTextBlock) 
					fprintf(stderr, "WARNING: Found ET without BT!\n");
			}
			if(bTextBlock){
				if(strcmp(pszToken, "Tf") == 0){
					stack.pop();
					PoDoFo::PdfName fontName = stack.top().GetName();
					PoDoFo::PdfObject* pFont = pPage->GetFromResources(PoDoFo::PdfName("Font"), fontName);
					if(!pFont){
						//PoDoFo::PODOFO_RAISE_ERROR_INFO( ePdfError_InvalidHandle, "Cannot create font!" );
						DKWARN("DKOcr::ExtractPdfText(): Cannot create font\n");
						return false;
					}
					pCurFont = pDocument->GetFont(pFont);
					if(!pCurFont){
						fprintf(stderr, "WARNING: Unable to create font for object %i %i R\n",
							pFont->Reference().ObjectNumber(),
							pFont->Reference().GenerationNumber());
					}
				}
				else if(strcmp(pszToken, "Tj") == 0 || strcmp( pszToken, "'") == 0){
					AddTextElement(dCurPosX, dCurPosY, pCurFont, stack.top().GetString());
					stack.pop();
				}
				else if(strcmp(pszToken, "\"") == 0){
					AddTextElement(dCurPosX, dCurPosY, pCurFont, stack.top().GetString());
					stack.pop();
					stack.pop(); // remove char spacing from stack
					stack.pop(); // remove word spacing from stack
				}
				else if(strcmp( pszToken, "TJ") == 0){
					PoDoFo::PdfArray array = stack.top().GetArray();
					stack.pop();
					for(int i=0; i<static_cast<int>(array.GetSize()); i++){
						if(array[i].IsString() || array[i].IsHexString())
							AddTextElement(dCurPosX, dCurPosY, pCurFont, array[i].GetString());
					}
				}
			}
		}
		else if (eType == PoDoFo::ePdfContentsType_Variant){
			stack.push(var);
		}
		else{
			// Impossible; type must be keyword or variant
			//PODOFO_RAISE_ERROR(ePdfError_InternalLogic);
			DKWARN("DKOcr::ExtractPdfText(): type must be keyword or variant\n");
		}
	}
	return true;
}
*/

bool DKOcr::ImageToText(DKString& file, DKString& text){
	DKDEBUGFUNC(file, text);
	DKString _file = file;
	if(has(file,".pdf")){
		if(!PdfToText(file, text))
			return DKERROR("PdfToText() failed \n");
		_file = DKFile::local_assets+"temp.png";
	}
	if(!DKFile::PathExists(_file))
		return DKERROR("_file does not exist \n");
	char* outText;
	Pix *image = pixRead(_file.c_str());
	api->SetImage(image);
	outText = api->GetUTF8Text();
	if(!outText)
		return DKERROR("outText invalid \n");	
	text = outText;
	DKINFO("OCR output:\n"+text+"\n");
	delete [] outText;
	pixDestroy(&image);
	return true;
}

bool DKOcr::PdfToText(DKString& file, DKString& text){
	DKDEBUGFUNC(file, text);
	//convert using PoDoFo
	/*
	PoDoFo::PdfMemDocument document(file.c_str());
	int nCount = document.GetPageCount();
	for(int i=0; i<nCount; i++){
		PoDoFo::PdfPage* pPage = document.GetPage(i);
		ExtractPdfText(&document, pPage);
	}
	*/
	//convert using ImageMagick
	//convert -density 300 a.pdf -resize 25% a.png
	DKString assets = DKFile::local_assets;
	DKString infile;
	DKFile::GetShortName(file, infile);
	DKUtil::System(assets+"/DKImageMagick/magick.exe convert -verbose -density 300 -trim \""+infile+"\" -quality 100 \""+assets+"/temp.png\"");
	return true;
}
