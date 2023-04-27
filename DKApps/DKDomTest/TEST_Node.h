// [IDL] https://dom.spec.whatwg.org/#interface-node
// [MDN] https://developer.mozilla.org/en-US/docs/Web/API/Node
#pragma once
#ifndef TEST_Node_H
#define TEST_Node_H

#include "DK/DK.h"
#include "DKNode/DKNode.h"


class TEST_Node : public DKObjectT<TEST_Node>
{
public:
	bool Init(){
		DKINFO("////// TEST_Node.h ////// \n");
		return DKTODO();
	}

};
REGISTER_OBJECT(TEST_Node, true);


#endif //TEST_Node_H