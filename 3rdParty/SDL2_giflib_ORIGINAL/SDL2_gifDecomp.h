#ifndef GIF_DEC_INCLUDED
#define GIF_DEC_INCLUDED

/***************************/
/** Based upon  http://giflib.sourceforge.net/whatsinagif/bits_and_bytes.html */

#include <SDL.h>

#if SDL_BYTEORDER == SDL_BIG_ENDIAN

    #define   RMASK  0xff000000
    #define   GMASK  0x00ff0000
    #define   BMASK  0x0000ff00
    #define   AMASK  0x000000ff

    #define COLOR_R(X) ((X&RMASK)>>24)
    #define COLOR_G(X) ((X&GMASK)>>16)
    #define COLOR_B(X) ((X&BMASK)>>8)
    #define COLOR_A(X) (X&AMASK)

#else

    #define RMASK  0x000000ff
    #define GMASK  0x0000ff00
    #define BMASK  0x00ff0000
    #define AMASK  0xff000000

    #define COLOR_R(X) (X&RMASK)
    #define COLOR_G(X) ((X&GMASK)>>8)
    #define COLOR_B(X) ((X&BMASK)>>16)
    #define COLOR_A(X) ((X&AMASK)>>24)

#endif


typedef struct CEV_gifColor
{/*color type*/
    uint8_t r,
            g,
            b,
            a;
}
CEV_gifColor;


typedef struct CEV_gifColorTable
{/*color table*/
    unsigned int numOfColors;
    CEV_gifColor *table;
}
CEV_gifColorTable;


typedef struct CEV_gifHeader
{/*header Block*/
    char signature[4];
    char version[4];
}
CEV_gifHeader;


typedef struct CEV_gifLSDpack
{/*Logical Screen Descriptor pack field, from byte*/
    uint8_t     usesGlobalColor,
                sorted;

    size_t      colorRes,
                numOfColors;
}
CEV_gifLSDpack;


typedef struct CEV_gifLSD
{/*Logical Screen Descriptor Block*/
    unsigned int    pxlAspectRatio;
    uint16_t    width,
                height;
    CEV_gifLSDpack   packField;
    uint8_t bckgrdColorIndex;
}
CEV_gifLSD;


typedef struct CEV_gifGCEPack
{/*Graphics Control Extension pack field, from byte*/
    uint8_t res,
            disposalMethod,
            userInput,
            alphaFlag;
}
CEV_gifGCEPack;


typedef struct CEV_gifGCE
{/*Graphics Control Extension*/
    uint8_t     byteSize,
                alphaColorIndex,
                used;

    uint16_t    delayTime;

    CEV_gifGCEPack   packField;
}
CEV_gifGCE;


typedef struct CEV_gifIDpack
{/*Image Descriptor packed file, from Byte*/
    uint8_t     usesLocalColor,
                interlace,
                sorted,
                res;
    size_t
                colorTabSize;
}
CEV_gifIDpack;


typedef struct CEV_gifID
{/*Image Descriptor*/

    uint16_t    leftPos,
                topPos,
                width,
                height;

    CEV_gifIDpack  imgPack;
}
CEV_gifID;


typedef struct CEV_gifImage
{
    CEV_gifGCE         control;
    CEV_gifID          descriptor;
    CEV_gifColorTable  localColor;
    uint8_t            *imageData;
}
CEV_gifImage;


typedef struct CEV_gifAppExt
{
    uint8_t     blockSize,
                subBlockSize;
    uint16_t    repeat;
    char        *text;
}
CEV_gifAppExt;


typedef struct CEV_gifComExt
{
    unsigned int numOfBlocks;
    char         *text;

}
CEV_gifComExt;

typedef struct CEV_gifColorShift
{
    uint8_t rShift,
            gShift,
            bShift,
            aShift;
}
CEV_gifColorShift;


