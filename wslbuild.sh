#!/bin/bash
apt update && apt upgrade -y
apt install -y autoconf automake build-essential byacc devscripts dos2unix fakeroot flex xa65
apt install -y libasound-dev libflac-dev libgif-dev libmp3lame-dev libmpg123-dev libpcap-dev libvorbis-dev libcurl4-openssl-dev
apt install -y libglew-dev libgtk-3-dev libpulse-dev subversion libavresample-dev libavfilter-dev libavformat-dev libavcodec-dev

svn checkout svn://svn.code.sf.net/p/vice-emu/code/trunk/vice vice

export USE_SVN_REVISION=1

cd vice

ARGS="--disable-arch --disable-pdf-docs --with-png --with-gif --with-vorbis --with-flac --enable-ethernet --enable-midi --enable-cpuhistory --enable-platformdox --enable-html-docs --enable-rs232 --enable-new8580filter --with-resid --enable-x64 --enable-x64-image --enable-realdevice --enable-ffmpeg"
ARGS="--enable-gtk3ui $ARGS"

./autogen.sh
./configure $ARGS
sed -i "s/The %s Emulator/𝓩𝓲𝓫𝓻𝓲'𝓼 𝓑𝓾𝓲𝓵𝓭./" src/arch/gtk3/uiabout.c
make -j8 DESTDIR=../build install-strip
7z a test_wsl_ubuntu22.7z ../build
