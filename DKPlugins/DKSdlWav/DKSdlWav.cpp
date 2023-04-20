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
#include "DKSdlWave/DKSdlWav.h"
#include "DK/DKFile.h"

WARNING_DISABLE
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
WARNING_ENABLE

#define AUDIO_FORMAT AUDIO_S16LSB
#define AUDIO_FREQUENCY 48000;
#define AUDIO_CHANNELS 2;
#define AUDIO_SAMPLES 4096;


static void addSound(Sound* root, Sound* snd);
static void freeSound(Sound* sound);
static Sound* createSound(const char* filename, uint8_t loop, int volume);
static inline void audioCallback(void* userdata, uint8_t* stream, int len);
static PrivateAudioDevice* gDevice;

typedef struct sound
{
    uint32_t length;
    uint32_t lengthTrue;
    uint8_t * bufferTrue;
    uint8_t * buffer;
    uint8_t loop;
    uint8_t fade;
    uint8_t volume;
    SDL_AudioSpec audio;
    struct sound * next;
} Sound;

typedef struct privateAudioDevice{
    SDL_AudioDeviceID device;
    SDL_AudioSpec want;
    uint8_t audioEnabled;
} PrivateAudioDevice;


bool DKSdlWav::Init(){
	if(SDL_Init(SDL_INIT_AUDIO) < 0)
		return DKERROR("Could not Init SDL_Audio\n");
	InitAudio();
	DKClass::RegisterFunc("DKSdlWav::PlaySound", &DKSdlWav::PlaySound, this);
	DKClass::RegisterFunc("DKSdlWav::OpenMusic", &DKSdlWav::OpenMusic, this);
	return true;
}

bool DKSdlWav::End(){
	endAudio();
	return true;
}

bool DKSdlWav::InitAudio(){
    Sound* global;
    gDevice = static_cast<PrivateAudioDevice*>(calloc(1, sizeof(PrivateAudioDevice)));

    if(!(SDL_WasInit(SDL_INIT_AUDIO) & SDL_INIT_AUDIO)){
        fprintf(stderr, "[%s: %d]Error: SDL_INIT_AUDIO not initialized\n", __FILE__, __LINE__);
        gDevice->audioEnabled = 0;
        return false;
    }
    else{
        gDevice->audioEnabled = 1;
    }

    if(gDevice == NULL){
        fprintf(stderr, "[%s: %d]Fatal Error: Memory c-allocation error\n", __FILE__, __LINE__);
        return false;
    }

    SDL_memset(&(gDevice->want), 0, sizeof(gDevice->want));
    (gDevice->want).freq = AUDIO_FREQUENCY;
    (gDevice->want).format = AUDIO_FORMAT;
    (gDevice->want).channels = AUDIO_CHANNELS;
    (gDevice->want).samples = AUDIO_SAMPLES;
    (gDevice->want).callback = audioCallback;
    (gDevice->want).userdata = calloc(1, sizeof(Sound));
    global = (Sound*)(gDevice->want).userdata;

    if(global == NULL){
        fprintf(stderr, "[%s: %d]Error: Memory allocation error\n", __FILE__, __LINE__);
        return false;
    }

    global->buffer = NULL;
    global->next = NULL;

    /* want.userdata = new; */
    if((gDevice->device = SDL_OpenAudioDevice(NULL, 0, &(gDevice->want), NULL, SDL_AUDIO_ALLOW_ANY_CHANGE)) == 0){
        fprintf(stderr, "[%s: %d]Warning: failed to open audio device: %s\n", __FILE__, __LINE__, SDL_GetError());
    }
    else{
        /* Unpause active audio stream */
        SDL_PauseAudioDevice(gDevice->device, 0);
    }
	return true;
}

bool DKSdlWav::EndAudio(){
    if(gDevice->audioEnabled){
        SDL_PauseAudioDevice(gDevice->device, 1);
        freeSound((Sound *) (gDevice->want).userdata);

        /* Close down audio */
        SDL_CloseAudioDevice(gDevice->device);
    }
    free(gDevice);
	return true;
}

bool DKSdlWav::playSound(const char* filename, int volume){
    Sound * snd;

    if(!gDevice->audioEnabled)
        return false;
    
    snd = createSound(filename, 0, volume);

    SDL_LockAudioDevice(gDevice->device);
    addSound((Sound *) (gDevice->want).userdata, snd);

    SDL_UnlockAudioDevice(gDevice->device);
	return true;
}

