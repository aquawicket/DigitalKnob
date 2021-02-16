SCRIPTDIR="$(cd "$(dirname "$0")"; pwd)"

# Add common build methods
. "$SCRIPTDIR"/build-common.sh

BOOST_VER1=1
BOOST_VER2=74
BOOST_VER3=0
BOOST_TAR="boost_${BOOST_VER1}_${BOOST_VER2}_${BOOST_VER3}.tar.bz2"
BOOST_DIR="boost_${BOOST_VER1}_${BOOST_VER2}_${BOOST_VER3}"

#------------------------
# Unpack Boost\
#------------------------
if [ ! -f $PROGDIR/$BOOST_TAR ]
then
	echo "Please download boost ${BOOST_VER1}.${BOOST_VER2}.${BOOST_VER3} manually\nand save it in this directory as $BOOST_TAR"
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

# ---------
# Bootstrap
# ---------
if [ ! -f ./$BOOST_DIR/b2 ]
then
  # Make the initial bootstrap
  echo "Performing boost bootstrap"

  cd $BOOST_DIR
  case "$HOST_OS" in
    windows)
        cmd //c "bootstrap.bat" 2>&1 | tee -a $PROGDIR/build.log
        ;;
    *)  # Linux and others
        ./bootstrap.sh 2>&1 | tee -a $PROGDIR/build.log
    esac

  if [ $? != 0 ] ; then
  	dump "ERROR: Could not perform boostrap! See $TMPLOG for more info."
  	exit 1
  fi
  cd $PROGDIR
  
  # -------------------------------------------------------------
  # Patching should be done only if we had a successfull bootstrap!
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
