FROM mcr.microsoft.com/devcontainers/java:0-17

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        xvfb x11vnc x11-utils xterm xdotool && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget ca-certificates && \
    wget -qO- https://github.com/novnc/noVNC/archive/v1.3.0.tar.gz | tar xz --strip 1 -C /opt && \
    wget -qO- https://github.com/novnc/websockify/archive/v0.11.0.tar.gz | tar xz --strip 1 -C /opt/websockify && \
    apt-get remove -y --purge wget ca-certificates && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY start-vnc.sh /usr/local/bin/start-vnc.sh
RUN chmod +x /usr/local/bin/start-vnc.sh

EXPOSE 6080
