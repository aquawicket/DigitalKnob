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
//#ifdef USE_osgFX
#include "DKOSGPicker/DKOSGPicker.h"
#include "DKOSGWindow/DKOSGWindow.h"


bool DKOSGPicker::Init(){
	outline = new osgFX::Outline;
	//dkWindow->world->addChild(outline.get());
	DKOSGWindow::Instance(data[1])->world->addChild(outline.get());

	outline->setWidth(5);
	outline->setColor(osg::Vec4(1,0,0,1));

	DKOSGWindow::Instance(data[1])->view->addEventHandler(this);
	return true;
}

DKOSGPicker::~DKOSGPicker(){
	outline = NULL;
	DKOSGWindow::Instance(data[1])->view->removeEventHandler(this);
}

bool DKOSGPicker::handle(const osgGA::GUIEventAdapter& ea,osgGA::GUIActionAdapter& aa){
	if(ea.getEventType() == osgGA::GUIEventAdapter::PUSH){
		osgViewer::View* view = dynamic_cast<osgViewer::View*>(&aa);
		if (view){
			pick(view,ea);
			return true;
		}
	}
	if(ea.getButtonMask() == osgGA::GUIEventAdapter::RIGHT_MOUSE_BUTTON){
		osgViewer::View* view = dynamic_cast<osgViewer::View*>(&aa);
		if (view){
			remove(view,ea);
		}
	}
	return false;
}

void DKOSGPicker::pick(osgViewer::View* view, const osgGA::GUIEventAdapter& ea){

	outline->removeChildren(0, outline->getNumChildren());

	/*
    osgUtil::LineSegmentIntersector::Intersections intersections;
    if(view->computeIntersections(ea,intersections)){
        for(osgUtil::LineSegmentIntersector::Intersections::iterator hitr = intersections.begin();
            hitr != intersections.end(); ++hitr){
			
			if((!hitr->nodePath.empty() && !(hitr->nodePath.back()->getName().empty())) || hitr->drawable.valid()){

				osg::Node *parent = hitr->nodePath.back();
				while(parent->getNumParents()){
					if(parent->getName() == "world"){
						//here we have the selected object
						outline->addChild(hitr->nodePath.back());
						DKStyler::Instance(dkWindow->dkRocket)->SetObject();
					}
					parent = parent->getParent(0);
				}


			}
		}
	}
	*/
	
    DKString gdlist="";
	//int z = 0;
	osgUtil::LineSegmentIntersector::Intersections intersections;
    if(view->computeIntersections(ea,intersections)){
        for(osgUtil::LineSegmentIntersector::Intersections::iterator hitr = intersections.begin(); hitr != intersections.end(); ++hitr){
            std::ostringstream os;
            if (!hitr->nodePath.empty() && !(hitr->nodePath.back()->getName().empty())){
                // the geodes are identified by name.
                os << "Object Name \"" << hitr->nodePath.back()->getName() << "\"" << std::endl;
            }
            else if (hitr->drawable.valid()){
                os << "Object Class \"" << hitr->drawable->className() << "\"" << std::endl;
				
				osg::Node *parent = hitr->nodePath.back();
				while(parent->getNumParents()){
					if(parent->getName() == "world"){
						//here we have the selected object
						//if(z == 1){
						outline->addChild(hitr->nodePath.back()); //outline
						//MenuRight::Instance(dkWindow->dkRocket)->SetObject();
						//return;
						//}

						//z++;
					}
					parent = parent->getParent(0);
				}

            }

            //os <<"   local coords vertex(" << hitr->getLocalIntersectPoint() << ")" << "  normal(" << hitr->getLocalIntersectNormal() << ")" << std::endl;
            //os <<"   world coords vertex(" << hitr->getWorldIntersectPoint() << ")" << "  normal(" << hitr->getWorldIntersectNormal() << ")" << std::endl;
            const osgUtil::LineSegmentIntersector::Intersection::IndexList& vil = hitr->indexList;
            for(unsigned int i=0;i<vil.size();++i){
                //os<<"   vertex indices [" << i << "] = " << vil[i] << std::endl;
            }

            gdlist += os.str();
        }
    }
    DKINFO(gdlist);
}

void DKOSGPicker::remove(osgViewer::View* view, const osgGA::GUIEventAdapter& ea){
	outline->removeChildren(0, outline->getNumChildren());
    osgUtil::LineSegmentIntersector::Intersections intersections;

    if(view->computeIntersections(ea,intersections)){
        for(osgUtil::LineSegmentIntersector::Intersections::iterator hitr = intersections.begin();
            hitr != intersections.end(); ++hitr){
			
			if((!hitr->nodePath.empty() && !(hitr->nodePath.back()->getName().empty())) || hitr->drawable.valid()){

				osg::Node *parent_node = hitr->nodePath.back();
				while(parent_node->getNumParents()){
					if(parent_node->getName() == "world"){
						//here we have the selected object
						hitr->nodePath.back()->getParent(0)->removeChild(hitr->nodePath.back());
					}
					parent_node = parent_node->getParent(0);
				}
			}
		}
	}
}

void DKOSGPicker::setLabel(const DKString& name){
	DK_UNUSED(name);
	//if (_updateText.get()) _updateText->setText(name);
}

//#endif
