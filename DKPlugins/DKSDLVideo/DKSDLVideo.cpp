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

// https://gist.github.com/mashingan/e94d41e21c6e0ce4c9f19cea72a57dc4

#include "DK/stdafx.h"
#include "DKSDLVideo/DKSDLVideo.h"
#include "DK/DKFile.h"
#include "DKSDLWindow/DKSDLWindow.h"


bool DKSDLVideo::Init() {
	DKDEBUGFUNC();

	//DKSDLWindow::AddEventFunc(&DKSDLVideo::OnEvent, this);
	
	OpenFile_A(DKFile::local_assets+"/DKSDLVideo/test.mp4");
	CloseFile_A();
	return true;
}

bool DKSDLVideo::End() {
	DKDEBUGFUNC();
	return true;
}

bool DKSDLVideo::OpenFile_A(const DKString& file) {
	
	// ffmpeg
    AVFormatContext* pFormatCtx;
    int vidId = -1;
	int audId = -1;
    double fpsrendering = 0.0;
    AVCodecContext* vidCtx;
	AVCodecContext* audCtx;
    AVCodec* vidCodec;
	AVCodec* audCodec;
    AVCodecParameters* vidpar;
	AVCodecParameters* audpar;
    AVFrame* vframe;
	AVFrame* aframe;
    AVPacket* packet;
	
	//sdl
    int swidth;
	int sheight;
    SDL_Window* screen;
    SDL_Renderer* renderer;
    SDL_Texture* texture;
    SDL_Rect rect;
    SDL_AudioDeviceID auddev;
    SDL_AudioSpec want;
	SDL_AudioSpec have;
	
	SDL_Init(SDL_INIT_EVERYTHING);
    pFormatCtx = avformat_alloc_context();
    char bufmsg[1024];
	
	if(avformat_open_input(&pFormatCtx, file.c_str(), NULL, NULL) < 0)
        return DKERROR("avformat_open_input() failed! \n"); //goto clean_format_context;
    if(avformat_find_stream_info(pFormatCtx, NULL) < 0)
		return DKERROR("avformat_find_stream_info() failed! \n"); //goto clean_format_context;
	bool foundVideo = false;
	bool foundAudio = false;
    for(int i = 0; i < pFormatCtx->nb_streams; i++) {
        AVCodecParameters *localparam = pFormatCtx->streams[i]->codecpar;
		const AVCodec *localcodec = avcodec_find_decoder(localparam->codec_id);
        if(localparam->codec_type == AVMEDIA_TYPE_VIDEO && !foundVideo) {
            vidCodec = (AVCodec*)localcodec;
            vidpar = localparam;
            vidId = i;
            AVRational rational = pFormatCtx->streams[i]->avg_frame_rate;
            fpsrendering = 1.0 / ((double)rational.num / (double)(rational.den));
            foundVideo = true;
        } 
		else if(localparam->codec_type == AVMEDIA_TYPE_AUDIO && !foundAudio) {
            audCodec = (AVCodec*)localcodec;
            audpar = localparam;
            audId = i;
            foundAudio = true;
        }
        if(foundVideo && foundAudio)
			break;
    }
	vidCtx = avcodec_alloc_context3(vidCodec);
    audCtx = avcodec_alloc_context3(audCodec);
    if(avcodec_parameters_to_context(vidCtx, vidpar) < 0)
		return DKERROR("avcodec_parameters_to_context() failed! \n"); //goto clean_codec_context;
    if(avcodec_parameters_to_context(audCtx, audpar) < 0)
        return DKERROR("avcodec_parameters_to_context() failed! \n"); //goto clean_codec_context;
    if(avcodec_open2(vidCtx, vidCodec, NULL) < 0)
		return DKERROR("avcodec_open2() failed! \n"); //goto clean_codec_context;
    if(avcodec_open2(audCtx, audCodec, NULL) < 0)
		return DKERROR("avcodec_open2() failed! \n"); //goto clean_codec_context;
    vframe = av_frame_alloc();
    aframe = av_frame_alloc();
    packet = av_packet_alloc();
    swidth = vidpar->width;
    sheight = vidpar->height;
    screen = SDL_CreateWindow("DKSDLVideo", SDL_WINDOWPOS_UNDEFINED, SDL_WINDOWPOS_UNDEFINED, swidth, sheight, SDL_WINDOW_OPENGL); 
    if(!screen)
		return DKERROR("screen invalid! \n"); //goto clean_packet_frame;
	renderer = SDL_CreateRenderer(screen, -1, SDL_RENDERER_ACCELERATED);
    if(!renderer)
        return DKERROR("renderer invalid! \n"); //goto clean_renderer;
	texture = SDL_CreateTexture(renderer, SDL_PIXELFORMAT_IYUV, SDL_TEXTUREACCESS_STREAMING | SDL_TEXTUREACCESS_TARGET, swidth, sheight);
    if(!texture)
        return DKERROR("texture invalid! \n"); // goto clean_texture:
    rect.x = 0;
    rect.y = 0;
    rect.w = swidth;
    rect.h = sheight;
    SDL_zero(want);
    SDL_zero(have);
    want.samples = audpar->sample_rate;
    want.channels = audpar->channels;
    auddev = SDL_OpenAudioDevice(NULL, 0, &want, &have, 0);
    SDL_PauseAudioDevice(auddev, 0);
    if(!auddev)
		return DKERROR("auddev invalid! \n"); // goto clean_audio_device:
    SDL_Event evt;
    uint32_t windowID = SDL_GetWindowID(screen);
    
        
	//////////// LOOP ////////////////////////////
	bool running = true;
    while(running) {
        while(av_read_frame(pFormatCtx, packet) >= 0) {
            while(SDL_PollEvent(&evt)) {
                switch (evt.type) {
                    case SDL_WINDOWEVENT: {
                        if(evt.window.windowID == windowID) {
                            switch(evt.window.event) {
                                case SDL_WINDOWEVENT_CLOSE: {
                                    evt.type = SDL_QUIT;
                                    running = false;
                                    SDL_PushEvent(&evt);
                                    break;
                                }
                            };
                        }
                        break;
                    }
                    case SDL_QUIT: {
                        running = false;
                        break;
                    }
                }
            }
            if(packet->stream_index == vidId) {
                display_A(vidCtx, packet, vframe, &rect, texture, renderer, fpsrendering);
            } 
			else if(packet->stream_index == audId) {
                playaudio_A(audCtx, packet, aframe, auddev);
            }
            av_packet_unref(packet);
        }
    }
	////////////////////////////////////////////////
	
	
	return true;
}

