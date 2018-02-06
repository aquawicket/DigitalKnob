#include "DK/stdafx.h"
#include "DKImageMagick/DKImageMagick.h"


//////////////////////////
bool DKImageMagick::Init()
{
	//DKCreate("DKImageMagickJS");
	//DKCreate("DKImageMagickV8");
	
	return true;
}

/////////////////////////
bool DKImageMagick::End()
{
	return true;
}

/////////////////////////////////////////////////////////////////
bool DKImageMagick::PdfToPng(DKString& filein, DKString& fileout)
{
	if(!DKUtil::System(DKFile::local_assets+"/DKImageMagick/magick.exe convert -density 300 "+filein+" "+fileout)){ return false; }
}

/////////////////////////////////////////////////////////////////
bool DKImageMagick::PdfToBmp(DKString& filein, DKString& fileout)
{
	if(!DKUtil::System(DKFile::local_assets+"/DKImageMagick/magick.exe convert -density 300 "+filein+" BMP3:"+fileout)){ return false; }
}