Developped by Cédric Van Den Bussche 
Release 0.x on 27 feb 2016

Online documentation available @ http://themealena.fr/html/SDL_GIFlib.php


This lib was developped to read gif files with SDL 2.x (latest, the best) 
Unlikely SDL_image, it will not only load one pic of a set, but allows to run it with full animation.
But, yeah, you can still load an non-animated gif though it would not be
very memory friendly considering the size of the structure used.
But, still, you could just load the file, copy the resulted SDL_texture into another
and then free the animation structure.

It can manage the most common gif files, from the overlay to the redraw method,
from the basic pictures to the interlaced ones.
Also, alpha channel is taken into consideration, thus, I strongly recommand to
use 32 bits textures with alpha chan enabled.
Really, I didn't try to set a 8 bits video texture with this lib.
Well, why would I, we are living the 3rd millenium aren't we ?

Say, so far every file I've tried has been processed successfully, not even a miss !

This lib was tested with a lot of care, though some bug may still appear.
Nice to tell me so I can correct any unwanted behaviour.


/************************************************************/

I'll here make a difference between the logical order and the reading order.

The logical order is the one internally managed by the structure as the gif is
supposed to be naturally played, as if opened with a web browser for instance.
Say, there are 5 frames in the animation, we will have something like frame[5].
frame[0] will then be the first logical frame and frame[4] the last logical frame.

The reading order is the one depending on which direction you are playing the animation.
This lib allows to "play" with how to show animation, thus you can run it backward if you wish.
In this case, animation will be played from frame[4] to frame[0] and so on...

The first reading frame will then be frame[4] while the first logical frame remains frame[0].
Remember this nuance as I'll make use of it in the functions explaination, so you don't have any surprise.




Main structure
----------------
The main structure used is an SDL_GifAnim, this to store all the informations.
This will basically be an animation instance.

/*******************************************************/

--------------------------------------------------
SDL_GifAnim* SDL_GIFAnimLoad(const *char fileName, SDL_Renderer* renderer)
--------------------------------------------------

This function will load a gif file and allocate sufficient memspace to store
an SDL_GifAnim structure.

Any created structure should be freed using SDL_GIFAnimFree().

Basic Code :

SDL_GifAnim *animation = SDL_GIFAnimLoad("file.gif", myRenderer);

return value :
- on success, pointer to an SDL_GifAnim structure is returned.
- a NULL pointer is returned if function has failed, stderr is completed with error information.

The main texture (as returned by SDL_GIFTexture()) shows the first logical frame if displayed as it is.

Animation mode is set to GIF_STOP when loaded, you must enable animation by setting
the animation mode through SDL_GIFLoopMode().



/**************************************************/

---------------------------------------
void SDL_GIFAnimFree(SDL_GifAnim* anim)
---------------------------------------

frees allocated SDL_GifAnim structure.

/****************************************************/

----------------------------------------------
SDL_Texture SDL_GIFTexture(SDL_GifAnim* anim)
----------------------------------------------

This function returns the main texture to be used for your application.
This SDL_Texture will remain unchanged, thus you don't need to manage
the modifications on this texture.

Basic Code :

	animation = SDL_GIFAnimLoad("MS0.gif", myRender);

	SDL_Texture *actTexture = SDL_GIFTexture(animation);
	SDL_GIFLoopMode(animation, GIF_REPEAT_FOR);


	while(!anyKeyHit())
	{
		SDL_GIFAnimAuto(animation);
		SDL_RenderClear(myRender);
		SDL_RenderCopy(myRender,actTexture,NULL,&blitPos);
		SDL_RenderPresent(myRender);
	}
	
Thus, though acttexture state is modified by SDL_GIFAnimAuto(),
you can endlessely blit acttexture.
Mostly, you can store it anywhere once for all without having to worry
about it to change.

/******************************************************/

---------------------------------------
char SDL_GIFAnimAuto(SDL_GifAnim* anim)
---------------------------------------

This function updates the main texture according to the reading mode parameters 
and individual frames delay.

Return value is 1 when when a changed has occured, meaning when the frame has changed. Returns 0 otherwise.
This can be used if you don't want to blit again and again but only when the animation has been refreshed.

Basic Code :

	SDL_Texture *actTexture = SDL_GIFTexture(animation);
	SDL_GIFLoopMode(animation, GIF_REPEAT_FOR);

	while(!anyKeyHit())
	{
		SDL_GIFAnimAuto(animation);
		SDL_RenderClear(myRender);
		SDL_RenderCopy(myRender,actTexture,NULL,&blitPos);
		SDL_RenderPresent(myRender);
	}
		
	/**or refreshing screen only when needed :**/

	while(!anyKeyHit())
	{	
		if(SDL_GIFAnimAuto(animation))
		{
			SDL_RenderClear(myRender);
			SDL_RenderCopy(myRender,actTexture,NULL,&blitPos);
			SDL_RenderPresent(myRender);
		}
	}
	
	
