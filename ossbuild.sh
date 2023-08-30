#!/bin/bash

zypper refresh
zypper -n in -t pattern devel_basis devel_C_C++
zypper -n in 7zip file wget curl dos2unix fakeroot subversion gtk3-devel glew-devel ffmpeg-4-libavcodec-devel ffmpeg-4-libavfilter-devel ffmpeg-4-libavformat-devel ffmpeg-4-libavresample-devel libpulse-devel alsa-devel libvorbis-devel flac-devel giflib-devel
zypper -n addrepo https://download.opensuse.org/repositories/home:strik/openSUSE_Factory/home:strik.repo
zypper -n --gpg-auto-import-keys refresh
zypper -n install xa65

sudo update-alternatives --set fakeroot /usr/bin/fakeroot-tcp

cd /t

dos2unix *.sh
chmod a+x *.sh

svn checkout svn://svn.code.sf.net/p/vice-emu/code/trunk/vice vice

export USE_SVN_REVISION=1

cd vice

ARGS="--enable-debug --disable-arch --disable-pdf-docs --with-png --with-gif --with-vorbis --with-flac --enable-ethernet --enable-midi --enable-cpuhistory --enable-platformdox --enable-rs232 --enable-new8580filter --with-resid --enable-x64 --enable-x64-image --enable-realdevice --enable-ffmpeg --enable-gtk3ui"

./autogen.sh
./configure $ARGS
patch -p0 <../patches.zibri
make -j8 DESTDIR=../data/build install-strip
rev=$(svnversion)
cp -R data/data/build/usr/local/share data/build/usr/local/
cd data/build/
7z a ../../gtk3vice_${rev}.7z *
cp ../../../vice_update_opensuse.sh ../../../vice_update.sh
cp ../../../installer.sh ../../../gtk3vice_${rev}.sh
cat ../../gtk3vice_${rev}.7z >>../../../gtk3vice_${rev}.sh
