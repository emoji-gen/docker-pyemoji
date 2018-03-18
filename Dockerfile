FROM debian:stretch

ENV PYTHON_35_VERSION 3.5.5
ENV PYTHON_36_VERSION 3.6.4

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    git gcc g++ make cmake ruby python \
    libyaml-dev zlib1g-dev libssl-dev libbz2-dev libreadline-dev \
    libfontconfig1-dev libx11-dev libxcomposite-dev libgl1-mesa-dev libglu1-mesa-dev freeglut3-dev \
    curl ca-certificates

RUN set -ex \
  && mkdir -p /usr/local \
  && git clone https://github.com/tagomoris/xbuild.git /usr/local/xbuild \
  && /usr/local/xbuild/python-install -f $PYTHON_35_VERSION /usr/local/python-3.5 \
  && /usr/local/xbuild/python-install -f $PYTHON_36_VERSION /usr/local/python-3.6 \
  && rm -rf /usr/local/xbuild

RUN apt-get purge -y curl \
  && apt-get autoremove -y \
  && apt-get clean \
  && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/* \