var DKWEB = "http://127.0.0.1"
var IMAGEMAGICK_VERSION = "ImageMagick-7.0.11-8-portable-Q16-x86";
var IMAGEMAGICK_DOWNLOAD = "http://ftp.icm.edu.pl/packages/ImageMagick/binaries/"+IMAGEMAGICK_VERSION+".zip";
var IMAGEMAGICK_CONVERT = "C:/digitalknob/DK/3rdParty/"+IMAGEMAGICK_VERSION+"/convert.exe";

/////////////////////////
function IconMaker_Init()
{
	IMAGEMAGICK_CONVERT = CPP_DKFile_GetShortName(IMAGEMAGICK_CONVERT);
	console.log("IMAGEMAGICK_CONVERT = "+IMAGEMAGICK_CONVERT);
}

////////////////////////
function IconMaker_End()
{

}

//////////////////////////////////
function IconMaker_Create(AppPath)
{
	CPP_dk.create("DKArchiveJS");
	IconMaker_ValidateImageMagick();
	
	//Create Windows Icon
	CPP_dk.file.makeDir(AppPath+"/icons/windows");
	CPP_DK_Execute(IMAGEMAGICK_CONVERT+" "+AppPath+"/icons/icon.png -define icon:auto-resize=256,128,64,48,32,16 "+AppPath+"/icons/windows/icon.ico");
	CPP_DK_Execute(IMAGEMAGICK_CONVERT+" "+AppPath+"/icons/icon.png -define icon:auto-resize=16 "+AppPath+"/assets/favicon.ico");
	
	//Create Mac Icons
	if(CPP_DK_GetOS() === "Mac"){
		CPP_dk.file.makeDir(AppPath+"/icons/mac");
		CPP_dk.file.makeDir(AppPath+"/icons/mac/icons.iconset");
		CPP_DK_Execute("sips -z 16 16 "+AppPath+"/icons/icon.png --out "+AppPath+"/icons/mac/icons.iconset/icon_16x16.png");
		CPP_DK_Execute("sips -z 32 32 "+AppPath+"/icons/icon.png --out "+AppPath+"/icons/mac/icons.iconset/icon_16x16@2x.png");
		CPP_DK_Execute("sips -z 32 32 "+AppPath+"/icons/icon.png --out "+AppPath+"/icons/mac/icons.iconset/icon_32x32.png");
		CPP_DK_Execute("sips -z 64 64 "+AppPath+"/icons/icon.png --out "+AppPath+"/icons/mac/icons.iconset/icon_32x32@2x.png");
		CPP_DK_Execute("sips -z 128 128 "+AppPath+"/icons/icon.png --out "+AppPath+"/icons/mac/icons.iconset/icon_128x128.png");
		CPP_DK_Execute("sips -z 256 256 "+AppPath+"/icons/icon.png --out "+AppPath+"/icons/mac/icons.iconset/icon_128x128@2x.png");
		CPP_DK_Execute("sips -z 256 256 "+AppPath+"/icons/icon.png --out "+AppPath+"/icons/mac/icons.iconset/icon_256x256.png");
		CPP_DK_Execute("sips -z 512 512 "+AppPath+"/icons/icon.png --out "+AppPath+"/icons/mac/icons.iconset/icon_256x256@2x.png");
		CPP_DK_Execute("sips -z 512 512 "+AppPath+"/icons/icon.png --out "+AppPath+"/icons/mac/icons.iconset/icon_512x512.png");
		CPP_DK_Execute("sips -z 1024 1024 "+AppPath+"/icons/icon.png --out "+AppPath+"/icons/mac/icons.iconset/icon_512x512@2x.png");
		CPP_DK_Execute("iconutil -c icns -o "+AppPath+"/icons/mac/logo.icns "+AppPath+"/icons/mac/icons.iconset");
	}
	
	//Create Linux Icons
	//CPP_dk.file.makeDir(AppPath+"/icons/linux");
	
	//Create Android Icons
	CPP_dk.file.makeDir(AppPath+"/icons/android");
	CPP_dk.file.makeDir(AppPath+"/icons/android/drawable-hdpi");
	CPP_DK_Execute(IMAGEMAGICK_CONVERT+" "+AppPath+"/icons/icon.png -resize 72x72 "+AppPath+"/icons/android/drawable-hdpi/icon.png");
	CPP_dk.file.makeDir(AppPath+"/icons/android/drawable-ldpi");
	CPP_DK_Execute(IMAGEMAGICK_CONVERT+" "+AppPath+"/icons/icon.png -resize 36x36 "+AppPath+"/icons/android/drawable-ldpi/icon.png");
	CPP_dk.file.makeDir(AppPath+"/icons/android/drawable-mdpi");
	CPP_DK_Execute(IMAGEMAGICK_CONVERT+" "+AppPath+"/icons/icon.png -resize 48x48 "+AppPath+"/icons/android/drawable-mdpi/icon.png");
	CPP_dk.file.makeDir(AppPath+"/icons/android/drawable-xhdpi");
	CPP_DK_Execute(IMAGEMAGICK_CONVERT+" "+AppPath+"/icons/icon.png -resize 96x96 "+AppPath+"/icons/android/drawable-xhdpi/icon.png");
	CPP_dk.file.makeDir(AppPath+"/icons/android/drawable-xxhdpi");
	CPP_DK_Execute(IMAGEMAGICK_CONVERT+" "+AppPath+"/icons/icon.png -resize 144x144 "+AppPath+"/icons/android/drawable-xxhdpi/icon.png");
	
	//Create iOS Icons
	//CPP_dk.file.makeDir(AppPath+"/icons/ios");
	
	//Create iOS 7 Icons
	//CPP_dk.file.makeDir(AppPath+"/icons/ios7");
}

////////////////////////////////////////
function IconMaker_ValidateImageMagick()
{
	console.log("Looking for ImageMagick...");
	//console.log(SVN);
	if(!CPP_DKFile_Exists(IMAGEMAGICK_CONVERT)){
		console.log("Installing ImageMagick...");
		IconMaker_InstallImageMagick();
	}
	console.log("Found ImageMagick");
}

///////////////////////////////////////
function IconMaker_InstallImageMagick()
{
	CPP_dk.file.makeDir("C:/digitalknob/DK/Download");
	var datapath = "C:/digitalknob/DK/Download/"+IMAGEMAGICK_VERSION+".zip";
	
	CPP_DKCurl_Download(IMAGEMAGICK_DOWNLOAD, datapath);
	CPP_DKArchive_Extract(datapath, "C:/digitalknob/DK/3rdParty/"+IMAGEMAGICK_VERSION);
}