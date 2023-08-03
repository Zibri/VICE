@echo off
wsl --update
wsl --install -d ubuntu -n
ubuntu install --root
wsl --user root "./wslbuild.sh"
