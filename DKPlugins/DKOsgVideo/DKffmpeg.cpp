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
#include "DKOSGVideo/DKffmpeg.h"


void MovieEventHandler::set(osg::Node* node){
    _imageStreamList.clear();
    if (node){
        FindImageStreamsVisitor fisv(_imageStreamList);
        node->accept(fisv);
    }
}

bool MovieEventHandler::handle(const osgGA::GUIEventAdapter& ea,osgGA::GUIActionAdapter& aa, osg::Object*, osg::NodeVisitor* nv){
    switch(ea.getEventType()){
        case(osgGA::GUIEventAdapter::MOVE):
        case(osgGA::GUIEventAdapter::PUSH):
        case(osgGA::GUIEventAdapter::RELEASE):
        {
            if(_trackMouse){
                osgViewer::View* view = dynamic_cast<osgViewer::View*>(&aa);
                osgUtil::LineSegmentIntersector::Intersections intersections;
                bool foundIntersection = view==0 ? false :
                    (nv==0 ? view->computeIntersections(ea, intersections) :
                             view->computeIntersections(ea, nv->getNodePath(), intersections));

                if(foundIntersection){

                    // use the nearest intersection
                    const osgUtil::LineSegmentIntersector::Intersection& intersection = *(intersections.begin());
                    osg::Drawable* drawable = intersection.drawable.get();
                    osg::Geometry* geometry = drawable ? drawable->asGeometry() : 0;
                    osg::Vec3Array* vertices = geometry ? dynamic_cast<osg::Vec3Array*>(geometry->getVertexArray()) : 0;
                    if(vertices){
                        // get the vertex indices.
                        const osgUtil::LineSegmentIntersector::Intersection::IndexList& indices = intersection.indexList;
                        const osgUtil::LineSegmentIntersector::Intersection::RatioList& ratios = intersection.ratioList;

                        if(indices.size()==3 && ratios.size()==3){
                            unsigned int i1 = indices[0];
                            unsigned int i2 = indices[1];
                            unsigned int i3 = indices[2];

                            float r1 = ratios[0];
                            float r2 = ratios[1];
                            float r3 = ratios[2];

                            osg::Array* texcoords = (geometry->getNumTexCoordArrays()>0) ? geometry->getTexCoordArray(0) : 0;
                            osg::Vec2Array* texcoords_Vec2Array = dynamic_cast<osg::Vec2Array*>(texcoords);
                            if(texcoords_Vec2Array){
                                // we have tex coord array so now we can compute the final tex coord at the point of intersection.
                                osg::Vec2 tc1 = (*texcoords_Vec2Array)[i1];
                                osg::Vec2 tc2 = (*texcoords_Vec2Array)[i2];
                                osg::Vec2 tc3 = (*texcoords_Vec2Array)[i3];
                                osg::Vec2 tc = tc1*r1 + tc2*r2 + tc3*r3;

                                osg::notify(osg::NOTICE)<<"We hit tex coords "<<tc<<std::endl;

                            }
                        }
                        else{
                            osg::notify(osg::NOTICE)<<"Intersection has insufficient indices to work with";
                        }
                    }
                }
                else{
                    osg::notify(osg::NOTICE)<<"No intersection"<<std::endl;
                }
            }
            break;
        }
        case(osgGA::GUIEventAdapter::KEYDOWN):
        {
            if (ea.getKey()=='p'){
                for(ImageStreamList::iterator itr=_imageStreamList.begin();
                    itr!=_imageStreamList.end();
                    ++itr)
                {
                    osg::ImageStream::StreamStatus playToggle = (*itr)->getStatus();
                    if (playToggle != osg::ImageStream::PLAYING){
                        std::cout<< (*itr).get() << " Play"<<std::endl;
                        (*itr)->play();
                    }
                    else{
                        // playing, so pause
                        std::cout<< (*itr).get() << " Pause"<<std::endl;
                        (*itr)->pause();
                    }
                }
                return true;
            }
            else if (ea.getKey()=='r'){
                for(ImageStreamList::iterator itr=_imageStreamList.begin();
                    itr!=_imageStreamList.end();
                    ++itr)
                {
                    std::cout<< (*itr).get() << " Restart"<<std::endl;
                    (*itr)->rewind();
                    (*itr)->play();
                }
                return true;
            }
            else if (ea.getKey()=='>'){
                for(ImageStreamList::iterator itr=_imageStreamList.begin();
                    itr!=_imageStreamList.end();
                    ++itr)
                {
                    std::cout<<"Seeking"<<std::endl;
                    if(_seekIncr > 3) _seekIncr = 0;
                    double length = (*itr)->getLength();
                    double t_pos = (length/4.0f)*_seekIncr;
                    //(*itr)->rewind();
                    (*itr)->seek(t_pos);
                    (*itr)->play();
                    _seekIncr++;
                }
                return true;
            }
            else if (ea.getKey()=='L'){
                for(ImageStreamList::iterator itr=_imageStreamList.begin();
                    itr!=_imageStreamList.end();
                    ++itr)
                {
                    if ( (*itr)->getLoopingMode() == osg::ImageStream::LOOPING){
                        std::cout<< (*itr).get() << " Toggle Looping Off"<<std::endl;
                        (*itr)->setLoopingMode( osg::ImageStream::NO_LOOPING );
                    }
                    else{
                        std::cout<< (*itr).get() << " Toggle Looping On"<<std::endl;
                        (*itr)->setLoopingMode( osg::ImageStream::LOOPING );
                    }
                }
                return true;
            }
            else if (ea.getKey()=='+'){
                for(ImageStreamList::iterator itr=_imageStreamList.begin(); itr!=_imageStreamList.end(); ++itr){
                    double tm = (*itr)->getTimeMultiplier();
                    tm += 0.1;
                    (*itr)->setTimeMultiplier(tm);
                    std::cout << (*itr).get() << " Increase speed rate "<< (*itr)->getTimeMultiplier() << std::endl;
                }
                return true;
            }
            else if (ea.getKey()=='-'){
                for(ImageStreamList::iterator itr=_imageStreamList.begin();
                    itr!=_imageStreamList.end();
                    ++itr)
                {
                    double tm = (*itr)->getTimeMultiplier();
                    tm -= 0.1;
                    (*itr)->setTimeMultiplier(tm);
                    std::cout << (*itr).get() << " Decrease speed rate "<< (*itr)->getTimeMultiplier() << std::endl;
                }
                return true;
            }
            else if (ea.getKey()=='o'){
                for(ImageStreamList::iterator itr=_imageStreamList.begin(); itr!=_imageStreamList.end(); ++itr){
                    std::cout<< (*itr).get() << " Frame rate  "<< (*itr)->getFrameRate() <<std::endl;
                }
                return true;
            }
            return false;
        }

        default:
            return false;
    }
    return false;
}

