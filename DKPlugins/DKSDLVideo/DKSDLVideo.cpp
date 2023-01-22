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

AVFrame DKSDLVideo::wanted_frame;
AudioPacket DKSDLVideo::audioq;

bool DKSDLVideo::Init() {
	DKDEBUGFUNC();

	//DKSDLWindow::AddEventFunc(&DKSDLVideo::OnEvent, this);
	
	OpenFile(DKFile::local_assets+"/DKSDLVideo/test.mp4");
	return true;
}

bool DKSDLVideo::End() {
	DKDEBUGFUNC();
	return true;
}

bool DKSDLVideo::OpenFile(const DKString& file) {
    DKDEBUGFUNC(file);
	SDLWrapper_init_sdl();
	Player_run(file);
	Player_clear();
	return true;
}


/////// SDLWrapper /////// 
void DKSDLVideo::SDLWrapper_init_sdl() {
    DKDEBUGFUNC();
	SDL_Init(SDL_INIT_EVERYTHING);
	#if WIN
		SDL_AudioInit("directsound");
	#endif
}

void DKSDLVideo::SDLWrapper_open_audio(SDL_AudioSpec* desired, SDL_AudioSpec* obtained) {
    DKDEBUGFUNC(desired, obtained);
	if (SDL_OpenAudio(desired, obtained) < 0)
		DKERROR("Failed to open audio \n");
}

/////// Player /////// 
void DKSDLVideo::Player_run(std::string video_add, std::string window_nam){
    DKDEBUGFUNC(video_add, window_nam);
	video_addr = video_add;
	window_name = window_nam;
    DKINFO("entering Player_Open() \n");
	Player_open();
    DKINFO("exited Player_Open() \n");
	Player_malloc();
    DKINFO("exited Player_malloc() \n");
	Player_create_display();
	Player_display_video();
}

bool DKSDLVideo::Player_open() {
    DKDEBUGFUNC();
	audioStream = -1;

	int res = avformat_open_input(&pFormatCtx, video_addr.c_str(), NULL, NULL); // open video

	// check video
	if(res != 0)
		return DKERROR("res invalid! \n");

	// get video info
	res = avformat_find_stream_info(pFormatCtx, NULL);
	if(res < 0)
		return DKERROR("res invalid! \n");

	// get video stream
	videoStream = Player_get_video_stream();
	if(videoStream == -1)
		return DKERROR("Error opening your video using AVCodecParameters, probably doesnt have codecpar_type type AVMEDIA_TYPE_VIDEO \n");

	// open
	Player_read_audio_video_codec();
}

void DKSDLVideo::Player_clear() {
    DKDEBUGFUNC();
	// close context info
	avformat_close_input(&pFormatCtx);
	avcodec_free_context(&pCodecCtx);

	// free buffers
	av_free(buffer);
	av_free(pFrameRGB);

	// Free the YUV frame
	av_free(pFrame);

	// Close the codecs
	avcodec_close(pCodecCtx);

	// Close the video file
	avformat_close_input(&pFormatCtx);

	//delete Player::get_instance();
}

int DKSDLVideo::Player_get_video_stream(void) {
    DKDEBUGFUNC();
	int videoStream = -1;
	for(unsigned int i = 0; i<pFormatCtx->nb_streams; i++){
		if (pFormatCtx->streams[i]->codecpar->codec_type == AVMEDIA_TYPE_VIDEO) 
			videoStream = i;
		if (pFormatCtx->streams[i]->codecpar->codec_type == AVMEDIA_TYPE_AUDIO) 
			audioStream = i;
	}
	if(videoStream == -1)
		DKERROR("Couldnt find stream \n");
	pCodecParameters = pFormatCtx->streams[videoStream]->codecpar;
	if(audioStream != -1) 
		pCodecAudioParameters = pFormatCtx->streams[audioStream]->codecpar;
	return videoStream;
}

