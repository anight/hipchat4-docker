#! /bin/sh

set -ex

docker build \
	--build-arg user=`id -nu` \
	--build-arg group=`id -ng` \
	--build-arg uid=`id -u` \
	--build-arg gid=`id -g` \
	--build-arg video_gid=`getent group video | cut -d: -f3` \
	-t anight/hipchat4 .
