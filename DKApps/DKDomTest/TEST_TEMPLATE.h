// [IDL]
// [MDN]
#pragma once
#ifndef TEST_TEMPLATE_H
#define TEST_TEMPLATE_H

//#include "DKTemplate/DKTemplate.h"


class TEST_TEMPLATE : public DKObjectT<TEST_TEMPLATE>
{
public:
	bool Init(){
		DKINFO("////// TEST_TEMPLATE.h ////// \n");
		
		////// Instance properties //////
		// etc . . .
		
		return DKTODO();
	}
	
};
REGISTER_OBJECT(TEST_TEMPLATE, true);


#endif //TEST_TEMPLATE_H