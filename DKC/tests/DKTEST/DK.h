#warning DK.h enter
#ifndef DKTEST_A_H
#define DKTEST_A_H

#define str(x) #x
#ifndef first
	#define first str(__FILE__)
#endif

#define current str(__FILE__)
#if current == first
	#warning "MATCH!!!!!!!!!"
#endif





#endif //DKTEST_A_H
#warning DK.h exit