int DKSDLVideo::Player_malloc(void){
    DKDEBUGFUNC();
	Audio_malloc(pCodecAudioCtx);
	Audio_open();
	pFrame = av_frame_alloc();
	if(pFrame == NULL)
		DKERROR("Couldnt allocate frame memory! \n");
	pFrameRGB = av_frame_alloc();
	if(pFrameRGB == NULL)
		DKERROR("Couldnt allocate rgb frame memory! \n");
	int numBytes = av_image_get_buffer_size(VIDEO_FORMAT, pCodecCtx->width, pCodecCtx->height, 1);
	buffer = (uint8_t *)av_malloc(numBytes*sizeof(uint8_t));
	int res = av_image_fill_arrays(pFrameRGB->data, pFrameRGB->linesize, buffer, VIDEO_FORMAT, pCodecCtx->width, pCodecCtx->height, 1);
	if (res < 0)
		DKERROR("res invalid! \n");
	
	return 1;
}

int DKSDLVideo::Player_create_display(void) {
    DKDEBUGFUNC();
	screen = SDL_CreateWindow(window_name.c_str(), SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, pCodecCtx->width, pCodecCtx->height, SDL_WINDOW_OPENGL);
	if (!screen)
		DKERROR("Couldn't show display window \n");
	renderer = SDL_CreateRenderer(screen, -1, 0);
	bmp = SDL_CreateTexture(renderer, SDL_PIXELFORMAT_YV12, SDL_TEXTUREACCESS_STATIC, pCodecCtx->width, pCodecCtx->height);
	return 1;
}

int DKSDLVideo::Player_display_video(void) {
    DKDEBUGFUNC();
	AVPacket packet;
	//video context
	sws_ctx = sws_getContext(pCodecCtx->width, pCodecCtx->height, pCodecCtx->pix_fmt, pCodecCtx->width, pCodecCtx->height, VIDEO_FORMAT, SWS_BILINEAR, NULL, NULL, NULL);
	SDL_Event evt;
	while (av_read_frame(pFormatCtx, &packet) >= 0) {
		if (packet.stream_index == audioStream){
			//Audio::get_instance()->put_audio_packet(&packet);
			Audio_put_audio_packet(&packet);
		}
		if (packet.stream_index == videoStream) {
			int res = avcodec_send_packet(pCodecCtx, &packet);
			if (res < 0)
				DKERROR("res invalid! \n");
			res = avcodec_receive_frame(pCodecCtx, pFrame);
			SDL_UpdateYUVTexture(bmp, NULL, pFrame->data[0], pFrame->linesize[0], pFrame->data[1], pFrame->linesize[1], pFrame->data[2], pFrame->linesize[2]);
			SDL_RenderCopy(renderer, bmp, NULL, NULL);
			SDL_RenderPresent(renderer);
			SDL_UpdateWindowSurface(screen);
			SDL_Delay(1000/30);
		}
		SDL_PollEvent(&evt);
		av_packet_unref(&packet);
	}
	return 1;
}

int DKSDLVideo::Player_getAudioPacket(AudioPacket* q, AVPacket* pkt, int block) {
    DKDEBUGFUNC();
	AVPacketList* pktl;
    int ret;
    SDL_LockMutex(q->mutex);
    while (1){
        pktl = q->first;
        if (pktl){
            q->first = pktl->next;
            if (!q->first)
                q->last = NULL;
            q->nb_packets--;
            q->size -= pktl->pkt.size;
            *pkt = pktl->pkt;
            av_free(pktl);
            ret = 1;
            break;
        }
        else if(!block) {
            ret = 0;
            break;
        }
        else {
            SDL_CondWait(q->cond, q->mutex);
        }
    }
    SDL_UnlockMutex(q->mutex);
    return ret;
}

int DKSDLVideo::Player_read_audio_video_codec(void) {
    DKDEBUGFUNC();
	pCodec = (AVCodec*)avcodec_find_decoder(pCodecParameters->codec_id);
	pAudioCodec = (AVCodec*)avcodec_find_decoder(pCodecAudioParameters->codec_id);
	if (pCodec == NULL)
		DKERROR("Video decoder not found \n");
	if (pAudioCodec == NULL) 
		DKERROR("Audio decoder not found \n");
	pCodecCtx = avcodec_alloc_context3(pCodec);
	if(pCodecCtx == NULL)
		DKERROR("Failed to allocate video context decoder \n");
	pCodecAudioCtx = avcodec_alloc_context3(pAudioCodec);
	if(pCodecAudioCtx == NULL)
		DKERROR("Failed to allocate audio context decoder \n");
	int res = avcodec_parameters_to_context(pCodecCtx, pCodecParameters);
	if(res < 0)
		DKERROR("Failed to transfer video parameters to context \n");
	res = avcodec_parameters_to_context(pCodecAudioCtx, pCodecAudioParameters);
	if (res < 0) 
		DKERROR("Failed to transfer audio parameters to context \n");
	res = avcodec_open2(pCodecCtx, pCodec, NULL);
	if(res < 0)
		DKERROR("Failed to open video codec \n");
	res = avcodec_open2(pCodecAudioCtx, pAudioCodec, NULL);
	if (res < 0)
		DKERROR("Failed to open auvio codec \n");
	
	return 1;
}