bool DKSDLVideo::CloseFile_A() {
	
	clean_audio_device:
    SDL_CloseAudioDevice(auddev);
	
    clean_texture:
    SDL_DestroyTexture(texture);
	
    clean_renderer:
    SDL_DestroyRenderer(renderer);
    SDL_DestroyWindow(screen);
	
    clean_packet_frame:
    av_packet_free(&packet);
    av_frame_free(&vframe);
    av_frame_free(&aframe);
	
    clean_codec_context:
    avcodec_free_context(&vidCtx);
    avcodec_free_context(&audCtx);
	
    clean_format_context:
    avformat_close_input(&pFormatCtx);
    avformat_free_context(pFormatCtx);
    SDL_Quit();
	return true;
}

void DKSDLVideo::display_A(AVCodecContext* ctx, AVPacket* pkt, AVFrame* frame, SDL_Rect* rect, SDL_Texture* texture, SDL_Renderer* renderer, double fpsrend) {
	time_t start = time(NULL);
    if(avcodec_send_packet(ctx, pkt) < 0) {
        DKERROR("avcodec_send_packet() failed! \n");
		return;
    }
    if(avcodec_receive_frame(ctx, frame) < 0) {
        DKERROR("avcodec_receive_frame() failed! \n");
        return;
    }
    int framenum = ctx->frame_number;
    if((framenum % 1000) == 0) {
        printf("Frame %d (size=%d pts %d dts %d key_frame %d"
            " [ codec_picture_number %d, display_picture_number %d\n",
            framenum, frame->pkt_size, frame->pts, frame->pkt_dts, frame->key_frame,
            frame->coded_picture_number, frame->display_picture_number);
    }
    SDL_UpdateYUVTexture(texture, rect, frame->data[0], frame->linesize[0], frame->data[1], frame->linesize[1], frame->data[2], frame->linesize[2]);
    SDL_RenderClear(renderer);
    SDL_RenderCopy(renderer, texture, NULL, rect);
    SDL_RenderPresent(renderer);
    time_t end = time(NULL);
    double diffms = difftime(end, start) / 1000.0;
    if(diffms < fpsrend) {
        uint32_t diff = (uint32_t)((fpsrend - diffms) * 1000);
        printf("diffms: %f, delay time %d ms.\n", diffms, diff);
        SDL_Delay(diff);
    }
}

void DKSDLVideo::playaudio_A(AVCodecContext *ctx, AVPacket *pkt, AVFrame *frame, SDL_AudioDeviceID auddev) {
	if(avcodec_send_packet(ctx, pkt) < 0) {
        DKERROR("avcodec_send_packet() failed! \n");
        return;
    }
    if(avcodec_receive_frame(ctx, frame) < 0) {
        DKERROR("avcodec_receive_frame() failed! \n");
        return;
    }
    int size;
    int bufsize = (int)av_samples_get_buffer_size(&size, ctx->channels, frame->nb_samples, (AVSampleFormat)frame->format, 0);
    bool isplanar = (bool)av_sample_fmt_is_planar((AVSampleFormat)frame->format) == 1;
    for(int ch = 0; ch < ctx->channels; ch++) {
        if(!isplanar) {
            if(SDL_QueueAudio(auddev, frame->data[ch], frame->linesize[ch]) < 0) {
                DKERROR("SDL_QueueAudio() failed! \n");
                return;
            }
        } 
		else {
            if(SDL_QueueAudio(auddev, frame->data[0] + size*ch, size) < 0) {
                DKERROR("SDL_QueueAudio() failed! \n");
                return;
            }
        }
    }
}

/*
bool DKSDLVideo::OnEvent(SDL_Event *event) {
	DKDEBUGFUNC(event);
	return false;
}
*/