typedef struct CEV_gifFile
{/*gif file descriptor*/
    CEV_gifHeader       header;
    CEV_gifLSD          lsd;
    CEV_gifColorTable   globalColor;
    CEV_gifGCE          gce;
    CEV_gifImage        *image;
    CEV_gifComExt       comExt;
    CEV_gifColorShift   colorShift;
    unsigned int        imgNum;

}
CEV_gifFile;

typedef struct CEV_gifDicoEntry
{
    int16_t prev;
    uint8_t value;
}
CEV_gifDicoEntry;


typedef struct CEV_gifDico
{
    CEV_gifDicoEntry entry[4096];
    uint16_t actSize;
}
CEV_gifDico;

CEV_gifFile *CEV_LoadGIF(const char*);

CEV_gifFile *CEV_LoadGIF_RW(SDL_RWops* file);

CEV_gifFile *CEV_newGif();

void CEV_GifInitHeader(CEV_gifHeader*);

void CEV_GifInitGce(CEV_gifGCE*);

void CEV_GifInitLsd (CEV_gifLSD*);

void CEV_GifInitComExt(CEV_gifComExt*);

void CEV_GifNewImg(CEV_gifFile*, FILE*);

void CEV_GifNewImg_RW(CEV_gifFile*, SDL_RWops*);

void CEV_GifFreeFile(CEV_gifFile*);

void CEV_GifFillData(CEV_gifFile*, FILE*);

void CEV_GifFillData_RW(CEV_gifFile*, SDL_RWops*);

int CEV_GifFillHeader(CEV_gifHeader*, FILE*);

int CEV_GifFillHeader_RW(CEV_gifHeader* , SDL_RWops*);

int CEV_GifFillExt(CEV_gifFile*, FILE*);

int CEV_GifFillExt_RW(CEV_gifFile*, SDL_RWops*);

int CEV_GifFillComExt(CEV_gifComExt*, FILE*);

int CEV_GifFillComExt_RW(CEV_gifComExt*, SDL_RWops*);

int CEV_GifFillLSD(CEV_gifLSD*, FILE*);

int CEV_GifFillLSD_RW(CEV_gifLSD*, SDL_RWops*);

int CEV_GifFillLSDPack(CEV_gifLSDpack*, FILE*);

int CEV_GifFillLSDPack_RW(CEV_gifLSDpack*, SDL_RWops*);

int CEV_GifFillColorTab(unsigned int, CEV_gifColorTable*, FILE*);

int CEV_GifFillColorTab_RW(unsigned int, CEV_gifColorTable*, SDL_RWops*);

int CEV_GifFillGCE(CEV_gifGCE*, FILE*);

int CEV_GifFillGCE_RW(CEV_gifGCE*, SDL_RWops*);

int CEV_GifFillGCEPack(CEV_gifGCEPack*, FILE*);

int CEV_GifFillGCEPack_RW(CEV_gifGCEPack*, SDL_RWops*);

int CEV_GifFillID(CEV_gifID*, FILE*);

int CEV_GifFillID_RW(CEV_gifID*, SDL_RWops*);

int CEV_GifFillIDPack(CEV_gifIDpack*, FILE*);

int CEV_GifFillIDPack_RW(CEV_gifIDpack*, SDL_RWops*);

void CEV_GifBlockSkip(FILE*);

void CEV_GifBlockSkip_RW(SDL_RWops*);

void CEV_GifLzw(void*, CEV_gifFile*, unsigned int);

uint16_t CEV_GetBitFieldValue16(void*, unsigned int*, size_t);

void CEV_GifInitDico(CEV_gifDico*, unsigned int);

uint8_t CEV_GetFirstOfString(CEV_gifDico*, CEV_gifDicoEntry);

void CEV_StringOutput(CEV_gifDico*, CEV_gifDicoEntry, uint8_t*, unsigned int*, unsigned int);

void CEV_RepeatedlyOutput(CEV_gifDico*, int16_t, uint8_t*, unsigned int*, unsigned int);

void CEV_ValueOutput(uint8_t, uint8_t*, unsigned int*, unsigned int);


#endif // GIF_DEC_INCLUDED