bool DKSdlWav::OpenMusic(const char* filename, int volume){
    Sound * global;
    Sound * snd;
    uint8_t music;

    if(!gDevice->audioEnabled)
        return false;

    music = 0;

    // Create new music sound with loop
    snd = createSound(filename, 1, volume);

    // Lock callback function
    SDL_LockAudioDevice(gDevice->device);
    global = ((Sound *) (gDevice->want).userdata)->next;

    // Find any existing musics, 0, 1 or 2
    while(global != NULL){
        // Phase out any current music
        if(global->loop == 1 && global->fade == 0){
            if(music){
                global->length = 0;
                global->volume = 0;
            }
            global->fade = 1;
        }
        // Set flag to remove any queued up music in favour of new music
        else if(global->loop == 1 && global->fade == 1){
            music = 1;
        }
        global = global->next;
    }

    addSound((Sound *) (gDevice->want).userdata, snd);
    SDL_UnlockAudioDevice(gDevice->device);
	return true;
}

bool DKSdlWav::PlaySound(const void* input, void* output){
	DKString path = *(DKString*)input;
	if(!DKFile::VerifyPath(path)){ return false; }
	playSound(path.c_str(), SDL_MIX_MAXVOLUME);
	return true;
}

bool DKSdlWav::OpenMusic(const void* input, void* output){
	DKString path = *(DKString*)input;
	if(!DKFile::VerifyPath(path)){ return false; }
	OpenMusic(path.c_str(), SDL_MIX_MAXVOLUME);
	return true;
}


//////////////////////////////////////////////////////////////////////////
static Sound* createSound(const char * filename, uint8_t loop, int volume){
    Sound* snd = static_cast<Sound*>(calloc(1, sizeof(Sound)));

    if(snd == NULL){
        fprintf(stderr, "[%s: %d]Error: Memory allocation error\n", __FILE__, __LINE__);
        return NULL;
    }

    snd->next = NULL;
    snd->loop = loop;
    snd->fade = 0;
    snd->volume = volume;

    if(SDL_LoadWAV(filename, &(snd->audio), &(snd->bufferTrue), &(snd->lengthTrue)) == NULL){
        fprintf(stderr, "[%s: %d]Warning: failed to open wave file: %s err: %s\n", __FILE__, __LINE__, filename, SDL_GetError());
        free(snd);
        return NULL;
    }

    snd->buffer = snd->bufferTrue;
    snd->length = snd->lengthTrue;
    (snd->audio).callback = NULL;
    (snd->audio).userdata = NULL;

    return snd;
}

static inline void audioCallback(void * userdata, uint8_t * stream, int len){
    Sound * sound = (Sound *) userdata;
    Sound * previous = sound;
    int tempLength;
    uint8_t music = 0;

    // Silence the main buffer
    SDL_memset(stream, 0, len);

    // First one is place holder
    sound = sound->next;

    while(sound != NULL){

        if(sound->length > 0){

            if(sound->fade == 1 && sound->loop == 1){
                music = 1;
                sound->volume--;

                if(sound->volume == 0){
                    sound->length = 0;
                }
            }

            if(music && sound->loop == 1 && sound->fade == 0){
                tempLength = 0;
            }

            else{
                tempLength = ((unsigned int)len > sound->length) ? sound->length : len;
            }

            SDL_MixAudioFormat(stream, sound->buffer, AUDIO_FORMAT, tempLength, sound->volume);
            sound->buffer += tempLength;
            sound->length -= tempLength;
            previous = sound;
            sound = sound->next;
        }

        else if(sound->loop == 1 && sound->fade == 0){
            sound->buffer = sound->bufferTrue;
            sound->length = sound->lengthTrue;
        }

        else{
            previous->next = sound->next;
            SDL_FreeWAV(sound->bufferTrue);
            free(sound);
            sound = previous->next;
        }
    }
}

static void addSound(Sound* root, Sound* snd){
    if(root == NULL)
        return;
    while(root->next != NULL){
        root = root->next;
    }
    root->next = snd;
}

static void freeSound(Sound *sound){
    Sound* temp;

    while(sound != NULL){
        SDL_FreeWAV(sound->bufferTrue);
        temp = sound;
        sound = sound->next;
        free(temp);
    }
}
