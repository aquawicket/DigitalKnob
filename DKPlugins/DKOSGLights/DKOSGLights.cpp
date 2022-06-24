#include "DK/stdafx.h"
#include "DKOSGLights.h"
#include "DKOSGWindow.h"
#include <osg/Point>


////////////////////////
bool DKOSGLights::Init()
{
	osg::Light* pLight = new osg::Light;
    pLight->setLightNum( 4 );                        
	pLight->setPosition(osg::Vec4(1.0f,0.0f,1.0f,1.0f));  // last param    w = 0.0 directional light (direction) w = 1.0 point light (position)
    pLight->setAmbient(osg::Vec4(1.0f,1.0f,1.0f,1.0f));
    pLight->setDiffuse(osg::Vec4(1.0f,1.0f,1.0f,1.0f));
    pLight->setSpotCutoff(20.0f);
    pLight->setSpotExponent(50.0f);
    pLight->setDirection(osg::Vec3(1.0f,1.0f,-1.0f));
	//               
    // light source
    osg::LightSource* pLightSource = new osg::LightSource;    
    pLightSource->setLight( pLight );
    DKOSGWindow::Instance("DKOSGWindow")->world->addChild( pLightSource );

	DKOSGWindow::Instance("DKOSGWindow")->world->getOrCreateStateSet()->setMode( GL_LIGHT4, osg::StateAttribute::ON );
	return true;
}

///////////////////////////////////
osg::Node* DKOSGLights::createLights()
{
	osg::StateSet* rootStateSet = new osg::StateSet;
    DKOSGWindow::Instance("DKOSGWindow")->world->setStateSet(rootStateSet);

    osg::Group* lightGroup = new osg::Group;

	// create a spot light.
    osg::Light* myLight1 = new osg::Light;
    myLight1->setLightNum(0);
    myLight1->setPosition(osg::Vec4(1.0f,0.0f,1.0f,1.0f));
    myLight1->setAmbient(osg::Vec4(1.0f,1.0f,1.0f,1.0f));
    myLight1->setDiffuse(osg::Vec4(1.0f,1.0f,1.0f,1.0f));
    myLight1->setSpotCutoff(20.0f);
    myLight1->setSpotExponent(50.0f);
    myLight1->setDirection(osg::Vec3(1.0f,1.0f,-1.0f));

    osg::LightSource* lightS1 = new osg::LightSource;
    lightS1->setLight(myLight1);
    lightS1->setLocalStateSetModes(osg::StateAttribute::ON);

    lightS1->setStateSetModes(*rootStateSet,osg::StateAttribute::ON);
    lightGroup->addChild(lightS1);

    // create a local light.
    osg::Light* myLight2 = new osg::Light;
    myLight2->setLightNum(1);
    myLight2->setPosition(osg::Vec4(1.0,0.0,1.0,1.0f));
    myLight2->setAmbient(osg::Vec4(0.0f,1.0f,1.0f,1.0f));
    myLight2->setDiffuse(osg::Vec4(0.0f,1.0f,1.0f,1.0f));
    myLight2->setConstantAttenuation(1.0f);
    myLight2->setLinearAttenuation(2.0f/100);
    myLight2->setQuadraticAttenuation(2.0f/osg::square(100));

    osg::LightSource* lightS2 = new osg::LightSource;
    lightS2->setLight(myLight2);
    lightS2->setLocalStateSetModes(osg::StateAttribute::ON);
    lightS2->setStateSetModes(*rootStateSet,osg::StateAttribute::ON);

    // create marker for point light.
    osg::Geometry* marker = new osg::Geometry;
    osg::Vec3Array* vertices = new osg::Vec3Array;
    vertices->push_back(osg::Vec3(0.0,0.0,0.0));
    marker->setVertexArray(vertices);
    marker->addPrimitiveSet(new osg::DrawArrays(GL_POINTS,0,1));

    osg::StateSet* stateset = new osg::StateSet;
    osg::Point* point = new osg::Point;
    point->setSize(4.0f);
    stateset->setAttribute(point);

    marker->setStateSet(stateset);

    osg::Geode* markerGeode = new osg::Geode;
    markerGeode->addDrawable(marker);

    return lightGroup;
}
