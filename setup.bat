@echo off
set MSYSTEM=MINGW64
dos2unix patches.zibri
dos2unix vice.sh
dos2unix my_build.sh
copy vice.sh c:\users\runneradmin\
copy patches.zibri c:\users\runneradmin\
c:\msys64\usr\bin\bash.exe --login /c/users/runneradmin/vice.sh