/////// Audio /////// 
void DKSDLVideo::Audio_malloc(AVCodecContext* pCodecAudioCtx) {
    DKDEBUGFUNC();
    //AudioCallback::set_audio_instance(this);
    swrCtx = swr_alloc();
    if (swrCtx == NULL)
        DKERROR("Failed to load audio \n");
    av_opt_set_channel_layout(swrCtx, "in_channel_layout", pCodecAudioCtx->channel_layout, 0);
    av_opt_set_channel_layout(swrCtx, "out_channel_layout", pCodecAudioCtx->channel_layout, 0);
    av_opt_set_int(swrCtx, "in_sample_rate", pCodecAudioCtx->sample_rate, 0);
    av_opt_set_int(swrCtx, "out_sample_rate", pCodecAudioCtx->sample_rate, 0);
    av_opt_set_sample_fmt(swrCtx, "in_sample_fmt", pCodecAudioCtx->sample_fmt, 0);
    av_opt_set_sample_fmt(swrCtx, "out_sample_fmt", AV_SAMPLE_FMT_FLT, 0);
    int res = swr_init(swrCtx);
    if (res != 0)
        DKERROR("Failed to initialize audio \n");
    memset(&wantedSpec, 0, sizeof(wantedSpec));
    wantedSpec.channels = pCodecAudioCtx->channels;
    wantedSpec.freq = pCodecAudioCtx->sample_rate;
    wantedSpec.format = AUDIO_S16SYS;
    wantedSpec.silence = 0;
    wantedSpec.samples = SDL_AUDIO_BUFFER_SIZE;
    wantedSpec.userdata = pCodecAudioCtx;
    wantedSpec.callback = DKSDLVideo::AudioCallback_audio_callback;
}

void DKSDLVideo::Audio_open() {
    DKDEBUGFUNC();
    SDLWrapper_open_audio(&wantedSpec, &audioSpec);
    wanted_frame.format = AV_SAMPLE_FMT_S16;
    wanted_frame.sample_rate = audioSpec.freq;
    wanted_frame.channel_layout = av_get_default_channel_layout(audioSpec.channels);
    wanted_frame.channels = audioSpec.channels;
    Audio_init_audio_packet(&audioq);
    SDL_PauseAudio(0);
}

