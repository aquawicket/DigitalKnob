var IMAGEMAGICK = "C:/digitalknob/3rdParty/ImageMagick-7.0.2-10-portable-Q16-x86/";

/////////////////////////
function IconMaker_Init()
{
	IMAGEMAGICK = DKFile_GetShortName(IMAGEMAGICK);
	DKLog("IMAGEMAGICK="+IMAGEMAGICK+"\n");
}

//////////////////////////////////
function IconMaker_Create(AppPath)
{
	DKLog("IconMaker_Create("+AppPath+"+) \n", DKINFO);
	
	//Create Android Icons
	DK_Execute(IMAGEMAGICK+"convert "+AppPath+"/icons/icon.png -resize 144x144 "+AppPath+"/icons/android/drawable-xxhdpi/icon.png");
}
