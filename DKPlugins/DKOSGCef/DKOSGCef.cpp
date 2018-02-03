#include "DK/stdafx.h"
#include "DK/DKApp.h"
#include "DK/DKClass.h"
#include "DK/DKFile.h"
#include "DK/DKLog.h"
#include "DKOSGCef/DKOSGCef.h"
#include <include/cef_urlrequest.h>
#ifdef WIN32
#include <delayimp.h>
#include "DKWindows.h"
#endif


/////////////////////
bool DKOSGCef::Init()
{
	dkOsgWindow = DKOSGWindow::Instance("DKOSGWindow0");
	dkCef = DKCef::Instance("DKCef");
	if(!dkOsgWindow || !dkCef){
		DKLog("DKOSGCef::Init(): INVALID OBJECTS \n", DKERROR);
		return;
	}

	id = data[1];
	cef_image = NULL;
	SetupOsg();
	SetupCef();
	_mouseLMBdown = false;
	_scrollFactor = 70.0f;
	dkCef->inFocus = true;
	dkOsgWindow->view->addEventHandler(this);
	DKClass::RegisterFunc(id+"::OnResize", &DKOSGCef::OnResize, this);
	DKClass::RegisterFunc("DKOSGCef::GetTexture", &DKOSGCef::GetTexture, this);
	return true;
}

////////////////////
bool DKOSGCef::End()
{
	DKApp::RemoveLoopFunc(&DKOSGCefHandler::DoFrame, cefHandler);
	//dkOsgWindow->view->removeEventHandler(this); //crash
	dkOsgWindow->root->removeChild(modelViewMat);
	modelViewMat = NULL;
	cefHandler = nullptr;
	return true;
}

////////////////////////////////////
void* DKOSGCef::OnResize(void* data)
{
	DKString str = *static_cast<DKString*>(data);
	//DKLog("DKOSGCef::OnResize("+str+")\n",DKWARN);

	DKStringArray arry;
	toStringArray(arry,str,",");
	dkCef->top = toInt(arry[0]);
	dkCef->left = toInt(arry[1]);
	dkCef->width = toInt(arry[2]);
	dkCef->height = toInt(arry[3]);
	//float top = ((float)dkCef->height + (float)dkCef->top) / (float)dkCef->height;
	//float left = -((float)dkCef->width + (float)dkCef->left) / (float)dkCef->width +1;
	//float right = ((float)dkOsgWindow->width - (float)dkCef->left) / (float)dkCef->width;
	//float bottom = -((float)dkOsgWindow->height - (float)dkCef->top) / (float)dkCef->height +1;
	//float top = (float)dkCef->height / (float)dkCef->height;
	//float left = -(float)dkCef->width / (float)dkCef->width +1;
	//float right = (float)dkOsgWindow->width / (float)dkCef->width;
	//float bottom = -(float)dkOsgWindow->height / (float)dkCef->height +1;
 	//cefCam->setProjectionMatrix(osg::Matrix::ortho2D(left, right, bottom, top));
	cefCam->setProjectionMatrix(osg::Matrix::ortho2D(1.0, dkCef->width, dkCef->height, 1.0));

	//dkCef->width = osg::maximum(0U, dkOsgWindow->width);
	//dkCef->height = osg::maximum(0U, dkOsgWindow->height - dkCef->top);
	//static unsigned char s_empty;
	//cef_image->setImage(0, 0, 1, 4, GL_BGRA, GL_UNSIGNED_BYTE, (unsigned char*)(&s_empty), osg::Image::NO_DELETE);

	for (unsigned int i = 0; i < dkCef->browsers.size(); ++i){
		dkCef->browsers[i]->GetHost()->WasResized();
	}
	return NULL;
}

/////////////////////////////////
void* DKOSGCef::GetTexture(void*)
{
	if(!cef_image){
		DKLog("DKOSGCef::GetTexture(): cef_image invalid \n", DKERROR);
		return NULL;
	}
	if(!cef_image->getImageSizeInBytes()){
		return NULL;
	}
	return static_cast<void*>(cef_image);
}

