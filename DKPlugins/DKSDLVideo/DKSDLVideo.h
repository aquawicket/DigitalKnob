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

//https://github.com/ashafiei/dranger-ffmpeg-tuto
//http://dranger.com/ffmpeg/
#pragma once
#ifndef DKSDLVideo_H
#define DKSDLVideo_H

#include "DK/DK.h"

//WARNING_DISABLE
#include "SDL.h"
#include <assert.h>
extern "C" {
	#include <libavcodec/avcodec.h>
	#include <libavdevice/avdevice.h>
	#include <libavfilter/avfilter.h>
	#include <libavformat/avformat.h>
	#include <libavformat/avio.h>
	#include <libavutil/avutil.h>
	#include <libpostproc/postprocess.h>
	#include <libswresample/swresample.h>
	#include <libswscale/swscale.h>
	#include <libavutil/frame.h>
	#include <libavutil/imgutils.h>
}
//WARNING_ENABLE

#define ERROR_SIZE 128
#define VIDEO_FORMAT AV_PIX_FMT_RGB24
#define SDL_AUDIO_BUFFER_SIZE 1024;
#define AVCODEC_MAX_AUDIO_FRAME_SIZE 192000

typedef struct _AudioPacket {
	AVPacketList* first, * last;
	int nb_packets, size;
	SDL_mutex* mutex;
	SDL_cond* cond;
} AudioPacket;


class DKSDLVideo : public DKObjectT<DKSDLVideo>
{
public:
	bool Init();
	bool End();
	
	bool OpenFile(const DKString& file);
	
	// SDLWrapper
	static void SDLWrapper_init_sdl();
	void SDLWrapper_open_audio(SDL_AudioSpec* desired, SDL_AudioSpec* obtained);
	
	
	// Player
	void Player_run(std::string, std::string window_nam="");
	void Player_clear();
	bool Player_open();
	int Player_get_video_stream(void);
	int Player_malloc(void);
	int Player_create_display(void);
	int Player_display_video(void);
	static int Player_getAudioPacket(AudioPacket*, AVPacket*, int);
	int Player_read_audio_video_codec(void);
	
	std::string video_addr;
	std::string window_name;
	int videoStream = 0;
	int audioStream = 0;
	AVFormatContext* pFormatCtx = NULL;
	AVCodecParameters* pCodecParameters = NULL;
	AVCodecParameters* pCodecAudioParameters = NULL;
	AVCodecContext* pCodecCtx = NULL;
	AVCodecContext* pCodecAudioCtx = NULL;
	AVCodec* pCodec = NULL;
	AVCodec* pAudioCodec = NULL;
	AVFrame* pFrame = NULL;
	AVFrame* pFrameRGB = NULL;
	uint8_t* buffer = NULL;
	SDL_Window* screen = NULL;
	SDL_Renderer* renderer = NULL;
	SDL_Texture* bmp = NULL;
	struct SwsContext* sws_ctx = NULL;
	
	
	// Audio
	void Audio_open();
	void Audio_malloc(AVCodecContext* pCodecAudioCtx);
	void Audio_init_audio_packet(AudioPacket* q);
	static int Audio_audio_decode_frame(AVCodecContext* aCodecCtx, uint8_t* audio_buf, int buf_size);
	int Audio_put_audio_packet(AVPacket*);
	
	struct SwrContext* swrCtx = NULL;
	static AVFrame wanted_frame;
	static AudioPacket audioq;
	SDL_AudioSpec wantedSpec = { 0 };
	SDL_AudioSpec audioSpec = { 0 };
	
	
	// AudioCallback
	static void AudioCallback_audio_callback(void* userdata, Uint8* stream, int len);
	
	

	
	
	
	
	
	
	
	
	
	/*
	bool OpenFile_A(const DKString& file);
	bool CloseFile_A();
	void display_A(AVCodecContext* ctx, AVPacket* pkt, AVFrame* frame, SDL_Rect* rect, SDL_Texture* texture, SDL_Renderer* renderer, double fpsrend);
	void playaudio_A(AVCodecContext *ctx, AVPacket *pkt, AVFrame *frame, SDL_AudioDeviceID auddev);
	*/
	
	//bool OnEvent(SDL_Event* event);
};


REGISTER_OBJECT(DKSDLVideo, true)
#endif //DKSDLVideo_H
