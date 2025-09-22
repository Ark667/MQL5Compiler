FROM ubuntu:22.04

# Envitronment variables
ENV DEBIAN_FRONTEND=noninteractive \
    WINEDEBUG=-all \
    WINEARCH=win64 \
    WINEPREFIX=/wine \
    MQL_WORK_DIR=/work/MQL5 \
    MQL_INCLUDE_DIR=/work/MQL5 \
    MQL_LOG_FILE=/work/build/compile.log

# Install dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wine64 \
        winbind \
        ca-certificates \
        wget \
        libimage-exiftool-perl && \
    rm -rf /var/lib/apt/lists/*

# Symlinks for Wine
RUN ln -s /usr/lib/wine/wine64 /usr/bin/wine && \
    ln -s /usr/lib/wine/wineserver64 /usr/bin/wineserver

# Initiaize Wine prefix
RUN wineboot --init 2>/dev/null && \
    wineserver --wait || true

# Add MetaEditor executable
COPY bin/MetaEditor64.exe /opt/mql/metaeditor64.exe

# Add scripts
COPY scripts/check-version.sh /opt/mql/scripts/check-version.sh
COPY scripts/mql5-compile.sh /opt/mql/scripts/mql5-compile.sh
RUN chmod +x /opt/mql/scripts/*.sh

WORKDIR /work

ENTRYPOINT ["bash"]