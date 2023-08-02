#!/bin/bash
cd $GITHUB_WORKSPACE
export PATH=$PATH:/usr/share:/usr/local/share:/mingw64/share:/runneradmin/.local/share

wget https://mirror.cs.jmu.edu/pub/msys2/mingw/mingw64/mingw-w64-x86_64-ffmpeg-4.4.3-6-any.pkg.tar.zst
wget https://mirror.cs.jmu.edu/pub/msys2/mingw/mingw64/mingw-w64-x86_64-celt-0.11.3-5-any.pkg.tar.zst
pacman -U --noconfirm mingw-w64-x86_64-ffmpeg-4.4.3-6-any.pkg.tar.zst mingw-w64-x86_64-celt-0.11.3-5-any.pkg.tar.zst
rm -rf *.zst
XA_VERSION=$(wget --tries=1 -O - https://www.floodgap.com/retrotech/xa/dists/ 2>/dev/null | grep '"xa-[^"]*gz"' | sed -e 's,.*xa-,,' -e 's,.tar.gz.*,,' | sort -V | tail -n1)

mkdir -p src
cd src
wget https://www.floodgap.com/retrotech/xa/dists/xa-${XA_VERSION}.tar.gz
tar -xzf xa-${XA_VERSION}.tar.gz
cd xa-${XA_VERSION}
make mingw install
ln -s /usr/local/bin/xa.exe /usr/local/bin/xa65.exe
cd ../..
rm -rf src

svn checkout svn://svn.code.sf.net/p/vice-emu/code/trunk/vice vice

export USE_SVN_REVISION=1

cd vice

ARGS="--disable-arch --disable-pdf-docs --with-png --with-gif --with-vorbis --with-flac --enable-ethernet --enable-midi --enable-cpuhistory --enable-platformdox --enable-html-docs --enable-rs232 --enable-new8580filter --with-resid --enable-x64 --enable-x64-image --enable-realdevice --enable-ffmpeg"
ARGS="--enable-gtk3ui $ARGS"

./autogen.sh
./configure $ARGS
sed -i "s/The %s Emulator/𝓩𝓲𝓫𝓻𝓲'𝓼 𝓑𝓾𝓲𝓵𝓭./" src/arch/gtk3/uiabout.c
make -j8 && make bindist7zip 