/////////////////////////
void DKOSGCef::SetupOsg()
{
	cefCam = dkOsgWindow->view->getCamera();
	cefCam->setRenderOrder(osg::Camera::POST_RENDER);
	cefCam->setClearMask(GL_DEPTH_BUFFER_BIT);

	float top = ((float)dkCef->height + (float)dkCef->top) / (float)dkCef->height;
	float left = -((float)dkCef->width + (float)dkCef->left) / (float)dkCef->width +1;
	float right = ((float)dkOsgWindow->width - (float)dkCef->left) / (float)dkCef->width;
	float bottom = -((float)dkOsgWindow->height - (float)dkCef->top) / (float)dkCef->height +1;
 	cefCam->setProjectionMatrix(osg::Matrix::ortho2D(left, right, bottom, top));

	cefCam->setProjectionResizePolicy(osg::Camera::FIXED);
	cefCam->setViewMatrix(osg::Matrix::identity());
	cefCam->setClearColor(osg::Vec4(1., 0., 1., 0.));

	//create image and texture to render to
	cef_image = new osg::Image();
	osg::PixelBufferObject* pbo = new osg::PixelBufferObject(cef_image.get());
	pbo->setCopyDataAndReleaseGLBufferObject(true);
	pbo->setUsage(GL_DYNAMIC_DRAW_ARB);
	cef_image->setPixelBufferObject(pbo);

	/*
	osg::Texture2D* tex = new osg::Texture2D(cef_image);
	tex->setResizeNonPowerOfTwoHint(false);
	tex->setFilter(osg::Texture::MIN_FILTER, osg::Texture::NEAREST);
	tex->setFilter(osg::Texture::MAG_FILTER, osg::Texture::NEAREST);
	tex->setWrap(osg::Texture::WRAP_S, osg::Texture::CLAMP_TO_EDGE);
	tex->setWrap(osg::Texture::WRAP_T, osg::Texture::CLAMP_TO_EDGE);
	*/

	//setup quad to render on
	/*
	osg::Geometry* geometry = new osg::Geometry();

	osg::Vec3Array* verts = new osg::Vec3Array();
	verts->reserve(4);
	verts->push_back(osg::Vec3(0, 0, 0));
	verts->push_back(osg::Vec3(1, 0, 0));
	verts->push_back(osg::Vec3(1, 1, 0));
	verts->push_back(osg::Vec3(0, 1, 0));
	geometry->setVertexArray(verts);

	osg::Vec4Array* colors = new osg::Vec4Array;
	colors->push_back(osg::Vec4(1.0f, 1.0f, 1.0f, 1.0f));
	geometry->setColorArray(colors);
	geometry->setColorBinding(osg::Geometry::BIND_OVERALL);

	osg::Vec2Array* tcoords = new osg::Vec2Array(4);
	(*tcoords)[3].set(0.0f, 0.0f);
	(*tcoords)[2].set(1.0f, 0.0f);
	(*tcoords)[1].set(1.0f, 1.0f);
	(*tcoords)[0].set(0.0f, 1.0f);
	geometry->setTexCoordArray(0, tcoords);

	geometry->addPrimitiveSet(new osg::DrawArrays(GL_QUADS, 0, 4));

	geometry->getOrCreateStateSet()->setTextureAttributeAndModes(0, tex, osg::StateAttribute::ON);
	geometry->setDataVariance(osg::Object::DYNAMIC);
	geometry->setName("CEFGeometry");

	osg::Geode* geode = new osg::Geode;
	geode->addDrawable(geometry);
	geode->getOrCreateStateSet()->setMode(GL_LIGHTING, osg::StateAttribute::OFF);
	geode->getOrCreateStateSet()->setMode(GL_DEPTH_TEST, osg::StateAttribute::OFF);
	geode->getOrCreateStateSet()->setMode(GL_BLEND, osg::StateAttribute::ON);
	geode->setDataVariance(osg::Object::DYNAMIC);

	modelViewMat = new osg::MatrixTransform;
	//modelViewMat->setReferenceFrame(osg::Transform::ABSOLUTE_RF);
	modelViewMat->setMatrix(osg::Matrix::identity());
	modelViewMat->addChild(geode);
	*/


	/*
	// setup popup
	_popupImage = new osg::Image();
	pbo = new osg::PixelBufferObject(_popupImage.get());
	pbo->setCopyDataAndReleaseGLBufferObject(true);
	pbo->setUsage(GL_DYNAMIC_DRAW_ARB);
	_popupImage->setPixelBufferObject(pbo);

	tex = new osg::Texture2D(_popupImage);
	tex->setResizeNonPowerOfTwoHint(false);
	tex->setFilter(osg::Texture::MIN_FILTER, osg::Texture::NEAREST);
	tex->setFilter(osg::Texture::MAG_FILTER, osg::Texture::NEAREST);
	tex->setWrap(osg::Texture::WRAP_S, osg::Texture::CLAMP_TO_EDGE);
	tex->setWrap(osg::Texture::WRAP_T, osg::Texture::CLAMP_TO_EDGE);

	//setup quad to render on
	_popupGeom = new osg::Geometry();

	_popupVerts = new osg::Vec3Array();
	_popupVerts->reserve(4);
	_popupVerts->push_back(osg::Vec3(0, 0, 0));
	_popupVerts->push_back(osg::Vec3(1, 0, 0));
	_popupVerts->push_back(osg::Vec3(1, 1, 0));
	_popupVerts->push_back(osg::Vec3(0, 1, 0));
	_popupGeom->setVertexArray(_popupVerts);

	colors = new osg::Vec4Array;
	colors->push_back(osg::Vec4(1.0f, 1.0f, 1.0f, 1.0f));
	_popupGeom->setColorArray(colors);
	_popupGeom->setColorBinding(osg::Geometry::BIND_OVERALL);

	tcoords = new osg::Vec2Array(4);
	(*tcoords)[3].set(0.0f, 0.0f);
	(*tcoords)[2].set(1.0f, 0.0f);
	(*tcoords)[1].set(1.0f, 1.0f);
	(*tcoords)[0].set(0.0f, 1.0f);
	_popupGeom->setTexCoordArray(0, tcoords);

	_popupGeom->addPrimitiveSet(new osg::DrawArrays(GL_QUADS, 0, 4));

	_popupGeom->getOrCreateStateSet()->setTextureAttributeAndModes(0, tex, osg::StateAttribute::ON);
	_popupGeom->setDataVariance(osg::Object::DYNAMIC);

	_popupNode = new osg::Geode();
	_popupNode->addDrawable(_popupGeom);
	_popupNode->getOrCreateStateSet()->setMode(GL_LIGHTING, osg::StateAttribute::OFF);
	_popupNode->getOrCreateStateSet()->setMode(GL_DEPTH_TEST, osg::StateAttribute::OFF);
	_popupNode->getOrCreateStateSet()->setMode(GL_BLEND, osg::StateAttribute::ON);
	_popupNode->setDataVariance(osg::Object::DYNAMIC);
	_popupNode->setNodeMask(0);

	modelViewMat->addChild(_popupNode);
	*/

	//modelViewMat->addChild(cefCam);
	//cefCam->setGraphicsContext(DKOSGWindow::Instance("DKOSGWindow")->gc); // same graphics context as main camera
	//cefCam->addChild(modelViewMat);
	//DKOSGWindow::Instance("DKOSGWindow")->root->addChild(cefCam);

	//dkOsgWindow->root->addChild(modelViewMat);
}

