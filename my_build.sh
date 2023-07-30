#!/usr/bin/env bash
#
# Usage: github-actions-build.sh <UI> [SVN rXXXXX override, or 'release']

#set -o errexit
set -o nounset
cd "$(dirname $0)"/../..

#
# Build and install xa65. When this stops working, check
# https://www.floodgap.com/retrotech/xa/dists/ to see why
#

XA_VERSION=$(wget --tries=1 -O - https://www.floodgap.com/retrotech/xa/dists/ 2>/dev/null | grep '"xa-[^"]*gz"' | sed -e 's,.*xa-,,' -e 's,.tar.gz.*,,' | sort -V | tail -n1)

if [ ! -e /usr/local/bin/xa65.exe ]
then
    pushd /usr/local
    mkdir -p src
    cd src
    wget https://www.floodgap.com/retrotech/xa/dists/xa-${XA_VERSION}.tar.gz
    tar -xzf xa-${XA_VERSION}.tar.gz
    cd xa-${XA_VERSION}
    make mingw install
    cp /usr/local/bin/xa.exe /usr/local/bin/xa65.exe
    popd
fi

if [ ! -f mingw-w64-x86_64-ffmpeg-4.4.3-6-any.pkg.tar.zst ]
then
wget https://mirror.cs.jmu.edu/pub/msys2/mingw/mingw64/mingw-w64-x86_64-ffmpeg-4.4.3-6-any.pkg.tar.zst
fi

if [ ! -f mingw-w64-x86_64-celt-0.11.3-5-any.pkg.tar.zst ]
then
wget https://mirror.cs.jmu.edu/pub/msys2/mingw/mingw64/mingw-w64-x86_64-celt-0.11.3-5-any.pkg.tar.zst
fi

pacman -U --noconfirm mingw-w64-x86_64-ffmpeg-4.4.3-6-any.pkg.tar.zst mingw-w64-x86_64-celt-0.11.3-5-any.pkg.tar.zst

ARGS="--disable-arch --disable-pdf-docs --with-png --with-gif --with-vorbis --with-flac --enable-ethernet --enable-midi --enable-cpuhistory --enable-platformdox --enable-html-docs --enable-rs232 --enable-new8580filter --with-resid --enable-x64 --enable-x64-image --enable-realdevice --enable-ffmpeg"
case "$1" in
GTK3)
    ARGS="--enable-gtk3ui $ARGS"
    ;;

SDL2)
    ARGS="--enable-sdlui2 $ARGS"
    ;;

*)
    echo "Bad UI: $1"
    exit 1
    ;;
esac

alias svn='curl -s "http://svn.code.sf.net/p/vice-emu/code/"|grep -i revis|cut -d " " -f 5|cut -d" " -f3|tail -n 1|cut -d ":" -f 1'
alias svnversion=svn

sed -i "s/The %s Emulator/𝓩𝓲𝓫𝓻𝓲'𝓼 𝓑𝓾𝓲𝓵𝓭./" src/arch/gtk3/uiabout.c
./autogen.sh
export USE_SVN_REVISION=1
./configure $ARGS
make -j8 clean
sync
make -j8 && make bindist7zip
#mv &>/dev/null GTK3VICE-3.7.1-win64.7z GTK3VICE-3.7.1-win64-r${SVN_REVISION_OVERRIDE}.7z || true
#mv &>/dev/null SDL2VICE-3.7.1-win64.7z SDL2VICE-3.7.1-win64-r${SVN_REVISION_OVERRIDE}.7z || true