void MovieEventHandler::getUsage(osg::ApplicationUsage& usage) const{
    usage.addKeyboardMouseBinding("p","Play/Pause movie");
    usage.addKeyboardMouseBinding("r","Restart movie");
    usage.addKeyboardMouseBinding("l","Toggle looping of movie");
    usage.addKeyboardMouseBinding("+","Increase speed of movie");
    usage.addKeyboardMouseBinding("-","Decrease speed of movie");
    usage.addKeyboardMouseBinding("o","Display frame rate of movie");
    usage.addKeyboardMouseBinding(">","Advance the movie using seek");
}





#if USE_SDL

WARNING_DISABLE
#include "SDL.h"
WARNING_ENABLE

static void soundReadCallback(void * user_data, uint8_t * data, int datalen){
    SDLAudioSink * sink = reinterpret_cast<SDLAudioSink*>(user_data);
    osg::ref_ptr<osg::AudioStream> as = sink->_audioStream.get();
    if (as.valid()){
        as->consumeAudioBuffer(data, datalen);
    }
}

SDLAudioSink::~SDLAudioSink(){
    stop();
}

void SDLAudioSink::play(){
    if (_started){
        if (_paused){
            SDL_PauseAudio(0);
            _paused = false;
        }
        return;
    }

    _started = true;
    _paused = false;

    osg::notify(osg::NOTICE)<<"SDLAudioSink()::startPlaying()"<<std::endl;
    osg::notify(osg::NOTICE)<<"  audioFrequency()="<<_audioStream->audioFrequency()<<std::endl;
    osg::notify(osg::NOTICE)<<"  audioNbChannels()="<<_audioStream->audioNbChannels()<<std::endl;
    osg::notify(osg::NOTICE)<<"  audioSampleFormat()="<<_audioStream->audioSampleFormat()<<std::endl;

    SDL_AudioSpec specs = { 0 };
    SDL_AudioSpec wanted_specs = { 0 };

    wanted_specs.freq = _audioStream->audioFrequency();
    wanted_specs.format = AUDIO_S16SYS;
    wanted_specs.channels = _audioStream->audioNbChannels();
    wanted_specs.silence = 0;
    wanted_specs.samples = 1024;
    wanted_specs.callback = soundReadCallback;
    wanted_specs.userdata = this;

	if (SDL_OpenAudio(&wanted_specs, &specs) < 0){
        throw "SDL_OpenAudio() failed (" + std::string(SDL_GetError()) + ")";
	}

    SDL_PauseAudio(0);
}

void SDLAudioSink::pause(){
    if (_started){
        SDL_PauseAudio(1);
        _paused = true;
    }
}

void SDLAudioSink::stop(){
    if (_started){
        if (!_paused) SDL_PauseAudio(1);
        SDL_CloseAudio();
        osg::notify(osg::NOTICE)<<"~SDLAudioSink() destructor, but still playing"<<std::endl;
    }
}

#endif //USE_SDL