If you stop calling SDL_GIFAnimAuto(), no animation occurs, and is just freezed as it
until further update.
The main texture will keep displaying what it was displaying before you stopped calling SDL_GIFAnimAuto().

note that if you restart the animation by calling the fonction again, the actual frame delay may be
overpassed, causing the animation to instantly skip to the next reading frame.

/************************************************************/

----------------------------------------------------------
void SDL_GIFLoopMode(SDL_GifAnim* anim, unsigned int mode)
----------------------------------------------------------

This function allows to specify the loop behaviour.
anim is the SDL_GifAnim which you want to modify.

mode can get any of these values :

 GIF_REPEAT_FOR  : gif loops forward, just as it would if opened with any software.
 GIF_ONCE_FOR    : gif will run from first frame to latest then stop, see SDL_GIFLoopReset() to restart animation.
 GIF_FORTH_BACK  : gif will loop forth and back, show all frames from first to last, then backward to first and so on...
 GIF_REPEAT_REV  : gif loops backward, shows all frames from last logical frame to first, then starts from last again and so on..
 GIF_ONCE_REV    : same as GIF_ONCE_FOR, but reverse, from last logical frame to first.
 GIF_STOP        : animation is stopped and is reset to display the first logical frame.
 
 
 ATTENTION : 
 The play-it-backward can sometimes lead to a weird result as some
 frames may be set to (partly) overlay the previous one instead of an "erase and replace" behaviour.
 This is called the disposal method. This method cannot be inhibited with this lib.
 Playing backward will keep the disposal method unchanged : a frame supposed to overlay the logical previous frame
 will then overlay the following logical frame instead. Which is not what was supposed to happen when the gif
 was initially created.
 Obviously, an animation with the overlay method is not meant to be played backward. 
 But, hey! try it for fun.

/*************************************************************/

----------------------------------------
void SDL_GIFLoopReset(SDL_GifAnim* anim)
----------------------------------------

This function simply resets the animation loop that will then start playing again 
from the first reading frame accordingly to the reading mode.

Say you played it one shot (GIF_ONCE_XXX), this will allow the loop to restart
and be played once again from the first reading frame.

Resetting an animation set to GIF_FORTH_BACK mode will go back to the first logical frame and
set it to start forward again.


/*************************************************************/

----------------------------------------
char SDL_GifLoopStatus(SDL_GifAnim* anim)
----------------------------------------

This function let you know wether the animation needs a reset or not.
Mostly, when playing an animation in GIF_ONCE_XXX mode, this will allow to
know if it has finished playing or not.

Return value is 1 while playing, whatever the mode may be (even in GIF_LOOP_STOP mode).
Return value is 0 once the GIF_ONCE_XXX animation has been executed and is stuck at last reading frame.


/*************************************************************/

-----------------------------------------------------------------
void SDL_GIFSpeedSet(SDL_GifAnim *anim, int frameNum, int delayms)
------------------------------------------------------------------

Display delay is basically set to the value set by the original gif file, frame by frame.
Though, you can adjust the delay frame by frame, or globaly.

if a GIF_ALL value is given as frameNum, the display time of all frames will be set at
delayms.

Otherwise, only the frame frameNum will be modified. Nothing is changed if frame index given is
higher than the number of frame available minus 1.
Say 5 frames for this animation, frameNum then can have a value of 0 to 4, 0 being the first logical frame and 4 the last one.

delayms is in milliseconds. Internally this value is turned into a 16 bits unsigned
thus, maximum value avalaible is 65 535.

/************************************************************/

----------------------------------------
void SDL_GIFNextFrame(SDL_GifAnim *anim)
----------------------------------------

This will go to the next reading frame to be displayed accordingly to the mode set with 
SDL_GIFLoopMode().

If the loop mode is set to GIF_ONCE_XXX, the animation will then stop at the last reading frame
Even if you would call this fonction 200 hundred times nothing would happen, it still need to be reset.

This will allow you to have your own management on when to change frame, say on a particuliar event.
Call to this function inhibits the frame delay, if every frame delay was set on 500ms, you can
play the animation faster by calling SDL_GIFNextFrame every 100 ms.

SDL_GIFAnimAuto() should do just as well most of the time.

/***************************************************************/

