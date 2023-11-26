/*
* This source file is part of digitalknob, the cross-platform C/C++/Javascript/Html/Css Solution
*
* For the latest information, see https://github.com/aquawicket/DigitalKnob
*
* Copyright(c) 2010 - 2023 Digitalknob Team, and contributors
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files(the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and /or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions :
*
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/
#include "DK/stdafx.h"
#include "DKOSGLights/DKOSGLights.h"
#include "DKOSGWindow/DKOSGWindow.h"

//WARNING_DISABLE
#include <osg/Point>
//WARNING_ENABLE


bool DKOSGLights::Init(){
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

osg::Node* DKOSGLights::createLights(){
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
