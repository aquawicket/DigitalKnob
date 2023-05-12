// [IDL] htps://???
// [MDN] htps://???
#pragma once
#ifndef TEST_TEMPLATE_H
#define TEST_TEMPLATE_H

//#include "DKTEMPLATE/DKTEMPLATE.h"


class TEST_TEMPLATE : public DKObjectT<TEST_TEMPLATE>
{
public:
	bool Init(){
		DKINFO("////// TEST_TEMPLATE.h ////// \n");
		
		return DKTODO();
	}
	
};
REGISTER_OBJECT(TEST_TEMPLATE, true);


#endif //TEST_TEMPLATE_H