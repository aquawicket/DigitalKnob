var DKWEB = "http://127.0.0.1"
var IMAGEMAGICK = "C:/digitalknob/DK/3rdParty/ImageMagick-7.0.2-10-portable-Q16-x86/convert.exe";

/////////////////////////
function IconMaker_Init()
{
	IMAGEMAGICK = DKCPP_DKFile_GetShortName(IMAGEMAGICK);
	console.log("IMAGEMAGICK="+IMAGEMAGICK);
}

////////////////////////
function IconMaker_End()
{

}

//////////////////////////////////
function IconMaker_Create(AppPath)
{
	DKCPP_DKDuktape_DKCreate("DKArchiveJS");
	IconMaker_ValidateImageMagick();
	
	//Create Windows Icon
	DKCPP_DKFile_MkDir(AppPath+"/icons/windows");
	DKCPP_DKDuktape_Execute(IMAGEMAGICK+" "+AppPath+"/icons/icon.png -define icon:auto-resize=256,128,64,48,32,16 "+AppPath+"/icons/windows/icon.ico");
	DKCPP_DKDuktape_Execute(IMAGEMAGICK+" "+AppPath+"/icons/icon.png -define icon:auto-resize=16 "+AppPath+"/assets/favicon.ico");
	
	//Create Mac Icons
	if(DKCPP_DKDuktape_GetOS() === "Mac"){
		DKCPP_DKFile_MkDir(AppPath+"/icons/mac");
		DKCPP_DKFile_MkDir(AppPath+"/icons/mac/icons.iconset");
		DKCPP_DKDuktape_Execute("sips -z 16 16 "+AppPath+"/icons/icon.png --out "+AppPath+"/icons/mac/icons.iconset/icon_16x16.png");
		DKCPP_DKDuktape_Execute("sips -z 32 32 "+AppPath+"/icons/icon.png --out "+AppPath+"/icons/mac/icons.iconset/icon_16x16@2x.png");
		DKCPP_DKDuktape_Execute("sips -z 32 32 "+AppPath+"/icons/icon.png --out "+AppPath+"/icons/mac/icons.iconset/icon_32x32.png");
		DKCPP_DKDuktape_Execute("sips -z 64 64 "+AppPath+"/icons/icon.png --out "+AppPath+"/icons/mac/icons.iconset/icon_32x32@2x.png");
		DKCPP_DKDuktape_Execute("sips -z 128 128 "+AppPath+"/icons/icon.png --out "+AppPath+"/icons/mac/icons.iconset/icon_128x128.png");
		DKCPP_DKDuktape_Execute("sips -z 256 256 "+AppPath+"/icons/icon.png --out "+AppPath+"/icons/mac/icons.iconset/icon_128x128@2x.png");
		DKCPP_DKDuktape_Execute("sips -z 256 256 "+AppPath+"/icons/icon.png --out "+AppPath+"/icons/mac/icons.iconset/icon_256x256.png");
		DKCPP_DKDuktape_Execute("sips -z 512 512 "+AppPath+"/icons/icon.png --out "+AppPath+"/icons/mac/icons.iconset/icon_256x256@2x.png");
		DKCPP_DKDuktape_Execute("sips -z 512 512 "+AppPath+"/icons/icon.png --out "+AppPath+"/icons/mac/icons.iconset/icon_512x512.png");
		DKCPP_DKDuktape_Execute("sips -z 1024 1024 "+AppPath+"/icons/icon.png --out "+AppPath+"/icons/mac/icons.iconset/icon_512x512@2x.png");
		DKCPP_DKDuktape_Execute("iconutil -c icns -o "+AppPath+"/icons/mac/logo.icns "+AppPath+"/icons/mac/icons.iconset");
	}
	
	//Create Linux Icons
	//DKCPP_DKFile_MkDir(AppPath+"/icons/linux");
	
	//Create Android Icons
	DKCPP_DKFile_MkDir(AppPath+"/icons/android");
	DKCPP_DKFile_MkDir(AppPath+"/icons/android/drawable-hdpi");
	DKCPP_DKDuktape_Execute(IMAGEMAGICK+" "+AppPath+"/icons/icon.png -resize 72x72 "+AppPath+"/icons/android/drawable-hdpi/icon.png");
	DKCPP_DKFile_MkDir(AppPath+"/icons/android/drawable-ldpi");
	DKCPP_DKDuktape_Execute(IMAGEMAGICK+" "+AppPath+"/icons/icon.png -resize 36x36 "+AppPath+"/icons/android/drawable-ldpi/icon.png");
	DKCPP_DKFile_MkDir(AppPath+"/icons/android/drawable-mdpi");
	DKCPP_DKDuktape_Execute(IMAGEMAGICK+" "+AppPath+"/icons/icon.png -resize 48x48 "+AppPath+"/icons/android/drawable-mdpi/icon.png");
	DKCPP_DKFile_MkDir(AppPath+"/icons/android/drawable-xhdpi");
	DKCPP_DKDuktape_Execute(IMAGEMAGICK+" "+AppPath+"/icons/icon.png -resize 96x96 "+AppPath+"/icons/android/drawable-xhdpi/icon.png");
	DKCPP_DKFile_MkDir(AppPath+"/icons/android/drawable-xxhdpi");
	DKCPP_DKDuktape_Execute(IMAGEMAGICK+" "+AppPath+"/icons/icon.png -resize 144x144 "+AppPath+"/icons/android/drawable-xxhdpi/icon.png");
	
	//Create iOS Icons
	//DKCPP_DKFile_MkDir(AppPath+"/icons/ios");
	
	//Create iOS 7 Icons
	//DKCPP_DKFile_MkDir(AppPath+"/icons/ios7");
}

////////////////////////////////////////
function IconMaker_ValidateImageMagick()
{
	console.log("Looking for ImageMagick...");
	//console.log(SVN);
	if(!DKCPP_DKFile_Exists(IMAGEMAGICK)){
		console.log("Installing ImageMagick...");
		IconMaker_InstallImageMagick();
	}
	console.log("Found ImageMagick");
}

///////////////////////////////////////
function IconMaker_InstallImageMagick()
{
	DKCPP_DKFile_MkDir("C:/digitalknob/DK/Download");
	var datapath = "C:/digitalknob/DK/Download/ImageMagick-7.0.2-10-portable-Q16-x86.zip";
	
	// http://ftp.icm.edu.pl/packages/ImageMagick/binaries/ImageMagick-7.0.2-10-portable-Q16-x86.zip
	DKCPP_DKCurl_Download(DKWEB+"/Download/Tools/ImageMagick-7.0.2-10-portable-Q16-x86.zip", datapath);
	DKCPP_DKArchive_Extract(datapath, "C:/digitalknob/DK/3rdParty/ImageMagick-7.0.2-10-portable-Q16-x86");
}