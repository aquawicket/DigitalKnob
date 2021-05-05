#include "DK/stdafx.h"
#include "DKImageMagick/DKImageMagick.h"
#include "DK/DKFile.h"


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
bool DKImageMagick::PdfToBmp(DKString& filein, DKString& fileout)
{
	DKString ret;
	return DKUtil::System(DKFile::local_assets+"DKImageMagick/magick.exe convert -density 300 "+filein+" BMP3:"+fileout, ret);
}

/////////////////////////////////////////////////////////////////
bool DKImageMagick::PdfToPng(DKString& filein, DKString& fileout)
{
	DKString ret;
	return DKUtil::System(DKFile::local_assets+"DKImageMagick/magick.exe convert -density 300 "+filein+" "+fileout, ret);
}