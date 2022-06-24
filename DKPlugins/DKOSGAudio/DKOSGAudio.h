#pragma once
#ifndef DKOSGAudio_H
#define DKOSGAudio_H
#include "DK.h"

#include <osgAudio/SoundManager.h>
#include <osgAudio/SoundNode.h>
#include <osgAudio/Source.h>
#include <osgAudio/Sample.h>
#include <osg/DeleteHandler>

class DKOSGAudio : public DKObjectT<DKOSGAudio>
{
public:
	bool Init();
	bool End();
	
	bool Create();
	void* OpenMusic(void* data);
	void* PlaySound(void* data);

	osg::ref_ptr<osgAudio::Sample> sample;
	osg::ref_ptr<osgAudio::SoundNode> sound_node;
	osg::ref_ptr<osgAudio::SoundState> musicSoundState;
};


REGISTER_OBJECT(DKOSGAudio, false)

#endif //DKOSGAudio_H