/////////////////////////
void DKOSGCef::SetupCef()
{
	cefHandler = new DKOSGCefHandler(cef_image);
	cefHandler->dkosgcef = this;
	DKCef::cefHandler = cefHandler;
	dkCef->NewBrowser();
	DKApp::AddLoopFunc("RENDER", &DKOSGCefHandler::DoFrame, cefHandler);
}

////////////////////////////////////////////////////////////////////////////////////
bool DKOSGCef::handle(const osgGA::GUIEventAdapter& ea, osgGA::GUIActionAdapter& aa)
{
	if(ea.getHandled()){ return false; }

	switch(ea.getEventType()){ //all mouse
		case(osgGA::GUIEventAdapter::MOVE) :
		case(osgGA::GUIEventAdapter::DRAG) :
		case(osgGA::GUIEventAdapter::PUSH) :
		case(osgGA::GUIEventAdapter::RELEASE) :
		case(osgGA::GUIEventAdapter::DOUBLECLICK) :
		case(osgGA::GUIEventAdapter::SCROLL) :{
			if(transparentPixel(dkOsgWindow->view, ea) && !_mouseLMBdown){
				if(ea.getEventType() == osgGA::GUIEventAdapter::RELEASE || ea.getEventType() == osgGA::GUIEventAdapter::DOUBLECLICK){
					dkCef->current_browser->GetHost()->SendFocusEvent(false);
					dkCef->inFocus = false;
				}
				return false;
			}
		}								   
	}

	switch(ea.getEventType()){
		case(osgGA::GUIEventAdapter::DOUBLECLICK) :
			return true;

		case osgGA::GUIEventAdapter::PUSH:{
			if (ea.getButton() == osgGA::GUIEventAdapter::LEFT_MOUSE_BUTTON){
				_mouseLMBdown = true;
			}

			CefMouseEvent mouse_event;
			mouse_event.x = (int)ea.getX() - dkCef->left;
			mouse_event.y = ea.getWindowHeight() - (int)ea.getY() - dkCef->top;
			//mouse_event.modifiers = _keyAdapter.getCefModifiers(ea.getModKeyMask());
			dkCef->current_browser->GetHost()->SendMouseClickEvent(mouse_event, getCefMouseButton(ea.getButton()), false, 1);
			return true;
		}

		case osgGA::GUIEventAdapter::RELEASE:{
			if (ea.getButton() == osgGA::GUIEventAdapter::LEFT_MOUSE_BUTTON){
				_mouseLMBdown = false;
			}
			CefMouseEvent mouse_event;
			mouse_event.x = (int)ea.getX() - dkCef->left;
			mouse_event.y = ea.getWindowHeight() - (int)ea.getY() - dkCef->top;
			//mouse_event.modifiers = _keyAdapter.getCefModifiers(ea.getModKeyMask());
			dkCef->current_browser->GetHost()->SendMouseClickEvent(mouse_event, getCefMouseButton(ea.getButton()), true, 1);

			dkCef->current_browser->GetHost()->SendFocusEvent(true);
			dkCef->inFocus = true;
			return true;
		}
		
		case osgGA::GUIEventAdapter::KEYDOWN:{
			if (!dkCef->inFocus){ return false; }

			/// Developer mode
			if (ea.getKey() == osgGA::GUIEventAdapter::KEY_F12){
				CefWindowInfo windowInfo;
				windowInfo.SetAsPopup(0L, "DevTools");
				CefBrowserSettings browserSettings;
				dkCef->current_browser->GetHost()->ShowDevTools(windowInfo, cefHandler, browserSettings, CefPoint());
			}
			
			/// Handle keyboard input
			CefKeyEvent KeyEvent;
       		KeyEvent.type = KEYEVENT_KEYDOWN;
			KeyEvent.windows_key_code = DKOSGWindow::osgKeyCode[ea.getUnmodifiedKey()];
       		KeyEvent.modifiers = _keyAdapter.getCefModifiers(ea.getModKeyMask());
      		dkCef->current_browser->GetHost()->SendKeyEvent(KeyEvent);

			CefKeyEvent charKeyEvent;
       		charKeyEvent.type = KEYEVENT_CHAR;
       		charKeyEvent.modifiers = _keyAdapter.getCefModifiers(ea.getModKeyMask());
      		
			if(ea.getUnmodifiedKey() > 96 && ea.getUnmodifiedKey() < 123){ //letter
				if(ea.getModKeyMask() & osgGA::GUIEventAdapter::MODKEY_SHIFT && ea.getModKeyMask() & osgGA::GUIEventAdapter::MODKEY_CAPS_LOCK){ //both = lowercase
					charKeyEvent.windows_key_code = DKOSGWindow::osgCharCode[ea.getUnmodifiedKey()];
				}
				else if(ea.getModKeyMask() & osgGA::GUIEventAdapter::MODKEY_SHIFT || ea.getModKeyMask() & osgGA::GUIEventAdapter::MODKEY_CAPS_LOCK){ //1 = uppercase
					charKeyEvent.windows_key_code = DKOSGWindow::osgShiftCharCode[ea.getUnmodifiedKey()];
				}
				else{
					charKeyEvent.windows_key_code = DKOSGWindow::osgCharCode[ea.getUnmodifiedKey()]; // lowercase
				}
			}
			else if(ea.getModKeyMask() & osgGA::GUIEventAdapter::MODKEY_SHIFT){ //other character keys
				charKeyEvent.windows_key_code = DKOSGWindow::osgShiftCharCode[ea.getUnmodifiedKey()]; //shifted symbol
			}
			else{
				charKeyEvent.windows_key_code = DKOSGWindow::osgCharCode[ea.getUnmodifiedKey()]; //symbol
			}

			dkCef->current_browser->GetHost()->SendKeyEvent(charKeyEvent);
			return true;
		}

		case osgGA::GUIEventAdapter::KEYUP:{
			if (!dkCef->inFocus){ return false; }

			CefKeyEvent KeyEvent;
       		KeyEvent.type = KEYEVENT_KEYUP;
			KeyEvent.windows_key_code = DKOSGWindow::osgKeyCode[ea.getUnmodifiedKey()];
       		KeyEvent.modifiers = _keyAdapter.getCefModifiers(ea.getModKeyMask());
      		dkCef->current_browser->GetHost()->SendKeyEvent(KeyEvent);
			return true;
		}

		case osgGA::GUIEventAdapter::MOVE:
		case osgGA::GUIEventAdapter::DRAG:{
			CefMouseEvent mouse_event;
			mouse_event.x = (int)ea.getX() - dkCef->left;
			mouse_event.y = ea.getWindowHeight() - (int)ea.getY() - dkCef->top;
			uint32 modifiers = _keyAdapter.getCefModifiers(ea.getModKeyMask());

			if (ea.getButtonMask() & osgGA::GUIEventAdapter::LEFT_MOUSE_BUTTON)
				modifiers |= EVENTFLAG_LEFT_MOUSE_BUTTON;
			if (ea.getButtonMask() & osgGA::GUIEventAdapter::MIDDLE_MOUSE_BUTTON)
				modifiers |= EVENTFLAG_MIDDLE_MOUSE_BUTTON;
			if (ea.getButtonMask() & osgGA::GUIEventAdapter::RIGHT_MOUSE_BUTTON)
				modifiers |= EVENTFLAG_RIGHT_MOUSE_BUTTON;

			mouse_event.modifiers = modifiers;
			dkCef->current_browser->GetHost()->SendMouseMoveEvent(mouse_event, false);
			return true;
		}

		case osgGA::GUIEventAdapter::SCROLL:{
			float deltaX, deltaY;
			if(getScrollDeltas(ea, deltaX, deltaY)){
				CefMouseEvent mouse_event;
				mouse_event.x = (int)ea.getX() - dkCef->left;
				mouse_event.y = ea.getWindowHeight() - (int)ea.getY() - dkCef->top;
				mouse_event.modifiers = _keyAdapter.getCefModifiers(ea.getModKeyMask());
				dkCef->current_browser->GetHost()->SendMouseWheelEvent(mouse_event, deltaX, deltaY);
			}
			return true;
		}

		//case osgGA::GUIEventAdapter::RESIZE:{
		//	setSize(ea.getWindowWidth(), ea.getWindowHeight());
		//	return true;
		//}
	}
	return false; //allow event to continue
}

