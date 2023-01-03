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
* The above copyright noticeand this permission notice shall be included in all
* copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*/

#include "DK/stdafx.h"
#include "DKOSGAudio/DKOSGAudio.h"
#include "DKOSGWindow/DKOSGWindow.h"
#include "DKAssets/DKAssets.h"


bool DKOSGAudio::Init(){
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

bool DKOSGAudio::End(){
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
	if(instance_count != 1)
		return false; //only shutdown on last instance
	if(osg::Referenced::getDeleteHandler())
	    osg::Referenced::getDeleteHandler()->setNumFramesToRetainObjects(0);
	osgAudio::SoundManager::instance()->shutdown();
	return true;
}

bool DKOSGAudio::Create(){
	/*
	DKString path = data[3];
	if(!DKAssets::VerifyPath(path))
		return DKERROR("Could not find "+path+"\n");
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

void* DKOSGAudio::PlaySound(void* data){
	DKString path = *static_cast<DKString*>(data);
	if(!DKAssets::VerifyPath(path))
		return DKERROR("Could not find "+path+"\n");
	sample = new osgAudio::Sample(path);
	musicSoundState->setSample( sample );
	musicSoundState->setPlay( true );
}

void* DKOSGAudio::OpenMusic(void* data){
	//TODO - the sample sound be preloaded for music or somehting..   IDK...  read how SDL does it different
	DKString path = *static_cast<DKString*>(data);
	if(!DKAssets::VerifyPath(path)){
		return DKERROR("Could not find "+path+"\n");
		return false; 
	}
	sample = new osgAudio::Sample(path);
	musicSoundState->setSample( sample );
	musicSoundState->setPlay( true );
}
