#pragma once
#ifndef TEST_DKRmlDocument_H
#define TEST_DKRmlDocument_H

#include "DK/DK.h"
//#include "DKRmlDocument/DKRmlDocument.h"	// TODO


class TEST_DKRmlDocument : public DKObjectT<TEST_DKRmlDocument>
{
public:
	bool Init(){
		DKINFO("////// TEST_DKRmlDocument.h ////// \n");
		return DKTODO();
	}

};
REGISTER_OBJECT(TEST_DKRmlDocument, true);


#endif //TEST_DKRmlDocument_H