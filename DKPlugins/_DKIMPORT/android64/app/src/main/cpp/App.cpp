/*
 * This source file is part of RmlUi, the HTML/CSS Interface Middleware
 *
 * For the latest information, see http://github.com/mikke89/RmlUi
 *
 * Copyright (c) 2008-2010 Nuno Silva
 * Copyright (c) 2019 The RmlUi Team, and contributors
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */

#include "App.h"
#include "Framerate.h"
#include <fstream>
#include "OnScreenText.h"

bool App::mActive;
Rml::String App::mFile;
Rml::String App::mTitle;
SDL_Window* App::mSdlWindow;
SDL_Renderer* App::mSdlRenderer;
Rml::Context* App::mRmlContext;
FileInterface* App::mFileInterface;
SystemInterface* App::mSystemInterface;
RenderInterface* App::mRenderInterface;
#ifdef IOS
int App::mX = 0;
int App::mY = 0;
int App::mWidth = 320;
int App::mHeight = 480;
#else
int App::mX = SDL_WINDOWPOS_CENTERED;
int App::mY = SDL_WINDOWPOS_CENTERED;
int App::mWidth = 800;
int App::mHeight = 600;
#endif

void App::init()
{
#ifdef RMLUI_PLATFORM_WIN32
	//AllocConsole();
#endif
	if (SDL_Init(SDL_INIT_VIDEO) < 0)
		printf("ERROR: SDL_Init( SDL_INIT_VIDEO ) failed: %s\n", SDL_GetError());

    //SDL_SetHint(SDL_HINT_VIDEO_MINIMIZE_ON_FOCUS_LOSS, "0");
	SDL_Window* sdlWindow = SDL_CreateWindow("RmlUi SDL2 with SDL_Renderer", mX, mY, mWidth, mHeight, SDL_WINDOW_RESIZABLE);
	if (!sdlWindow)
		printf("SDL_Window* invalid: %s\n", SDL_GetError());
	mSdlWindow = sdlWindow;

    SDL_Renderer* sdlRenderer = SDL_CreateRenderer(sdlWindow, -1, SDL_RENDERER_ACCELERATED/* | SDL_RENDERER_PRESENTVSYNC*/);
	if (!sdlRenderer)
		printf("SDL renderer invalid: %s\n", SDL_GetError());
	mSdlRenderer = sdlRenderer;
    
	SDL_RendererInfo sdlRenderinfo;
	if (SDL_GetRendererInfo(mSdlRenderer, &sdlRenderinfo) < 0)
		printf("SDL_GetRendererInfo() failed: %s\n", SDL_GetError());

	// Print the SDL_Render name, and display it in the mTitle bar
	Rml::String rendererName = sdlRenderinfo.name;
	printf("SDL_Renderer Driver = %s\n", rendererName.c_str());
	mTitle = Rml::String("SDL_Renderer RmlUi - " + rendererName);
	SDL_SetWindowTitle(sdlWindow, mTitle.c_str());

    mFileInterface = new FileInterface( FileInterface::FindAssets(App::mFile) );
    Rml::SetFileInterface(mFileInterface);
    
    mSystemInterface = new SystemInterface;
    Rml::SetSystemInterface(mSystemInterface);
    
	mRenderInterface = new RenderInterface(mSdlRenderer, mSdlWindow);
    Rml::SetRenderInterface(mRenderInterface);
    
	if (!Rml::Initialise())
		printf("Rml::Initialise() failed\n");

	struct FontFace 
	{
		Rml::String filename;
		bool fallback_face;
	};
	FontFace font_faces[] = {
		{ "LatoLatin-Regular.ttf",    false },
		{ "LatoLatin-Italic.ttf",     false },
		{ "LatoLatin-Bold.ttf",       false },
		{ "LatoLatin-BoldItalic.ttf", false },
		{ "NotoEmoji-Regular.ttf",    true  },
	};

	OnScreenText::Init(mSdlRenderer);

	for (const FontFace& face : font_faces) {
		Rml::LoadFontFace("assets/" + face.filename, face.fallback_face);
	}

	Rml::Context* rmlContext = Rml::CreateContext("default", Rml::Vector2i(mWidth, mHeight) );
	mRmlContext = rmlContext;

	Rml::Debugger::Initialise(rmlContext);
	if (mFile.empty())
	{
		mFile = "assets/demo.rml";
	}
	Rml::ElementDocument* rmlDocument = rmlContext->LoadDocument(mFile); //Path to resources

	if (rmlDocument) {
		rmlDocument->Show();
		fprintf(stdout, "Document loaded\n");
	}
	else {
		fprintf(stdout, "Document is nullptr\n");
	}

	mActive = true;
	loop();
	exit();
}


void App::loop()
{
	while (mActive)
	{
		Framerate::LimitFramerate(60);
		do_frame();
	}
}
	
