#pragma once
#ifndef DKOSGLights_H
#define DKOSGLights_H
#include "DK.h"

#include <osg/Node>

///////////////////////////////////////////
class DKOSGLights : public DKObjectT<DKOSGLights>
{
public:
	bool Init();

private:
	osg::Node* createLights();
};


REGISTER_OBJECT(DKOSGLights, true);

#endif //DKOSGLights_H
