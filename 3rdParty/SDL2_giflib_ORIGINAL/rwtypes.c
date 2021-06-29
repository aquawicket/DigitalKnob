/**********************************************************/
/** Done by  |      Date     |  version |    comment     **/
/**------------------------------------------------------**/
/**   CEV    |  14-02-2015   |   1.0    |    creation    **/
/**********************************************************/

#include <SDL.h>
#include "SDL2_gifRwtypes.h"

char readWriteErr=0;


Uint8 SDL_Readu8 (SDL_RWops *src)
{
	Uint8 value;

	if(SDL_RWread(src, &value, (sizeof value), 1)!=1)
        readWriteErr++;

	return(value);
}

uint8_t read_u8(FILE* f)
{
    uint8_t b;
    if (fread(&b, 1, 1, f) != sizeof(b))
        readWriteErr++;

    return b;
}

int8_t read_s8(FILE* f)
{
    int8_t b;
    if (fread(&b, 1, 1, f) != sizeof(b))
        readWriteErr++;

    return b;
}

uint16_t read_u16le(FILE* f)
{/*lecture u16 bits dans fichier le*/
    uint8_t b[2];

    if (fread(b,1,sizeof(b),f)!=sizeof(b))
        readWriteErr++;

    return 0U | b[0] | b[1]<<8;
}


int16_t read_s16le(FILE* f)
{/*lecture s16 bits dans fichier le*/
    uint8_t b[2];

    if(fread(b,1,sizeof(b),f)!=sizeof(b))
        readWriteErr++;

    return b[0] | b[1]<<8;
}


void write_u16le(uint16_t val,FILE* f)
{/*ecriture u16 dans fichier le*/
   uint8_t b[2];

   b[0]=val      & 0xff;
   b[1]=(val>>8) & 0xff;

   if(fwrite(b,1,sizeof(b),f)!=sizeof(b))
        readWriteErr++;
}


void write_s16le(int16_t val,FILE*f)
{/*ecriture s16 dans fichier le*/
    write_u16le((uint16_t)val,f);
}


uint16_t read_u16be(FILE*f)
{/*lecture u16 dans fichier be*/
    uint8_t b[2];

    if(fread(b,1,sizeof(b),f)!=sizeof(b))
        readWriteErr++;

    return 0U | b[0]<<8 | b[1];
}


int16_t read_s16be(FILE*f)
{/*lecture s16 dans fichier be*/
    uint8_t b[2];

    if(fread(b,1,sizeof(b),f)!=sizeof(b))
        readWriteErr++;

    return b[0]<<8 | b[1];
}


void write_u16be(uint16_t val,FILE*f)
{/*ecriture u16 en be*/
    uint8_t b[2];

    b[0]=(val>>8) & 0xff;
    b[1]=val      & 0xff;

    if(fwrite(b,1,sizeof(b),f)!=sizeof(b))
        readWriteErr++;

}


void write_s16be(int16_t val,FILE*f)
{/*ecriture s16 en be*/
    write_u16be((uint16_t)val,f);
}


uint32_t read_u32le(FILE* f)
{/*lecture u32 bits dans fichier le*/
    uint8_t b[4];

    if(fread(b,1,sizeof(b),f)!=sizeof(b))
        readWriteErr++;

    return 0U | b[0] | b[1]<<8 | b[2]<<16 | b[3]<<24;
}


int32_t read_s32le(FILE* f)
{/*lecture s32 dans fichier le*/
    uint8_t b[4];

    if(fread(b,1,sizeof(b),f)!=sizeof(b))
        readWriteErr++;

    return b[0] | b[1]<<8 | b[2]<<16 | b[3]<<24;
}


void write_u32le(uint32_t val,FILE*f)
{/*ecriture en le dans fichier*/
    uint8_t b[4];


    b[0]=val       & 0xff;
    b[1]=(val>>8)  & 0xff;
    b[2]=(val>>16) & 0xff;
    b[3]=(val>>24) & 0xff;

    if(fwrite(b,1,sizeof(b),f)!=sizeof(b))
        readWriteErr++;
}


void write_s32le(int32_t val,FILE*f)
{/*ecriture en le dans fichier*/
    write_u32le((uint32_t)val,f);
}


uint32_t read_u32be(FILE* f)
{/*lecture dans fichier be*/
    uint8_t b[4];

    if(fread(b,1,sizeof(b),f)!=sizeof(b))
        readWriteErr++;

    return 0U | b[0]<<24 | b[1]<<16 | b[2]<<8 | b[3];
}


