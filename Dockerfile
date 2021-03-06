FROM debian:buster-slim

ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8

RUN ["/bin/bash", "-c", "\
  set -eux -o pipefail \
    && export PYTHON_36_VERSION=3.6.10 \
    && export PYTHON_37_VERSION=3.7.6 \
    && export PYTHON_38_VERSION=3.8.2 \
    \
    && apt-get -qq update \
    && apt-get -qq install -y --no-install-recommends \
      git gcc g++ make cmake ruby python \
      libyaml-dev zlib1g-dev libssl-dev libbz2-dev libreadline-dev libffi-dev \
      libfontconfig1-dev libx11-dev libxcomposite-dev libgl1-mesa-dev libglu1-mesa-dev freeglut3-dev \
      curl ca-certificates unzip patchelf \
    \
    && mkdir -p /usr/local \
    && git clone https://github.com/tagomoris/xbuild.git /usr/local/xbuild \
    && /usr/local/xbuild/python-install -f $PYTHON_36_VERSION /usr/local/python-3.6 \
    && /usr/local/xbuild/python-install -f $PYTHON_37_VERSION /usr/local/python-3.7 \
    && /usr/local/xbuild/python-install -f $PYTHON_38_VERSION /usr/local/python-3.8 \
    \
    && /usr/local/python-3.6/bin/pip3 install pip --upgrade \
    && /usr/local/python-3.7/bin/pip3 install pip --upgrade \
    && /usr/local/python-3.8/bin/pip3 install pip --upgrade \
    && gem install --no-document gemfury \
    \
    && rm -rf /usr/local/xbuild \
    && apt-get -qq autoremove -y \
    && apt-get -qq clean \
    && rm -rf ~/.cache/pip/ \
    && rm -rf ~/.pyenv/ \
    && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* \
"]
