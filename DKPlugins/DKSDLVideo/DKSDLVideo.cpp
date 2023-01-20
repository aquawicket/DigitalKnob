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
#include "DKSDLVideo/DKSDLVideo.h"
#include "DK/DKFile.h"
#include "DKSDLWindow/DKSDLWindow.h"

// http://www.dranger.com/ffmpeg/tutorial01.html
bool DKSDLVideo::Init() {
	DKDEBUGFUNC();

	av_register_all();
	
	DKSDLWindow::AddEventFunc(&DKSDLVideo::OnEvent, this);
	DKClass::RegisterFunc("DKSDLVideo::Play", &DKSDLVideo::Play, this);
	
	Open(DKFile::local_assets+"/DKSDLVideo/test.avi");
	return true;
}

bool DKSDLVideo::End() {
	DKDEBUGFUNC();
	return true;
}

bool DKSDLVideo::Open(const DKString& file) {
	
	// open file
	AVFormatContext *pFormatCtx = NULL;
	if(avformat_open_input(&pFormatCtx, file.c_str(), NULL, 0, NULL) != 0)
		return DKERROR("avformat_open_input() failed! \n");
	
	// Retrieve stream information
	if(avformat_find_stream_info(pFormatCtx, NULL) < 0)
		return DKERROR("avformat_find_stream_info() failed! \n");
	
	// Dump information about file onto standard error
	av_dump_format(pFormatCtx, 0, file.c_str(), 0);
	
	int i;
	AVCodecContext *pCodecCtxOrig = NULL;
	AVCodecContext *pCodecCtx = NULL;

	// Find the first video stream
	videoStream=-1;
	for(i=0; i < pFormatCtx->nb_streams; i++)
		if(pFormatCtx->streams[i]->codec->codec_type == AVMEDIA_TYPE_VIDEO) {
			videoStream=i;
			break;
	}
	if(videoStream == -1)
		return DKERROR("Didn't find a video stream \n");

	// Get a pointer to the codec context for the video stream
	pCodecCtx=pFormatCtx->streams[videoStream]->codec;
	
	AVCodec *pCodec = NULL;

	// Find the decoder for the video stream
	pCodec=avcodec_find_decoder(pCodecCtx->codec_id);
	if(pCodec==NULL) 
		return DKERROR("Unsupported codec! \n");

	// Copy context
	pCodecCtx = avcodec_alloc_context3(pCodec);
	if(avcodec_copy_context(pCodecCtx, pCodecCtxOrig) != 0)
		return DKERROR("Couldn't copy codec context! \n");

	// Open codec
	if(avcodec_open2(pCodecCtx, pCodec) < 0)
		return DKERROR("Could not open codec! \n");

	//// Storing the Data ////
	AVFrame *pFrame = NULL;

	// Allocate video frame
	pFrame=av_frame_alloc();
	
	// Allocate an AVFrame structure
	pFrameRGB=av_frame_alloc();
	if(pFrameRGB == NULL)
		return DKERROR("pFrameRGB invalid! \n");
	
	uint8_t *buffer = NULL;
	int numBytes;
	
	// Determine required buffer size and allocate buffer
	numBytes=avpicture_get_size(PIX_FMT_RGB24, pCodecCtx->width, pCodecCtx->height);
	buffer = (uint8_t *)av_malloc(numBytes*sizeof(uint8_t));
	
	// Assign appropriate parts of buffer to image planes in pFrameRGB
	// Note that pFrameRGB is an AVFrame, but AVFrame is a superset
	// of AVPicture
	avpicture_fill((AVPicture *)pFrameRGB, buffer, PIX_FMT_RGB24, pCodecCtx->width, pCodecCtx->height);
	
	/// Reading the Data ///
	struct SwsContext *sws_ctx = NULL;
	int frameFinished;
	AVPacket packet;
	// initialize SWS context for software scaling
	sws_ctx = sws_getContext(pCodecCtx->width, pCodecCtx->height, pCodecCtx->pix_fmt, pCodecCtx->width, pCodecCtx->height, PIX_FMT_RGB24, SWS_BILINEAR, NULL, NULL, NULL);

	i=0;
	while(av_read_frame(pFormatCtx, &packet)>=0) {
		// Is this a packet from the video stream?
		if(packet.stream_index==videoStream) {
			// Decode video frame
			avcodec_decode_video2(pCodecCtx, pFrame, &frameFinished, &packet);
    
			// Did we get a video frame?
			if(frameFinished) {
				// Convert the image from its native format to RGB
				sws_scale(sws_ctx, (uint8_t const * const *)pFrame->data, pFrame->linesize, 0, pCodecCtx->height, pFrameRGB->data, pFrameRGB->linesize);
	
				// Save the frame to disk
				if(++i<=5)
					SaveFrame(pFrameRGB, pCodecCtx->width, pCodecCtx->height, i);
			}
		}
    
		// Free the packet that was allocated by av_read_frame
		av_free_packet(&packet);
	}
}

bool DKSDLVideo::Close() {
	/*
	// Free the RGB image
	av_free(buffer);
	av_free(pFrameRGB);

	// Free the YUV frame
	av_free(pFrame);

	// Close the codecs
	avcodec_close(pCodecCtx);
	avcodec_close(pCodecCtxOrig);

	// Close the video file
	avformat_close_input(&pFormatCtx);
	*/
	return true;
}

void DKSDLVideo::SaveFrame(AVFrame *pFrame, int width, int height, int iFrame) {
	FILE *pFile;
	char szFilename[32];
	int  y;
  
	// Open file
	sprintf(szFilename, "frame%d.ppm", iFrame);
	pFile=fopen(szFilename, "wb");
	if(pFile == NULL)
		return DKERROR("pFile invalid! \n");
  
	// Write header
	fprintf(pFile, "P6\n%d %d\n255\n", width, height);
  
	// Write pixel data
	for(y=0; y<height; y++)
		fwrite(pFrame->data[0]+y*pFrame->linesize[0], 1, width*3, pFile);
  
	// Close file
	fclose(pFile);
}

bool DKSDLVideo::OnEvent(SDL_Event *event) {
	DKDEBUGFUNC(event);
	return false;
}

bool DKSDLVideo::Play(const void* input, void* output) {
	DKDEBUGFUNC(input, output);
	return true;
}
