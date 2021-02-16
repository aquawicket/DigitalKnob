SCRIPTDIR="$(cd "$(dirname "$0")"; pwd)"

# Add common build methods
. "$SCRIPTDIR"/build-common.sh

BOOST_VER1=1
BOOST_VER2=74
BOOST_VER3=0
register_option "--boost=<version>" boost_version "Boost version to be used, one of {1.74.0, 1.73.0, 1.71.0, 1.70.0, 1.69.0, 1.68.0, 1.67.0, 1.66.0, 1.65.1, 1.55.0, 1.54.0, 1.53.0, 1.49.0, 1.48.0, 1.45.0}, default is 1.74.0."
boost_version()
{
  if [ "$1" = "1.74.0" ]; then
    BOOST_VER1=1
    BOOST_VER2=74
    BOOST_VER3=0
  elif [ "$1" = "1.73.0" ]; then
    BOOST_VER1=1
    BOOST_VER2=73
    BOOST_VER3=0
  else
    echo "Unsupported boost version '$1'."
    exit 1
  fi
}

BOOST_TAR="boost_${BOOST_VER1}_${BOOST_VER2}_${BOOST_VER3}.tar.bz2"
BOOST_DIR="boost_${BOOST_VER1}_${BOOST_VER2}_${BOOST_VER3}"

# Check platform patch
case "$HOST_OS" in
    linux)
        PlatformOS=linux
        ;;
    darwin|freebsd)
        PlatformOS=darwin
        ;;
    windows|cygwin)
        PlatformOS=windows
        ;;
    *)  # let's play safe here
        PlatformOS=linux
esac

# -----------------------
# Download required files
# -----------------------

# Downalod and unzip boost in a temporal folder and
if [ ! -f $BOOST_TAR ]
then
	echo "Downloading boost ${BOOST_VER1}.${BOOST_VER2}.${BOOST_VER3} please wait..."
	prepare_download
	download_file $BOOST_DOWNLOAD_LINK $PROGDIR/$BOOST_TAR
fi

if [ ! -f $PROGDIR/$BOOST_TAR ]
then
	echo "Failed to download boost! Please download boost ${BOOST_VER1}.${BOOST_VER2}.${BOOST_VER3} manually\nand save it in this directory as $BOOST_TAR"
	exit 1
fi

if [ ! -d $PROGDIR/$BOOST_DIR ]
then
	echo "Unpacking boost"
	if [ "$OPTION_PROGRESS" = "yes" ] ; then
		pv $PROGDIR/$BOOST_TAR | tar xjf - -C $PROGDIR
	else
		tar xjf $PROGDIR/$BOOST_TAR
	fi
fi

if [ $DOWNLOAD = yes ] ; then
	echo "All required files has been downloaded and unpacked!"
	exit 0
fi

# ---------
# Bootstrap
# ---------
if [ ! -f ./$BOOST_DIR/b2 ]
then
  # -------------------------------------------------------------
  # Patching shpould be done only if we had a successfull bootstrap!
  # -------------------------------------------------------------

  # Apply patches to boost
  BOOST_VER=${BOOST_VER1}_${BOOST_VER2}_${BOOST_VER3}
  PATCH_BOOST_DIR="$SCRIPTDIR/patches/boost-${BOOST_VER}"

  for dir in $PATCH_BOOST_DIR; do
    if [ ! -d "$dir" ]; then
      echo "Could not find directory '$dir' while looking for patches"
      exit 1
    fi

    PATCHES=`(cd $dir && ls *.patch | sort) 2> /dev/null`

    if [ -z "$PATCHES" ]; then
      echo "No patches found in directory '$dir'"
      exit 1
    fi

    for PATCH in $PATCHES; do
      PATCH=`echo $PATCH | sed -e s%^\./%%g`
      SRC_DIR=$PROGDIR/$BOOST_DIR
      PATCHDIR=`dirname $PATCH`
      PATCHNAME=`basename $PATCH`
      log "Applying $PATCHNAME into $SRC_DIR/$PATCHDIR"
      cd $SRC_DIR && patch -p1 < $dir/$PATCH && cd $PROGDIR
      if [ $? != 0 ] ; then
        dump "ERROR: Patch failure !! Please check your patches directory!"
        dump "       Try to perform a clean build using --clean ."
        dump "       Problem patch: $dir/$PATCHNAME"
        exit 1
      fi
    done
  done
fi
