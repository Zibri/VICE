#!/bin/bash

sudo apt install -y autoconf automake build-essential byacc devscripts dos2unix fakeroot flex xa65 p7zip-full
sudo apt install -y libasound-dev libflac-dev libgif-dev libmp3lame-dev libmpg123-dev libpcap-dev libvorbis-dev libcurl4-openssl-dev
sudo apt install -y libglew-dev libgtk-3-dev libpulse-dev subversion libavfilter-dev libavformat-dev libavcodec-dev
sudo update-alternatives --set fakeroot /usr/bin/fakeroot-tcp

svn checkout svn://svn.code.sf.net/p/vice-emu/code/trunk/vice vice

export USE_SVN_REVISION=1

cd vice

ARGS="--disable-arch --disable-pdf-docs --with-png --with-gif --with-vorbis --with-flac --enable-ethernet --enable-midi --enable-cpuhistory --enable-platformdox --enable-html-docs --enable-rs232 --enable-new8580filter --with-resid --enable-x64 --enable-x64-image --enable-realdevice --enable-ffmpeg"
ARGS="--enable-gtk3ui $ARGS"

./autogen.sh
./configure $ARGS
sed -i "s/The %s Emulator/𝓩𝓲𝓫𝓻𝓲'𝓼 𝓑𝓾𝓲𝓵𝓭./" src/arch/gtk3/uiabout.c
make -j8 DESTDIR=../data/build install-strip
rev=$(svnversion)
cp -R data/data/build/usr/local/share data/build/usr/local/
cd data/build/
7z a ../../gtk3vice_${rev}.7z *
cp ../../../installer.sh ../../gtk3vice_${rev}.sh
cp ../../../vice_update.sh ../../
cat ../../gtk3vice_${rev}.7z >>../../gtk3vice_${rev}.sh
