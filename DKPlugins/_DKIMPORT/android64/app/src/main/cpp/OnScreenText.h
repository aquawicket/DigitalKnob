#ifndef ONSCREENTEXT_H
#define ONSCREENTEXT_H

#include <SDL.h>
#include <SDL_ttf.h>
#include <string>
#include <vector>

struct OSText {
	std::string label;
	std::string text;
	TTF_Font* font;
	int size;
	SDL_Color color;
	SDL_Rect rect;
	SDL_Texture* mSdlTexture;
};

class OnScreenText
{
public:
	static bool Init(SDL_Renderer* sdlRenderer);
	static int Create(const std::string& label, const std::string text, const int x, const int y);
	static void SetText(const int& i, const std::string& text);
	static void Render(const int& i);
	static void Draw(const std::string& label, std::string text, const int x, const int y);
	static std::vector<OSText> mOsText;
	static SDL_Renderer* mSdlRenderer;
};

#endif