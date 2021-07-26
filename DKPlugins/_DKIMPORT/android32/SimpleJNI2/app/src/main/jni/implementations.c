#include "Main.h"
#include <stdio.h>


JNIEXPORT void JNICALL Java_Main_nativeCall(JNIEnv * environment, jclass klass)
{
  puts("inside native call");
  fflush(stdout);
}
