#pragma once
#ifndef DKOSGVideo_H
#define DKOSGVideo_H
#include "DK.h"

#ifdef USE_osgDB
#include <osgDB/Registry>
#endif

class DKOSGVideo : public DKObjectT<DKOSGVideo>
{
public:
	static void loaddlls();
	//static void unloaddlls();
	void Init();
	void End();
	void Play(const DKString& file);
};

REGISTER_OBJECT(DKOSGVideo, true)

#define DKVIDEO_LOAD_DLLS() \
    class DK_VIDEO_LOAD{ \
    public: \
        DK_VIDEO_LOAD() \
        { \
            DKOSGVideo::loaddlls(); \
		} \
    }; \
static DK_VIDEO_LOAD global_DK_VIDEO_LOAD;
 
//#ifdef USE_osgdb_ffmpeg
#ifndef ANDROID
	//#include "DKOSGVideo.h"
	DKVIDEO_LOAD_DLLS()
	USE_OSGPLUGIN(ffmpeg)
#endif
//#endif

#endif //DKOSGVideo_H
