BOOST="$(cd "$(dirname "$0")"; pwd)"

# This affects bootstrap to select MSVC vc142
. "$BOOST"/build-common.sh

BOOST_VER1=1
BOOST_VER2=74
BOOST_VER3=0
BOOST_DIR="boost_${BOOST_VER1}_${BOOST_VER2}_${BOOST_VER3}"



# ---------
# Bootstrap
# ---------
if [ ! -f ./b2 ]
then
  # Make the initial bootstrap
  echo "Performing boost bootstrap"

  case "$HOST_OS" in
    windows)
        cmd //c "bootstrap.bat" 2>&1 | tee -a build.log
        ;;
    *)  # Linux and others
        ./bootstrap.sh 2>&1 | tee -a build.log
    esac

  if [ $? != 0 ] ; then
  	echo "ERROR: Could not perform boostrap! See $TMPLOG for more info."
  	exit 1
  fi
  
  # -------------------------------------------------------------
  # Patching should be done only if we had a successfull bootstrap!
  # -------------------------------------------------------------

  # Apply patches to boost
  BOOST_VER=${BOOST_VER1}_${BOOST_VER2}_${BOOST_VER3}
  PATCH_BOOST_DIR="$BOOST/patches/boost-${BOOST_VER}"

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
      SRC_DIR=$BOOST_DIR
      PATCHDIR=`dirname $PATCH`
      PATCHNAME=`basename $PATCH`
      echo "Applying $PATCHNAME into $SRC_DIR/$PATCHDIR"
      patch -p1 < $dir/$PATCH
      if [ $? != 0 ] ; then
        echo "ERROR: Patch failure !! Please check your patches directory!"
        echo "       Try to perform a clean build using --clean ."
        echo "       Problem patch: $dir/$PATCHNAME"
        exit 1
      fi
    done
  done
fi
