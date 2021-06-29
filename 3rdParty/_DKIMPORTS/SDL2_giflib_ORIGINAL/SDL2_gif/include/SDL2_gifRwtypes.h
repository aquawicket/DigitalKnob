/**********************************************************/
/** Done by  |      Date     |  version |    comment     **/
/**------------------------------------------------------**/
/**   CEV    |  14-02-2015   |   1.0    |    creation    **/
/**********************************************************/

#ifndef RWTYPES_H_INCLUDED
#define RWTYPES_H_INCLUDED

#include <stdio.h>
#include <stdint.h>
#include <SDL.h>


char readWriteErr;

Uint8 SDL_Readu8 (SDL_RWops *src);

uint8_t read_u8(FILE* f);

int8_t read_s8(FILE* f);

uint16_t read_u16le(FILE* f);

int16_t read_s16le(FILE* f);

void write_u16le(uint16_t val,FILE* f);

void write_s16le(int16_t val,FILE*f);

uint16_t read_u16be(FILE*f);

int16_t read_s16be(FILE*f);

void write_u16be(uint16_t val,FILE*f);

void write_s16be(int16_t val,FILE*f);

uint32_t read_u32le(FILE* f);

int32_t read_s32le(FILE* f);

void write_u32le(uint32_t val,FILE*f);

void write_s32le(int32_t val,FILE*f);

uint32_t read_u32be(FILE* f);

int32_t read_s32be(FILE* f);

void write_u32be(uint32_t val,FILE*f);

void write_s32be(int32_t val,FILE*f);

uint64_t read_u64le(FILE* f);

int64_t read_s64le(FILE* f);

void write_u64le(uint64_t val,FILE*f);

void write_s64le(int64_t val,FILE*f);

uint64_t read_u64be(FILE* f);

int64_t read_s64be(FILE* f);

void write_u64be(uint64_t val,FILE*f);

void write_s64be(int64_t val,FILE*f);

#endif /* RWTYPES_H_INCLUDED */
