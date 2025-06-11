@echo off
curl -L "https://repo.msys2.org/distrib/x86_64/msys2-x86_64-20231026.exe" -o msysz.exe
msysz.exe install --root C:\msysz --confirm-command
rem c:\msysz\usr\bin\bash.exe --login -c "pacman -Suy --noconfirm"
rem c:\msysz\usr\bin\bash.exe --login -c "pacman -Suy --noconfirm git base-devel autotools mingw-w64-x86_64-toolchain zip p7zip subversion git mingw-w64-x86_64-pkg-config mingw-w64-x86_64-ntldd mingw-w64-x86_64-glew mingw-w64-x86_64-giflib mingw-w64-x86_64-lame mingw-w64-x86_64-libvorbis mingw-w64-x86_64-flac mingw-w64-x86_64-icoutils mingw-w64-x86_64-gtk3  mingw-w64-x86_64-SDL2_image mingw-w64-x86_64-ffmpeg4.4 msys/libpcap-devel mingw64/mingw-w64-x86_64-libpcap mingw64/mingw-w64-x86_64-curl autotools"
c:\msysz\msys2_shell.cmd -mingw64 -defterm -no-start -here -c "pacman -Suy --noconfirm"
c:\msysz\msys2_shell.cmd -mingw64 -defterm -no-start -here -c "pacman -S --noconfirm git base-devel autotools mingw-w64-x86_64-toolchain zip p7zip subversion git mingw-w64-x86_64-pkg-config mingw-w64-x86_64-ntldd mingw-w64-x86_64-glew mingw-w64-x86_64-giflib mingw-w64-x86_64-lame mingw-w64-x86_64-libvorbis mingw-w64-x86_64-flac mingw-w64-x86_64-icoutils mingw-w64-x86_64-gtk3  mingw-w64-x86_64-SDL2_image mingw-w64-x86_64-ffmpeg4.4 msys/libpcap-devel mingw64/mingw-w64-x86_64-libpcap mingw64/mingw-w64-x86_64-curl autotools"

dos2unix patches.zibri
dos2unix vice.sh
dos2unix my_build.sh
copy vice.sh c:\users\runneradmin\
copy patches.zibri c:\users\runneradmin\
rem c:\msysz\usr\bin\bash.exe --login /c/users/runneradmin/vice.sh
c:\msysz\msys2_shell.cmd -mingw64 -defterm -no-start -here -c "/c/users/runneradmin/vice.sh"
rem c:\msysz\usr\bin\bash.exe --login -c "export USE_SVN_REVISION=1;cd $GITHUB_WORKSPACE/vice;make -j8 && make bindist7zip"
c:\msysz\msys2_shell.cmd -mingw64 -defterm -no-start -here -c "export USE_SVN_REVISION=1; cd $GITHUB_WORKSPACE/vice; make -j8 && make bindist7zip"
