// [IDL] https://dom.spec.whatwg.org/#interface-document
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Document
#pragma once
#ifndef TEST_Document_H
#define TEST_Document_H

#include "DKDocument/DKDocument.h"


class TEST_Document : public DKObjectT<TEST_Document>
{
public:
	bool Init(){
		DKDEBUGFUNC();
		DKINFO("\n////// TEST_Document.h //////\n");
		
		DKDocument document;
		printDocumentProperties(document);
		return true;
	}
	
	static void printDocumentProperties(DKDocument& document){
		DKDEBUGFUNC(document);
		DKTODO();
	}
};
REGISTER_OBJECT(TEST_Document, true);


#endif //TEST_Document_H