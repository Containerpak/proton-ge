FROM ubuntu:26.04 AS source

ADD --checksum=sha256:de43c4b25f3c047db49b96c44d84759952c5a01332a68805a09e69f95dc38a75 \
    https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton11-5/GE-Proton11-5-x86_64.tar.gz \
    /tmp/proton.tar.gz

RUN mkdir -p /out/GE-Proton && \
    tar -xzf /tmp/proton.tar.gz -C /out/GE-Proton --strip-components=1 && \
    test -x /out/GE-Proton/proton && \
    test -f /out/GE-Proton/compatibilitytool.vdf

FROM ghcr.io/containerpak/wine:main

COPY --from=source /out/GE-Proton /usr/share/steam/compatibilitytools.d/GE-Proton11-5
COPY --chmod=0755 proton-ge /usr/bin/proton-ge
