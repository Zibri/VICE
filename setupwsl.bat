@echo off
wsl --update
wsl --install -d ubuntu -n
ubuntu install --root
wsl --user root -e apt update
wsl --user root -e apt upgrade -y
cd %GITHUB_WORKSPACE%
wsl --user root -e ls -al
wsl --user root ./wslbuild.sh
