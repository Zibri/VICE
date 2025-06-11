#!/bin/bash
cd $GITHUB_WORKSPACE
#export PATH=$PATH:/usr/share:/usr/local/share:/mingw64/share:/runneradmin/.local/share
export PATH=/c//mingw64/bin:/mingw64/bin:/usr/local/bin:/usr/bin:/bin:/c/Windows/System32:/c/Windows:/c/Windows/System32/Wbem:/c/Windows/System32/WindowsPowerShell/v1.0/:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl
#pacman -Sy --noconfirm git base-devel autotools mingw-w64-x86_64-toolchain zip p7zip subversion git mingw-w64-x86_64-pkg-config mingw-w64-x86_64-ntldd mingw-w64-x86_64-glew mingw-w64-x86_64-giflib mingw-w64-x86_64-lame mingw-w64-x86_64-libvorbis mingw-w64-x86_64-flac mingw-w64-x86_64-icoutils mingw-w64-x86_64-gtk3  mingw-w64-x86_64-SDL2_image mingw-w64-x86_64-ffmpeg4.4 msys/libpcap-devel mingw64/mingw-w64-x86_64-libpcap autotools
#wget https://mirror.cs.jmu.edu/pub/msys2/mingw/mingw64/mingw-w64-x86_64-ffmpeg-4.4.3-6-any.pkg.tar.zst
wget https://mirror.cs.jmu.edu/pub/msys2/mingw/mingw64/mingw-w64-x86_64-celt-0.11.3-5-any.pkg.tar.zst
pacman -U --noconfirm mingw-w64-x86_64-celt-0.11.3-5-any.pkg.tar.zst

pacman -Sy --noconfirm mingw-w64-x86_64-ffmpeg4.4 mingw-w64-x86_64-xa65

export "PKG_CONFIG_PATH=/mingw64/lib/ffmpeg4.4/pkgconfig:$PKG_CONFIG_PATH"

#XA_VERSION=$(wget --tries=1 -O - https://www.floodgap.com/retrotech/xa/dists/ 2>/dev/null | grep '"xa-[^"]*gz"' | sed -e 's,.*xa-,,' -e 's,.tar.gz.*,,' | sort -V | tail -n1)

#mkdir -p src
#cd src
#wget https://www.floodgap.com/retrotech/xa/dists/xa-${XA_VERSION}.tar.gz
#tar -xzf xa-${XA_VERSION}.tar.gz
#cd xa-${XA_VERSION}
#make mingw install
#ln -s /usr/local/bin/xa.exe /usr/local/bin/xa65.exe
#cd ../..
#rm -rf src

pacman -Sy --noconfirm mingw-w64-x86_64-gcc mingw-w64-x86_64-binutils mingw-w64-x86_64-crt-git mingw-w64-x86_64-headers-git mingw-w64-x86_64-winpthreads-git mingw-w64-x86_64-gcc-libs

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
patch -p0 <~/patches.zibri
#make -j8 && make bindist7zip 
    echo contents of config.log
    cat config.log
