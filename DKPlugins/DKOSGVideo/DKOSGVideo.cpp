#include "DK/stdafx.h"
#include "DKOSGVideo.h"
#include "DKffmpeg.h"
#include "DKFile.h"
#include "DKAssets.h"
#include "DKOSGWindow.h"
#ifdef WIN32
#include <delayimp.h>
#endif

// FIXME
//
// We need to get the name of the app in GLOBAL scope,
// then we can check for ffmpeg files against portable apps
//
///////////////////////////
void DKOSGVideo::loaddlls()
{
#ifdef WIN32
	//delay loading the DLL to move it's locations
	//DKCreate("DKAssets");
	DKFile::local_assets = "C:/digitalknob/DKApps/DKOS/assets/"; //FIXME
	DKString path = DKFile::local_assets += "DKFfmpeg";
	
	DKString avutil = path + "\\avutil-54.dll";
	HMODULE avutil_dll = LoadLibrary(avutil.c_str());
	if (!avutil_dll){ DKLog("Could not load avutil-54.dll \n", DKERROR); }
	__HrLoadAllImportsForDll("avutil-54.dll");

	DKString swresample = path + "\\swresample-1.dll";
	HMODULE swresample_dll = LoadLibrary(swresample.c_str());
	if (!swresample_dll){ DKLog("Could not load swresample-1.dll \n", DKERROR); }
	__HrLoadAllImportsForDll("swresample-1.dll");

	DKString avcodec = path + "\\avcodec-56.dll";
	HMODULE avcodec_dll = LoadLibrary(avcodec.c_str());
	if (!avcodec_dll){ DKLog("Could not load avcodec-56.dll \n", DKERROR); }
	__HrLoadAllImportsForDll("avcodec-56.dll");

	DKString avformat = path + "\\avformat-56.dll";
	HMODULE avformat_dll = LoadLibrary(avformat.c_str());
	if (!avformat_dll){ DKLog("Could not load avformat-56.dll \n", DKERROR); }
	__HrLoadAllImportsForDll("avformat-56.dll");

	DKString postproc = path + "\\postproc-53.dll";
	HMODULE postproc_dll = LoadLibrary(postproc.c_str());
	if (!postproc_dll){ DKLog("Could not load postproc-53.dll \n", DKERROR); }
	__HrLoadAllImportsForDll("postproc-53.dll");

	DKString swscale = path + "\\swscale-3.dll";
	HMODULE swscale_dll = LoadLibrary(swscale.c_str());
	if (!swscale_dll){ DKLog("Could not load swscale-3.dll \n", DKERROR); }
	__HrLoadAllImportsForDll("swscale-3.dll");

	DKString avfilter = path + "\\avfilter-5.dll";
	HMODULE avfilter_dll = LoadLibrary(avfilter.c_str());
	if (!avfilter_dll){ DKLog("Could not load avfilter-5.dll \n", DKERROR); }
	__HrLoadAllImportsForDll("avfilter-5.dll");

	DKString avdevice = path + "\\avdevice-56.dll";
	HMODULE avdevice_dll = LoadLibrary(avdevice.c_str());
	if(!avdevice_dll){ DKLog("Could not load avdevice-56.dll \n", DKERROR); }
	__HrLoadAllImportsForDll("avdevice-56.dll");
#endif
}

/*
/////////////////////////////
void DKOSGVideo::unloaddlls()
{
#ifdef WIN32
	//if(!__FUnloadDelayLoadedDLL2("avutil-54.dll")){
	//	DKLog("DKOSGVideo::loaddlls(): avutil-54.dll did not unload \n", DKERROR);
	//}

    if(!__FUnloadDelayLoadedDLL2("avdevice-56.dll")){
		DKLog("DKOSGVideo::loaddlls(): avdevice-56.dll did not unload \n", DKERROR);
	}
	if(!__FUnloadDelayLoadedDLL2("avfilter-5.dll")){
		DKLog("DKOSGVideo::loaddlls(): avfilter-5.dll did not unload \n", DKERROR);
	}
	if(!__FUnloadDelayLoadedDLL2("swscale-3.dll")){
		DKLog("DKOSGVideo::loaddlls(): swscale-3.dll did not unload \n", DKERROR);
	}
	if(!__FUnloadDelayLoadedDLL2("postproc-53.dll")){
		DKLog("DKOSGVideo::loaddlls(): postproc-53.dll did not unload \n", DKERROR);
	}
	if(!__FUnloadDelayLoadedDLL2("avformat-56.dll")){
		DKLog("DKOSGVideo::loaddlls(): avformat-56.dll did not unload \n", DKERROR);
	}
	if(!__FUnloadDelayLoadedDLL2("avcodec-56.dll")){
		DKLog("DKOSGVideo::loaddlls(): avcodec-56.dll did not unload \n", DKERROR);
	}
	if(!__FUnloadDelayLoadedDLL2("swresample-1.dll")){
		DKLog("DKOSGVideo::loaddlls(): swresample-1.dll did not unload \n", DKERROR);
	}
	if(!__FUnloadDelayLoadedDLL2("avutil-54.dll")){
		DKLog("DKOSGVideo::loaddlls(): avutil-54.dll did not unload \n", DKERROR);
	}
#endif //WIN32
}
*/

///////////////////////
void DKOSGVideo::Init()
{
	DKCreate("DKOSGVideoJS");
}

//////////////////////
void DKOSGVideo::End()
{

}

///////////////////////////////////////////
void DKOSGVideo::Play(const DKString& file)
{
	DKLog("DKOSGVideo::Play("+file+")\n", DKDEBUG);
	
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
		//DKLog("we got an image stream :D \n");
		osg::ImageStream::AudioStreams& audioStreams = imagestream->getAudioStreams();
		if(!audioStreams.empty()){
			//DKLog("we got a audio streams :D \n");
		}
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

		if (xyPlane) { pos.y() += height*1.05f; }
		else{ pos.z() += height*1.05f; }
     }
     else{
		 DKLog("video error\n", DKERROR);
     }
	
	 theRoot->addChild(videogeode); //add video to world :)
}

