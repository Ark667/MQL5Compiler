FROM ubuntu:22.04

# Envitronment variables
ENV DEBIAN_FRONTEND=noninteractive \
    WINEDEBUG=-all \
    WINEARCH=win64 \
    WINEPREFIX=/wine \
    WINEDLLOVERRIDES="mshtml=,mscoree=" \
    NODE_VERSION=20

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    git \
    gnupg \
    libimage-exiftool-perl \
    wine && \
    rm -rf /var/lib/apt/lists/*

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - \
    && apt-get install -y nodejs \
    && apt-get clean

# Add MetaEditor executable
COPY bin/MetaEditor64.exe /opt/mql/metaeditor64.exe

# Add scripts
COPY scripts/check-version.sh /opt/mql/scripts/check-version.sh
COPY scripts/mql5-compile.sh /opt/mql/scripts/mql5-compile.sh
RUN chmod +x /opt/mql/scripts/*.sh

WORKDIR /work

ENTRYPOINT ["bash"]