#pragma once
#ifndef TEST_Document_H
#define TEST_Document_H

#include "DK/DK.h"
#include "DKDocument/DKDocument.h"


class TEST_Document : public DKObjectT<TEST_Document>
{
public:
	bool Init(){
		return DKTODO();
	}
	
	bool End(){
		return DKTODO();
	}

};
REGISTER_OBJECT(TEST_Document, true);


#endif //TEST_Document_H