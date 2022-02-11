#include "OnScreenText.h"
#include "FileInterface.h"

std::vector<OSText> OnScreenText::mOsText;
SDL_Renderer* OnScreenText::mSdlRenderer = NULL;

bool OnScreenText::Init(SDL_Renderer* sdlRenderer)
{
	if(!mSdlRenderer)
		mSdlRenderer = sdlRenderer;
	if(!TTF_WasInit())
		TTF_Init();
	return true;
}

int OnScreenText::Create(const std::string& label, const std::string text, const int x, const int y)
{
	OSText osText;
	osText.label = label;
	osText.text = text;
	std::string font_file = "assets/LatoLatin-Regular.ttf"; //DEFAULT
	std::string font_path = FileInterface::mRoot + font_file;
	osText.size = 20; //DEFAULT
	osText.font = TTF_OpenFont(font_path.c_str(), osText.size);
	//TTF_SetFontStyle(osText.font, TTF_STYLE_BOLD);
	//TTF_SetFontOutline(osText.font, 1);
	if (!osText.font) {
		printf("Error: could not load font %s\n", font_file.c_str());
		return -1;
	}
	osText.color = { 160,160,250 }; //DEFAULT
	osText.rect.x = x;
	osText.rect.y = y;

	SDL_Surface* sdlSurface = TTF_RenderText_Solid(osText.font, osText.text.c_str(), osText.color);
	osText.mSdlTexture = SDL_CreateTextureFromSurface(mSdlRenderer, sdlSurface);
	if (!osText.mSdlTexture) {
		printf("The Texture is Invalid\n");
		return -1;
	}
	SDL_QueryTexture(osText.mSdlTexture, NULL, NULL, &osText.rect.w, &osText.rect.h);
	mOsText.push_back(osText);
	SDL_FreeSurface(sdlSurface);
	return mOsText.size() - 1;
}

void OnScreenText::SetText(const int& i, const std::string& text)
{
	SDL_DestroyTexture(mOsText[i].mSdlTexture);
	SDL_Surface* sdlSurface = TTF_RenderText_Solid(mOsText[i].font, mOsText[i].text.c_str(), mOsText[i].color);
	mOsText[i].mSdlTexture = SDL_CreateTextureFromSurface(mSdlRenderer, sdlSurface);
	SDL_QueryTexture(mOsText[i].mSdlTexture, NULL, NULL, &mOsText[i].rect.w, &mOsText[i].rect.h);
	SDL_FreeSurface(sdlSurface);
}

void OnScreenText::Render(const int& i)
{
	SDL_RenderCopy(mSdlRenderer, mOsText[i].mSdlTexture, NULL, &mOsText[i].rect);
}

//Single function to create and draw within a render loop.
void OnScreenText::Draw(const std::string& label, std::string text, const int x, const int y)
{
	for (unsigned int i = 0; i < mOsText.size(); ++i) {
		if (mOsText[i].label == label){
			mOsText[i].rect.x = x;
			mOsText[i].rect.y = y;
			if (mOsText[i].text != text) {
				mOsText[i].text = text;
				SetText(i, text);
			}
			Render(i);
			return;
		}
	}
	int n = Create(label, text, x, y);
	if(n < 0)
		return;
	if (mOsText[n].mSdlTexture)
		Render(n);
}