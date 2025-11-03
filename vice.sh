#!/bin/bash
export MSYSTEM=MINGW64
cd $GITHUB_WORKSPACE
pacman -Sy --noconfirm git base-devel autotools mingw-w64-x86_64-toolchain zip p7zip subversion git mingw-w64-x86_64-pkg-config mingw-w64-x86_64-ntldd mingw-w64-x86_64-glew mingw-w64-x86_64-giflib mingw-w64-x86_64-lame mingw-w64-x86_64-libvorbis mingw-w64-x86_64-flac mingw-w64-x86_64-icoutils mingw-w64-x86_64-gtk3 mingw-w64-x86_64-SDL2_image msys/libpcap-devel mingw64/mingw-w64-x86_64-libpcap autotools
wget https://mirror.cs.jmu.edu/pub/msys2/mingw/mingw64/mingw-w64-x86_64-ffmpeg4.4-4.4.6-7-any.pkg.tar.zst
wget https://mirror.cs.jmu.edu/pub/msys2/mingw/mingw64/mingw-w64-x86_64-celt-0.11.3-5-any.pkg.tar.zst
pacman -U --noconfirm mingw-w64-x86_64-celt-0.11.3-5-any.pkg.tar.zst ./mingw-w64-x86_64-ffmpeg4.4-4.4.6-7-any.pkg.tar.zst
pacman -Sy --noconfirm mingw-w64-x86_64-xa65 mingw-w64-x86_64-libpcap mingw-w64-x86_64-curl

svn checkout svn://svn.code.sf.net/p/vice-emu/code/trunk/vice vice

export USE_SVN_REVISION=1

cd vice

ARGS="--disable-arch --disable-pdf-docs --with-png --with-gif --with-vorbis --with-flac --enable-ethernet --enable-midi --enable-cpuhistory --enable-platformdox --enable-html-docs --enable-rs232 --enable-new8580filter --with-resid --enable-x64 --enable-x64-image --enable-realdevice --enable-ffmpeg"
ARGS="--enable-gtk3ui $ARGS"

    echo "--- Debugging vice.sh ---"
    echo "Current MSYSTEM: $MSYSTEM"
    echo "Current PATH: $PATH"
    which cc
    which gcc
    echo "--- End Debugging ---"
./autogen.sh
./configure $ARGS
patch -p0 <../patches.zibri
make -j8 && make bindist7zip 
