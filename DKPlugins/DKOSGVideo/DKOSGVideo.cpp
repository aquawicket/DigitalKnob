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
#include "DKOSGVideo/DKOSGVideo.h"
#include "DKOSGVideo/DKffmpeg.h"
#include "DK/DKFile.h"
#include "DKAssets/DKAssets.h"
#include "DKOSGWindow/DKOSGWindow.h"

//WARNING_DISABLE
#if WIN
	#include <delayimp.h>
#endif
//WARNING_ENABLE


// FIXME
//
// We need to get the name of the app in GLOBAL scope,
// then we can check for ffmpeg files against portable apps
//

bool DKOSGVideo::Init(){
	DKDEBUGFUNC();
	DKClass::DKCreate("DKOSGVideoJS");
	return true;
}

bool DKOSGVideo::End(){
	DKDEBUGFUNC();
	return true;
}

void DKOSGVideo::loaddlls(){
#if WIN
	//delay loading the DLL to move it's locations
	//DKClass::DKCreate("DKAssets");
	DKFile::local_assets = "C:/digitalknob/DKApps/DKOS/assets/"; //FIXME
	DKString path = DKFile::local_assets += "DKFfmpeg";
	
	DKString avutil = path + "\\avutil-54.dll";
	HMODULE avutil_dll = LoadLibrary(avutil.c_str());
	if (!avutil_dll)
		DKERROR("Could not load avutil-54.dll \n");
	__HrLoadAllImportsForDll("avutil-54.dll");

	DKString swresample = path + "\\swresample-1.dll";
	HMODULE swresample_dll = LoadLibrary(swresample.c_str());
	if (!swresample_dll)
		DKERROR("Could not load swresample-1.dll \n");
	__HrLoadAllImportsForDll("swresample-1.dll");

	DKString avcodec = path + "\\avcodec-56.dll";
	HMODULE avcodec_dll = LoadLibrary(avcodec.c_str());
	if (!avcodec_dll)
		DKERROR("Could not load avcodec-56.dll \n");
	__HrLoadAllImportsForDll("avcodec-56.dll");

	DKString avformat = path + "\\avformat-56.dll";
	HMODULE avformat_dll = LoadLibrary(avformat.c_str());
	if (!avformat_dll)
		DKERROR("Could not load avformat-56.dll \n");
	__HrLoadAllImportsForDll("avformat-56.dll");

	DKString postproc = path + "\\postproc-53.dll";
	HMODULE postproc_dll = LoadLibrary(postproc.c_str());
	if (!postproc_dll)
		DKERROR("Could not load postproc-53.dll \n");
	__HrLoadAllImportsForDll("postproc-53.dll");

	DKString swscale = path + "\\swscale-3.dll";
	HMODULE swscale_dll = LoadLibrary(swscale.c_str());
	if (!swscale_dll)
		DKERROR("Could not load swscale-3.dll \n");
	__HrLoadAllImportsForDll("swscale-3.dll");

	DKString avfilter = path + "\\avfilter-5.dll";
	HMODULE avfilter_dll = LoadLibrary(avfilter.c_str());
	if (!avfilter_dll)
		DKERROR("Could not load avfilter-5.dll \n");
	__HrLoadAllImportsForDll("avfilter-5.dll");

	DKString avdevice = path + "\\avdevice-56.dll";
	HMODULE avdevice_dll = LoadLibrary(avdevice.c_str());
	if(!avdevice_dll)
		DKERROR("Could not load avdevice-56.dll \n");
	__HrLoadAllImportsForDll("avdevice-56.dll");
#endif
}