--------------------------------------
void SDL_GIFReverse(SDL_GifAnim *anim)
--------------------------------------

This will simply revert the actual direction of frame reading.
Global mode is kept as, only direction is changed : say you set the animation mode to GIF_REPEAT_FOR,
a call to SDL_GIFReverse will set it to GIF_REPEAT_REV. 
In this case, direction is changed from the frame it is displaying at function call.

if a one shot reading has come to an end (GIF_ONCE_XXX),
direction will be changed, but animation will not restart
until a call to SDL_GIFLoopReset() is done.

if mode was set to GIF_FORTH_BACK, animation will then instantly change its direction from where it is at function call.

/*****************************************************************/

---------------------------------------
char *SDL_GIFComment(SDL_GifAnim *anim)
---------------------------------------

returns the gif comment embedded in the gif file if any,
otherwise a NULL pointer is returned.


/*******************************************************************/

---------------------------------------
char *SDL_GIFVersion(SDL_GifAnim *anim)
---------------------------------------

returns the gif version embedded in the gif file if any,
otherwise a pointer to a nul char ('/0') is returned.

/********************************************************************/

-----------------------------------------
char *SDL_GIFsignature(SDL_GifAnim *anim)
-----------------------------------------

returns the signature embedded in the gif file if any,
otherwise a pointer to a nul char ('/0') is returned. 

/*********************************************************************/

----------------------------------
int SDL_GIFFrameNum(SDL_GifAnim* anim)
----------------------------------

returns the number of frames available for this animation.


/*********************************************************************/

----------------------------------
char SDL_GifMethod(SDL_GifAnim* anim, uint8_t num)
----------------------------------

returns disposal method of the numth frame of anim.
This value is supposed to be either METHOD_OVERWRITE or METHOD_REDRAW.
METHOD_REDRAW is applied if the disposal method would be different from one of these values.

/*********************************************************************/

----------------------------------
void SDL_GifMethodSet(SDL_GifAnim* anim, int num, uint8_t method)
----------------------------------

This function allows to set "anim"'s "num"th frame disposal method to "method";
If GIF_ALL is passed as num, method will be applied to all frames.








BASIC TEST CODE :
_______________________________________________________________________


#include <stdlib.h>
#include <SDL.h>
#include <stdint.h>
#include "SDL2_gif.h"

int main ( int argc, char* argv[] )
{
    SDL_Window* window      = NULL;
	SDL_Texture* actTexture = NULL;
	SDL_Rect blitPos 		= {0, 0 , 50 ,50};	

	SDL_GifAnim * animation = NULL;

	SDL_Renderer* myRender =NULL;

    srand(time(NULL));

	if( SDL_Init( SDL_INIT_VIDEO ) <0)
	{
		printf( "SDL could not initialize! SDL_Error: %s\n", SDL_GetError() );
	}
	else
	{
	    window = SDL_CreateWindow( "SDL2 gif stress", 50, 50, 500, 500, 0);
		if( !window )		
			printf( "Window could not be created! SDL_Error: %s\n", SDL_GetError());
		
		else
		{
            myRender=SDL_CreateRenderer(window,-1,SDL_RENDERER_ACCELERATED);
            SDL_SetRenderDrawColor(myRender,255,255,255,255);
			SDL_RenderSetLogicalSize(myRender,128,72);
			SDL_RenderClear(myRender);

            animation = SDL_GIFAnimLoad("MS0.gif", myRender);

			actTexture = SDL_GIFTexture(animation);
			SDL_GIFLoopMode(animation, GIF_REPEAT_FOR);


            while(!interrupt())
            {
                SDL_GIFAnimAuto(animation);
                SDL_RenderClear(myRender);
                SDL_RenderCopy(myRender,actTexture,NULL,&blitPos);
                SDL_RenderPresent(myRender);
            }
			
			SDL_GIFAnimFree(animation);

		}
	}

    SDL_DestroyRenderer(myRender);
	SDL_DestroyWindow( window );

	SDL_Quit();

	return 0;
}

--------------------------------------------------------------------------
								UPDATES :
--------------------------------------------------------------------------

Uptdate 04 March 2016

- anim structure is now lighter, only frames pixels are stored instead of full SDL_textures.
- corrected overwrite method behaviour causing the frame Alpha pixels to set the destination SDL_texture to be alpha too instead of beeing ignored.
- added control/correction of the frame blit position on the dest SDL_texture (as if frame width > picture width).
- corrected calculation error in CEV_FillWithAlpha.
- added 2 user functions, one to query the disposal method on a particuliar frame, another one to set it. 
- SDL_GifAnimAuto() now ticks on every pic change.