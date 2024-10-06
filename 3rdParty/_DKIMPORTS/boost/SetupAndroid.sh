BOOST="$(cd "$(dirname "$0")"; pwd)"
BOOST_VER1=1
BOOST_VER2=78
BOOST_VER3=0
BOOST_DIR="boost_${BOOST_VER1}_${BOOST_VER2}_${BOOST_VER3}"

# ---------
# HOST info
# ---------
host_arch=`uname -m`
case "$host_arch" in
    i?86) host_arch=x86
    ;;
    amd64) host_arch=x86_64
    ;;
    powerpc) host_arch=ppc
    ;;
esac

host_exe=""
host_os=`uname -s`
case "$host_os" in
    Darwin)
        host_os=darwin
        ;;
    Linux)
        host_os=linux
        ;;
    FreeBsd)  # not tested
        host_os=freebsd
        ;;
    CYGWIN*|*_NT-*)
        host_os=windows
        host_exe=.exe
        if [ "x$OSTYPE" = xcygwin ] ; then
            host_os=cygwin
        fi
        ;;
esac

compute_host_tag ()
{
    case "$host_os" in
        windows|cygwin)
            host_tag="windows"
            ;;
        *)  host_tag="${host_os}-${host_arch}"
    esac
}
compute_host_tag

  
# ---------
# Patching
# ---------
BOOST_VER=${BOOST_VER1}_${BOOST_VER2}_${BOOST_VER3}
PATCH_BOOST_DIR="$BOOST/android-patches/boost-${BOOST_VER}"

for dir in $PATCH_BOOST_DIR; do
	if [ ! -d "$dir" ]; then
		echo "Could not find directory '$dir' while looking for android-patches"
		exit 1
	fi

    PATCHES=`(cd $dir && ls *.patch | sort) 2>/dev/null`

    if [ -z "$PATCHES" ]; then
      echo "No android-patches found in directory '$dir'"
      exit 1
    fi

    for PATCH in $PATCHES; do
		if grep -Fxq "$PATCH" ${BOOST}/installed
		then
			echo "The $PATCHNAME patch has already been applied"
		else
			PATCH=`echo $PATCH | sed -e s%^\./%%g`
			PATCHDIR=`dirname $PATCH`
			PATCHNAME=`basename $PATCH`
			echo "Applying $PATCHNAME into $BOOST_DIR/$PATCHDIR"
			patch -p1 < $dir/$PATCH
			echo "$PATCH" >> ${BOOST}/installed
			if [ $? != 0 ] ; then
				echo "ERROR: Patch failure !! Please check your android-patches directory!"
				echo "Problem patch: $dir/$PATCHNAME"
				exit 1
			fi
		fi
	done
done
