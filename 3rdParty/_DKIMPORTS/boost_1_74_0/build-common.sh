# Current script name into PROGNAME
PROGNAME=`basename $0`
PROGDIR=`pwd`

## Verify OS and CPU
HOST_ARCH=`uname -m`
case "$HOST_ARCH" in
    i?86) HOST_ARCH=x86
    ;;
    amd64) HOST_ARCH=x86_64
    ;;
    powerpc) HOST_ARCH=ppc
    ;;
esac

#   x86
#   x86_64
#   ppc
HOST_EXE=""
HOST_OS=`uname -s`
case "$HOST_OS" in
    Darwin)
        HOST_OS=darwin
        ;;
    Linux)
        # note that building  32-bit binaries on x86_64 is handled later
        HOST_OS=linux
        ;;
    FreeBsd)  # note: this is not tested
        HOST_OS=freebsd
        ;;
    CYGWIN*|*_NT-*)
        HOST_OS=windows
        HOST_EXE=.exe
        if [ "x$OSTYPE" = xcygwin ] ; then
            HOST_OS=cygwin
        fi
        ;;
esac

# at this point, the value of HOST_OS should be one of the following:
#   linux
#   darwin
#    windows (MSys)
#    cygwin
#
# Note that cygwin is treated as a special case because it behaves very differently
# for a few things. Other values may be possible but have not been tested
#

# define HOST_TAG as a unique tag used to identify both the host OS and CPU
# supported values are:
#
#   linux-x86
#   linux-x86_64
#   darwin-x86
#   darwin-ppc
#   windows
#
# other values are possible but were not tested.
#
compute_host_tag ()
{
    case "$HOST_OS" in
        windows|cygwin)
            HOST_TAG="windows"
            ;;
        *)  HOST_TAG="${HOST_OS}-${HOST_ARCH}"
    esac
}

compute_host_tag

# Compute the number of host CPU cores an HOST_NUM_CPUS
case "$HOST_OS" in
    linux)
        HOST_NUM_CPUS=`cat /proc/cpuinfo | grep processor | wc -l`
        ;;
    darwin|freebsd)
        HOST_NUM_CPUS=`sysctl -n hw.ncpu`
        ;;
    windows|cygwin)
        HOST_NUM_CPUS=$NUMBER_OF_PROCESSORS
        ;;
    *)  # let's play safe here
        HOST_NUM_CPUS=1
esac

# If BUILD_NUM_CPUS is not already defined in your environment,
# define it as the double of HOST_NUM_CPUS. This is used to
# run Make commends in parralles, as in 'make -j$BUILD_NUM_CPUS'
if [ -z "$BUILD_NUM_CPUS" ] ; then
    BUILD_NUM_CPUS=`expr $HOST_NUM_CPUS \* 2`
fi

# Various probes are going to need to run a small C program
TMPC=/tmp/myst-$$-test.c
TMPO=/tmp/myst-$$-test.o
TMPE=/tmp/myst-$$-test$EXE
TMPL=/tmp/myst-$$-test.log
