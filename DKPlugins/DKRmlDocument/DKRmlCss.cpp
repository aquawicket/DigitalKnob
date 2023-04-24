/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/
#include "DK/stdafx.h"
#include "DK/DKFile.h"
#include "DKRmlDocument/DKRmlCss.h"

WARNING_DISABLE
#include "RmlUi/Core/Factory.h"
WARNING_ENABLE


DKRmlDocument* DKRmlCss::dkRmlDocument;

bool DKRmlCss::Init(){
	DKDEBUGFUNC();
	dkRmlDocument = DKRmlDocument::Get();
	if(!dkRmlDocument)
		return DKERROR("dkRmlDocument invalid\n");
	//data = ("DKRmlCss", file)
	if(data.size() < 2){
		DKString _data = toString(data, ",");
		return DKERROR("data is missing parameters: data:("+_data+")\n");
	}
	if(data.size() > 2){
		DKString _data = toString(data, ",");
		return DKERROR("data has too many parameters: data:("+_data+")\n");
	}
	DKString file = data[1];
	if(!DKFile::VerifyPath(file))
		return DKERROR("could not find css file\n");	

	//Load user agent style sheet
	const Rml::StyleSheetContainer* doc_sheet = dkRmlDocument->document->GetOwnerDocument()->GetStyleSheetContainer();
	Rml::SharedPtr<Rml::StyleSheetContainer> file_sheet = Rml::Factory::InstanceStyleSheetFile(file.c_str());
	if (doc_sheet) { //Combine the file_sheet to the current sheet
		Rml::SharedPtr<Rml::StyleSheetContainer> new_sheet = doc_sheet->CombineStyleSheetContainer(*file_sheet);
		dkRmlDocument->document->GetOwnerDocument()->SetStyleSheetContainer(std::move(new_sheet));
	}
	else //no current sheet, just load the file sheet
		dkRmlDocument->document->GetOwnerDocument()->SetStyleSheetContainer(std::move(file_sheet));
	return true;
}

bool DKRmlCss::End(){
	DKDEBUGFUNC();
	return true;
}
