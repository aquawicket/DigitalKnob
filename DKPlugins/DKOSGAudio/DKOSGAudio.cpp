#include "DK/stdafx.h"
#include "DKOSGAudio.h"
#include "DKOSGWindow.h"
#include "DKAssets.h"

///////////////////////
bool DKOSGAudio::Init()
{
	if(instance_count == 1){ //only initiate on first instance
		osgAudio::SoundManager::instance()->init(32); 
		osgAudio::SoundManager::instance()->getEnvironment()->setGain(1.0); 
		osgAudio::SoundManager::instance()->getEnvironment()->setDistanceModel(osgAudio::InverseDistance); 
		osgAudio::SoundManager::instance()->getEnvironment()->setDopplerFactor(1);
	}

	Create();

	DKClass::RegisterFunc("DKOSGAudio::PlaySound", &DKOSGAudio::PlaySound, this);
	DKClass::RegisterFunc("DKOSGAudio::OpenMusic", &DKOSGAudio::OpenMusic, this);
	return true;
}

//////////////////////
bool DKOSGAudio::End()
{
	musicSoundState->setPlay( false ); 
	//sample = nullptr;
	sample = NULL;
	DKOSGWindow::Instance("DKOSGWindow")->root->removeChild(sound_node);
	osgAudio::SoundManager::instance()->removeSoundState(musicSoundState);
	//musicSoundState = nullptr;
	musicSoundState = NULL;
	//sound_node = nullptr;
	sound_node = NULL;

	// Very important to call before end of main!
	if(instance_count != 1){ return false; } //only shutdown on last instance
	if(osg::Referenced::getDeleteHandler()){
	    osg::Referenced::getDeleteHandler()->setNumFramesToRetainObjects(0);
	}
	osgAudio::SoundManager::instance()->shutdown();
	return true;
}

/////////////////////////
bool DKOSGAudio::Create()
{
	/*
	DKString path = data[3];
	if(!DKAssets::VerifyPath(path)){
		DKLog("Could not find "+path+"\n",DKERROR);
		return false; 
	}
	*/

	musicSoundState = new osgAudio::SoundState("music"); 
	musicSoundState->allocateSource( 10 ); 
	osgAudio::SoundManager::instance()->addSoundState( musicSoundState );
	sound_node = new osgAudio::SoundNode;
	sound_node->setSoundState(musicSoundState); 
	DKOSGWindow::Instance("DKOSGWindow")->root->addChild(sound_node);

	//sample = new osgAudio::Sample(path);
	//musicSoundState->setSample( sample );
	musicSoundState->setLooping( false ); 
	musicSoundState->setRelative(true); 
	musicSoundState->setPosition(osg::Vec3(0,0,0)); 
	musicSoundState->setReferenceDistance(10); 
	musicSoundState->setRolloffFactor(1);
	return true;
}

///////////////////////////////////////
void* DKOSGAudio::PlaySound(void* data)
{
	DKString path = *static_cast<DKString*>(data);
	if(!DKAssets::VerifyPath(path)){
		DKLog("Could not find "+path+"\n",DKERROR);
		return false; 
	}

	sample = new osgAudio::Sample(path);
	musicSoundState->setSample( sample );
	musicSoundState->setPlay( true );
}

///////////////////////////////////////
void* DKOSGAudio::OpenMusic(void* data)
{
	//TODO - the sample sound be preloaded for music or somehting..   IDK...  read how SDL does it different
	DKString path = *static_cast<DKString*>(data);
	if(!DKAssets::VerifyPath(path)){
		DKLog("Could not find "+path+"\n",DKERROR);
		return false; 
	}

	sample = new osgAudio::Sample(path);
	musicSoundState->setSample( sample );
	musicSoundState->setPlay( true );
}