int DKSDLVideo::Audio_audio_decode_frame(AVCodecContext* aCodecCtx, uint8_t* audio_buf, int buf_size) {
    DKDEBUGFUNC(aCodecCtx, audio_buf, buf_size);
    static AVPacket pkt;
    static uint8_t* audio_pkt_data = NULL;
    static int audio_pkt_size = 0;
    static AVFrame frame;
    int len1;
    int data_size = 0;
    SwrContext* swr_ctx = NULL;
    while(1) {
        while(audio_pkt_size > 0) {
            int got_frame = 0;
            avcodec_send_packet(aCodecCtx, &pkt);
            avcodec_receive_frame(aCodecCtx, &frame);
            len1 = frame.pkt_size;
            if (len1 < 0) {
                audio_pkt_size = 0;
                break;
            }
            audio_pkt_data += len1;
            audio_pkt_size -= len1;
            data_size = 0;
            if (got_frame) {
                int linesize = 1;
                data_size = av_samples_get_buffer_size(&linesize, aCodecCtx->channels, frame.nb_samples, aCodecCtx->sample_fmt, 1);
                assert(data_size <= buf_size);
                memcpy(audio_buf, frame.data[0], data_size);
            }
            if (frame.channels > 0 && frame.channel_layout == 0)
                frame.channel_layout = av_get_default_channel_layout(frame.channels);
            else if (frame.channels == 0 && frame.channel_layout > 0)
                frame.channels = av_get_channel_layout_nb_channels(frame.channel_layout);
            if (swr_ctx) {
                swr_free(&swr_ctx);
                swr_ctx = NULL;
            }
            swr_ctx = swr_alloc_set_opts(NULL, wanted_frame.channel_layout, (AVSampleFormat)wanted_frame.format, wanted_frame.sample_rate,
                frame.channel_layout, (AVSampleFormat)frame.format, frame.sample_rate, 0, NULL);
            if (!swr_ctx || swr_init(swr_ctx) < 0)
                DKERROR("swr_init failed \n");
            int dst_nb_samples = (int)av_rescale_rnd(swr_get_delay(swr_ctx, frame.sample_rate) + frame.nb_samples, wanted_frame.sample_rate, wanted_frame.format, AV_ROUND_INF);
            int len2 = swr_convert(swr_ctx, &audio_buf, dst_nb_samples, (const uint8_t**)frame.data, frame.nb_samples);
            if (len2 < 0)
                DKERROR("swr_convert failed \n");
            av_packet_unref(&pkt);
            if (swr_ctx){
                swr_free(&swr_ctx);
                swr_ctx = NULL;
            }
            return wanted_frame.channels * len2 * av_get_bytes_per_sample(AV_SAMPLE_FMT_S16);
        }
        if (Player_getAudioPacket(&audioq, &pkt, 1) < 0)
            return -1;
        audio_pkt_data = pkt.data;
        audio_pkt_size = pkt.size;
    }
}

void DKSDLVideo::Audio_init_audio_packet(AudioPacket* q) {
    DKDEBUGFUNC(q);
    q->last = NULL;
    q->first = NULL;
    q->mutex = SDL_CreateMutex();
    q->cond = SDL_CreateCond();
}

int DKSDLVideo::Audio_put_audio_packet(AVPacket* packet) {
    //DKDEBUGFUNC(packet); // EXCESSIVE LOGGING
    AVPacketList* pktl;
    AVPacket* newPkt;
    newPkt = (AVPacket*)av_mallocz_array(1, sizeof(AVPacket));
    if(av_packet_ref(newPkt, packet) < 0)
        return -1;
    pktl = (AVPacketList*)av_malloc(sizeof(AVPacketList));
    if(!pktl)
        return -1;
    pktl->pkt = *newPkt;
    pktl->next = NULL;
    SDL_LockMutex(audioq.mutex);
    if(!audioq.last)
        audioq.first = pktl;
    else
        audioq.last->next = pktl;
    audioq.last = pktl;
    audioq.nb_packets++;
    audioq.size += newPkt->size;
    SDL_CondSignal(audioq.cond);
    SDL_UnlockMutex(audioq.mutex);
	
    return 0;
}


/////// AudioCallback /////// 
void DKSDLVideo::AudioCallback_audio_callback(void* userdata, Uint8* stream, int len) {
    DKDEBUGFUNC(userdata, stream, len);
    AVCodecContext* aCodecCtx = (AVCodecContext*)userdata;
    int len1;
    int audio_size;
    static uint8_t audio_buff[192000 * 3 / 2];
    static unsigned int audio_buf_size = 0;
    static unsigned int audio_buf_index = 0;
    SDL_memset(stream, 0, len);
    while (len > 0) {
        if (audio_buf_index >= audio_buf_size) {
            //audio_size = AudioCallback::audio_instance->audio_decode_frame(aCodecCtx, audio_buff, sizeof(audio_buff));
			audio_size = Audio_audio_decode_frame(aCodecCtx, audio_buff, sizeof(audio_buff));
            if (audio_size < 0) {
                audio_buf_size = 1024;
                memset(audio_buff, 0, audio_buf_size);
            }
            else
                audio_buf_size = audio_size;
            audio_buf_index = 0;
        }
        len1 = audio_buf_size - audio_buf_index;
        if (len1 > len)
            len1 = len;
        SDL_MixAudio(stream, audio_buff + audio_buf_index, len, SDL_MIX_MAXVOLUME);
        len -= len1;
        stream += len1;
        audio_buf_index += len1;
    }
}


/*
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
*/

/*
bool DKSDLVideo::OnEvent(SDL_Event *event) {
	DKDEBUGFUNC(event);
	return false;
}
*/