void App::draw_background(SDL_Renderer* sdlRenderer, int width, int height)
{
	SDL_Color sdlColor[2] = { { 100, 100, 100, 255 }, { 150, 150, 150, 255 } };
	SDL_Rect sdlRect({ 0,0,8,8 });
	int i, x, y;
	for (y = 0; y < height; y += sdlRect.h) {
		for (x = 0; x < width; x += sdlRect.w) {
			i = (((x ^ y) >> 3) & 1);
			sdlRect.x = x;
			sdlRect.y = y;
			SDL_SetRenderDrawColor(sdlRenderer, sdlColor[i].r, sdlColor[i].g, sdlColor[i].b, sdlColor[i].a);
			SDL_RenderFillRect(sdlRenderer, &sdlRect);
		}
	}
}

void App::do_frame()
{
	SDL_Event event;

	SDL_RenderClear(mSdlRenderer);

	//adjust the Context if the window is resized
	SDL_GetWindowSize(mSdlWindow, &mWidth, &mHeight);
    if(!mRmlContext){
        printf("ERROR: The context is invalid\n");
        return;
    }
	if (mWidth != mRmlContext->GetDimensions().x || mHeight != mRmlContext->GetDimensions().y)
	{
		mRmlContext->SetDimensions(Rml::Vector2i(mWidth, mHeight));
	}
	
	draw_background(mSdlRenderer, mWidth, mHeight);
	mRmlContext->Render();

	Uint8 r, g, b, a;
	SDL_GetRenderDrawColor(mSdlRenderer, &r, &g, &b, &a);
	SDL_SetRenderDrawColor(mSdlRenderer, 0, 0, 0, 180);
	SDL_SetRenderDrawBlendMode(mSdlRenderer, SDL_BLENDMODE_BLEND);
	SDL_Rect rect = { mWidth-100, 3, 80, 30 };
	SDL_RenderFillRect(mSdlRenderer, &rect);
	SDL_SetRenderDrawBlendMode(mSdlRenderer, SDL_BLENDMODE_NONE);
	SDL_SetRenderDrawColor(mSdlRenderer, r, g, b, a);
	OnScreenText::Draw("label", std::to_string(Framerate::GetFps())+"fps", (mWidth - 90), 5);

	SDL_RenderPresent(mSdlRenderer);

	while (SDL_PollEvent(&event))
	{
		switch (event.type)
		{
		case SDL_QUIT:
			mActive = false;
			break;

		case SDL_MOUSEMOTION:
			mRmlContext->ProcessMouseMove(event.motion.x, event.motion.y, mSystemInterface->GetKeyModifiers());
			break;
		case SDL_MOUSEBUTTONDOWN:
			mRmlContext->ProcessMouseButtonDown(mSystemInterface->TranslateMouseButton(event.button.button), mSystemInterface->GetKeyModifiers());
			break;

		case SDL_MOUSEBUTTONUP:
			mRmlContext->ProcessMouseButtonUp(mSystemInterface->TranslateMouseButton(event.button.button), mSystemInterface->GetKeyModifiers());
			break;

		case SDL_MOUSEWHEEL:
			mRmlContext->ProcessMouseWheel(float(-event.wheel.y), mSystemInterface->GetKeyModifiers());
			break;

		case SDL_KEYDOWN:
		{
			// Intercept F11 key stroke to toggle Fullscreen
			if (event.key.keysym.sym == SDLK_F11)
			{
				long FullscreenFlag = SDL_WINDOW_FULLSCREEN;
				bool isFullscreen = ((SDL_GetWindowFlags(mSdlWindow) & FullscreenFlag) != 0);
				isFullscreen ? SDL_SetWindowFullscreen(mSdlWindow, 0) : SDL_SetWindowFullscreen(mSdlWindow, SDL_WINDOW_FULLSCREEN_DESKTOP);
				break;
			}
			// Intercept F12 key stroke to toggle RmlUi's visual debugger tool
			if (event.key.keysym.sym == SDLK_F12)
			{
				Rml::Debugger::SetVisible(!Rml::Debugger::IsVisible());
				break;
			}

			mRmlContext->ProcessKeyDown(mSystemInterface->TranslateKey(event.key.keysym.sym), mSystemInterface->GetKeyModifiers());
			break;
		}

		default:
			break;
		}
	}
	mRmlContext->Update();

	// update framerate in the window Titlebar
	//Rml::String title = mTitle + " : " + std::to_string(Framerate::GetFps()) + "fps";
	//SDL_SetWindowTitle(mSdlWindow, title.c_str());
}

void App::exit() 
{
	mActive = false;
	Rml::Shutdown();
    SDL_DestroyRenderer(mSdlRenderer);
    SDL_DestroyWindow(mSdlWindow);
    SDL_Quit();
}