/*
void DKOSGVideo::unloaddlls(){
#if WIN
	//if(!__FUnloadDelayLoadedDLL2("avutil-54.dll"))
	//	DKERROR("DKOSGVideo::loaddlls(): avutil-54.dll did not unload \n");
    if(!__FUnloadDelayLoadedDLL2("avdevice-56.dll"))
		DKERROR("DKOSGVideo::loaddlls(): avdevice-56.dll did not unload \n");
	if(!__FUnloadDelayLoadedDLL2("avfilter-5.dll"))
		DKERROR("DKOSGVideo::loaddlls(): avfilter-5.dll did not unload \n");
	if(!__FUnloadDelayLoadedDLL2("swscale-3.dll"))
		DKERROR("DKOSGVideo::loaddlls(): swscale-3.dll did not unload \n");
	if(!__FUnloadDelayLoadedDLL2("postproc-53.dll"))
		DKERROR("DKOSGVideo::loaddlls(): postproc-53.dll did not unload \n");
	if(!__FUnloadDelayLoadedDLL2("avformat-56.dll"))
		DKERROR("DKOSGVideo::loaddlls(): avformat-56.dll did not unload \n");
	if(!__FUnloadDelayLoadedDLL2("avcodec-56.dll"))
		DKERROR("DKOSGVideo::loaddlls(): avcodec-56.dll did not unload \n");
	if(!__FUnloadDelayLoadedDLL2("swresample-1.dll"))
		DKERROR("DKOSGVideo::loaddlls(): swresample-1.dll did not unload \n");
	if(!__FUnloadDelayLoadedDLL2("avutil-54.dll"))
		DKERROR("DKOSGVideo::loaddlls(): avutil-54.dll did not unload \n");
#endif //WIN32
}
*/

void DKOSGVideo::Play(const DKString& file){
	DKDEBUGFUNC(file);
	osg::Group* theRoot = DKOSGWindow::Instance("DKOSGWindow")->world;
	bool useTextureRectangle = true;
    bool useShader = false;
	bool fullscreen = 0;
	bool flip = 0;
	osg::Vec3 pos(0.0f,0.0f,0.0f);
    osg::Vec3 topleft = pos;
    osg::Vec3 bottomright = pos;
    bool xyPlane = fullscreen;
    bool useAudioSink = false; //TODO
	osg::ref_ptr<osg::Geode> videogeode = new osg::Geode;
    osg::StateSet* stateset = videogeode->getOrCreateStateSet();
    stateset->setMode(GL_LIGHTING,osg::StateAttribute::OFF);
	osg::Image* image = osgDB::readImageFile(file);
    osg::ImageStream* imagestream = dynamic_cast<osg::ImageStream*>(image);
    if(imagestream){
		//DKDEBUG("we got an image stream :D \n");
		osg::ImageStream::AudioStreams& audioStreams = imagestream->getAudioStreams();
		//if(!audioStreams.empty()){
			//DKDEBUG("we got a audio streams :D \n");
		//}
		imagestream->play();
	}
	if(image){
		osg::notify(osg::NOTICE) << "image->s()" << image->s() << " image-t()=" << image->t() << " aspectRatio=" << image->getPixelAspectRatio() << std::endl;
        float width = image->s() * image->getPixelAspectRatio();
        float height = image->t();
        osg::ref_ptr<osg::Drawable> drawable = myCreateTexturedQuadGeometry(pos, width, height,image, useTextureRectangle, xyPlane, flip);   
        if (image->isImageTranslucent()){
			osg::notify(osg::NOTICE)<<"Transparent movie, enabling blending."<<std::endl;
            drawable->getOrCreateStateSet()->setMode(GL_BLEND, osg::StateAttribute::ON);
            drawable->getOrCreateStateSet()->setRenderingHint(osg::StateSet::TRANSPARENT_BIN);
        }
        videogeode->addDrawable(drawable.get());
        bottomright = pos + osg::Vec3(width,height,0.0f);
		if (xyPlane){
			pos.y() += height*1.05f; 
		}
		else{ 
			pos.z() += height*1.05f; 
		}
     }
     else{
		 DKERROR("video error\n");
     }
	 theRoot->addChild(videogeode); //add video to world :)
}
