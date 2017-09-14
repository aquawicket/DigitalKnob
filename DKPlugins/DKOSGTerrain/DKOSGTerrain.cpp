#include "DK/stdafx.h"
#include "DKOSGTerrain.h"
#include "DKOSGWindow.h"
#include <osg/ShapeDrawable>
#include "terrain_coords.h"
#include <osgDB/ReadFile>


//////////////////////
void DKOSGTerrain::Init()
{
	osg::Vec3 center(0.0f,0.0f,0.0f);
	float radius = 100.0f;
    terrain = createBase(center-osg::Vec3(0.0f,0.0f,radius*0.1),radius);
	DKOSGWindow::Instance("DKOSGWindow")->world->addChild(terrain);
}

/////////////////////
void DKOSGTerrain::End()
{
	DKOSGWindow::Instance("DKOSGWindow")->world->removeChild(terrain);
}

//////////////////////////////////////////////////////////////////////
osg::Node* DKOSGTerrain::createBase(const osg::Vec3& center,float radius)
{
    osg::Geode* geode = new osg::Geode;
    
    // set up the texture of the base.
    osg::StateSet* stateset = new osg::StateSet();
    osg::Image* image = osgDB::readImageFile("lz.rgb");
    if (image)
    {
        osg::Texture2D* texture = new osg::Texture2D;
        texture->setImage(image);
        stateset->setTextureAttributeAndModes(0,texture,osg::StateAttribute::ON);
    }
    
    geode->setStateSet( stateset );

    osg::HeightField* grid = new osg::HeightField;
    grid->allocate(38,39);
    grid->setOrigin(center+osg::Vec3(-radius,-radius,0.0f));
    grid->setXInterval(radius*2.0f/(float)(38-1));
    grid->setYInterval(radius*2.0f/(float)(39-1));
    
    float minHeight = FLT_MAX;
    float maxHeight = -FLT_MAX;

    unsigned int r;
    for(r=0;r<39;++r)
    {
        for(unsigned int c=0;c<38;++c)
        {
            float h = vertex[r+c*39][2];
            if (h>maxHeight) maxHeight=h;
            if (h<minHeight) minHeight=h;
        }
    }
    
    float hieghtScale = radius*0.5f/(maxHeight-minHeight);
    float hieghtOffset = -(minHeight+maxHeight)*0.5f;

    for(r=0;r<39;++r)
    {
        for(unsigned int c=0;c<38;++c)
        {
            float h = vertex[r+c*39][2];
            grid->setHeight(c,r,(h+hieghtOffset)*hieghtScale);
        }
    }
    
    geode->addDrawable(new osg::ShapeDrawable(grid));
     
    osg::Group* group = new osg::Group;
    group->addChild(geode);
     
    return group;
}