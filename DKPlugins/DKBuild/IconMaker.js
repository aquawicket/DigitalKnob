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
	
	//Create Windows Icon
	DKFile_MkDir(AppPath+"/icons/windows");
	DK_Execute(IMAGEMAGICK+"convert "+AppPath+"/icons/icon.png -define icon:auto-resize=256,128,64,48,32,16 "+AppPath+"/icons/windows/icon.ico");
	
	//Create Mac Icons
	DKFile_MkDir(AppPath+"/icons/mac");
	DK_Execute("sips -z 16 16 "+AppPath+"/icons/icon.png --out "+AppPath+"/icons/windows/icon_16x16.png");
	
	//Create Linux Icons
	//DKFile_MkDir(AppPath+"/icons/linux");
	
	//Create Android Icons
	DKFile_MkDir(AppPath+"/icons/android");
	DKFile_MkDir(AppPath+"/icons/android/drawable-hdpi");
	DK_Execute(IMAGEMAGICK+"convert "+AppPath+"/icons/icon.png -resize 72x72 "+AppPath+"/icons/android/drawable-hdpi/icon.png");
	DKFile_MkDir(AppPath+"/icons/android/drawable-ldpi");
	DK_Execute(IMAGEMAGICK+"convert "+AppPath+"/icons/icon.png -resize 36x36 "+AppPath+"/icons/android/drawable-ldpi/icon.png");
	DKFile_MkDir(AppPath+"/icons/android/drawable-mdpi");
	DK_Execute(IMAGEMAGICK+"convert "+AppPath+"/icons/icon.png -resize 48x48 "+AppPath+"/icons/android/drawable-mdpi/icon.png");
	DKFile_MkDir(AppPath+"/icons/android/drawable-xhdpi");
	DK_Execute(IMAGEMAGICK+"convert "+AppPath+"/icons/icon.png -resize 96x96 "+AppPath+"/icons/android/drawable-xhdpi/icon.png");
	DKFile_MkDir(AppPath+"/icons/android/drawable-xxhdpi");
	DK_Execute(IMAGEMAGICK+"convert "+AppPath+"/icons/icon.png -resize 144x144 "+AppPath+"/icons/android/drawable-xxhdpi/icon.png");
	
	//Create iOS Icons
	//DKFile_MkDir(AppPath+"/icons/ios");
	
	//Create iOS 7 Icons
	//DKFile_MkDir(AppPath+"/icons/ios7");
}
