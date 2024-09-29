#!/bin/sh
[ -z "${DKINIT}" ] && . "${DKBASH_FUNCTIONS_DIR_}DK.sh"

################################################################################
# installPacman()
#
#installPacman() {
	
	#$(set +o posix)    && set +o posix
	$(set +o pipefail) && set +o pipefail  	# trace ERR through pipes
	$(set +o errtrace) && set +o errtrace 	# set -E : trace ERR through 'time command' and other functions
	$(set +o nounset)  && set +o nounset  	# set -u : exit the script if you try to use an uninitialised variable
	$(set +o errexit)  && set +o errexit  	# set -e : exit the script if any statement returns a non-true
	#$(shopt +s extdebug) && shopt +s extdebug
	trap '' ERR

	echo "###### STEP 1 ######"
	# Step 1: Run these commands to download /etc/pacman.conf and 3 packages: pacman, pacman-mirrors and msys2-keyring. 
	# See my Dec 9, 2022 comment below on why you need zstd in .xz format. These packages/versions were tested on both 32 and 64-bit Portable Git 2.38.1:
	if [[ "$HOSTTYPE" == "i686" ]]; then
		pacman="
		pacman-6.0.0-4-i686.pkg.tar.zst
		pacman-mirrors-20210703-1-any.pkg.tar.zst
		msys2-keyring-1~20210213-2-any.pkg.tar.zst
		"
		zstd=zstd-1.5.0-1-i686.pkg.tar.xz
	else
		pacman="
		pacman-6.0.1-26-x86_64.pkg.tar.zst
		pacman-mirrors-20221016-1-any.pkg.tar.zst
		msys2-keyring-1~20221024-1-any.pkg.tar.zst
		"
		zstd=zstd-1.5.2-1-x86_64.pkg.tar.xz
	fi
	dk_call dk_validate DKDOWNLOAD_DIR "dk_call dk_DKDIGITALKNOB_DIR"
	
	echo "https://raw.githubusercontent.com/msys2/MSYS2-packages/7858ee9c236402adf569ac7cff6beb1f883ab67c/pacman/pacman.conf"
	dk_call dk_download https://raw.githubusercontent.com/msys2/MSYS2-packages/7858ee9c236402adf569ac7cff6beb1f883ab67c/pacman/pacman.conf ${DKDOWNLOAD_DIR}/pacman.conf
	dk_call dk_copy "${DKDOWNLOAD_DIR}/pacman.conf" "/etc/pacman.conf" OVERWRITE
	#curl https://raw.githubusercontent.com/msys2/MSYS2-packages/7858ee9c236402adf569ac7cff6beb1f883ab67c/pacman/pacman.conf -o /etc/pacman.conf
	#curl https://raw.githubusercontent.com/msys2/MSYS2-packages/master/pacman/pacman.conf -o /etc/pacman.conf
	
	for f in $pacman; do echo "https://repo.msys2.org/msys/$HOSTTYPE/$f" && dk_call dk_download https://repo.msys2.org/msys/$HOSTTYPE/$f ${DKDOWNLOAD_DIR}/$f; done
	#for f in $pacman; do echo "https://repo.msys2.org/msys/$HOSTTYPE/$f" && curl https://repo.msys2.org/msys/$HOSTTYPE/$f -fo ~/Downloads/$f; done
	
	# https://github.com/mcgitty/pacman-for-git/raw/main/zstd-1.5.2-1-x86_64.pkg.tar.xz
	echo "https://github.com/mcgitty/pacman-for-git/raw/main/$zstd"
	dk_call dk_download https://github.com/mcgitty/pacman-for-git/raw/main/$zstd ${DKDOWNLOAD_DIR}/$zstd
	#curl -L https://github.com/mcgitty/pacman-for-git/raw/main/$zstd -o ~/Downloads/$zstd
	
	echo "###### STEP 2 ######"
	# Step 2: Unpack them at the root then restore pacman with these commands:
	cd /
	#tar x --xz -vf ~/Downloads/$zstd usr
	tar x --xz -vf ${DKDOWNLOAD_DIR}/$zstd usr
	#for f in $pacman; do tar x --zstd -vf ~/Downloads/$f usr etc 2>/dev/nul && $(true); done
	for f in $pacman; do tar x --zstd -vf ${DKDOWNLOAD_DIR}/$f usr etc 2>/dev/nul && $(true); done
	mkdir -p /var/lib/pacman; ln -s `which gettext` /usr/bin/
	pacman-key --init
	pacman-key --populate msys2
	pacman -Syu
	
	echo "###### STEP 3 ######"
	# Step 3: The next set of commands restore all matching metadata (be patient). Like the zstd packages in Step 1, 
	# this relies on my public github repo pacman-for-git to provide the git-sdk commit ID of each Portable Git release, which I'll do my best to update:
	t=`grep -E 'mingw-w64-[ix_0-9]+-git ' /etc/package-versions.txt`
	#dk_call dk_download https://github.com/mcgitty/pacman-for-git/raw/main/version-tags.txt ${DKDOWNLOAD_DIR}/version-tags.txt
	t=`curl -sL https://github.com/mcgitty/pacman-for-git/raw/main/version-tags.txt|grep "$t"`
	[[ "$t" == "" ]] && echo "ERROR: Commit ID not logged in github pacman-for-git." && read
	b=64 && [[ "$t" == *-i686-* ]] && b=32
	URL=https://github.com/git-for-windows/git-sdk-$b/raw/${t##* }
	cat /etc/package-versions.txt | while read p v; do d=/var/lib/pacman/local/$p-$v;
	#cat ${DKDOWNLOAD_DIR}/version-tags.txt | while read p v; do d=/var/lib/pacman/local/$p-$v;
	#mkdir -p $d; echo $d; for f in desc files mtree; do dk_call dk_download "$URL$d/$f" ${DKDOWNLOAD_DIR}/$f
	mkdir -p $d; echo $d; for f in desc files mtree; do curl -fsSL "$URL$d/$f" -o $d/$f;
	done; [[ ! -f $d/desc ]] && rmdir $d && echo Missing $d; done
	
	echo "###### STEP 4 ######"
	#Step 4: Now, is it too much to ask for 'make' and 'zip'?
	pacman -S make zip
	
	#Voilà, still just a 337MB mean little environment that can expand and upgrade!
	
	#$(set -o posix)    && set -o posix
	$(set -o pipefail) && set -o pipefail  	# trace ERR through pipes
	$(set -o errtrace) && set -o errtrace 	# set -E : trace ERR through 'time command' and other functions
	$(set -o nounset)  && set -o nounset  	# set -u : exit the script if you try to use an uninitialised variable
	$(set -o errexit)  && set -o errexit  	# set -e : exit the script if any statement returns a non-true
	#$(shopt -s extdebug) && shopt -s extdebug
	trap 'dk_onError $BASH_SOURCE $LINENO' ERR
#}






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
#DKTEST() {
#	installPacman
#}