////////////////////////////////////////////////////////////////////////////////////////
bool DKOSGCef::transparentPixel(osgViewer::View* view, const osgGA::GUIEventAdapter& ea)
{
	osg::Image* image = cef_image.get();/*cefHandler->getImage();*/
	if (image && image->getPixelFormat()){
		int x = ea.getX();
		int y = ea.getWindowHeight() - ea.getY();
		if (x >= 0 && x < image->s() && y >= 0 && y < image->t()){
			//TODO
			//ImageUtils::PixelReader ia(image);
			//osg::Vec4 color = ia(x, y);
			//return color.a() == 0.0;
		}
	}
	return false;
}

///////////////////////////////////////////////////////////////////////
CefBrowserHost::MouseButtonType DKOSGCef::getCefMouseButton(int button)
{
	return button == osgGA::GUIEventAdapter::LEFT_MOUSE_BUTTON ? MBT_LEFT : button == osgGA::GUIEventAdapter::RIGHT_MOUSE_BUTTON ? MBT_RIGHT : MBT_MIDDLE;
}

//////////////////////////////////////////////////////////////////////////////////////////////
bool DKOSGCef::getScrollDeltas(const osgGA::GUIEventAdapter& ea, float &deltaX, float &deltaY)
{
	if (ea.getScrollingDeltaX() != 0 || ea.getScrollingDeltaY() != 0)
	{
		deltaX = ea.getScrollingDeltaX();
		deltaY = ea.getScrollingDeltaY();
		return true;
	}

	deltaX = 0.0f;
	deltaY = 0.0f;

	switch (ea.getScrollingMotion())
	{
	case osgGA::GUIEventAdapter::SCROLL_UP:
		deltaY = _scrollFactor;
		break;

	case osgGA::GUIEventAdapter::SCROLL_DOWN:
		deltaY = -_scrollFactor;
		break;

	case osgGA::GUIEventAdapter::SCROLL_LEFT:
		deltaX = -_scrollFactor;
		break;

	case osgGA::GUIEventAdapter::SCROLL_RIGHT:
		deltaX = _scrollFactor;
		break;
	}

	return deltaX != 0.0f || deltaY != 0.0f;
}

