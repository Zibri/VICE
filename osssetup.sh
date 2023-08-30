#!/bin/bash
docker pull opensuse/tumbleweed
docker run --volume .:/t opensuse/tumbleweed /t/ossbuild.sh
docker rm $(docker ps -aq)