int32_t read_s32be(FILE* f)
{/*lecture dans fichier be*/
    uint8_t b[4];

    if(fread(b,1,sizeof(b),f)!=sizeof(b))
        readWriteErr++;

    return b[0]<<24 | b[1]<<16 | b[2]<<8 | b[3];
}


void write_u32be(uint32_t val,FILE*f)
{/*ecriture en be*/
    uint8_t b[4];

    b[3]=val       & 0xff;
    b[2]=(val>>8)  & 0xff;
    b[1]=(val>>16) & 0xff;
    b[0]=(val>>24) & 0xff;

    if(fwrite(b,1,sizeof(b),f)!=sizeof(b))
        readWriteErr++;
}


void write_s32be(int32_t val,FILE*f)
{/*ecriture en be*/

    write_u32be((uint32_t)val,f);
}


uint64_t read_u64le(FILE* f)
{/*lecture u32 bits dans fichier le*/
    uint8_t b[8];

    if(fread(b,1,sizeof(b),f)!=sizeof(b))
        readWriteErr++;

    return 0UL | (uint64_t)b[0] | (uint64_t)b[1]<<8 |
            (uint64_t)b[2]<<16 | (uint64_t)b[3]<<24 |
            (uint64_t)b[4]<<32 | (uint64_t)b[5]<<40 |
            (uint64_t)b[6]<<48 | (uint64_t)b[7]<<56 ;
}


int64_t read_s64le(FILE* f)
{/*lecture s32 dans fichier le*/
    uint8_t b[8];

    if(fread(b,1,sizeof(b),f)!=sizeof(b))
        readWriteErr++;

    return (uint64_t)b[0] | (uint64_t)b[1]<<8 |
            (uint64_t)b[2]<<16 | (uint64_t)b[3]<<24 |
            (uint64_t)b[4]<<32 | (uint64_t)b[5]<<40 |
            (uint64_t)b[6]<<48 |(uint64_t)b[7]<<56 ;
}


void write_u64le(uint64_t val,FILE*f)
{/*ecriture en le dans fichier*/
    uint8_t b[8];


    b[0]=val       & 0xff;
    b[1]=(val>>8)  & 0xff;
    b[2]=(val>>16) & 0xff;
    b[3]=(val>>24) & 0xff;
    b[4]=(val>>32) & 0xff;
    b[5]=(val>>40) & 0xff;
    b[6]=(val>>48) & 0xff;
    b[7]=(val>>56) & 0xff;

    if(fwrite(b,1,sizeof(b),f)!=sizeof(b))
        readWriteErr++;
}


void write_s64le(int64_t val,FILE*f)
{/*ecriture en le dans fichier*/
    write_u64le((uint64_t) val,f);
}

uint64_t read_u64be(FILE* f)
{/*lecture dans fichier be*/
    uint8_t b[8];

    if(fread(b,1,sizeof(b),f)!=sizeof(b))
        readWriteErr++;

    return 0U | (uint64_t)b[0]<<56 | (uint64_t)b[1]<<48 |
            (uint64_t)b[2]<<40 | (uint64_t)b[3]<<32 |
            (uint64_t)b[4]<<24 | (uint64_t)b[5]<<16 |
            (uint64_t)b[6]<<8 | (uint64_t)b[7];
}


int64_t read_s64be(FILE* f)
{/*lecture dans fichier be*/
    uint8_t b[8];

    if(fread(b,1,sizeof(b),f)!=sizeof(b))
        readWriteErr++;

    return (uint64_t)b[0]<<56 | (uint64_t)b[1]<<48 |
            (uint64_t)b[2]<<40 | (uint64_t)b[3]<<32 |
            (uint64_t)b[4]<<24 | (uint64_t)b[5]<<16 |
            (uint64_t)b[6]<<8 | (uint64_t)b[7];
}


void write_u64be(uint64_t val,FILE*f)
{/*ecriture en be*/
    uint8_t b[8];

    b[7]=val       & 0xff;
    b[6]=(val>>8)  & 0xff;
    b[5]=(val>>16) & 0xff;
    b[4]=(val>>24) & 0xff;
    b[3]=(val>>32) & 0xff;
    b[2]=(val>>40) & 0xff;
    b[1]=(val>>48) & 0xff;
    b[0]=(val>>56) & 0xff;

    if(fwrite(b,1,sizeof(b),f)!=sizeof(b))
        readWriteErr++;
}


void write_s64be(int64_t val,FILE*f)
{/*ecriture en be*/

    write_u64be((uint64_t)val,f);
}
