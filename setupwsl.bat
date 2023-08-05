@echo off
wsl --update
rem wsl --install -d ubuntu -n
rem ubuntu install --root
wsl --install Ubuntu-20.04 -n
ubuntu2004 install --root
wsl -d Ubuntu-20.04 --user root -e apt update
wsl -d Ubuntu-20.04 --user root -e apt upgrade -y
cd %GITHUB_WORKSPACE%
dos2unix wslbuild.sh
dos2unix wsl.conf
wsl -d Ubuntu-20.04 --user root cp wsl.conf /etc/wsl.conf
wsl -d Ubuntu-20.04 --shutdown
wsl -d Ubuntu-20.04 --user root ./wslbuild.sh
