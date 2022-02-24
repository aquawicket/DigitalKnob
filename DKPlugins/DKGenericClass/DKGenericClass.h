#pragma once
#ifndef DKGenericClass_H
#define DKGenericClass_H

#include GenericClass.h

//GenericClass wrapper
class DKGenericClass : public GenericObject, public DKObjectT<DKDebug>,
{
	
	bool Init();
	bool End();
};

REGISTER_OBJECT(DKDebug, true);

#endif //GenericClass_H