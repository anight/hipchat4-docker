FROM ubuntu:16.04

RUN apt-get update

RUN apt-get install -y curl gnupg apt-transport-https

RUN echo "deb https://atlassian.artifactoryonline.com/atlassian/hipchat-apt-client xenial main" > /etc/apt/sources.list.d/atlassian-hipchat4.list
RUN curl -s https://atlassian.artifactoryonline.com/atlassian/api/gpg/key/public | apt-key add -

RUN apt-get update && apt-get install -y hipchat4 libegl1-mesa libgl1-mesa-glx libgl1-mesa-dri

ARG user="n/a"
ARG group="n/a"
ARG uid="n/a"
ARG gid="n/a"
ARG video_gid="n/a"
ARG audio_gid="n/a"

RUN groupmod -g ${gid} ${group}
RUN userdel www-data
RUN groupmod -g ${video_gid} video
RUN groupmod -g ${audio_gid} audio
RUN useradd -m -u ${uid} -g ${group} -G ${video_gid},${audio_gid} ${user}

USER ${user}
ENV HOME /home/${user}
CMD /opt/HipChat4/bin/HipChat4

