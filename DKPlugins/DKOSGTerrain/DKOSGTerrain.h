#pragma once
#ifndef DKOSGTerrain_H
#define DKOSGTerrain_H
#include "DK.h"

#include <osg/Node>

class DKOSGTerrain : public DKObjectT<DKOSGTerrain>  
{
public:
	void Init();
	void End();

private:
	osg::Node* createBase(const osg::Vec3& center,float radius);
	osg::ref_ptr<osg::Node> terrain;
};

REGISTER_OBJECT(DKOSGTerrain, true);
#endif //DKOSGTerrain_H
